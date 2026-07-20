codeunit 61000 EXCCRIEventSubscriber
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    var
        EXCCRISalesHeader: Record "Sales Header";
    begin
        if not EXCCRISalesHeader.Get(
            SalesLine."Document Type",
            SalesLine."Document No.")
        then
            exit;

        if EXCCRISalesHeader."Pedido Consignacion" then begin
            ItemJnlLine."Precio Unitario Cons. Inicial" :=
                SalesLine."Unit Price";
            ItemJnlLine."Descuento % Cons. Inicial" :=
                SalesLine."Line Discount %";
            ItemJnlLine."Importe Cons. bruto Inicial" :=
                SalesLine."Unit Price" *
                SalesLine."Qty. to Invoice";
            ItemJnlLine."Importe Cons Neto Inicial" :=
                ItemJnlLine."Importe Cons. bruto Inicial" -
                SalesLine."Line Discount Amount";
            ItemJnlLine."No. Mov. Prod. Cosg. a Liq." :=
                SalesLine."No. Mov. Prod. Cosg. a Liq.";
            ItemJnlLine."Pedido Consignacion" := true;
        end;

        ItemJnlLine."No aplica Derechos de Autor" :=
            EXCCRISalesHeader."No aplica Derechos de Autor";
        ItemJnlLine."Cod. Colegio" :=
            EXCCRISalesHeader."Cod. Colegio";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."Collector Code" := GenJournalLine."Collector Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnBeforeCleanupAfterExecution', '', false, false)]
    local procedure OnBeforeCleanupAfterExecution(
        var JobQueueEntry: Record "Job Queue Entry";
        var IsHandled: Boolean)
    begin
        if IsHandled then
            exit;
        if not JobQueueEntry."Recurring Job" then
            exit;
        if not JobQueueEntry."Hold On Finish" then
            exit;

        JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
        JobQueueEntry."Hold On Finish" := false;
        JobQueueEntry.Modify(false);

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", 'OnAfterFinalizeRun', '', false, false)]
    local procedure OnAfterFinalizeRun(JobQueueEntry: Record "Job Queue Entry")
    var
    //TODO: Ver EXCCRINotifyError: Codeunit 50300;
    begin
        if JobQueueEntry.Status <> JobQueueEntry.Status::Error then
            exit;

        //TODO: Ver EXCCRINotifyError.Run(JobQueueEntry);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure OnAfterCopyTransferShipmentHeader(
        var TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Cantidad de Bultos" :=
            TransferHeader."Cantidad de Bultos";
        TransferShipmentHeader.Observaciones :=
            TransferHeader.Observaciones;
        TransferShipmentHeader."Prioridad entrega consignacion" :=
            TransferHeader."Prioridad entrega consignacion";
        TransferShipmentHeader."Cod. Vendedor" :=
            TransferHeader."Cod. Vendedor";
        TransferShipmentHeader."Pedido Consignacion" :=
            TransferHeader."Pedido Consignacion";
        TransferShipmentHeader."Devolucion Consignacion" :=
            TransferHeader."Devolucion Consignacion";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure OnAfterCopyTransferShipmentLine(
        var TransferShipmentLine: Record "Transfer Shipment Line";
        TransferLine: Record "Transfer Line")
    begin
        TransferShipmentLine."Precio Venta Consignacion" :=
            TransferLine."Precio Venta Consignacion";
        TransferShipmentLine."Descuento % Consignacion" :=
            TransferLine."Descuento % Consignacion";
        TransferShipmentLine."Importe Consignacion" :=
            TransferLine."Importe Consignacion";
        TransferShipmentLine."No. Mov. Prod. Cosg. a Liq." :=
            TransferLine."No. Mov. Prod. Cosg. a Liq.";
        TransferShipmentLine."No. Linea Pedido Consignacion" :=
            TransferLine."No. Linea Pedido Consignacion";
        TransferShipmentLine."No. Pedido Consignacion" :=
            TransferLine."No. Pedido Consignacion";
        TransferShipmentLine.ISBN :=
            TransferLine.ISBN;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure OnAfterCopyTransferReceiptHeader(
        var TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Cantidad de Bultos" :=
            TransferHeader."Cantidad de Bultos";
        TransferReceiptHeader.Observaciones :=
            TransferHeader.Observaciones;
        TransferReceiptHeader."Consignacion Muestras" :=
            TransferHeader."Consignacion Muestras";
        TransferReceiptHeader."Cod. Ubicacion Alm. Origen" :=
            TransferHeader."Cod. Ubicacion Alm. Origen";
        TransferReceiptHeader."Cod. Ubicacion Alm. Destino" :=
            TransferHeader."Cod. Ubicacion Alm. Destino";
        TransferReceiptHeader."Prioridad entrega consignacion" :=
            TransferHeader."Prioridad entrega consignacion";
        TransferReceiptHeader."Cod. Vendedor" :=
            TransferHeader."Cod. Vendedor";
        TransferReceiptHeader."Pedido Consignacion" :=
            TransferHeader."Pedido Consignacion";
        TransferReceiptHeader."Devolucion Consignacion" :=
            TransferHeader."Devolucion Consignacion";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CopyFromToPriceListLine, 'OnCopyFromSalesPrice', '', false, false)]
    local procedure OnCopyFromSalesPrice(
        var SalesPrice: Record "Sales Price";
        var PriceListLine: Record "Price List Line")
    begin
        PriceListLine."Source counter" :=
            SalesPrice."Source counter";
        PriceListLine.IdJobQueueEntry :=
            SalesPrice.IdJobQueueEntry;
        PriceListLine.Location :=
            SalesPrice.Location;
        PriceListLine."Precio manual" :=
            SalesPrice."Precio manual";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CopyFromToPriceListLine, 'OnCopyToSalesPrice', '', false, false)]
    local procedure OnCopyToSalesPrice(
        var SalesPrice: Record "Sales Price";
        var PriceListLine: Record "Price List Line")
    begin
        SalesPrice."Source counter" :=
            PriceListLine."Source counter";
        SalesPrice.IdJobQueueEntry :=
            PriceListLine.IdJobQueueEntry;
        SalesPrice.Location :=
            PriceListLine.Location;
        SalesPrice."Precio manual" :=
            PriceListLine."Precio manual";
    end;
}
