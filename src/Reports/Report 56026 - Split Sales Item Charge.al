report 56026 "Split Sales Item Charge"
{
    Caption = 'Split Sales Item Charge';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; 37)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

            trigger OnPostDataItem()
            begin
                GenLedgerSetUp.GET();
                Counter += 1;
                CLEAR(wImporteAsignar);

                ICASales.RESET;
                ICASales.SETRANGE("Document Type", "Document Type");
                ICASales.SETRANGE("Document No.", "Document No.");
                ICASales.SETRANGE("Item Charge No.", "No.");
                IF NOT ICASales.FINDFIRST THEN
                    ERROR(Err001, "No.", FIELDCAPTION("Document Type"), "No.");

                ICASales.RESET;
                ICASales.SETRANGE("Document Type", "Document Type");
                ICASales.SETRANGE("Document No.", "Document No.");
                ICASales.SETRANGE("Item Charge No.", "No.");
                ICASales.SETRANGE("Amount to Assign", 0);
                IF ICASales.FINDFIRST THEN
                    ERROR(Err002, "No.", FIELDCAPTION("Document Type"), "No.");


                CASE ICASales."Applies-to Doc. Type" OF
                    0: //quote
                        BEGIN
                        END;
                    1: //Order
                        BEGIN
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", "Document Type");
                            SalesLine2.SETRANGE("Document No.", "Document No.");
                            SalesLine2.SETRANGE(Type, Type);
                            SalesLine2.SETRANGE("No.", "No.");
                            SalesLine2.FINDFIRST;

                            ICASales.RESET;
                            ICASales.SETRANGE("Document Type", "Document Type");
                            ICASales.SETRANGE("Document No.", "Document No.");
                            ICASales.SETRANGE("Item Charge No.", "No.");
                            IF ICASales.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICASales."Item No.");
                                    SalesLine.TRANSFERFIELDS(SalesLine2);
                                    SalesLine."Line No." := NoLin;
                                    SalesLine.VALIDATE("No.");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Qty. to Ship", 1);

                                    ItemCharge.GET(ICASales."Item Charge No.");
                                    IF SalesHeader."Prices Including VAT" THEN
                                        SalesLine.VALIDATE("Unit Price", ROUND(ICASales."Amount to Assign" * (1 + "VAT %" / 100),
                                         GenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        SalesLine.VALIDATE("Unit Price", ICASales."Amount to Assign");

                                    SalesLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICASales2.TRANSFERFIELDS(ICASales);
                                    ICASales2."Document Line No." := NoLin;
                                    ICASales2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICASales2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICASales2."Amount to Assign" := ICASales2."Amount to Assign";

                                    IF ICASales2."Qty. to Assign" <> 0 THEN
                                        ICASales2.INSERT(TRUE);

                                UNTIL ICASales.NEXT = 0;

                                ICASales.RESET;
                                ICASales.SETRANGE("Document Type", "Document Type");
                                ICASales.SETRANGE("Document No.", "Document No.");
                                ICASales.SETRANGE("Item Charge No.", "No.");
                                IF ICASales.FIND('-') THEN
                                    REPEAT
                                        ICASales3.GET(ICASales."Document Type", ICASales."Document No.", ICASales."Document Line No.",
                                                         ICASales."Line No.");
                                        ICASales3.DELETE;
                                    UNTIL ICASales.NEXT = 0;

                                ICASales2.FINDSET;
                                REPEAT
                                    ICASales.COPY(ICASales2);
                                    ICASales.INSERT(TRUE);
                                UNTIL ICASales2.NEXT = 0;

                                SalesLine3.COPY("Sales Line");
                                SalesLine3.DELETE(TRUE);
                            END;

                        END;
                    2: //Invoice
                        BEGIN
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", "Document Type");
                            SalesLine2.SETRANGE("Document No.", "Document No.");
                            SalesLine2.SETRANGE(Type, Type);
                            SalesLine2.SETRANGE("No.", "No.");
                            SalesLine2.FINDFIRST;

                            ICASales.RESET;
                            ICASales.SETRANGE("Document Type", "Document Type");
                            ICASales.SETRANGE("Document No.", "Document No.");
                            ICASales.SETRANGE("Item Charge No.", "No.");
                            IF ICASales.FINDSET THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICASales."Item No.");
                                    SalesLine.TRANSFERFIELDS(SalesLine2);
                                    SalesLine."Line No." := NoLin;
                                    SalesLine.VALIDATE("No.");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Qty. to Ship", 1);

                                    ItemCharge.GET(ICASales."Item Charge No.");

                                    IF SalesHeader."Prices Including VAT" THEN
                                        SalesLine.VALIDATE("Unit Price", ROUND(ICASales."Amount to Assign" * (1 + "VAT %" / 100),
                                         GenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        SalesLine.VALIDATE("Unit Price", ICASales."Amount to Assign");

                                    SalesLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICASales2.TRANSFERFIELDS(ICASales);
                                    ICASales2."Document Line No." := NoLin;
                                    ICASales2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICASales2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICASales2."Amount to Assign" := ICASales2."Amount to Assign";

                                    ICASales2.INSERT(TRUE);

                                UNTIL ICASales.NEXT = 0;

                                ICASales.RESET;
                                ICASales.SETRANGE("Document Type", "Document Type");
                                ICASales.SETRANGE("Document No.", "Document No.");
                                ICASales.SETRANGE("Item Charge No.", "No.");
                                IF ICASales.FIND('-') THEN
                                    REPEAT
                                        ICASales3.GET(ICASales."Document Type", ICASales."Document No.", ICASales."Document Line No.",
                                                         ICASales."Line No.");
                                        ICASales3.DELETE;
                                    UNTIL ICASales.NEXT = 0;

                                ICASales2.FINDSET;
                                REPEAT
                                    ICASales.COPY(ICASales2);
                                    ICASales.INSERT(TRUE);
                                UNTIL ICASales2.NEXT = 0;

                                SalesLine3.COPY("Sales Line");
                                SalesLine3.DELETE(TRUE);
                            END;
                        END;
                    3: //Credit Memo
                        BEGIN
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", "Document Type");
                            SalesLine2.SETRANGE("Document No.", "Document No.");
                            SalesLine2.SETRANGE(Type, Type);
                            SalesLine2.SETRANGE("No.", "No.");
                            SalesLine2.FINDFIRST;

                            ICASales.RESET;
                            ICASales.SETRANGE("Document Type", "Document Type");
                            ICASales.SETRANGE("Document No.", "Document No.");
                            ICASales.SETRANGE("Item Charge No.", "No.");
                            IF ICASales.FINDSET THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICASales."Item No.");
                                    SalesLine.TRANSFERFIELDS(SalesLine2);
                                    SalesLine."Line No." := NoLin;
                                    SalesLine.VALIDATE("No.");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Qty. to Ship", 1);

                                    ItemCharge.GET(ICASales."Item Charge No.");

                                    IF SalesHeader."Prices Including VAT" THEN
                                        SalesLine.VALIDATE("Unit Price", ROUND(ICASales."Amount to Assign" * (1 + "VAT %" / 100),
                                         GenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        SalesLine.VALIDATE("Unit Price", ICASales."Amount to Assign");

                                    SalesLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICASales2.TRANSFERFIELDS(ICASales);
                                    ICASales2."Document Line No." := NoLin;
                                    ICASales2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICASales2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICASales2."Amount to Assign" := ICASales2."Amount to Assign";

                                    ICASales2.INSERT(TRUE);

                                UNTIL ICASales.NEXT = 0;

                                ICASales.RESET;
                                ICASales.SETRANGE("Document Type", "Document Type");
                                ICASales.SETRANGE("Document No.", "Document No.");
                                ICASales.SETRANGE("Item Charge No.", "No.");
                                IF ICASales.FIND('-') THEN
                                    REPEAT
                                        ICASales3.GET(ICASales."Document Type", ICASales."Document No.", ICASales."Document Line No.",
                                                         ICASales."Line No.");
                                        ICASales3.DELETE;
                                    UNTIL ICASales.NEXT = 0;

                                ICASales2.FINDSET;
                                REPEAT
                                    ICASales.COPY(ICASales2);
                                    ICASales.INSERT(TRUE);
                                UNTIL ICASales2.NEXT = 0;

                                SalesLine3.COPY("Sales Line");
                                SalesLine3.DELETE(TRUE);
                            END;
                        END;
                    4: //Blanket Order
                        BEGIN
                        END;
                    5: //Return Order
                        BEGIN
                        END;
                    6: //Shipment
                        BEGIN
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", "Document Type");
                            SalesLine2.SETRANGE("Document No.", "Document No.");
                            SalesLine2.SETRANGE(Type, Type);
                            SalesLine2.SETRANGE("No.", "No.");
                            SalesLine2.FINDFIRST;

                            ICASales.RESET;
                            ICASales.SETRANGE("Document Type", "Document Type");
                            ICASales.SETRANGE("Document No.", "Document No.");
                            ICASales.SETRANGE("Item Charge No.", "No.");
                            IF ICASales.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICASales."Item No.");
                                    SalesLine.TRANSFERFIELDS(SalesLine2);
                                    SalesLine."Line No." := NoLin;
                                    SalesLine.VALIDATE("No.");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Qty. to Ship", 1);

                                    ItemCharge.GET(ICASales."Item Charge No.");

                                    IF SalesHeader."Prices Including VAT" THEN
                                        SalesLine.VALIDATE("Unit Price", ROUND(ICASales."Amount to Assign" * (1 + "VAT %" / 100),
                                         GenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        SalesLine.VALIDATE("Unit Price", ICASales."Amount to Assign");


                                    SalesLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICASales2.TRANSFERFIELDS(ICASales);
                                    ICASales2."Document Line No." := NoLin;
                                    ICASales2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICASales2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICASales2."Amount to Assign" := ICASales2."Amount to Assign";

                                    ICASales2.INSERT(TRUE);

                                UNTIL ICASales.NEXT = 0;

                                ICASales.RESET;
                                ICASales.SETRANGE("Document Type", "Document Type");
                                ICASales.SETRANGE("Document No.", "Document No.");
                                ICASales.SETRANGE("Item Charge No.", "No.");
                                IF ICASales.FIND('-') THEN
                                    REPEAT
                                        ICASales3.GET(ICASales."Document Type", ICASales."Document No.", ICASales."Document Line No.",
                                                         ICASales."Line No.");
                                        ICASales3.DELETE;
                                    UNTIL ICASales.NEXT = 0;

                                ICASales2.FIND('-');
                                REPEAT
                                    ICASales.COPY(ICASales2);
                                    ICASales.INSERT(TRUE);
                                UNTIL ICASales2.NEXT = 0;

                                SalesLine3.COPY("Sales Line");
                                SalesLine3.DELETE(TRUE);
                            END;


                        END;
                    7: //Transfer Receipt
                        BEGIN
                            SalesLine2.RESET;
                            SalesLine2.SETRANGE("Document Type", "Document Type");
                            SalesLine2.SETRANGE("Document No.", "Document No.");
                            SalesLine2.SETRANGE(Type, Type);
                            SalesLine2.SETRANGE("No.", "No.");
                            SalesLine2.FINDFIRST;

                            ICASales.RESET;
                            ICASales.SETRANGE("Document Type", "Document Type");
                            ICASales.SETRANGE("Document No.", "Document No.");
                            ICASales.SETRANGE("Item Charge No.", "No.");
                            IF ICASales.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICASales."Item No.");
                                    SalesLine.TRANSFERFIELDS(SalesLine2);
                                    SalesLine."Line No." := NoLin;
                                    SalesLine.VALIDATE("No.");
                                    SalesLine.VALIDATE(Quantity, 1);
                                    SalesLine.VALIDATE("Qty. to Ship", 1);
                                    //AMS calcular el selectivo especifco o Advalorem
                                    ItemCharge.GET(ICASales."Item Charge No.");

                                    IF SalesHeader."Prices Including VAT" THEN
                                        SalesLine.VALIDATE("Unit Price", ROUND(ICASales."Amount to Assign" * (1 + "VAT %" / 100),
                                         GenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        SalesLine.VALIDATE("Unit Price", ICASales."Amount to Assign");

                                    SalesLine.INSERT(TRUE);
                                    AssignDimension;
                                    ICASales2.TRANSFERFIELDS(ICASales);
                                    ICASales2."Document Line No." := NoLin;
                                    ICASales2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICASales2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICASales2."Amount to Assign" := ICASales2."Amount to Assign";
                                    ICASales2.INSERT(TRUE);

                                UNTIL ICASales.NEXT = 0;

                                ICASales.RESET;
                                ICASales.SETRANGE("Document Type", "Document Type");
                                ICASales.SETRANGE("Document No.", "Document No.");
                                ICASales.SETRANGE("Item Charge No.", "No.");
                                IF ICASales.FIND('-') THEN
                                    REPEAT
                                        ICASales3.GET(ICASales."Document Type", ICASales."Document No.", ICASales."Document Line No.",
                                                         ICASales."Line No.");
                                        ICASales3.DELETE;
                                    UNTIL ICASales.NEXT = 0;

                                ICASales2.FIND('-');
                                REPEAT
                                    ICASales.COPY(ICASales2);
                                    ICASales.INSERT(TRUE);
                                UNTIL ICASales2.NEXT = 0;

                                SalesLine3.COPY("Sales Line");
                                SalesLine3.DELETE(TRUE);
                            END;

                        END;
                    8: //Return Shipment
                        BEGIN
                        END;
                    9: //Sales Shipment
                        BEGIN
                        END;
                    10: //Return Receipt
                        BEGIN
                        END;
                END;

                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
            end;

            trigger OnPreDataItem()
            begin
                SalesLine2.RESET;
                SalesLine2.SETFILTER("Document Type", GETFILTER("Document Type"));
                SalesLine2.SETFILTER("Document No.", GETFILTER("Document No."));
                SalesLine2.FINDLAST;
                NoLin := SalesLine2."Line No.";

                SalesHeader.GET(SalesLine2."Document Type", SalesLine2."Document No.");
                CounterTotal := COUNT;
                Window.OPEN(Text001);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ICA: Record 5809;
        ICASales: Record 5809;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Err001: Label 'There is not assigment of Item Charge %1 for %2 %3';
        Err002: Label 'There are lines with zero amount in Item Charge %1 for %2 %3';
        ICASales2: Record 5809 temporary;
        ICASales3: Record 5809;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        SalesLine2: Record 37;
        SalesLine3: Record 37;
        NoLin: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Transfer Receipt","Return Shipment","Sales Shipment","Return Receipt";
        Item: Record 27;
        wImporteAsignar: Decimal;
        TransfShipLine: Record 5745;
        ItemCharge: Record 5800;
        SalesShipment: Record 111;
        GenLedgerSetUp: Record 98;
        SalesInvLine: Record 113;
        wCantTotalCajas: Decimal;
        wCantTotalLitros: Decimal;
        "wFlete/Cajas": Decimal;
        wLitroXFobTotal: Decimal;
        "wSeguro/LitroXFob": Decimal;
        wSeguro: Decimal;
        wFlete: Decimal;
        wLitroXFob: Decimal;
        wCif: Decimal;
        wFobUnit: Decimal;
        Cont: Boolean;
        wAcum: Decimal;
        QtyBase: Decimal;

    procedure AssignDimension()
    var
        T37: Record 37;
        T111: Record 111;
        T5745: Record 5745;
    begin
        CASE ICASales."Applies-to Doc. Type" OF
            0: //quote
                BEGIN
                END;
            1: //Order
                BEGIN
                    IF T37.GET(T37."Document Type"::Order, ICASales."Applies-to Doc. No.", ICASales."Applies-to Doc. Line No.") THEN BEGIN
                        SalesLine."Dimension Set ID" := T37."Dimension Set ID";
                        SalesLine.MODIFY;
                    END;
                END;
            2: //Invoice
                BEGIN
                    IF T37.GET(T37."Document Type"::Invoice, ICASales."Applies-to Doc. No.", ICASales."Applies-to Doc. Line No.") THEN BEGIN
                        SalesLine."Dimension Set ID" := T37."Dimension Set ID";
                        SalesLine.MODIFY;
                    END;
                END;
            3: //Credit Memo
                BEGIN
                    IF T37.GET(T37."Document Type"::"Credit Memo", ICASales."Applies-to Doc. No.", ICASales."Applies-to Doc. Line No.") THEN BEGIN
                        SalesLine."Dimension Set ID" := T37."Dimension Set ID";
                        SalesLine.MODIFY;
                    END;
                END;
            4: //Blanket Order
                BEGIN
                END;
            5: //Return Order
                BEGIN
                END;
            6: //Receipt
                BEGIN
                    IF T111.GET(ICASales."Applies-to Doc. No.", ICASales."Applies-to Doc. Line No.") THEN BEGIN
                        SalesLine."Dimension Set ID" := T111."Dimension Set ID";
                        SalesLine.MODIFY;
                    END;
                END;
            7: //Transfer Receipt
                BEGIN
                    IF T5745.GET(ICASales."Applies-to Doc. No.", ICASales."Applies-to Doc. Line No.") THEN BEGIN
                        SalesLine."Dimension Set ID" := T5745."Dimension Set ID";
                        SalesLine.MODIFY;
                    END;
                END;
            8: //Return Shipment
                BEGIN
                END;
            9: //Sales Shipment
                BEGIN
                END;
            10: //Return Receipt
                BEGIN
                END;
        END;
    end;

    procedure CalculaArancel()
    var
        wCostoFobLitros: Decimal;
    begin
        /*
        //AMS calcular el selectivo especifco o Advalorem
        rItem.GET(ICASales."Item No.");
        rItem.TESTFIELD("Unit Volume");
        //GRN rItem.TESTFIELD("Cod. Procedencia");
        //GRN rDiageoSetUp.TESTFIELD("Netas periodo acumulado");
        
        wLitroXFob          := 0;
        "wFlete/Cajas"      := 0;
        "wSeguro/LitroXFob" := 0;
        wCif                := 0;
        wFlete              := 0;
        wFobUnit            := 0;
        
        rPurchHeader.GET(SalesLine."Document Type",SalesLine."Document No.");
        //rPurchHeader.TESTFIELD("No. Fact. Liquidacion");
        //rPurchHeader.TESTFIELD("Tasa liquidacion");
        
        
        //Buscamos Cantidad total de la factura que se esta liquidando
        rPurchInvLine.RESET;
        rPurchInvLine.SETCURRENTKEY("Document No.",Type);
        //rPurchInvLine.SETRANGE(rPurchInvLine."Document No.",rPurchHeader."No. Fact. Liquidacion");
        rPurchInvLine.SETRANGE(rPurchInvLine.Type,rPurchInvLine.Type::Item);
        IF rPurchInvLine.FIND('-') THEN
           BEGIN
            IF NOT Cont THEN
               BEGIN
                wCantTotalCajas     := 0;
                wCantTotalLitros    := 0;
                REPEAT
                 rItem.GET(rPurchInvLine."No.");
                 Cont := TRUE;
                 wCantTotalCajas  +=  rPurchInvLine.Quantity;
        //GRN         wCantTotalLitros += (rPurchInvLine.Quantity * rItem2."Unit Volume");
                 //Llevamos el costo Fob a Litros
        //GRN         wCostoFobLitros :=  (rItem2."Cod. Procedencia" * 1.30)/rItem2."Unit Volume";
                 //wAcum := ((rPurchInvLine.Quantity * rItem2."Unit Volume") * rItem2."Costo FOB");
        //GRN         wAcum := ((rPurchInvLine.Quantity * rItem2."Unit Volume") * wCostoFobLitros);
                 //wLitroXFobTotal  += ((rPurchInvLine.Quantity * rItem2."Unit Volume") * rItem2."Costo FOB");
        //GRN         wLitroXFobTotal  += ((rPurchInvLine.Quantity * rItem2."Unit Volume") * wCostoFobLitros);
                UNTIL rPurchInvLine.NEXT = 0;
               END;
        
        //GRN    "wSeguro/LitroXFob"  := rPurchHeader."Importe Seguro"/wLitroXFobTotal;
        //GRN    "wFlete/Cajas"       := rPurchHeader."Importe Flete"/wCantTotalCajas;
        
            //Buscamos Cantidad de la linea de factura que se esta liquidando
            rPurchInvLine.RESET;
        //GRN    rPurchInvLine.SETRANGE("Document No.",rPurchHeader."No. Fact. Liquidacion");
            rPurchInvLine.SETRANGE(Type,rPurchInvLine.Type::Item);
            rPurchInvLine.SETRANGE("No.",ICASales."Item No.");
            IF rPurchInvLine.FINDFIRST THEN
               BEGIN
                rItem.GET(ICASales."Item No.");
        //GRN        wFobUnit   := rItem."costo FOB";
        //GRN        wCostoFobLitros :=  ( rItem."Cod. Procedencia" * 1.30)/rItem."Unit Volume";
                //wLitroXFob := ((rPurchInvLine.Quantity * rItem."Unit Volume") * wFobUnit);
        //GRN        wLitroXFob := ((rPurchInvLine.Quantity * rItem."Unit Volume") * wCostoFobLitros);
        //GRN        wSeguro    := rPurchHeader."Importe Seguro"/ wLitroXFobTotal * wLitroXFob;
        //GRN        wFlete     := rPurchHeader."Importe Flete" / wLitroXFobTotal * wLitroXFob;
        //GRN        wCif       := (wLitroXFob + wSeguro + wFlete) * rPurchHeader."Tasa liquidacion";
        
                wImporteAsignar := wCif;
        //GRN        wImporteAsignar := wImporteAsignar * (rDiageoSetUp."Netas periodo acumulado"/100);
                SalesLine.VALIDATE("unit price",wImporteAsignar);
               END;
           END;
        
        
        */

    end;

    procedure CalculaSelectivoA()
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rPurchReceipt.RESET;
        rPurchReceipt.GET(ICASales."Applies-to Doc. No.",ICASales."Applies-to Doc. Line No.");
        rItem.GET(ICASales."Item No.");
        rItem.TESTFIELD("Monto Selectivo Advalorem");
        wImporteAsignar := rItem."Monto Selectivo Advalorem" * rPurchReceipt."Quantity (Base)";
        SalesLine.VALIDATE("unit price",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoE(TRL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        rTransferRecLine.GET(ICASales."Applies-to Doc. No.",ICASales."Applies-to Doc. Line No.");
        rItem.GET(ICASales."Item No.");
        wImporteAsignar := rItem."Selectivo Especifico" * rTransferRecLine."Quantity (Base)";
        SalesLine.VALIDATE("unit price",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoE(RL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rPurchReceipt.RESET;
        rPurchReceipt.GET(ICASales."Applies-to Doc. No.",ICASales."Applies-to Doc. Line No.");
        rItem.GET(ICASales."Item No.");
        wImporteAsignar := rItem."Selectivo Especifico" * rPurchReceipt."Quantity (Base)";
        SalesLine.VALIDATE("unit price",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoA(TRL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rTransferRecLine.GET(ICASales."Applies-to Doc. No.",ICASales."Applies-to Doc. Line No.");
        rItem.GET(ICASales."Item No.");
        rItem.TESTFIELD("Monto Selectivo Advalorem");
        wImporteAsignar := rItem."Monto Selectivo Advalorem" * rTransferRecLine."Quantity (Base)";
        SalesLine.VALIDATE("unit price",wImporteAsignar);
        */

    end;

    local procedure UpdateQty()
    var
        PurchLine: Record 39;
        PurchLine2: Record 39;
        PurchRcptLine: Record 121;
        ReturnShptLine: Record 6651;
        TransferRcptLine: Record 5747;
        SalesShptLine: Record 111;
        ReturnRcptLine: Record 6661;
        AssignableQty: Decimal;
        TotalQtyToAssign: Decimal;
        RemQtyToAssign: Decimal;
        AssgntAmount: Decimal;
        TotalAmountToAssign: Decimal;
        RemAmountToAssign: Decimal;
        UnitCost: Decimal;
    begin
        /*
        QtyBase := 0;
        CASE ICA."Applies-to Doc. Type" OF
          ICA."Applies-to Doc. Type"::Order,ICA."Applies-to Doc. Type"::Invoice:
            BEGIN
              SalesLine.GET(ICA."Applies-to Doc. Type",ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := SalesLine."Qty. Received (Base)";
            END;
          ICA."Applies-to Doc. Type"::"Return Order",ICA."Applies-to Doc. Type"::"Credit Memo":
            BEGIN
              SalesLine.GET(ICA."Applies-to Doc. Type",ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := SalesLine."Return Qty. Shipped (Base)";
            END;
          ICA."Applies-to Doc. Type"::Receipt:
            BEGIN
              PurchRcptLine.GET(ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := PurchRcptLine."Quantity (Base)";
            END;
          ICA."Applies-to Doc. Type"::"Return Shipment":
            BEGIN
              ReturnShptLine.GET(ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := ReturnShptLine."Quantity (Base)";
            END;
          ICA."Applies-to Doc. Type"::"Transfer Receipt":
            BEGIN
              TransferRcptLine.GET(ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := TransferRcptLine.Quantity;
            END;
          ICA."Applies-to Doc. Type"::"Sales Shipment":
            BEGIN
              SalesShptLine.GET(ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := SalesShptLine."Quantity (Base)";
            END;
          ICA."Applies-to Doc. Type"::"Return Receipt":
            BEGIN
              ReturnRcptLine.GET(ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := ReturnRcptLine."Quantity (Base)";
            END;
        END;
        */

    end;
}

