using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.Utilities;

codeunit 61017 EXCCRIPostedSalesCorrMgt
{
    procedure CreateSalesInvoiceCopyDocument(
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var SalesHeader: Record "Sales Header")
    begin
        CreateCopyDocumentCredit(
            SalesCrMemoHeader,
            SalesHeader,
            SalesHeader."Document Type"::Order);
    end;

    procedure CreateCopyDocumentCredit(
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var SalesHeader: Record "Sales Header";
        DocumentType: Enum "Sales Document Type")
    var
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
    begin
        EXCCRIInitializeSalesHeader(
            SalesHeader,
            DocumentType,
            EXCCRISalesOrderNoSeriesCodeLbl,
            EXCCRILegacyPostingDate());

        case DocumentType of
            SalesHeader."Document Type"::"Credit Memo":
                CopyDocumentMgt.SetPropertiesForCreditMemoCorrection();
            SalesHeader."Document Type"::Order:
                CopyDocumentMgt.SetPropertiesForInvoiceCorrection(true);
            else
                Error(EXCCRIWrongDocumentTypeErr);
        end;

        CopyDocumentMgt.CopySalesDocForCrMemoCancelling(
            SalesCrMemoHeader."No.",
            SalesHeader);
    end;

    procedure CreateCreditMemoCopyDocument2(
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesHeader: Record "Sales Header"): Boolean
    var
        CopyDocumentMgt: Codeunit "Copy Document Mgt.";
    begin
        EXCCRIValidateInvoiceForCopy(SalesInvoiceHeader);

        EXCCRIInitializeSalesHeader(
            SalesHeader,
            SalesHeader."Document Type"::"Credit Memo",
            EXCCRICreditMemoNoSeriesCodeLbl,
            EXCCRILegacyPostingDate());

        CopyDocumentMgt.SetPropertiesForCreditMemoCorrection();
        CopyDocumentMgt.CopySalesDocForInvoiceCancelling(
            SalesInvoiceHeader."No.",
            SalesHeader);

        exit(true);
    end;

    local procedure EXCCRIInitializeSalesHeader(
        var SalesHeader: Record "Sales Header";
        DocumentType: Enum "Sales Document Type";
        NoSeriesCode: Code[20];
        PostingDate: Date)
    var
        NoSeries: Codeunit "No. Series";
    begin
        Clear(SalesHeader);
        SalesHeader.Init();
        SalesHeader."Document Type" := DocumentType;
        SalesHeader."No." :=
            NoSeries.GetNextNo(
                NoSeriesCode,
                WorkDate());
        SalesHeader."Posting No." := SalesHeader."No.";
        SalesHeader."Posting Date" := PostingDate;
        SalesHeader.SetAllowSelectNoSeries();
        SalesHeader.Insert(true);
    end;

    local procedure EXCCRIValidateInvoiceForCopy(
        SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        if SalesInvoiceHeader."Prepayment Invoice" then
            Error(EXCCRIPrepaymentInvoiceErr);

        SalesInvoiceLine.SetRange(
            "Document No.",
            SalesInvoiceHeader."No.");
        SalesInvoiceLine.SetRange(
            Type,
            SalesInvoiceLine.Type::"Fixed Asset");

        if not SalesInvoiceLine.IsEmpty() then
            Error(EXCCRIFixedAssetInvoiceErr);
    end;

    local procedure EXCCRILegacyPostingDate(): Date
    begin
        exit(20220103D);
    end;

    var
        EXCCRISalesOrderNoSeriesCodeLbl: Label 'V FACT21R', Locked = true;
        EXCCRICreditMemoNoSeriesCodeLbl: Label 'VNR21', Locked = true;
        EXCCRIWrongDocumentTypeErr: Label
            'You cannot correct or cancel this type of document.';
        EXCCRIPrepaymentInvoiceErr: Label
            'You cannot correct or cancel a posted sales prepayment invoice. Open the related sales order and post a prepayment credit memo instead.';
        EXCCRIFixedAssetInvoiceErr: Label
            'You cannot create the document because the posted sales invoice contains fixed asset lines. Use the fixed asset cancellation process instead.';
}
