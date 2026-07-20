codeunit 61010 EXCCRIDocumentPrintSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforePrintCheck', '', false, false)]
    local procedure OnBeforePrintCheck(
        var GenJournalLine: Record "Gen. Journal Line";
        var IsPrinted: Boolean)
    var
        BankAccount: Record "Bank Account";
    begin
        if IsPrinted then
            exit;

        if
            GenJournalLine."Bal. Account Type" =
            GenJournalLine."Bal. Account Type"::"Bank Account"
        then
            BankAccount.Get(GenJournalLine."Bal. Account No.")
        else
            BankAccount.Get(GenJournalLine."Account No.");

        BankAccount.TestField("Check Report ID");

        Report.RunModal(
            BankAccount."Check Report ID",
            true,
            false,
            GenJournalLine);

        IsPrinted := true;
    end;
}
