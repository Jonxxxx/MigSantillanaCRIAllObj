codeunit 61003 EXCCRIItemJnlPostLineSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(
        var NewItemLedgEntry: Record "Item Ledger Entry";
        var ItemJournalLine: Record "Item Journal Line";
        var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Precio Unitario Cons. Inicial" :=
            ItemJournalLine."Precio Unitario Cons. Inicial";
        NewItemLedgEntry."Descuento % Cons. Inicial" :=
            ItemJournalLine."Descuento % Cons. Inicial";
        NewItemLedgEntry."Importe Cons. bruto Inicial" :=
            ItemJournalLine."Importe Cons. bruto Inicial";
        NewItemLedgEntry."Importe Cons. Neto Inicial" :=
            ItemJournalLine."Importe Cons Neto Inicial";
        NewItemLedgEntry."No. Mov. Prod. Cosg. a Liq." :=
            ItemJournalLine."No. Mov. Prod. Cosg. a Liq.";
        NewItemLedgEntry."Pedido Consignacion" :=
            ItemJournalLine."Pedido Consignacion";
        NewItemLedgEntry."Devolucion Consignacion" :=
            ItemJournalLine."Devolucion Consignacion";

        NewItemLedgEntry."Precio Unitario Cons. Act." :=
            ItemJournalLine."Precio Unitario Cons. Inicial";
        NewItemLedgEntry."Descuento % Cons. Actualizado" :=
            ItemJournalLine."Descuento % Cons. Inicial";
        NewItemLedgEntry."Importe Cons. bruto Act." :=
            ItemJournalLine."Importe Cons. bruto Inicial";
        NewItemLedgEntry."Importe Cons. Neto Act." :=
            ItemJournalLine."Importe Cons Neto Inicial";

        NewItemLedgEntry."No aplica Derechos de Autor" :=
            ItemJournalLine."No aplica Derechos de Autor";
        NewItemLedgEntry.Promocion :=
            ItemJournalLine.Promocion;
        NewItemLedgEntry."Cod. Colegio" :=
            ItemJournalLine."Cod. Colegio";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(
        var ValueEntry: Record "Value Entry";
        var ItemJournalLine: Record "Item Journal Line";
        var ValueEntryNo: Integer;
        var ItemLedgEntry: Record "Item Ledger Entry")
    begin
        ValueEntry."Precio Unitario Consignacion" :=
            ItemJournalLine."Precio Unitario Cons. Inicial";
        ValueEntry."Descuento % Consignacion" :=
            ItemJournalLine."Descuento % Cons. Inicial";
        ValueEntry."Importe Consignacion bruto" :=
            ItemJournalLine."Importe Cons. bruto Inicial";
        ValueEntry."Importe Consignacion Neto" :=
            ItemJournalLine."Importe Cons Neto Inicial";
        ValueEntry."Pedido Consignacion" :=
            ItemJournalLine."Pedido Consignacion";
        ValueEntry."Devolucion Consignacion" :=
            ItemJournalLine."Devolucion Consignacion";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSplitItemJnlLineOnBeforeInsertTempTrkgSpecification', '', false, false)]
    local procedure OnBeforeInsertTempTracking(
        var TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemJnlLine2: Record "Item Journal Line";
        SignFactor: Integer)
    begin
        TempTrackingSpecification."Quantity actual Handled (Base)" :=
            SignFactor * ItemJnlLine2."Quantity (Base)";
    end;
}
