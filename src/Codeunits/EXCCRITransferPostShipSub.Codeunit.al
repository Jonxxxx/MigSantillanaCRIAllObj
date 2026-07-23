using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Transfer;

codeunit 61027 EXCCRITransferPostShipSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun(
        var TransferHeader: Record "Transfer Header";
        var HideValidationDialog: Boolean;
        var SuppressCommit: Boolean;
        PreviewMode: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
    begin
        if IsHandled then
            exit;

        EXCCRISetup.Get();
        if not EXCCRISetup."Funcionalidad Consig. Activa" then
            exit;

        ReleaseTransferDocument.Reopen(TransferHeader);
        TransferHeader.Validate(
            "Posting Date",
            WorkDate());
        TransferHeader.Validate(
            "Shipment Date",
            WorkDate());
        TransferHeader.TestField(
            "External Document No.");
        TransferHeader.TestField(
            "Cod. Vendedor");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLine(
        var ItemJournalLine: Record "Item Journal Line";
        TransferLine: Record "Transfer Line";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Precio Unitario Cons. Inicial" :=
            TransferShipmentLine."Precio Venta Consignacion";
        ItemJournalLine."Descuento % Cons. Inicial" :=
            TransferShipmentLine."Descuento % Consignacion";
        ItemJournalLine."Importe Cons. bruto Inicial" :=
            TransferShipmentLine."Precio Venta Consignacion" *
            -TransferShipmentLine.Quantity;
        ItemJournalLine."Importe Cons Neto Inicial" :=
            -TransferShipmentLine."Importe Consignacion";
        ItemJournalLine."Pedido Consignacion" :=
            TransferShipmentHeader."Pedido Consignacion";
        ItemJournalLine."Devolucion Consignacion" :=
            TransferShipmentHeader."Devolucion Consignacion";
        ItemJournalLine."No. Mov. Prod. Cosg. a Liq." :=
            TransferShipmentLine."No. Linea Pedido Consignacion";
        ItemJournalLine.ISBN :=
            TransferShipmentLine.ISBN;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransLineModify', '', false, false)]
    local procedure OnBeforeTransLineModify(
        var TransferLine: Record "Transfer Line";
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        EXCCRISetup.Get();
        if not EXCCRISetup."Funcionalidad Consig. Activa" then
            exit;

        TransferLine."Qty. in Transit" :=
            TransferLine."Qty. in Transit" -
            TransferLine."Cantidad Devuelta";
        TransferLine."Qty. to Ship" :=
            TransferLine."Qty. to Ship" -
            TransferLine."Cantidad Devuelta";
        TransferLine."Qty. in Transit (Base)" :=
            TransferLine."Qty. in Transit (Base)" -
            TransferLine."Cantidad Devuelta";
        TransferLine."Qty. to Receive" :=
            TransferLine."Qty. to Receive" -
            TransferLine."Cantidad Devuelta";
    end;
}
