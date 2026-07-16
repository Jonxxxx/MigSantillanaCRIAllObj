codeunit 34003004 "Pre Sales-Order to Order"
{
    // DSLoc1.01   GRN     04/07/2011    Para adicionar funcionalidad Facturacion con limite de lineas - Guatemala

    TableNo = 36;

    trigger OnRun()
    var
        Result: Decimal;
    begin
        TESTFIELD("Pre pedido", TRUE);

        //DSLoc1.01
        ConfigSantillana.GET();
        ConfigSantillana.TESTFIELD(Country);
        ParamPais.GET(ConfigSantillana.Country);
        IF ParamPais."Control Lin. por Factura" THEN
            ParamPais.TESTFIELD("Cantidad Lin. por factura");
        // *** End ***

        Cust.GET("Sell-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, "Document Type"::Order, TRUE, FALSE);
        CALCFIELDS("Amount Including VAT");
        SalesOrderHeader := Rec;
        SalesQuoteHeader := Rec;

        IF GUIALLOWED AND NOT HideValidationDialog THEN
            CustCheckCreditLimit.SalesHeaderCheck(SalesOrderHeader);
        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;

        SalesQuoteLine.RESET;
        SalesQuoteLine.SETRANGE("Document Type", "Document Type");
        SalesQuoteLine.SETRANGE("Document No.", "No.");
        SalesQuoteLine.SETRANGE(Type, SalesQuoteLine.Type::Item);
        SalesQuoteLine.SETFILTER("No.", '<>%1', '');
        IF SalesQuoteLine.FINDSET THEN
            REPEAT
                ContLin += 1;
                IF (SalesQuoteLine."Outstanding Quantity" > 0) THEN BEGIN
                    SalesLine := SalesQuoteLine;
                    SalesLine.VALIDATE("Reserved Qty. (Base)", 0);
                    SalesLine."Line No." := 0;
                    IF GUIALLOWED AND NOT HideValidationDialog THEN BEGIN
                        IF ItemCheckAvail.SalesLineCheck(SalesLine) THEN
                            ItemCheckAvail.RaiseUpdateInterruptedError;
                    END;
                END;
            UNTIL SalesQuoteLine.NEXT = 0;


        Result := ContLin / ParamPais."Cantidad Lin. por factura" MOD 1;
        IF Result <> 0 THEN
            FOR i := 1 TO ROUND(ContLin / ParamPais."Cantidad Lin. por factura", 1, '<') + 1 DO
                CrearCabecera
        ELSE
            FOR i := 1 TO ROUND(ContLin / ParamPais."Cantidad Lin. por factura", 1, '<') DO
                CrearCabecera;


        DELETELINKS;
        DELETE;

        SalesQuoteLine.RESET;
        SalesQuoteLine.SETRANGE("Document Type", "Document Type");
        SalesQuoteLine.SETRANGE("Document No.", "No.");
        SalesQuoteLine.DELETEALL;

        COMMIT;
        CLEAR(CustCheckCreditLimit);
        CLEAR(ItemCheckAvail);
    end;

    var
        Text000: Label 'An Open Opportunity is linked to this quote.\';
        Text001: Label 'It has to be closed before an Order can be made.\';
        Text002: Label 'Do you wish to close this Opportunity now?';
        Text003: Label 'Wizard Aborted';
        SalesQuoteLine: Record 37;
        SalesLine: Record 37;
        SalesOrderHeader: Record 36;
        SalesOrderLine: Record 37;
        SalesCommentLine: Record 44;
        ItemChargeAssgntSales: Record 5809;
        CustCheckCreditLimit: Codeunit 312;
        ItemCheckAvail: Codeunit 311;
        ReserveSalesLine: Codeunit 99000832;
        DocDim: Codeunit 408;
        PrepmtMgt: Codeunit 441;
        HideValidationDialog: Boolean;
        Text004: Label 'The Opportunity has not been closed. The program has aborted making the Order.';
        SalesDocLineComment: Record 44;
        SalesSetup: Record 311;
        ArchiveManagement: Codeunit 5063;
        ContLin: Integer;
        "*** DSLoc1.01 ***": Integer;
        SalesQuoteHeader: Record 36;
        ParamPais: Record 34003011;
        Seq: Integer;
        i: Integer;
        OldSalesCommentLine: Record 44;
        Cust: Record 18;
        "*** Santillana ***": Integer;
        ConfigSantillana: Record 56001;
        NoLin: Integer;

    procedure GetSalesOrderHeader(var SalesHeader2: Record 36)
    begin
        SalesHeader2 := SalesOrderHeader;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure CrearCabecera()
    var
        CantLin: Integer;
        ATOLink: Record 904;
    begin
        Seq += 1;
        CantLin := 0;
        SalesOrderHeader."No. Printed" := 0;
        SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
        SalesOrderHeader."No." := SalesQuoteHeader."No." + '-' + FORMAT(Seq);
        CLEAR(SalesOrderHeader."Pre pedido");
        SalesOrderLine.LOCKTABLE;
        SalesOrderHeader.INSERT(TRUE);

        SalesOrderHeader."Order Date" := SalesOrderHeader."Order Date";
        IF SalesOrderHeader."Posting Date" <> 0D THEN
            SalesOrderHeader."Posting Date" := SalesOrderHeader."Posting Date";
        SalesOrderHeader."Document Date" := SalesOrderHeader."Document Date";
        SalesOrderHeader."Shipment Date" := SalesOrderHeader."Shipment Date";
        SalesOrderHeader."Shortcut Dimension 1 Code" := SalesOrderHeader."Shortcut Dimension 1 Code";
        SalesOrderHeader."Shortcut Dimension 2 Code" := SalesOrderHeader."Shortcut Dimension 2 Code";

        SalesOrderHeader."Location Code" := SalesOrderHeader."Location Code";
        SalesOrderHeader."Outbound Whse. Handling Time" := SalesOrderHeader."Outbound Whse. Handling Time";
        SalesOrderHeader."Ship-to Name" := SalesOrderHeader."Ship-to Name";
        SalesOrderHeader."Ship-to Name 2" := SalesOrderHeader."Ship-to Name 2";
        SalesOrderHeader."Ship-to Address" := SalesOrderHeader."Ship-to Address";
        SalesOrderHeader."Ship-to Address 2" := SalesOrderHeader."Ship-to Address 2";
        SalesOrderHeader."Ship-to City" := SalesOrderHeader."Ship-to City";
        SalesOrderHeader."Ship-to Post Code" := SalesOrderHeader."Ship-to Post Code";
        SalesOrderHeader."Ship-to County" := SalesOrderHeader."Ship-to County";
        SalesOrderHeader."Ship-to Country/Region Code" := SalesOrderHeader."Ship-to Country/Region Code";
        SalesOrderHeader."Ship-to Contact" := SalesOrderHeader."Ship-to Contact";

        SalesOrderHeader."Prepayment %" := Cust."Prepayment %";
        IF SalesOrderHeader."Posting Date" = 0D THEN
            SalesOrderHeader."Posting Date" := WORKDATE;

        SalesOrderHeader.MODIFY;

        SalesQuoteLine.RESET;
        SalesQuoteLine.SETRANGE("Document Type", SalesQuoteHeader."Document Type");
        SalesQuoteLine.SETRANGE("Document No.", SalesQuoteHeader."No.");

        IF NoLin <> 0 THEN
            SalesQuoteLine.SETFILTER("Line No.", '%1..', NoLin);

        IF SalesQuoteLine.FINDSET THEN
            REPEAT
                CantLin += 1;
                NoLin := SalesQuoteLine."Line No.";

                IF CantLin > ParamPais."Cantidad Lin. por factura" THEN
                    EXIT;

                SalesOrderLine := SalesQuoteLine;
                SalesOrderLine."Document Type" := SalesOrderHeader."Document Type";
                SalesOrderLine."Document No." := SalesOrderHeader."No.";
                ReserveSalesLine.TransferSaleLineToSalesLine(
                  SalesQuoteLine, SalesOrderLine, SalesQuoteLine."Outstanding Qty. (Base)");
                SalesOrderLine."Shortcut Dimension 1 Code" := SalesQuoteLine."Shortcut Dimension 1 Code";
                SalesOrderLine."Shortcut Dimension 2 Code" := SalesQuoteLine."Shortcut Dimension 2 Code";

                IF Cust."Prepayment %" <> 0 THEN
                    SalesOrderLine."Prepayment %" := Cust."Prepayment %";
                PrepmtMgt.SetSalesPrepaymentPct(SalesOrderLine, SalesOrderHeader."Posting Date");
                SalesOrderLine.VALIDATE("Prepayment %");

                SalesOrderLine.INSERT;

            /*//fes mig
                IF ATOLink.AsmExistsForSalesLine(SalesQuoteLine) THEN
                  ATOLink.TransferQuoteToSalesOrderLine(SalesQuoteLine,SalesOrderLine);
                ReserveSalesLine.TransferSaleLineToSalesLine(
                  SalesQuoteLine,SalesOrderLine,SalesQuoteLine."Outstanding Qty. (Base)");
                ReserveSalesLine.VerifyQuantity(SalesOrderLine,SalesQuoteLine);

                IF SalesOrderLine.Reserve = SalesOrderLine.Reserve::Always THEN BEGIN
                  SalesOrderLine.AutoReserve(FALSE);
                END;
            */
            UNTIL SalesQuoteLine.NEXT = 0;

        SalesSetup.GET;

        IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN BEGIN
            SalesOrderHeader."Posting Date" := 0D;
            SalesOrderHeader.MODIFY;
        END;

        SalesCommentLine.SETRANGE("Document Type", SalesQuoteLine."Document Type");
        SalesCommentLine.SETRANGE("No.", SalesQuoteHeader."No.");
        IF NOT SalesCommentLine.ISEMPTY THEN BEGIN
            SalesCommentLine.LOCKTABLE;
            IF SalesCommentLine.FINDSET THEN
                REPEAT
                    OldSalesCommentLine := SalesCommentLine;
                    SalesCommentLine.DELETE;
                    SalesCommentLine."Document Type" := SalesOrderHeader."Document Type";
                    SalesCommentLine."No." := SalesOrderHeader."No.";
                    SalesCommentLine.INSERT;
                    SalesCommentLine := OldSalesCommentLine;
                UNTIL SalesCommentLine.NEXT = 0;
        END;
        SalesOrderHeader.COPYLINKS(SalesQuoteHeader);

        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type", SalesQuoteHeader."Document Type");
        ItemChargeAssgntSales.SETRANGE("Document No.", SalesQuoteHeader."No.");
        WHILE ItemChargeAssgntSales.FINDFIRST DO BEGIN
            ItemChargeAssgntSales.DELETE;
            ItemChargeAssgntSales."Document Type" := SalesOrderHeader."Document Type";
            ItemChargeAssgntSales."Document No." := SalesOrderHeader."No.";
            IF NOT (ItemChargeAssgntSales."Applies-to Doc. Type" IN
                    [ItemChargeAssgntSales."Applies-to Doc. Type"::Shipment,
                     ItemChargeAssgntSales."Applies-to Doc. Type"::"Return Receipt"])
            THEN BEGIN
                ItemChargeAssgntSales."Applies-to Doc. Type" := SalesOrderHeader."Document Type";
                ItemChargeAssgntSales."Applies-to Doc. No." := SalesOrderHeader."No.";
            END;
            ItemChargeAssgntSales.INSERT;
        END;

    end;
}

