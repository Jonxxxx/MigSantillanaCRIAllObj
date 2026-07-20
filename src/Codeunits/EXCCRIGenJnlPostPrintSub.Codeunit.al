codeunit 61011 EXCCRIGenJnlPostPrintSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnBeforePostJournalBatch', '', false, false)]
    local procedure OnBeforePostJournalBatch(
        var GenJournalLine: Record "Gen. Journal Line";
        var HideDialog: Boolean)
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        EXCCRILastVendorEntryNo := 0;

        if VendorLedgerEntry.FindLast() then
            EXCCRILastVendorEntryNo := VendorLedgerEntry."Entry No.";

        EXCCRIPostingStarted := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnAfterOnRun', '', false, false)]
    local procedure OnAfterOnRun(
        var GenJournalLine: Record "Gen. Journal Line")
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        VendorLedgerEntryToNotify: Record "Vendor Ledger Entry";
        EXCCRINotificationFunctions: Codeunit 34003007;
        PaymentFound: Boolean;
    begin
        if not EXCCRIPostingStarted then
            exit;

        EXCCRIPostingStarted := false;

        Commit();

        VendorLedgerEntry.SetFilter(
            "Entry No.",
            '>%1',
            EXCCRILastVendorEntryNo);
        VendorLedgerEntry.SetRange(
            "Document Type",
            VendorLedgerEntry."Document Type"::Payment);

        if VendorLedgerEntry.FindSet(false, false) then
            repeat
                VendorLedgerEntryToNotify.Reset();
                VendorLedgerEntryToNotify.SetRange(
                    "Entry No.",
                    VendorLedgerEntry."Entry No.");

                //TOOD: Ver EXCCRINotificationFunctions.
                //TOOD: Ver     EnviaEmailPagosMovProv(
                //TOOD: Ver         VendorLedgerEntryToNotify);
                PaymentFound := true;
            until VendorLedgerEntry.Next() = 0;

        if PaymentFound and GuiAllowed() then
            Message(EXCCRINotificationSentMsg);
    end;

    var
        EXCCRILastVendorEntryNo: Integer;
        EXCCRIPostingStarted: Boolean;
        EXCCRINotificationSentMsg: Label 'Notification sent';
}
