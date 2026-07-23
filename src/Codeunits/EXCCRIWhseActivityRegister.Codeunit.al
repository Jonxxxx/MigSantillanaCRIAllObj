codeunit 61026 EXCCRIWhseActivityRegister
{
    [EventSubscriber(
        ObjectType::Codeunit,
        Codeunit::"Whse.-Activity-Register",
        'OnAfterCreateRegActivLine',
        '',
        false,
        false)]
    local procedure WhseActivityRegisterOnAfterCreateRegActivLine(
        var WarehouseActivityLine: Record "Warehouse Activity Line";
        var RegisteredWhseActivLine: Record "Registered Whse. Activity Line";
        var RegisteredInvtMovementLine: Record "Registered Invt. Movement Line")
    var
        SalesLine: Record "Sales Line";
    begin
        if WarehouseActivityLine."Activity Type" <>
           WarehouseActivityLine."Activity Type"::Pick
        then
            exit;

        if WarehouseActivityLine."Action Type" <>
           WarehouseActivityLine."Action Type"::Take
        then
            exit;

        if WarehouseActivityLine."Source Document" <>
           WarehouseActivityLine."Source Document"::"Sales Order"
        then
            exit;

        if not SalesLine.Get(
             SalesLine."Document Type"::Order,
             WarehouseActivityLine."Source No.",
             WarehouseActivityLine."Source Line No.")
        then
            exit;

        SalesLine."Bin Ranking" := WarehouseActivityLine."Bin Ranking";
        SalesLine.Modify();
    end;
}
