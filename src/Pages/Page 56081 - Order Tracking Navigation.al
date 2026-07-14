page 56081 "Order Tracking Navigation"
{
    // --------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // --------------------------------------------------------------------------
    // #117    21-10-2013      PLB           Page para el seguimiento de pedidos
    // #9645   16-01-2015      MOI           Se cambia el TextConstant Text011 por Text012 para que se pueda abrir el page y no de un fallo.
    // #50366  16-05-2016      JMB           Se añade el campo 'Reference' en el grupo repeater y se añade parametro a la funcion InsertIntoDocEntry().

    Caption = 'Navigate';
    PageType = NavigatePage;
    SaveValues = true;
    SourceTable = 56053;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(GeneralG)
            {
                Caption = 'General';
                field(DocType; DocType)
                {
                    Caption = 'Document Type';
                    OptionCaption = ' ,Sales Order,Sales Shipment,Sales Invoice';

                    trigger OnValidate()
                    begin
                        SetSource(DocType, '');
                    end;
                }
                field(DocNo; DocNo)
                {
                    Caption = 'Document No.';

                    trigger OnValidate()
                    begin
                        SetSource(DocType, DocNo);
                    end;
                }
            }
            repeater(General)
            {
                Editable = false;
                IndentationColumn = Indentation;
                field("Entry no."; "Entry no.")
                {
                    Visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    Visible = false;
                }
                field("Table Name"; "Table Name")
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        ShowRecords;
                    end;
                }
                field(Reference; Reference)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fi&nd")
            {
                Caption = 'Fi&nd';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FindPush;
                end;
            }
            action(Show)
            {
                Caption = '&Show';
                Enabled = ShowEnable;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    ShowRecords;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ShowEnable := FALSE;
    end;

    trigger OnOpenPage()
    begin
        IF (NewDocNo = '') AND (NewDocType = 0) THEN BEGIN
            DELETEALL;
            SetSource(0, '');
        END ELSE BEGIN
            DocType := NewDocType;
            DocNo := NewDocNo;
            FindRecords;
        END;
    end;

    var
        SalesHeader: Record 36;
        SalesLine: Record 37;
        SalesHeaderArchive: Record 5107;
        WhseShptLine: Record 7321;
        WhseShptHeader: Record 7320;
        PostedWhseShptLine: Record 7323;
        PostedWhseShptHeader: Record 7322;
        WhseActivityLine: Record 5767;
        WhseActivityHeader: Record 5766;
        RegWhseActivityLine: Record 5773;
        RegWhseActivityHeader: Record 5772;
        CabPacking: Record 56030;
        CabPackingReg: Record 56033;
        SalesShptHeader: Record 110;
        SalesInvHeader: Record 112;
        LinHojaRutaReg: Record 56023;
        CabHojaRutaReg: Record 56022;
        LinHojaRuta: Record 56021;
        CabHojaRuta: Record 56020;
        ReturnRcptHeader: Record 6660;
        SalesCrMemoHeader: Record 114;
        CustLedgEntry: Record 21;
        DetCustLedgEntry: Record 379;
        DocNo: Code[20];
        DocType: Option " ","Sales Order","Sales Shipment","Sales Invoice";
        NewDocNo: Code[20];
        NewDocType: Option ,"Sales Order","Sales Shipment","Sales Invoice";
        DocExists: Boolean;
        OrderNo: Code[20];
        NewIdent: Integer;
        Text001: Label 'Counting records...';
        Text002: Label 'There are no posted records with this document number.';
        Text003: Label 'Posted Sales Invoice';
        Text004: Label 'Posted Sales Credit Memo';
        Text005: Label 'Posted Sales Shipment';
        Text006: Label 'Sales Order';
        Text007: Label 'Picking';
        Text008: Label 'Posted Picking';
        Text009: Label 'Packaging';
        Text010: Label 'Posted Packaging';
        Text011: Label 'Cantidad en Back Order';
        Text012: Label '%1 unidades';
        Text013: Label 'Cobro';
        [InDataSet]
        ShowEnable: Boolean;

    procedure SetDoc(DocType: Integer; DocNo: Code[20])
    begin
        NewDocNo := DocNo;
        NewDocType := DocType;
    end;

    local procedure SetSource(DocType2: Integer; DocNo2: Code[20])
    begin
        DocType := DocType2;
        DocNo := DocNo2;

        RESET;
        DELETEALL;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ShowRecords()
    begin
        CASE "Table ID" OF
            DATABASE::"Sales Header":
                BEGIN
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Document No.") THEN BEGIN
                        SalesHeader.SETRECFILTER;
                        PAGE.RUN(PAGE::"Sales Order", SalesHeader);
                    END
                    ELSE BEGIN
                        SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                        SalesHeaderArchive.SETRANGE("No.", "Document No.");
                        SalesHeaderArchive.FINDLAST;
                        PAGE.RUN(PAGE::"Sales Order Archive", SalesHeaderArchive);
                    END;
                END;
            DATABASE::"Sales Invoice Header":
                BEGIN
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvHeader);
                END;
            DATABASE::"Sales Shipment Header":
                BEGIN
                    SalesShptHeader.RESET;
                    SalesShptHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Posted Sales Shipment", SalesShptHeader);
                END;
            DATABASE::"Warehouse Shipment Header":
                BEGIN
                    WhseShptHeader.RESET;
                    WhseShptHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Warehouse Shipment", WhseShptHeader);
                END;
            DATABASE::"Posted Whse. Shipment Header":
                BEGIN
                    PostedWhseShptHeader.RESET;
                    PostedWhseShptHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Posted Whse. Shipment", PostedWhseShptHeader);
                END;
            DATABASE::"Warehouse Activity Header":
                BEGIN
                    WhseActivityHeader.RESET;
                    WhseActivityHeader.SETRANGE(Type, WhseActivityHeader.Type::Pick);
                    WhseActivityHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Warehouse Pick", WhseActivityHeader);
                END;
            DATABASE::"Registered Whse. Activity Hdr.":
                BEGIN
                    RegWhseActivityHeader.RESET;
                    RegWhseActivityHeader.SETRANGE(Type, RegWhseActivityHeader.Type::Pick);
                    RegWhseActivityHeader.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Registered Pick", RegWhseActivityHeader);
                END;
            DATABASE::"Cab. Packing":
                BEGIN
                    CabPacking.RESET;
                    CabPacking.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Cab. Packing List", CabPacking); // #50366
                END;
            DATABASE::"Cab. Packing Registrado":
                BEGIN
                    CabPackingReg.RESET;
                    CabPackingReg.SETRANGE("No.", "Document No.");
                    PAGE.RUN(PAGE::"Cab. Packing Registrado", CabPackingReg); // #50366
                END;
            // #50366: Inicio
            DATABASE::"Cab. Hoja de Ruta":
                BEGIN
                    CabHojaRuta.RESET;
                    CabHojaRuta.SETRANGE("No. Hoja Ruta", "Document No.");
                    PAGE.RUN(PAGE::"Cab. Hoja de Ruta", CabHojaRuta);
                END;
            // #50366: Fin
            DATABASE::"Cab. Hoja de Ruta Reg.":
                BEGIN
                    CabHojaRutaReg.RESET;
                    CabHojaRutaReg.SETRANGE("No. Hoja Ruta", "Document No.");
                    PAGE.RUN(PAGE::"Cab. Hoja de Ruta Reg.", CabHojaRutaReg);
                END;
            DATABASE::"Cust. Ledger Entry":
                BEGIN
                    CustLedgEntry.RESET;
                    CustLedgEntry.SETFILTER("Entry No.", "Document No.");
                    PAGE.RUN(0, CustLedgEntry);
                END;
        END;
    end;

    local procedure FindPush()
    begin
        FindRecords;
    end;

    procedure FindRecords()
    var
        WhseShptHeaderTMP: Record 7320 temporary;
        PostedWhseShptHeaderTMP: Record 7322 temporary;
        WhseActivityHeaderTMP: Record 5766 temporary;
        RegWhseActivityHeaderTMP: Record 5772 temporary;
        CabHojaRutaRegTMP: Record 56022 temporary;
        CabHojaRutaReg: Record 56022;
        CabHojaRutaTMP: Record 56020 temporary;
        Window: Dialog;
        BackOrderQty: Decimal;
        UpdateNewIdent: Boolean;
    begin
        Window.OPEN(Text001);
        RESET;
        DELETEALL;
        "Entry no." := 0;

        CASE DocType OF
            DocType::"Sales Order":
                OrderNo := DocNo;
            DocType::"Sales Shipment":
                BEGIN
                    SalesShptHeader.GET(DocNo);
                    OrderNo := SalesShptHeader."Order No.";
                END;
            DocType::"Sales Invoice":
                BEGIN
                    SalesInvHeader.GET(DocNo);
                    OrderNo := SalesInvHeader."Order No.";
                END;
        END;
        IF OrderNo <> '' THEN BEGIN

            NewIdent := 0;
            IF SalesHeader.READPERMISSION THEN BEGIN
                InsertIntoDocEntry
                (
                  DATABASE::"Sales Header",
                  Text006,
                  OrderNo,
                  NewIdent,
                  '' // #50366
                );

                IF SalesHeader.GET(SalesHeader."Document Type"::Order, OrderNo) THEN BEGIN
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            BackOrderQty += SalesLine."Cantidad pendiente BO";
                        UNTIL SalesLine.NEXT = 0;
                    IF BackOrderQty > 0 THEN
                        InsertIntoDocEntry
                        (
                          DATABASE::"Sales Header",
                          Text011, // #9645
                          STRSUBSTNO(Text012, BackOrderQty),
                          NewIdent + 1,
                          '' // #50366
                        );
                END;
            END;

            IF WhseShptLine.READPERMISSION THEN BEGIN
                WhseShptLine.RESET;
                WhseShptLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
                WhseShptLine.SETRANGE("Source Type", 37);
                WhseShptLine.SETRANGE("Source Subtype", 1); // 1 = Order
                WhseShptLine.SETRANGE("Source No.", OrderNo);
                IF WhseShptLine.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT WhseShptHeaderTMP.GET(WhseShptLine."No.") THEN BEGIN
                            WhseShptHeaderTMP."No." := WhseShptLine."No.";
                            WhseShptHeaderTMP.INSERT;
                            InsertIntoDocEntry
                            (
                              DATABASE::"Warehouse Shipment Header",
                              WhseShptHeaderTMP.TABLECAPTION,
                              WhseShptLine."No.",
                              NewIdent,
                              '' // #50366
                            );
                        END;
                    UNTIL WhseShptLine.NEXT = 0;
                END;
            END;

            IF RegWhseActivityLine.READPERMISSION THEN BEGIN
                RegWhseActivityLine.RESET;
                RegWhseActivityLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
                RegWhseActivityLine.SETRANGE("Activity Type", RegWhseActivityLine."Activity Type"::Pick);
                RegWhseActivityLine.SETRANGE("Source Type", 37);
                RegWhseActivityLine.SETRANGE("Source Subtype", 1); // 1 = Order
                RegWhseActivityLine.SETRANGE("Source No.", OrderNo);
                IF RegWhseActivityLine.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT RegWhseActivityHeaderTMP.GET(RegWhseActivityHeaderTMP.Type::Pick, RegWhseActivityLine."No.") THEN BEGIN
                            RegWhseActivityHeaderTMP.Type := RegWhseActivityHeaderTMP.Type::Pick;
                            RegWhseActivityHeaderTMP."No." := RegWhseActivityLine."No.";
                            RegWhseActivityHeaderTMP.INSERT;
                            InsertIntoDocEntry
                            (
                              DATABASE::"Registered Whse. Activity Hdr.",
                              Text008,
                              RegWhseActivityLine."No.",
                              NewIdent,
                              '' // #50366
                            );
                        END;
                    UNTIL RegWhseActivityLine.NEXT = 0;

                    IF RegWhseActivityHeaderTMP.FINDSET THEN BEGIN
                        UpdateNewIdent := FALSE;
                        REPEAT
                            IF CabPacking.READPERMISSION THEN BEGIN
                                CabPacking.RESET;
                                CabPacking.SETRANGE("Picking No.", RegWhseActivityHeaderTMP."No.");
                                IF CabPacking.FINDSET THEN
                                    REPEAT
                                        IF NOT UpdateNewIdent THEN
                                            UpdateNewIdent := TRUE;
                                        InsertIntoDocEntry
                                        (
                                          DATABASE::"Cab. Packing",
                                          Text009,
                                          CabPacking."No.",
                                          NewIdent + 1,
                                          '' // #50366
                                        );
                                    UNTIL CabPacking.NEXT = 0;
                            END;

                            IF CabPackingReg.READPERMISSION THEN BEGIN
                                CabPackingReg.RESET;
                                CabPackingReg.SETRANGE("Picking No.", RegWhseActivityHeaderTMP."No.");
                                IF CabPackingReg.FINDSET THEN
                                    REPEAT
                                        IF NOT UpdateNewIdent THEN
                                            UpdateNewIdent := TRUE;
                                        InsertIntoDocEntry
                                        (
                                          DATABASE::"Cab. Packing Registrado",
                                          Text010,
                                          CabPackingReg."No.",
                                          NewIdent + 1,
                                          '' // #50366
                                        );
                                    UNTIL CabPackingReg.NEXT = 0;
                            END;
                        UNTIL RegWhseActivityHeaderTMP.NEXT = 0;
                        IF UpdateNewIdent THEN
                            NewIdent += 1;
                    END;
                END;
            END;

            IF PostedWhseShptLine.READPERMISSION THEN BEGIN
                PostedWhseShptLine.RESET;
                PostedWhseShptLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.");
                PostedWhseShptLine.SETRANGE("Source Type", 37);
                PostedWhseShptLine.SETRANGE("Source Subtype", 1); // 1 = Order
                PostedWhseShptLine.SETRANGE("Source No.", OrderNo);
                IF PostedWhseShptLine.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT PostedWhseShptHeaderTMP.GET(PostedWhseShptLine."No.") THEN BEGIN
                            PostedWhseShptHeaderTMP."No." := PostedWhseShptLine."No.";
                            PostedWhseShptHeaderTMP.INSERT;
                            InsertIntoDocEntry
                            (
                              DATABASE::"Posted Whse. Shipment Header",
                              PostedWhseShptHeaderTMP.TABLECAPTION,
                              PostedWhseShptLine."No.",
                              NewIdent,
                              '' // #50366
                            );
                        END;
                    UNTIL PostedWhseShptLine.NEXT = 0;
                END;
            END;

            IF WhseActivityLine.READPERMISSION THEN BEGIN
                WhseActivityLine.RESET;
                WhseActivityLine.SETRANGE("Activity Type", WhseActivityLine."Activity Type"::Pick);
                WhseActivityLine.SETRANGE("Source Type", 36);
                WhseActivityLine.SETRANGE("Source Subtype", 1); // 1 = Order
                WhseActivityLine.SETRANGE("Source No.", OrderNo);
                IF WhseActivityLine.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT WhseActivityHeaderTMP.GET(WhseActivityHeaderTMP.Type::Pick, WhseActivityLine."No.") THEN BEGIN
                            WhseActivityHeaderTMP.Type := WhseActivityHeaderTMP.Type::Pick;
                            WhseActivityHeaderTMP."No." := WhseActivityLine."No.";
                            WhseActivityHeaderTMP.INSERT;
                            InsertIntoDocEntry
                            (
                              DATABASE::"Warehouse Activity Header",
                              Text007,
                              WhseActivityLine."No.",
                              NewIdent,
                              '' // #50366
                            );
                        END;
                    UNTIL WhseActivityHeader.NEXT = 0;
                END;
            END;


            IF SalesShptHeader.READPERMISSION THEN BEGIN
                SalesShptHeader.RESET;
                SalesShptHeader.SETCURRENTKEY("Order No.");
                SalesShptHeader.SETRANGE("Order No.", OrderNo);
                IF SalesShptHeader.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        InsertIntoDocEntry
                        (
                          DATABASE::"Sales Shipment Header",
                          Text005,
                          SalesShptHeader."No.",
                          NewIdent,
                          '' // #50366
                        );
                    UNTIL SalesShptHeader.NEXT = 0;
                END;
            END;

            IF LinHojaRutaReg.READPERMISSION THEN BEGIN
                LinHojaRutaReg.RESET;
                LinHojaRutaReg.SETRANGE("No. Pedido", OrderNo);
                IF LinHojaRutaReg.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT CabHojaRutaRegTMP.GET(LinHojaRutaReg."No. Hoja Ruta") THEN BEGIN
                            CabHojaRutaReg.GET(LinHojaRutaReg."No. Hoja Ruta"); // #50366
                            CabHojaRutaRegTMP."No. Hoja Ruta" := LinHojaRutaReg."No. Hoja Ruta";
                            CabHojaRutaRegTMP.INSERT;
                            InsertIntoDocEntry
                             (
                               DATABASE::"Cab. Hoja de Ruta Reg.",
                               CabHojaRutaRegTMP.TABLECAPTION,
                               LinHojaRutaReg."No. Hoja Ruta",
                               NewIdent,
                               CabHojaRutaReg."Hoja de Ruta Origen" // #50366
                             );
                        END;
                    UNTIL LinHojaRutaReg.NEXT = 0;
                END;
            END;

            // #50366: Inicio
            IF LinHojaRuta.READPERMISSION THEN BEGIN
                LinHojaRuta.RESET;
                LinHojaRuta.SETRANGE("No. Pedido", OrderNo);
                IF LinHojaRuta.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        IF NOT CabHojaRutaTMP.GET(LinHojaRuta."No. Hoja Ruta") THEN BEGIN
                            CabHojaRutaTMP."No. Hoja Ruta" := LinHojaRuta."No. Hoja Ruta";
                            CabHojaRutaTMP.INSERT;
                            InsertIntoDocEntry
                            (
                              DATABASE::"Cab. Hoja de Ruta",
                              CabHojaRutaTMP.TABLECAPTION,
                              LinHojaRuta."No. Hoja Ruta",
                              NewIdent,
                              '' // #50366
                            );
                        END;
                    UNTIL LinHojaRuta.NEXT = 0;
                END;
            END;

            // #50366: Fin
            IF SalesInvHeader.READPERMISSION THEN BEGIN
                SalesInvHeader.RESET;
                SalesInvHeader.SETCURRENTKEY("Order No.");
                SalesInvHeader.SETRANGE("Order No.", OrderNo);
                IF SalesInvHeader.FINDSET THEN BEGIN
                    NewIdent += 1;
                    REPEAT
                        InsertIntoDocEntry
                        (
                          DATABASE::"Sales Invoice Header",
                          Text003,
                          SalesInvHeader."No.",
                          NewIdent,
                          '' // #50366
                        );

                        CustLedgEntry.RESET;
                        CustLedgEntry.SETCURRENTKEY("Document No.");
                        CustLedgEntry.SETRANGE("Document No.", SalesInvHeader."No.");
                        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                        CustLedgEntry.SETRANGE("Posting Date", SalesInvHeader."Posting Date");
                        CustLedgEntry.FINDFIRST;
                        DetCustLedgEntry.RESET;
                        DetCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.");
                        DetCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntry."Entry No.");
                        DetCustLedgEntry.SETRANGE("Entry Type", DetCustLedgEntry."Entry Type"::Application);
                        DetCustLedgEntry.SETRANGE(Unapplied, FALSE);
                        IF DetCustLedgEntry.FINDSET THEN
                            REPEAT
                                InsertIntoDocEntry
                                (
                                  DATABASE::"Cust. Ledger Entry",
                                  Text013,
                                  FORMAT(DetCustLedgEntry."Applied Cust. Ledger Entry No."),
                                  NewIdent + 1,
                                  '' // #50366
                                );
                            UNTIL DetCustLedgEntry.NEXT = 0;
                    UNTIL SalesInvHeader.NEXT = 0;
                END;

            END;

        END;

        /*
        IF SalesCrMemoHeader.READPERMISSION THEN BEGIN
          SalesCrMemoHeader.RESET;
          SalesCrMemoHeader.SETrange("No.",orderno);
          SalesCrMemoHeader.SETFILTER("Posting Date",PostingDateFilter);
          InsertIntoDocEntry(
            DATABASE::"Sales Cr.Memo Header",0,Text004,SalesCrMemoHeader.COUNT);
        END;
        */
        DocExists := FINDFIRST;

        //SetSource(0,'');
        IF NOT DocExists THEN
            MESSAGE(Text002);

        UpdateFormAfterFindRecords;
        Window.CLOSE;

    end;

    local procedure InsertIntoDocEntry(DocTableID: Integer; DocTableName: Text[250]; DocNo: Code[20]; DocIdent: Integer; DocRef: Code[20])
    begin
        IF DocNo = '' THEN
            EXIT;
        INIT;
        "Entry no." := "Entry no." + 1;
        "Table ID" := DocTableID;
        "Table Name" := COPYSTR(DocTableName, 1, MAXSTRLEN("Table Name"));
        "Document No." := DocNo;
        Indentation := DocIdent;
        Reference := DocRef;  // #50366
        INSERT;
    end;

    local procedure UpdateFormAfterFindRecords()
    begin
        ShowEnable := DocExists;
        CurrPage.UPDATE(FALSE);
    end;
}

