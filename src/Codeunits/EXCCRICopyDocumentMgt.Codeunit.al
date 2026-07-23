codeunit 61022 EXCCRICopyDocumentMgt
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesHeader', '', false, false)]
    local procedure CopyDocumentMgtOnAfterCopySalesHeader(
        var ToSalesHeader: Record "Sales Header";
        OldSalesHeader: Record "Sales Header";
        FromSalesHeader: Record "Sales Header";
        FromDocType: Enum "Sales Document Type From")
    begin
        ClearSalesElectronicDocumentData(ToSalesHeader, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnAfterTransferPostedInvoiceFields', '', false, false)]
    local procedure CopyDocumentMgtOnAfterTransferPostedInvoiceFields(
        var ToSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        OldSalesHeader: Record "Sales Header")
    begin
        ClearSalesElectronicDocumentData(ToSalesHeader, false);

        ToSalesHeader."E-Mail-FE" := OldSalesHeader."E-Mail-FE";
        ToSalesHeader."Posting Date" := OldSalesHeader."Posting Date";
        ToSalesHeader."Order Date" := OldSalesHeader."Order Date";
        ToSalesHeader."Document Date" := OldSalesHeader."Document Date";
        ToSalesHeader."Due Date" := OldSalesHeader."Due Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnBeforeCopySalesDocInvLine', '', false, false)]
    local procedure CopyDocumentMgtOnBeforeCopySalesInvoiceLines(
        var FromSalesInvoiceHeader: Record "Sales Invoice Header";
        var ToSalesHeader: Record "Sales Header";
        var ShouldExit: Boolean)
    begin
        FromSalesInvoiceHeader."Posting Date" := ToSalesHeader."Posting Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterTransferFieldsFromCrMemoToInv', '', false, false)]
    local procedure CopyDocumentMgtOnAfterTransferFieldsFromCrMemoToInv(
        var ToSalesHeader: Record "Sales Header";
        FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var CopyJobData: Boolean)
    begin
        ClearSalesElectronicDocumentData(ToSalesHeader, true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocOnBeforeCopySalesDocCrMemoLine', '', false, false)]
    local procedure CopyDocumentMgtOnBeforeCopySalesCrMemoLines(
        var FromSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ToSalesHeader: Record "Sales Header")
    begin
        if FromSalesCrMemoHeader."Currency Code" <> '' then
            ToSalesHeader.Validate("Currency Code", FromSalesCrMemoHeader."Currency Code");

        if ToSalesHeader."Document Type" in
           [ToSalesHeader."Document Type"::Order, ToSalesHeader."Document Type"::Invoice]
        then begin
            ToSalesHeader."No. Comprobante Fiscal Rel." := FromSalesCrMemoHeader."No. Comprobante Fiscal";
            ToSalesHeader."Tipo de ingreso" := FromSalesCrMemoHeader."Tipo de ingreso";
            ToSalesHeader."Payment Method Code" := FromSalesCrMemoHeader."Payment Method Code";
            ToSalesHeader."No. Comprobante Fiscal" := '';
        end;

        ToSalesHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopyPurchaseDocument', '', false, false)]
    local procedure CopyDocumentMgtOnBeforeCopyPurchaseDocument(
        FromDocumentType: Option;
        FromDocumentNo: Code[20];
        var ToPurchaseHeader: Record "Purchase Header";
        var IsHandled: Boolean)
    begin
        ToPurchaseHeader."No. Comprobante Fiscal Rel." := '';
        ToPurchaseHeader."No. Comprobante Fiscal" := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeCopyPurchDocInvLine', '', false, false)]
    local procedure CopyDocumentMgtOnBeforeCopyPurchInvoiceLines(
        var FromPurchInvHeader: Record "Purch. Inv. Header";
        var ToPurchaseHeader: Record "Purchase Header")
    begin
        ToPurchaseHeader."No. Comprobante Fiscal Rel." := FromPurchInvHeader."No. Comprobante Fiscal";
        ToPurchaseHeader."No. Comprobante Fiscal" := '';
        ToPurchaseHeader.Modify();

        CopyPurchaseRetentionDetails(FromPurchInvHeader, ToPurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopyPurchDocOnBeforeCopyPurchDocCrMemoLine', '', false, false)]
    local procedure CopyDocumentMgtOnBeforeCopyPurchCrMemoLines(
        var FromPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var ToPurchaseHeader: Record "Purchase Header")
    begin
        ToPurchaseHeader."No. Comprobante Fiscal Rel." := FromPurchCrMemoHdr."No. Comprobante Fiscal";
        ToPurchaseHeader."No. Comprobante Fiscal" := '';
        ToPurchaseHeader.Modify();
    end;

    local procedure ClearSalesElectronicDocumentData(
        var SalesHeader: Record "Sales Header";
        ClearEmail: Boolean)
    begin
        SalesHeader.Clave := '';
        SalesHeader.Consecutivo := '';
        SalesHeader.Estado := '';
        SalesHeader.Mensaje := '';
        SalesHeader."Fecha Doc Electronico" := 0DT;
        Clear(SalesHeader."Tipo Doc Electronico");

        if ClearEmail then
            SalesHeader."E-Mail-FE" := '';
    end;

    local procedure CopyPurchaseRetentionDetails(
        FromPurchInvHeader: Record "Purch. Inv. Header";
        ToPurchaseHeader: Record "Purchase Header")
    var
        HistoricalVendorRetention: Record "Historico Retencion Prov.";
        VendorDocumentRetention: Record "Retencion Doc. Proveedores";
    begin
        HistoricalVendorRetention.SetRange("No. documento", FromPurchInvHeader."No.");
        if HistoricalVendorRetention.FindSet() then
            repeat
                VendorDocumentRetention.Init();
                VendorDocumentRetention.TransferFields(HistoricalVendorRetention);
                VendorDocumentRetention."Tipo documento" := ToPurchaseHeader."Document Type";
                VendorDocumentRetention."No. documento" := ToPurchaseHeader."No.";
                VendorDocumentRetention.Insert();
            until HistoricalVendorRetention.Next() = 0;
    end;
}
