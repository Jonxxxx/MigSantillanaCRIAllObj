using Microsoft.Sales.Document;
using System.Automation;

codeunit 61018 EXCCRIApprovalsMgtSub
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckSalesApprovalPossible', '', false, false)]
    local procedure OnBeforeCheckSalesApprovalPossible(
        var SalesHeader: Record "Sales Header";
        var Result: Boolean;
        var IsHandled: Boolean)
    var
        EXCCRISetup: Record 56001;
    begin
        SalesHeader.TestField("Categoria Pedido Venta");

        EXCCRISetup.Get();
        EXCCRIValidateZeroAmountLines(
            SalesHeader,
            EXCCRISetup);
    end;

    local procedure EXCCRIValidateZeroAmountLines(
        SalesHeader: Record "Sales Header";
        EXCCRISetup: Record 56001)
    var
        SalesLine: Record "Sales Line";
        ValidateLines: Boolean;
    begin
        case SalesHeader."Tipo de Venta" of
            SalesHeader."Tipo de Venta"::Muestras:
                ValidateLines :=
                    EXCCRISetup."Precio de Venta Muestras" <>
                    EXCCRISetup."Precio de Venta Muestras"::Cero;
            SalesHeader."Tipo de Venta"::Donaciones:
                ValidateLines :=
                    EXCCRISetup."Precio de Venta Donaciones" =
                    EXCCRISetup."Precio de Venta Donaciones"::Costo;
            else
                ValidateLines := true;
        end;

        if not ValidateLines then
            exit;

        SalesLine.SetRange(
            "Document Type",
            SalesHeader."Document Type");
        SalesLine.SetRange(
            "Document No.",
            SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                if
                    (SalesLine.Quantity <> 0) and
                    (SalesLine.Quantity *
                     SalesLine."Unit Price" = 0)
                then
                    Error(
                        EXCCRIZeroLineAmountErr,
                        SalesLine."Line No.",
                        SalesLine."Document No.");
            until SalesLine.Next() = 0;
    end;

    var
        EXCCRIZeroLineAmountErr: Label
            'The amount of line %1 in sales document %2 cannot be zero.';
}
