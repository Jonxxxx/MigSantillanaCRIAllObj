codeunit 61006 EXCCRISalesPostPrintSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(
        var SalesHeader: Record "Sales Header";
        var HideDialog: Boolean;
        var IsHandled: Boolean;
        var SendReportAsEmail: Boolean;
        var DefaultOption: Integer)
    var
        EXCCRISetup: Record 56001;
    begin
        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad FE Activa" then
            exit;

        EXCCRISetup.TestField("Reporte Factura Resguardo");
        EXCCRISetup.TestField("Reporte Factura Fact. Elect.");
        EXCCRISetup.TestField("Reporte NC Resguardo");
        EXCCRISetup.TestField("Reporte NC Elect.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforePrintInvoice', '', false, false)]
    local procedure OnBeforePrintInvoice(
        var SalesHeader: Record "Sales Header";
        SendReportAsEmail: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
        EXCCRITPVUser: Record 34002503;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CopyNo: Integer;
    begin
        if IsHandled then
            exit;

        SalesInvoiceHeader.Get(EXCCRIGetPostedDocumentNo(SalesHeader));
        SalesInvoiceHeader.SetRecFilter();

        if
            (SalesHeader."Tipo pedido" =
             SalesHeader."Tipo pedido"::TPV) and
            EXCCRITPVUser.Get(UserId())
        then begin
            for CopyNo := 1 to EXCCRITPVUser."Cantidad de Copias Contado" do
                Report.Run(
                    EXCCRITPVUser."ID Reporte contado",
                    false,
                    false,
                    SalesInvoiceHeader);

            IsHandled := true;
            exit;
        end;

        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad Imp. Fiscal Act." then
            exit;

        SalesInvoiceHeader.CalcFields("Amount Including VAT");

        if SalesInvoiceHeader."Amount Including VAT" = 0 then begin
            EXCCRISetup.TestField("Impresion Muestras");
            Report.Run(
                EXCCRISetup."Impresion Muestras",
                false,
                false,
                SalesInvoiceHeader);
        end else
            SalesInvoiceHeader.PrintRecords(false);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforePrintCrMemo', '', false, false)]
    local procedure OnBeforePrintCrMemo(
        var SalesHeader: Record "Sales Header";
        SendReportAsEmail: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        if IsHandled then
            exit;

        EXCCRISetup.Get();

        if not EXCCRISetup."Funcionalidad FE Activa" then
            exit;

        SalesCrMemoHeader.Get(EXCCRIGetPostedDocumentNo(SalesHeader));
        SalesCrMemoHeader.SetRecFilter();

        if SalesCrMemoHeader.CAE <> '' then
            Report.Run(
                EXCCRISetup."Reporte NC Elect.",
                false,
                false,
                SalesCrMemoHeader);

        if SalesCrMemoHeader.CAEC <> '' then
            Report.Run(
                EXCCRISetup."Reporte NC Resguardo",
                false,
                false,
                SalesCrMemoHeader);

        if
            (SalesCrMemoHeader.CAE = '') and
            (SalesCrMemoHeader.CAEC = '') and
            (SalesCrMemoHeader."Posting Date" < 20120301D)
        then
            Report.Run(
                EXCCRISetup."Reporte NC Resguardo",
                false,
                false,
                SalesCrMemoHeader);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforePrintShip', '', false, false)]
    local procedure OnBeforePrintShip(
        var SalesHeader: Record "Sales Header";
        SendReportAsEmail: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        if IsHandled then
            exit;

        EXCCRISetup.Get();

        if
            SalesHeader."Pedido Consignacion" or
            (SalesHeader."Tipo pedido" =
             SalesHeader."Tipo pedido"::TPV) or
            not EXCCRISetup."Imprimir Remision Venta"
        then
            IsHandled := true;
    end;

    local procedure EXCCRIGetPostedDocumentNo(
        SalesHeader: Record "Sales Header"): Code[20]
    begin
        if SalesHeader."Last Posting No." <> '' then
            exit(SalesHeader."Last Posting No.");

        exit(SalesHeader."No.");
    end;
}
