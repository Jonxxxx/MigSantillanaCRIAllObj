codeunit 61009 EXCCRICustEntryEditSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', false, false)]
    local procedure OnBeforeCustLedgEntryModify(
        var CustLedgEntry: Record "Cust. Ledger Entry";
        FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.Validate(
            "Fecha Recepcion Documento",
            FromCustLedgEntry."Fecha Recepcion Documento");
    end;
}
