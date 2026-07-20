codeunit 61007 EXCCRISalesQuoteToOrderSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine(
        var SalesOrderLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
        SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderLine."Cantidad Solicitada" := SalesOrderLine.Quantity;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterInsertSalesOrderLine', '', false, false)]
    local procedure OnAfterInsertSalesOrderLine(
        var SalesOrderLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
        SalesQuoteLine: Record "Sales Line";
        SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderLine.Validate(Quantity, 0);
        SalesOrderLine.Modify();
    end;
}
