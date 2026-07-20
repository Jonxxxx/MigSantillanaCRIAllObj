codeunit 61005 EXCCRISalesPostYesNoSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    local procedure OnBeforeConfirmSalesPost(
        var SalesHeader: Record "Sales Header";
        var HideDialog: Boolean;
        var IsHandled: Boolean;
        var DefaultOption: Integer;
        var PostAndSend: Boolean)
    begin
        EXCCRIValidateCreditMemoReference(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        if PreviewMode or CommitIsSuppressed then
            exit;

        EXCCRISetup.Get();

        if EXCCRISetup."Funcionalidad FE Activa" then
            EXCCRIProcessElectronicInvoice(
                SalesHeader,
                SalesInvHdrNo,
                SalesCrMemoHdrNo);

        if EXCCRISetup."Config Factura Electronica CR" then
            EXCCRIProcessCostaRicaElectronicInvoice(
                SalesHeader,
                SalesInvHdrNo,
                SalesCrMemoHdrNo);
    end;

    local procedure EXCCRIValidateCreditMemoReference(
        SalesHeader: Record "Sales Header")
    var
        AllFieldsAreBlank: Boolean;
        AllFieldsAreCompleted: Boolean;
    begin
        if not
           (SalesHeader."Document Type" in
            [
                SalesHeader."Document Type"::"Credit Memo",
                SalesHeader."Document Type"::"Return Order"
            ])
        then
            exit;

        AllFieldsAreBlank :=
            (SalesHeader."Tipo Doc. Ref NC" =
             SalesHeader."Tipo Doc. Ref NC"::" ") and
            (SalesHeader."Numero Referencia FE" = '') and
            (SalesHeader."Codigo Referencia" =
             SalesHeader."Codigo Referencia"::" ");

        AllFieldsAreCompleted :=
            (SalesHeader."Tipo Doc. Ref NC" <>
             SalesHeader."Tipo Doc. Ref NC"::" ") and
            (SalesHeader."Numero Referencia FE" <> '') and
            (SalesHeader."Codigo Referencia" <>
             SalesHeader."Codigo Referencia"::" ");

        if AllFieldsAreBlank or AllFieldsAreCompleted then
            exit;

        Error(EXCCRIReferenceFieldsErr);
    end;

    local procedure EXCCRIProcessElectronicInvoice(
        SalesHeader: Record "Sales Header";
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EXCCRIElectronicInvoice: Codeunit 56003;
    begin
        if SalesInvHdrNo <> '' then begin
            SalesInvoiceHeader.Get(SalesInvHdrNo);
            //TODO: Ver EXCCRIElectronicInvoice.Factura(SalesInvoiceHeader);
        end;

        if
            (SalesCrMemoHdrNo <> '') and
            not SalesHeader.Correction
        then begin
            SalesCrMemoHeader.Get(SalesCrMemoHdrNo);
            //TODO: Ver EXCCRIElectronicInvoice.NotaCR(SalesCrMemoHeader);
        end;
    end;

    local procedure EXCCRIProcessCostaRicaElectronicInvoice(
        SalesHeader: Record "Sales Header";
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        EXCCRICostaRicaElectronicInvoice: Codeunit 52504;
    begin
        if SalesHeader."Venta TPV" then
            exit;

        if SalesInvHdrNo <> '' then begin
            SalesInvoiceHeader.Get(SalesInvHdrNo);

            //TODO: Ver 
            /*
            if
                SalesInvoiceHeader."Tipo de Venta" =
                SalesInvoiceHeader."Tipo de Venta"::Exportacion
            then
                EXCCRICostaRicaElectronicInvoice.
                    FacturaElectronicaExportacion(
                        SalesInvoiceHeader."No.")
            else
                if
                    SalesInvoiceHeader."Tipo Doc Electronico" =
                    SalesInvoiceHeader."Tipo Doc Electronico"::Factura
                then
                    EXCCRICostaRicaElectronicInvoice.
                        FacturaElectronica(
                            SalesInvoiceHeader."No.")
                else
                    EXCCRICostaRicaElectronicInvoice.
                        TiqueteElectronico_vCentral(
                            SalesInvoiceHeader."No.");*/
        end;

        if
            (SalesCrMemoHdrNo <> '') and
            not SalesHeader.Correction
        then begin
            SalesCrMemoHeader.Get(SalesCrMemoHdrNo);
            //TODO: Ver EXCCRICostaRicaElectronicInvoice.
            //TODO: Ver     NotaCreditoElectronica(
            //TODO: Ver         SalesCrMemoHeader."No.");
        end;
    end;

    var
        EXCCRIReferenceFieldsErr: Label
            'Tipo Doc. Ref NC, Numero Referencia FE, and Codigo Referencia must either all be completed or all be blank.';
}
