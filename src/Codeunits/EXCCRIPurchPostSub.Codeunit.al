codeunit 61008 EXCCRIPurchPostSub
{
    Permissions =
        tabledata "Purch. Inv. Header" = rm,
        tabledata "Purch. Cr. Memo Hdr." = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        CommitIsSupressed: Boolean;
        var HideProgressWindow: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        EXCCRISetup.Get();

        if
            (PurchaseHeader."Document Type" in
             [
                 PurchaseHeader."Document Type"::Order,
                 PurchaseHeader."Document Type"::Invoice
             ]) and
            EXCCRISetup."Forma Pago Oblig. en Compra"
        then
            PurchaseHeader.TestField("Payment Method Code");

        EXCCRIMdMFunctions.ContrlFechasDocC(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeUpdatePostingNos', '', false, false)]
    local procedure OnBeforeUpdatePostingNos(
        var PurchHeader: Record "Purchase Header";
        var ModifyHeader: Boolean;
        SuppressCommit: Boolean;
        var IsHandled: Boolean;
        var DateOrderSeriesUsed: Boolean)
    var
        ContextKey: Text;
    begin
        ContextKey := EXCCRIGetPostingContextKey(PurchHeader);
        EXCCRINewPostingNoContext.Remove(ContextKey);

        if not PurchHeader.Invoice then
            exit;

        if PurchHeader."Posting No." <> '' then
            exit;

        if
            (PurchHeader."No. Series" =
             PurchHeader."Posting No. Series") and
            not
            (PurchHeader."Document Type" in
             [
                 PurchHeader."Document Type"::Order,
                 PurchHeader."Document Type"::"Return Order"
             ])
        then
            exit;

        EXCCRINewPostingNoContext.Add(ContextKey, true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdatePostingNos', '', false, false)]
    local procedure OnAfterUpdatePostingNos(
        var PurchaseHeader: Record "Purchase Header";
        CommitIsSupressed: Boolean;
        PreviewMode: Boolean;
        var ModifyHeader: Boolean)
    var
        ContextKey: Text;
        GenerateNCF: Boolean;
    begin
        ContextKey := EXCCRIGetPostingContextKey(PurchaseHeader);

        if not EXCCRINewPostingNoContext.Get(ContextKey, GenerateNCF) then
            exit;

        EXCCRINewPostingNoContext.Remove(ContextKey);

        if PreviewMode or not GenerateNCF then
            exit;

        EXCCRIGeneratePurchaseNCF(PurchaseHeader);
        ModifyHeader := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostCommitPurchaseDoc', '', false, false)]
    local procedure OnBeforePostCommitPurchaseDoc(
        var PurchaseHeader: Record "Purchase Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PreviewMode: Boolean;
        var ModifyHeader: Boolean;
        var CommitIsSupressed: Boolean;
        var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        EXCCRIVendor: Record Vendor;
        EXCCRILocalization: Codeunit 34003002;
    begin
        if not PurchaseHeader.Invoice then
            exit;

        EXCCRIVendor.Get(PurchaseHeader."Buy-from Vendor No.");
        EXCCRILocalization.ValidaNCFCompras(PurchaseHeader);
        EXCCRILocalization.ValidaClasifGasto(PurchaseHeader);
        PurchaseHeader.TestField("Payment Method Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdateLastPostingNos', '', false, false)]
    local procedure OnAfterUpdateLastPostingNos(
        var PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader.Invoice then
            PurchHeader."No. Comprobante Fiscal" := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure OnBeforePurchInvHeaderInsert(
        var PurchInvHeader: Record "Purch. Inv. Header";
        var PurchHeader: Record "Purchase Header";
        CommitIsSupressed: Boolean)
    var
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        if not PurchInvHeader.Correction then
            exit;

        PurchCrMemoHeader.SetRange(
            "Buy-from Vendor No.",
            PurchInvHeader."Buy-from Vendor No.");
        PurchCrMemoHeader.SetRange(
            "No. Comprobante Fiscal",
            PurchInvHeader."No. Comprobante Fiscal Rel.");

        if not PurchCrMemoHeader.FindFirst() then
            exit;

        if PurchCrMemoHeader."No. Comprobante Fiscal" = '' then
            exit;

        PurchCrMemoHeader."No. Comprobante Fiscal" :=
            CopyStr(
                EXCCRICorrectionPrefixLbl +
                CopyStr(
                    PurchCrMemoHeader."No. Comprobante Fiscal",
                    6,
                    8),
                1,
                MaxStrLen(
                    PurchCrMemoHeader."No. Comprobante Fiscal"));
        PurchCrMemoHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoHeaderInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoHeaderInsert(
        var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var PurchHeader: Record "Purchase Header";
        CommitIsSupressed: Boolean)
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if not PurchCrMemoHdr.Correction then
            exit;

        PurchInvHeader.SetRange(
            "Buy-from Vendor No.",
            PurchCrMemoHdr."Buy-from Vendor No.");
        PurchInvHeader.SetRange(
            "No. Comprobante Fiscal",
            PurchCrMemoHdr."No. Comprobante Fiscal Rel.");

        if not PurchInvHeader.FindFirst() then
            exit;

        if PurchInvHeader."No. Comprobante Fiscal" = '' then
            exit;

        PurchInvHeader."No. Comprobante Fiscal" :=
            CopyStr(
                EXCCRICorrectionPrefixLbl +
                CopyStr(
                    PurchInvHeader."No. Comprobante Fiscal",
                    6,
                    8),
                1,
                MaxStrLen(
                    PurchInvHeader."No. Comprobante Fiscal"));
        PurchInvHeader.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertCombinedSalesShipment', '', false, false)]
    local procedure OnAfterInsertCombinedSalesShipment(
        var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        EXCCRIMdMFunctions.ContrlFechasAlbV(SalesShipmentHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(
        var PurchaseHeader: Record "Purchase Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        PurchRcpHdrNo: Code[20];
        RetShptHdrNo: Code[20];
        PurchInvHdrNo: Code[20];
        PurchCrMemoHdrNo: Code[20];
        CommitIsSupressed: Boolean)
    var
        EXCCRIMdMFunctions: Codeunit 75000;
    begin
        EXCCRIMdMFunctions.ContrlFechasMdMTmp(1);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdatePurchaseHeader', '', false, false)]
    local procedure OnAfterUpdatePurchaseHeader(
        var VendorLedgerEntry: Record "Vendor Ledger Entry";
        var PurchInvHeader: Record "Purch. Inv. Header";
        var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        GenJnlLineDocType: Integer;
        GenJnlLineDocNo: Code[20];
        PreviewMode: Boolean;
        var PurchaseHeader: Record "Purchase Header")
    var
        EXCCRIWithholdings: Codeunit 34003000;
    begin
        EXCCRIWithholdings.Run(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnAfterPrepareGenJnlLine', '', false, false)]
    local procedure OnAfterPrepareGenJnlLine(
        var GenJnlLine: Record "Gen. Journal Line";
        PurchHeader: Record "Purchase Header";
        InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    begin
        GenJnlLine."No. Comprobante Fiscal" :=
            PurchHeader."No. Comprobante Fiscal";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnPostLedgerEntryOnBeforeGenJnlPostLine', '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(
        var GenJnlLine: Record "Gen. Journal Line";
        var PurchHeader: Record "Purchase Header";
        var TotalPurchLine: Record "Purchase Line";
        var TotalPurchLineLCY: Record "Purchase Line";
        PreviewMode: Boolean;
        SuppressCommit: Boolean;
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        GenJnlLine."No. Comprobante Fiscal" :=
            PurchHeader."No. Comprobante Fiscal";
        GenJnlLine."Cod. Clasificacion Gasto" :=
            PurchHeader."Cod. Clasificacion Gasto";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnPostBalancingEntryOnAfterInitNewLine', '', false, false)]
    local procedure OnPostBalancingEntryOnAfterInitNewLine(
        var GenJnlLine: Record "Gen. Journal Line";
        var PurchHeader: Record "Purchase Header")
    var
        ContextKey: Text;
    begin
        GenJnlLine."No. Comprobante Fiscal" :=
            PurchHeader."No. Comprobante Fiscal";
        GenJnlLine."Cod. Clasificacion Gasto" :=
            PurchHeader."Cod. Clasificacion Gasto";

        ContextKey := EXCCRIGetRetentionContextKey(
            PurchHeader."Posting No.",
            GenJnlLine."Document No.");

        EXCCRIRetentionContext.Remove(ContextKey);
        EXCCRIRetentionContext.Add(
            ContextKey,
            PurchHeader."Document Type" =
            PurchHeader."Document Type"::"Credit Memo");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnBeforeSetAmountsForBalancingEntry', '', false, false)]
    local procedure OnBeforeSetAmountsForBalancingEntry(
        var VendLedgEntry: Record "Vendor Ledger Entry";
        var GenJnlLine: Record "Gen. Journal Line";
        var TotalPurchLine: Record "Purchase Line";
        var TotalPurchLineLCY: Record "Purchase Line";
        var IsHandled: Boolean)
    var
        ContextKey: Text;
        IsCreditMemo: Boolean;
    begin
        ContextKey := EXCCRIGetRetentionContextKey(
            VendLedgEntry."Document No.",
            GenJnlLine."Document No.");

        if not EXCCRIRetentionContext.Get(
            ContextKey,
            IsCreditMemo)
        then
            IsCreditMemo :=
                VendLedgEntry."Document Type" =
                VendLedgEntry."Document Type"::"Credit Memo";

        if not EXCCRIHasRetention(
            IsCreditMemo,
            VendLedgEntry."Document No.")
        then
            exit;

        VendLedgEntry.CalcFields(
            "Remaining Amount",
            "Remaining Amt. (LCY)",
            Amount);

        GenJnlLine.Amount :=
            -VendLedgEntry."Remaining Amount" +
            VendLedgEntry."Remaining Pmt. Disc. Possible";
        GenJnlLine."Source Currency Amount" :=
            GenJnlLine.Amount;

        if VendLedgEntry.Amount = 0 then
            GenJnlLine."Amount (LCY)" :=
                TotalPurchLineLCY."Amount Including VAT"
        else
            GenJnlLine."Amount (LCY)" :=
                -VendLedgEntry."Remaining Amt. (LCY)" +
                Round(
                    VendLedgEntry.
                        "Remaining Pmt. Disc. Possible" /
                    VendLedgEntry."Adjusted Currency Factor");

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", 'OnPostBalancingEntryOnBeforeGenJnlPostLine', '', false, false)]
    local procedure OnPostBalancingEntryOnBeforeGenJnlPostLine(
        var GenJnlLine: Record "Gen. Journal Line";
        var PurchHeader: Record "Purchase Header";
        var TotalPurchLine: Record "Purchase Line";
        var TotalPurchLineLCY: Record "Purchase Line";
        PreviewMode: Boolean;
        SuppressCommit: Boolean;
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        ContextKey: Text;
        IsCreditMemo: Boolean;
    begin
        IsCreditMemo :=
            PurchHeader."Document Type" =
            PurchHeader."Document Type"::"Credit Memo";

        if EXCCRIHasRetention(
            IsCreditMemo,
            PurchHeader."Posting No.")
        then
            Clear(GenJnlPostLine);

        ContextKey := EXCCRIGetRetentionContextKey(
            PurchHeader."Posting No.",
            GenJnlLine."Document No.");
        EXCCRIRetentionContext.Remove(ContextKey);
    end;

    local procedure EXCCRIGeneratePurchaseNCF(
        var PurchaseHeader: Record "Purchase Header")
    var
        VendorPostingGroup: Record "Vendor Posting Group";
        NoSeriesLine: Record "No. Series Line";
        NoSeries: Codeunit "No. Series";
        NCFSeriesCode: Code[20];
    begin
        if PurchaseHeader.Correction then
            exit;

        VendorPostingGroup.Get(
            PurchaseHeader."Vendor Posting Group");

        if not VendorPostingGroup."Permite Emitir NCF" then
            exit;

        if not EXCCRIValidateInternationalServices(
            PurchaseHeader,
            VendorPostingGroup.Internacional)
        then
            exit;

        PurchaseHeader.TestField("VAT Registration No.");

        if
            PurchaseHeader."Document Type" in
            [
                PurchaseHeader."Document Type"::Order,
                PurchaseHeader."Document Type"::Invoice
            ]
        then begin
            PurchaseHeader.TestField(
                "No. Serie NCF Facturas");
            NCFSeriesCode :=
                PurchaseHeader."No. Serie NCF Facturas";
        end else begin
            PurchaseHeader.TestField(
                "No. Serie NCF Abonos");
            NCFSeriesCode :=
                PurchaseHeader."No. Serie NCF Abonos";
        end;

        NoSeriesLine.SetRange(
            "Series Code",
            NCFSeriesCode);
        NoSeriesLine.SetFilter(
            "Starting Date",
            '>=%1',
            DMY2Date(1, 5, 2018));
        NoSeriesLine.SetRange(Open, true);
        NoSeriesLine.FindFirst();

        if
            (PurchaseHeader."Posting Date" >
             NoSeriesLine."Expiration date") and
            (NoSeriesLine."Expiration date" <> 0D)
        then
            Error(
                EXCCRINCFExpirationErr,
                PurchaseHeader.FieldCaption("Posting Date"),
                NoSeriesLine.FieldCaption("Expiration date"),
                PurchaseHeader."Posting Date",
                NoSeriesLine."Expiration date");

        if PurchaseHeader."No. Comprobante Fiscal" = '' then begin
            PurchaseHeader."Fecha vencimiento NCF" :=
                NoSeriesLine."Expiration date";
            PurchaseHeader."No. Comprobante Fiscal" :=
                NoSeries.GetNextNo(
                    NCFSeriesCode,
                    PurchaseHeader."Posting Date");
        end;
    end;

    local procedure EXCCRIValidateInternationalServices(
        PurchaseHeader: Record "Purchase Header";
        InternationalVendor: Boolean): Boolean
    var
        PurchaseLine: Record "Purchase Line";
        VATProductPostingGroup: Record "VAT Product Posting Group";
        VATPostingSetup: Record "VAT Posting Setup";
        ServiceFound: Boolean;
    begin
        if not InternationalVendor then
            exit(true);

        PurchaseLine.SetRange(
            "Document Type",
            PurchaseHeader."Document Type");
        PurchaseLine.SetRange(
            "Document No.",
            PurchaseHeader."No.");

        if PurchaseLine.FindSet() then
            repeat
                VATPostingSetup.Reset();
                VATPostingSetup.SetRange(
                    "VAT Bus. Posting Group",
                    PurchaseLine."VAT Bus. Posting Group");
                VATPostingSetup.SetRange(
                    "VAT Prod. Posting Group",
                    PurchaseLine."VAT Prod. Posting Group");

                if VATPostingSetup.FindFirst() then
                    if VATPostingSetup."VAT %" > 0 then
                        Error(EXCCRIInternationalTaxErr);

                VATProductPostingGroup.Reset();
                VATProductPostingGroup.SetRange(
                    Code,
                    PurchaseLine."VAT Prod. Posting Group");

                if VATProductPostingGroup.FindFirst() then
                    if
                        VATProductPostingGroup.
                            "Tipo de bien-servicio" =
                        VATProductPostingGroup.
                            "Tipo de bien-servicio"::Servicios
                    then
                        ServiceFound := true;
            until PurchaseLine.Next() = 0;

        exit(ServiceFound);
    end;

    local procedure EXCCRIHasRetention(
        IsCreditMemo: Boolean;
        DocumentNo: Code[20]): Boolean
    var
        RetentionDocument: Record 34003003;
    begin
        RetentionDocument.Reset();

        if IsCreditMemo then
            RetentionDocument.SetRange(
                "Tipo documento",
                RetentionDocument."Tipo documento"::"Credit Memo")
        else
            RetentionDocument.SetRange(
                "Tipo documento",
                RetentionDocument."Tipo documento"::Invoice);

        RetentionDocument.SetRange(
            "No. documento",
            DocumentNo);

        exit(RetentionDocument.FindFirst());
    end;

    local procedure EXCCRIGetPostingContextKey(
        PurchaseHeader: Record "Purchase Header"): Text
    begin
        exit(
            StrSubstNo(
                '%1|%2',
                Format(PurchaseHeader."Document Type", 0, 9),
                PurchaseHeader."No."));
    end;

    local procedure EXCCRIGetRetentionContextKey(
        PrimaryDocumentNo: Code[20];
        FallbackDocumentNo: Code[20]): Text
    begin
        if PrimaryDocumentNo <> '' then
            exit(PrimaryDocumentNo);

        exit(FallbackDocumentNo);
    end;

    var
        EXCCRINewPostingNoContext: Dictionary of [Text, Boolean];
        EXCCRIRetentionContext: Dictionary of [Text, Boolean];
        EXCCRICorrectionPrefixLbl: Label 'CORREC';
        EXCCRINCFExpirationErr: Label
            '%1 cannot be later than %2 of the NCF number series. The corresponding values are %3 and %4.';
        EXCCRIInternationalTaxErr: Label
            'Lines in orders for international vendors must be exempt from tax.';
}
