codeunit 61024 EXCCRIItemBudgetManagement
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Budget Management", 'OnFindRecOnBeforeItemFind', '', false, false)]
    local procedure ItemBudgetManagementOnFindRecordBeforeItemFind(var Item: Record Item)
    begin
        Item.SetRange(Inactivo, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Budget Management", 'OnNextRecOnBeforeItemFind', '', false, false)]
    local procedure ItemBudgetManagementOnNextRecordBeforeItemFind(var Item: Record Item)
    begin
        Item.SetRange(Inactivo, false);
    end;
}
