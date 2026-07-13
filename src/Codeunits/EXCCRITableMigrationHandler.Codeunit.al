codeunit 50026 EXCCRITableMigrationHandler
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(
        var EXCCRIItemJournalLine: Record "Item Journal Line";
        EXCCRISalesLine: Record "Sales Line")
    var
        EXCCRISalesHeader: Record "Sales Header";
    begin
        if not EXCCRISalesHeader.Get(
            EXCCRISalesLine."Document Type",
            EXCCRISalesLine."Document No.")
        then
            exit;

        if EXCCRISalesHeader."Pedido Consignacion" then begin
            EXCCRIItemJournalLine."Precio Unitario Cons. Inicial" :=
                EXCCRISalesLine."Unit Price";
            EXCCRIItemJournalLine."Descuento % Cons. Inicial" :=
                EXCCRISalesLine."Line Discount %";
            EXCCRIItemJournalLine."Importe Cons. bruto Inicial" :=
                EXCCRISalesLine."Unit Price" *
                EXCCRISalesLine."Qty. to Invoice";
            EXCCRIItemJournalLine."Importe Cons Neto Inicial" :=
                EXCCRIItemJournalLine."Importe Cons. bruto Inicial" -
                EXCCRISalesLine."Line Discount Amount";
            EXCCRIItemJournalLine."No. Mov. Prod. Cosg. a Liq." :=
                EXCCRISalesLine."No. Mov. Prod. Cosg. a Liq.";
            EXCCRIItemJournalLine."Pedido Consignacion" := true;
        end;

        EXCCRIItemJournalLine."No aplica Derechos de Autor" :=
            EXCCRISalesHeader."No aplica Derechos de Autor";
        EXCCRIItemJournalLine."Cod. Colegio" :=
            EXCCRISalesHeader."Cod. Colegio";
    end;
}
