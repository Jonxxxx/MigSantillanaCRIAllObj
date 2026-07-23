codeunit 61021 EXCCRIUndoPostingManagement
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Posting Management", 'OnCheckItemLedgEntriesOnBeforeCheckTempItemLedgEntry', '', false, false)]
    local procedure UndoPostingManagementOnBeforeCheckTempItemLedgEntry(
        var TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        var IsHandled: Boolean)
    begin
        if TempItemLedgEntry."Order Type" <> TempItemLedgEntry."Order Type"::Assembly then
            exit;

        IsHandled := true;
    end;
}
