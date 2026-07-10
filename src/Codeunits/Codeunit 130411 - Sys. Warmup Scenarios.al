codeunit 130411 "Sys. Warmup Scenarios"
{
    Subtype = Test;

    trigger OnRun()
    begin
    end;

    [Test]
    [Scope('Personalization')]
    procedure WarmupInvoicePosting()
    var
        Customer: Record 18;
        Item: Record 27;
        SalesHeader Record: 36;
    begin
        IF NOT Customer.FINDFIRST THEN
            EXIT;

        Item.SETFILTER(Inventory, '<>%1', 0);
        IF NOT Item.FINDFIRST THEN
            EXIT;

        CreateSalesInvoice(SalesHeader, Customer, Item);
        PostSalesInvoice(SalesHeader);
    end;

    local procedure GetRandomString(): Text
    begin
        EXIT(DELCHR(FORMAT(CREATEGUID), '=', '{}-'));
    end;

    local procedure CreateSalesInvoice(var SalesHeader Record: 36; Customer: Record 18; Item: Record 27)
    begin
        CreateSalesHeader(SalesHeader, Customer);
        CreateSalesLine(SalesHeader, Item);
    end;

    local procedure PostSalesInvoice(var SalesHeader Record: 36")
    begin
        SalesHeader.Ship := TRUE;
        SalesHeader.Invoice := TRUE;
        CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
    end;

    local procedure CreateSalesHeader(var SalesHeader Record: 36; Customer: Record 18)
    begin
        SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader."No." := COPYSTR(GetRandomString, 1, MAXSTRLEN(SalesHeader."No."));
        SalesHeader.INSERT(TRUE);
        SalesHeader.VALIDATE("Sell-to Customer No.", Customer."No.");
        SalesHeader.MODIFY(TRUE);
    end;

    local procedure CreateSalesLine(SalesHeader Record: 36; Item: Record 27)
    var
        SalesLine Record: 37;
    begin
        SalesLine.VALIDATE("Document Type", SalesHeader."Document Type");
        SalesLine.VALIDATE("Document No.", SalesHeader."No.");
        SalesLine.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.VALIDATE("Line No.", 10000);
        SalesLine.INSERT(TRUE);
        SalesLine.VALIDATE(Type, SalesLine.Type::Item);
        SalesLine.VALIDATE("No.", Item."No.");
        SalesLine.VALIDATE(Quantity, 1);
        SalesLine.MODIFY(TRUE);
    end;
}

