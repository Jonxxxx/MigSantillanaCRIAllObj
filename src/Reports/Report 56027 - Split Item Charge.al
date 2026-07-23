report 56027 "Split Item Charge"
{
    Caption = 'Split Item Charge';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Line"; 39)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

            trigger OnPostDataItem()
            begin
                rGenLedgerSetUp.GET();
                Counter += 1;
                CLEAR(wImporteAsignar);

                ICAPurchase.RESET;
                ICAPurchase.SETRANGE("Document Type", "Document Type");
                ICAPurchase.SETRANGE("Document No.", "Document No.");
                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                IF NOT ICAPurchase.FINDFIRST THEN
                    ERROR(Err001, "No.", FIELDCAPTION("Document Type"), "No.");

                ICAPurchase.RESET;
                ICAPurchase.SETRANGE("Document Type", "Document Type");
                ICAPurchase.SETRANGE("Document No.", "Document No.");
                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                ICAPurchase.SETRANGE("Amount to Assign", 0);
                IF ICAPurchase.FINDFIRST THEN
                    ERROR(Err002, "No.", FIELDCAPTION("Document Type"), "No.");


                CASE ICAPurchase."Applies-to Doc. Type" OF
                    0: //quote
                        BEGIN
                        END;
                    1: //Order
                        BEGIN
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    rItemCharge.GET(ICAPurchase."Item Charge No.");
                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");

                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FINDSET;
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;

                        END;
                    2: //Invoice
                        BEGIN
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FINDSET THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");

                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FINDSET;
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;
                        END;
                    3: //Credit Memo
                        BEGIN
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    //AMS calcular el selectivo especifco o Advalorem
                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");

                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FIND('-');
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;

                        END;
                    4: //Blanket Order
                        BEGIN
                        END;
                    5: //Return Order
                        BEGIN // devolucion compras
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");


                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FIND('-');
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;

                        END;
                    6: //Receipt
                        BEGIN
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");


                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FIND('-');
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;


                        END;
                    7: //Transfer Receipt
                        BEGIN
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);
                                    //AMS calcular el selectivo especifco o Advalorem
                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");

                                    PurchLine.INSERT(TRUE);
                                    AssignDimension;
                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";
                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FIND('-');
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;

                        END;
                    8: //Return Shipment
                        BEGIN    // nota credito compa
                            PurchLine2.RESET;
                            PurchLine2.SETRANGE("Document Type", "Document Type");
                            PurchLine2.SETRANGE("Document No.", "Document No.");
                            PurchLine2.SETRANGE(Type, Type);
                            PurchLine2.SETRANGE("No.", "No.");
                            PurchLine2.FINDFIRST;

                            ICAPurchase.RESET;
                            ICAPurchase.SETRANGE("Document Type", "Document Type");
                            ICAPurchase.SETRANGE("Document No.", "Document No.");
                            ICAPurchase.SETRANGE("Item Charge No.", "No.");
                            IF ICAPurchase.FIND('-') THEN BEGIN
                                REPEAT
                                    NoLin += 100;
                                    Window.UPDATE(1, ICAPurchase."Item No.");
                                    PurchLine.TRANSFERFIELDS(PurchLine2);
                                    PurchLine."Line No." := NoLin;
                                    PurchLine.VALIDATE("No.");
                                    PurchLine.VALIDATE(Quantity, 1);

                                    rItemCharge.GET(ICAPurchase."Item Charge No.");

                                    IF PuchHeader."Prices Including VAT" THEN
                                        PurchLine.VALIDATE("Direct Unit Cost", ROUND(ICAPurchase."Amount to Assign" * (1 + "VAT %" / 100),
                                         rGenLedgerSetUp."Amount Rounding Precision"))
                                    ELSE
                                        PurchLine.VALIDATE("Direct Unit Cost", ICAPurchase."Amount to Assign");


                                    PurchLine.INSERT(TRUE);

                                    AssignDimension;

                                    ICAPurchase2.TRANSFERFIELDS(ICAPurchase);
                                    ICAPurchase2."Document Line No." := NoLin;
                                    ICAPurchase2."Qty. to Assign" := 1;
                                    //AMS calcular el selectivo especifco o Advalorem
                                    IF wImporteAsignar <> 0 THEN
                                        ICAPurchase2."Amount to Assign" := wImporteAsignar
                                    ELSE
                                        ICAPurchase2."Amount to Assign" := ICAPurchase2."Amount to Assign";

                                    ICAPurchase2.INSERT(TRUE);

                                UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase.RESET;
                                ICAPurchase.SETRANGE("Document Type", "Document Type");
                                ICAPurchase.SETRANGE("Document No.", "Document No.");
                                ICAPurchase.SETRANGE("Item Charge No.", "No.");
                                IF ICAPurchase.FIND('-') THEN
                                    REPEAT
                                        ICAPurchase3.GET(ICAPurchase."Document Type", ICAPurchase."Document No.", ICAPurchase."Document Line No.",
                                                         ICAPurchase."Line No.");
                                        ICAPurchase3.DELETE;
                                    UNTIL ICAPurchase.NEXT = 0;

                                ICAPurchase2.FIND('-');
                                REPEAT
                                    ICAPurchase.COPY(ICAPurchase2);
                                    ICAPurchase.INSERT(TRUE);
                                UNTIL ICAPurchase2.NEXT = 0;

                                PurchLine3.COPY("Purchase Line");
                                PurchLine3.DELETE(TRUE);
                            END;

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
                PurchLine2.RESET;
                PurchLine2.SETFILTER("Document Type", GETFILTER("Document Type"));
                PurchLine2.SETFILTER("Document No.", GETFILTER("Document No."));
                PurchLine2.FINDLAST;
                NoLin := PurchLine2."Line No.";

                PuchHeader.GET(PurchLine2."Document Type", PurchLine2."Document No.");
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
        ICA: Record 5805;
        ICAPurchase: Record 5805;
        Text001: Label 'Processing  #1########## @2@@@@@@@@@@@@@';
        Err001: Label 'There is not assigment of Item Charge %1 for %2 %3';
        Err002: Label 'There are lines with zero amount in Item Charge %1 for %2 %3';
        ICAPurchase2: Record 5805 temporary;
        ICAPurchase3: Record 5805;
        PuchHeader: Record 38;
        PurchLine: Record 39;
        PurchLine2: Record 39;
        PurchLine3: Record 39;
        NoLin: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        TipoDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Transfer Receipt","Return Shipment","Sales Shipment","Return Receipt";
        rItem: Record 27;
        wImporteAsignar: Decimal;
        rTransfRecpLine: Record 5747;
        rItemCharge: Record 5800;
        rPurchReceipt: Record 121;
        rGenLedgerSetUp: Record 98;
        rPurchInvLine: Record 123;
        rPurchHeader: Record 38;
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
        rItem2: Record 27;
        QtyBase: Decimal;

    procedure AssignDimension()
    var
        recLinCmpOrigen: Record 39;
        recLinCmpDestino: Record 39;
        recLinAlbOrigen: Record 121;
        recLinTransfOrigen: Record 5747;
        recLinReturnShipment: Record 6651;
    begin
        CASE ICAPurchase."Applies-to Doc. Type" OF
            0: //quote
                BEGIN
                END;
            1: //Order
                BEGIN
                    /*
                    DocDim2.SETRANGE("Table ID",39);
                    DocDim2.SETRANGE("Document No.",ICAPurchase."Applies-to Doc. No.");
                    DocDim2.SETRANGE("Line No.",ICAPurchase."Applies-to Doc. Line No.");
                    IF DocDim2.FIND('-') THEN
                       REPEAT
                        DocDim."Table ID"             := 39;
                        DocDim."Document Type"        := "Purchase Line"."Document Type";
                        DocDim."Document No."         := "Purchase Line"."Document No.";
                        DocDim."Line No."             := NoLin;
                        DocDim."Dimension Code"       := DocDim2."Dimension Code";
                        DocDim."Dimension Value Code" := DocDim2."Dimension Value Code";
                        IF DocDim.INSERT(TRUE) THEN;
                       UNTIL DocDim2.NEXT = 0;
                    */
                    recLinCmpOrigen.GET(ICAPurchase."Applies-to Doc. Type", ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.");
                    recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                    recLinCmpDestino."Dimension Set ID" := recLinCmpOrigen."Dimension Set ID";
                    recLinCmpDestino.MODIFY;


                END;
            2: //Invoice
                BEGIN
                    /*
                    PostedDocDim.SETRANGE("Table ID",39);
                    PostedDocDim.SETRANGE("Document No.",ICAPurchase."Applies-to Doc. No.");
                    PostedDocDim.SETRANGE("Line No.",ICAPurchase."Applies-to Doc. Line No.");
                    IF PostedDocDim.FIND('-') THEN
                       REPEAT
                        DocDim."Table ID"             := 39;
                        DocDim."Document Type"        := "Purchase Line"."Document Type";
                        DocDim."Document No."         := "Purchase Line"."Document No.";
                        DocDim."Line No."             := NoLin;
                        DocDim."Dimension Code"       := PostedDocDim."Dimension Code";
                        DocDim."Dimension Value Code" := PostedDocDim."Dimension Value Code";
                        IF DocDim.INSERT(TRUE) THEN;
                       UNTIL PostedDocDim.NEXT = 0;
                   */
                    recLinCmpOrigen.GET(ICAPurchase."Applies-to Doc. Type", ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.");
                    recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                    recLinCmpDestino."Dimension Set ID" := recLinCmpOrigen."Dimension Set ID";
                    recLinCmpDestino.MODIFY;

                END;


            3: //Credit Memo
                BEGIN
                END;
            4: //Blanket Order
                BEGIN
                END;
            5: //Return Order
                BEGIN

                    // ++ #173474
                    IF recLinAlbOrigen.GET(ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.") THEN BEGIN
                        recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                        recLinCmpDestino."Dimension Set ID" := recLinAlbOrigen."Dimension Set ID";
                        recLinCmpDestino.MODIFY;
                    END
                    ELSE BEGIN
                        IF recLinCmpOrigen.GET(ICAPurchase."Applies-to Doc. Type", ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.") THEN BEGIN
                            recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                            recLinCmpDestino."Dimension Set ID" := recLinCmpOrigen."Dimension Set ID";
                            recLinCmpDestino.MODIFY;
                        END
                        ELSE BEGIN
                            IF recLinReturnShipment.GET(ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.") THEN BEGIN
                                recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                                recLinCmpDestino."Dimension Set ID" := recLinReturnShipment."Dimension Set ID";
                                recLinCmpDestino.MODIFY;
                            END
                        END
                    END

                    // -- #173474
                    // 6650  recLinReturnShipment
                END;

            6: //Receipt
                BEGIN
                    /*
                     PostedDocDim.SETRANGE("Table ID",121);
                     PostedDocDim.SETRANGE("Document No.",ICAPurchase."Applies-to Doc. No.");
                     PostedDocDim.SETRANGE("Line No.",ICAPurchase."Applies-to Doc. Line No.");
                     IF PostedDocDim.FIND('-') THEN
                        REPEAT
                         DocDim."Table ID"             := 39;
                         DocDim."Document Type"        := "Purchase Line"."Document Type";
                         DocDim."Document No."         := "Purchase Line"."Document No.";
                         DocDim."Line No."             := NoLin;
                         DocDim."Dimension Code"       := PostedDocDim."Dimension Code";
                         DocDim."Dimension Value Code" := PostedDocDim."Dimension Value Code";
                         IF DocDim.INSERT(TRUE) THEN;
                        UNTIL PostedDocDim.NEXT = 0;
                     */
                    recLinAlbOrigen.GET(ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.");
                    recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                    recLinCmpDestino."Dimension Set ID" := recLinAlbOrigen."Dimension Set ID";
                    recLinCmpDestino.MODIFY;

                END;
            7: //Transfer Receipt
                BEGIN
                    /*
                     PostedDocDim.SETRANGE("Table ID",5747);
                     PostedDocDim.SETRANGE("Document No.",ICAPurchase."Applies-to Doc. No.");
                     PostedDocDim.SETRANGE("Line No.",ICAPurchase."Applies-to Doc. Line No.");
                     IF PostedDocDim.FIND('-') THEN
                        REPEAT
                         DocDim."Table ID"             := 39;
                         DocDim."Document Type"        := "Purchase Line"."Document Type";
                         DocDim."Document No."         := "Purchase Line"."Document No.";
                         DocDim."Line No."             := NoLin;
                         DocDim."Dimension Code"       := PostedDocDim."Dimension Code";
                         DocDim."Dimension Value Code" := PostedDocDim."Dimension Value Code";
                         IF DocDim.INSERT(TRUE) THEN;
                        UNTIL PostedDocDim.NEXT = 0;
                      */
                    recLinTransfOrigen.GET(ICAPurchase."Applies-to Doc. No.", ICAPurchase."Applies-to Doc. Line No.");
                    recLinCmpDestino.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.", NoLin);
                    recLinCmpDestino."Dimension Set ID" := recLinTransfOrigen."Dimension Set ID";
                    recLinCmpDestino.MODIFY;

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
        rItem.GET(ICAPurchase."Item No.");
        rItem.TESTFIELD("Unit Volume");
        //GRN rItem.TESTFIELD("Cod. Procedencia");
        //GRN rDiageoSetUp.TESTFIELD("Netas periodo acumulado");
        
        wLitroXFob          := 0;
        "wFlete/Cajas"      := 0;
        "wSeguro/LitroXFob" := 0;
        wCif                := 0;
        wFlete              := 0;
        wFobUnit            := 0;
        
        rPurchHeader.GET(PurchLine."Document Type",PurchLine."Document No.");
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
                 rItem2.GET(rPurchInvLine."No.");
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
            rPurchInvLine.SETRANGE("No.",ICAPurchase."Item No.");
            IF rPurchInvLine.FINDFIRST THEN
               BEGIN
                rItem.GET(ICAPurchase."Item No.");
        //GRN        wFobUnit   := rItem."costo FOB";
        //GRN        wCostoFobLitros :=  ( rItem."Cod. Procedencia" * 1.30)/rItem."Unit Volume";
                //wLitroXFob := ((rPurchInvLine.Quantity * rItem."Unit Volume") * wFobUnit);
        //GRN        wLitroXFob := ((rPurchInvLine.Quantity * rItem."Unit Volume") * wCostoFobLitros);
        //GRN        wSeguro    := rPurchHeader."Importe Seguro"/ wLitroXFobTotal * wLitroXFob;
        //GRN        wFlete     := rPurchHeader."Importe Flete" / wLitroXFobTotal * wLitroXFob;
        //GRN        wCif       := (wLitroXFob + wSeguro + wFlete) * rPurchHeader."Tasa liquidacion";
        
                wImporteAsignar := wCif;
        //GRN        wImporteAsignar := wImporteAsignar * (rDiageoSetUp."Netas periodo acumulado"/100);
                PurchLine.VALIDATE("Direct Unit Cost",wImporteAsignar);
               END;
           END;
        
        
        */

    end;

    procedure CalculaSelectivoA()
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rPurchReceipt.RESET;
        rPurchReceipt.GET(ICAPurchase."Applies-to Doc. No.",ICAPurchase."Applies-to Doc. Line No.");
        rItem.GET(ICAPurchase."Item No.");
        rItem.TESTFIELD("Monto Selectivo Advalorem");
        wImporteAsignar := rItem."Monto Selectivo Advalorem" * rPurchReceipt."Quantity (Base)";
        PurchLine.VALIDATE("Direct Unit Cost",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoE(TRL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        rTransferRecLine.GET(ICAPurchase."Applies-to Doc. No.",ICAPurchase."Applies-to Doc. Line No.");
        rItem.GET(ICAPurchase."Item No.");
        wImporteAsignar := rItem."Selectivo Especifico" * rTransferRecLine."Quantity (Base)";
        PurchLine.VALIDATE("Direct Unit Cost",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoE(RL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rPurchReceipt.RESET;
        rPurchReceipt.GET(ICAPurchase."Applies-to Doc. No.",ICAPurchase."Applies-to Doc. Line No.");
        rItem.GET(ICAPurchase."Item No.");
        wImporteAsignar := rItem."Selectivo Especifico" * rPurchReceipt."Quantity (Base)";
        PurchLine.VALIDATE("Direct Unit Cost",wImporteAsignar);
        */

    end;

    procedure "CalculaSelectivoA(TRL)"()
    var
        rTransferRecLine: Record 5747;
    begin
        /*
        //Calcular el selectivo especifco o Advalorem
        rTransferRecLine.GET(ICAPurchase."Applies-to Doc. No.",ICAPurchase."Applies-to Doc. Line No.");
        rItem.GET(ICAPurchase."Item No.");
        rItem.TESTFIELD("Monto Selectivo Advalorem");
        wImporteAsignar := rItem."Monto Selectivo Advalorem" * rTransferRecLine."Quantity (Base)";
        PurchLine.VALIDATE("Direct Unit Cost",wImporteAsignar);
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
              PurchLine.GET(ICA."Applies-to Doc. Type",ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := PurchLine."Qty. Received (Base)";
            END;
          ICA."Applies-to Doc. Type"::"Return Order",ICA."Applies-to Doc. Type"::"Credit Memo":
            BEGIN
              PurchLine.GET(ICA."Applies-to Doc. Type",ICA."Applies-to Doc. No.",ICA."Applies-to Doc. Line No.");
              QtyBase := PurchLine."Return Qty. Shipped (Base)";
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

