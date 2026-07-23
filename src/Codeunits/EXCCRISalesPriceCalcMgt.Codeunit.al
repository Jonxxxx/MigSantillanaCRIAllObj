codeunit 61023 EXCCRISalesPriceCalcMgt
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterApplyPrice', '', false, false)]
    local procedure SalesLineOnAfterApplyPrice(
        var SalesLine: Record "Sales Line";
        var xSalesLine: Record "Sales Line";
        CallFieldNo: Integer;
        CurrentFieldNo: Integer)
    begin
        if SalesLine.Type <> SalesLine.Type::Item then
            exit;

        if xSalesLine."Line Discount %" = 0 then
            exit;

        if SalesLine."Line Discount %" = xSalesLine."Line Discount %" then
            exit;

        SalesLine.Validate("Line Discount %", xSalesLine."Line Discount %");
    end;
}
