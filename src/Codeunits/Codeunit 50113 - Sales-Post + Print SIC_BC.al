codeunit 50113 "Sales-Post + Print SIC_BC"
{
    // YFC     : Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001         11/10/2023      YFC           SANTINAV-4683 Crear proceso para envio de facturas POS hacia Hacienda
    // 002         08/08/2024      LDP           SANTINAV-6837: Facturas pendientes de liquidar

    TableNo = 36;

    trigger OnRun()
    var
        SalesHeader: Record 36;
    begin
        SalesHeader.COPY(Rec);
        Code(SalesHeader);
        Rec := SalesHeader;
    end;

    var
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';
        PostAndPrintQst: Label 'Do you want to post and print the %1?', Comment = '%1 = Document Type';
        PostAndEmailQst: Label 'Do you want to post and email the %1?', Comment = '%1 = Document Type';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        SendReportAsEmail: Boolean;
        i: Integer;
        rConfEmp: Record 56001;

    [Scope('Internal')]
    procedure PostAndEmail(var ParmSalesHeader: Record 36)
    var
        SalesHeader: Record 36;
    begin
        SendReportAsEmail := TRUE;
        SalesHeader.COPY(ParmSalesHeader);
        Code(SalesHeader);
        ParmSalesHeader := SalesHeader;
    end;

    local procedure "Code"(var SalesHeader: Record 36)
    var
        SalesSetup: Record 311;
        SalesPostViaJobQueue: Codeunit 88;
        HideDialog: Boolean;
    begin
        HideDialog := TRUE;

        /*
        OnBeforeConfirmPost(SalesHeader,HideDialog);
        IF NOT HideDialog THEN
          IF NOT ConfirmPost(SalesHeader) THEN
            EXIT;
        */

        SalesSetup.GET;
        IF SalesSetup."Post & Print with Job Queue" AND NOT SendReportAsEmail THEN
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        ELSE BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            END ELSE BEGIN
                CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            END;
            GetReport(SalesHeader);
        END;

        // ++ 001-YFC
        rConfEmp.GET;
        IF rConfEmp."Config Factura Electronica CR" THEN
            FE_CR(SalesHeader);
        // -- 001-YFC

        OnAfterPost(SalesHeader);
        COMMIT;

        //002+ Registro de Cobros Dspos
        RegistroCobrosDsPos(SalesHeader);
        //002- Registro de Cobros Dspos

    end;

    [Scope('Personalization')]
    procedure GetReport(var SalesHeader: Record 36)
    begin
        WITH SalesHeader DO
            CASE "Document Type" OF
                "Document Type"::Order:
                    BEGIN
                        //IF Ship THEN
                        //  PrintShip(SalesHeader);
                        //        IF Invoice THEN
                        //          PrintInvoice(SalesHeader);
                    END;
                //"Document Type"::Invoice:
                //PrintInvoice(SalesHeader);
                "Document Type"::"Return Order":
                    BEGIN
                        /* IF Receive THEN // NO IMPRIMIR DEVOLUCIONES AUTOMATICAMENTE
                           PrintReceive(SalesHeader);
                         IF Invoice THEN
                           PrintCrMemo(SalesHeader);*/
                    END;
                "Document Type"::"Credit Memo":
                    BEGIN
                        //PrintCrMemo(SalesHeader);
                    END;
            END;

    end;

    local procedure ConfirmPost(var SalesHeader: Record 36): Boolean
    var
        Selection: Integer;
    begin
        WITH SalesHeader DO BEGIN
            CASE "Document Type" OF
                "Document Type"::Order:
                    BEGIN
                        Selection := STRMENU(ShipInvoiceQst, 3);
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                        Ship := Selection IN [1, 3];
                        Invoice := Selection IN [2, 3];
                    END;
                "Document Type"::"Return Order":
                    BEGIN
                        Selection := STRMENU(ReceiveInvoiceQst, 3);
                        IF Selection = 0 THEN
                            EXIT(FALSE);
                        Receive := Selection IN [1, 3];
                        Invoice := Selection IN [2, 3];
                    END
                ELSE
                    IF NOT CONFIRM(ConfirmationMessage, FALSE, "Document Type") THEN
                        EXIT(FALSE);
            END;
            "Print Posted Documents" := TRUE;
        END;
        EXIT(TRUE);
    end;

    local procedure ConfirmationMessage(): Text
    begin
        IF SendReportAsEmail THEN
            EXIT(PostAndEmailQst);
        EXIT(PostAndPrintQst);
    end;

    local procedure PrintReceive(SalesHeader: Record 36)
    var
        ReturnRcptHeader: Record 6660;
    begin
        ReturnRcptHeader."No." := SalesHeader."Last Return Receipt No.";
        IF ReturnRcptHeader.FIND THEN;
        ReturnRcptHeader.SETRECFILTER;

        IF SendReportAsEmail THEN
            ReturnRcptHeader.EmailRecords(TRUE)
        ELSE
            ReturnRcptHeader.PrintRecords(FALSE);
    end;

    local procedure PrintInvoice(SalesHeader: Record 36)
    var
        SalesInvHeader: Record 112;
    begin
        IF SalesHeader."Last Posting No." = '' THEN
            SalesInvHeader."No." := SalesHeader."No."
        ELSE
            SalesInvHeader."No." := SalesHeader."Last Posting No.";
        SalesInvHeader.FIND;
        SalesInvHeader.SETRECFILTER;

        ///JERM
        //TestPrintMult.TestPirint(SalesInvHeader."No.");
        ///JERM
        //
        //
        // IF SendReportAsEmail THEN
        //  SalesInvHeader.EmailRecords(TRUE)
        // ELSE;
        //  // ++ YFC
        //  //SalesInvHeader.PrintRecords(FALSE);
        //  BEGIN
        //    FOR i := 1 TO 2 DO
        //      BEGIN
        //        CASE i OF
        //          1: BEGIN
        //               FacturaventaKettleSanchez.RecibirValores('Original');
        //               FacturaventaKettleSanchez.RecibePedido(SalesInvHeader."No.");
        //
        //             END;
        //          2: BEGIN
        //               FacturaventaKettleSanchez.RecibirValores('Copia Original');
        //               FacturaventaKettleSanchez.RecibePedido(SalesInvHeader."No.");
        //
        //             END;
        //        END;
        //        FacturaventaKettleSanchez.RUN;
        //    // REPORT.RUNMODAL(50010,FALSE,FALSE,RecVarToPrint);
        //      //CLEAR(FacturaventaKettleSanchez);
        //      END;
        //    //REPORT.RUNMODAL(50032,FALSE,FALSE,RecVarToPrint);
        //    FacturaventaKettleSVS20.RecibePedido(SalesInvHeader."No.");
        //    FacturaventaKettleSVS20.RUN;
        //  END;

        // --
    end;

    local procedure PrintShip(SalesHeader: Record 36)
    var
        SalesShptHeader: Record 110;
    begin
        SalesShptHeader."No." := SalesHeader."Last Shipping No.";
        IF SalesShptHeader.FIND THEN;
        SalesShptHeader.SETRECFILTER;

        IF SendReportAsEmail THEN
            SalesShptHeader.EmailRecords(TRUE)
        ELSE
            SalesShptHeader.PrintRecords(FALSE);
    end;

    local procedure PrintCrMemo(SalesHeader: Record 36)
    var
        SalesCrMemoHeader: Record 114;
    begin
        IF SalesHeader."Last Posting No." = '' THEN
            SalesCrMemoHeader."No." := SalesHeader."No."
        ELSE
            SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
        SalesCrMemoHeader.FIND;
        SalesCrMemoHeader.SETRECFILTER;

        IF SendReportAsEmail THEN
            SalesCrMemoHeader.EmailRecords(TRUE)
        ELSE
            SalesCrMemoHeader.PrintRecords(FALSE);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPost(var SalesHeader: Record 36)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeConfirmPost(var SalesHeader: Record 36; var HideDialog: Boolean)
    begin
    end;

    procedure FE_CR(SalesHeader: Record 36)
    var
        "**012**": Integer;
        cuFE: Codeunit 52504;
        txtResp: array[7] of Text[1024];
        rSIH: Record 112;
        NoFactReg: Code[20];
        rSCMH: Record 114;
    begin
        // ++ 001-YFC

        IF (NOT SalesHeader."Venta TPV") THEN
            EXIT;

        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR
           (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN BEGIN
            IF rSIH.GET(SalesHeader."Last Posting No.") THEN;

            //TODO: Ver IF rSIH."Tipo Doc Electronico" = rSIH."Tipo Doc Electronico"::Tiquete THEN
            //TODO: Ver    cuFE.TiqueteElectronico_vCentral(rSIH."No.");
        END;

        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order")) AND
            (NOT SalesHeader.Correction) THEN BEGIN
            //TODO: Ver IF rSCMH.GET(SalesHeader."Last Posting No.") THEN
            //TODO: Ver    cuFE.TiqueteElectronicoNCR_vCentral(rSCMH."No.");
        END;

        // -- 001-YFC
    end;

    procedure RegistroCobrosDsPos(SalesHeader: Record 36)
    var
        ConfiEmpresa: Record 56001;
        RegisCobrDsPos: Codeunit 50116;
        rSIH: Record 112;
        rSCMH: Record 114;
    begin
        ConfiEmpresa.GET;
        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR
           (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice)) AND
           ConfiEmpresa."Liquidar Factura TPV" THEN BEGIN
            IF rSIH.GET(SalesHeader."Last Posting No.") THEN
                RegisCobrDsPos.RegistrarCobrosFacturaTPV(rSIH);
        END;

        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order")) AND
           ConfiEmpresa."Liquidar Nota Credito TPV" THEN BEGIN
            IF rSCMH.GET(SalesHeader."Last Posting No.") THEN
                RegisCobrDsPos.RegistrarCobrosNotaCreditoTPV(rSCMH);
        END;
    end;
}

