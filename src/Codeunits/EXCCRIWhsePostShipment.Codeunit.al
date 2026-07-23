codeunit 61028 EXCCRIWhsePostShipment
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforeCheckWhseShptLines', '', false, false)]
    local procedure WhsePostShipmentOnBeforeCheckWhseShptLines(
        var WarehouseShipmentLine: Record "Warehouse Shipment Line";
        var WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        Invoice: Boolean;
        var SuppressCommit: Boolean;
        var IsHandled: Boolean)
    begin
        ValidatePacking(WarehouseShipmentLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", 'OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify', '', false, false)]
    local procedure SalesWhsePostShipmentOnBeforeSalesHeaderModify(
        var SalesHeader: Record "Sales Header";
        var WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        var ModifyHeader: Boolean;
        WhsePostParameters: Record "Whse. Post Parameters" temporary;
        var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        if SalesHeader."Cantidad de Bultos" = WarehouseShipmentHeader."Cantidad de Bultos" then
            exit;

        SalesHeader."Cantidad de Bultos" := WarehouseShipmentHeader."Cantidad de Bultos";
        ModifyHeader := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Transfer Whse. Post Shipment", 'OnInitSourceDocumentHeaderOnBeforeTransHeaderModify', '', false, false)]
    local procedure TransferWhsePostShipmentOnBeforeTransferHeaderModify(
        var TransferHeader: Record "Transfer Header";
        var WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        var ModifyHeader: Boolean)
    begin
        if TransferHeader."Cantidad de Bultos" = WarehouseShipmentHeader."Cantidad de Bultos" then
            exit;

        TransferHeader."Cantidad de Bultos" := WarehouseShipmentHeader."Cantidad de Bultos";
        ModifyHeader := true;
    end;

    local procedure ValidatePacking(var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine2: Record "Warehouse Shipment Line";
        RegisteredWhseActivityLine: Record "Registered Whse. Activity Line";
        Location: Record Location;
    begin
        WarehouseShipmentLine.TestField("Completely Picked", true);
        WarehouseShipmentHeader.Get(WarehouseShipmentLine."No.");
        WarehouseShipmentLine.TestField("Location Code");
        Location.Get(WarehouseShipmentHeader."Location Code");

        if not Location."Packing requerido" then
            exit;

        WarehouseShipmentLine2.SetRange("No.", WarehouseShipmentLine."No.");
        if WarehouseShipmentLine2.FindSet() then
            repeat
                RegisteredWhseActivityLine.Reset();
                RegisteredWhseActivityLine.SetRange("Source No.", WarehouseShipmentLine2."Source No.");
                RegisteredWhseActivityLine.SetRange("Source Line No.", WarehouseShipmentLine2."Line No.");
                RegisteredWhseActivityLine.SetRange("Action Type", RegisteredWhseActivityLine."Action Type"::Take);
                RegisteredWhseActivityLine.FindFirst();
                RegisteredWhseActivityLine.TestField("Cantidad Empacada");
            until WarehouseShipmentLine2.Next() = 0;
    end;
}
