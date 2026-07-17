pageextension 50070 EXCCRIPurchaseOrderStatistics extends "Purchase Order Statistics"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIRetentions)
            {
                Caption = 'Retentions';

                field(EXCCRIRetentionCode1; EXCCRIRetentionCode[1])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 1';
                    Editable = false;
                    ToolTip = 'Specifies the first retention code calculated for the purchase order.';
                }
                field(EXCCRIRetentionAmount1; EXCCRIRetentionAmount[1])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 1';
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the first retention code.';
                }
                field(EXCCRIRetentionCode2; EXCCRIRetentionCode[2])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 2';
                    Editable = false;
                    ToolTip = 'Specifies the second retention code calculated for the purchase order.';
                }
                field(EXCCRIRetentionAmount2; EXCCRIRetentionAmount[2])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 2';
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the second retention code.';
                }
                field(EXCCRIRetentionCode3; EXCCRIRetentionCode[3])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 3';
                    Editable = false;
                    ToolTip = 'Specifies the third retention code calculated for the purchase order.';
                }
                field(EXCCRIRetentionAmount3; EXCCRIRetentionAmount[3])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 3';
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the third retention code.';
                }
                field(EXCCRIRetentionCode4; EXCCRIRetentionCode[4])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 4';
                    Editable = false;
                    ToolTip = 'Specifies the fourth retention code calculated for the purchase order.';
                }
                field(EXCCRIRetentionAmount4; EXCCRIRetentionAmount[4])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 4';
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the fourth retention code.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRICalculateRetentions();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRICalculateRetentions();
    end;

    local procedure EXCCRICalculateRetentions()
    var
        EXCCRIRetentionDocument: Record 34003002;
        EXCCRIRetentions: Codeunit 34003000;
        EXCCRICounter: Integer;
        EXCCRIRetentionValue: Decimal;
        EXCCRIVATAmount: Decimal;
    begin
        Clear(EXCCRIRetentionCode);
        Clear(EXCCRIRetentionAmount);

        Rec.CalcFields(Amount, "Amount Including VAT");
        EXCCRIVATAmount := Rec."Amount Including VAT" - Rec.Amount;

        EXCCRIRetentionDocument.Reset();
        EXCCRIRetentionDocument.SetRange(
            "Cod. Proveedor",
            Rec."Buy-from Vendor No.");
        EXCCRIRetentionDocument.SetFilter(
            "Tipo documento",
            '%1',
            Rec."Document Type");
        EXCCRIRetentionDocument.SetRange(
            "No. documento",
            Rec."No.");

        if not EXCCRIRetentionDocument.FindSet() then
            exit;

        repeat
            EXCCRICounter += 1;
            if EXCCRICounter > ArrayLen(EXCCRIRetentionCode) then
                exit;

            Clear(EXCCRIRetentionValue);
            EXCCRIRetentionCode[EXCCRICounter] :=
                EXCCRIRetentionDocument."Codigo Retencion";

            if EXCCRIRetentionDocument."Base Cálculo" <>
               EXCCRIRetentionDocument."Base Cálculo"::Ninguno
            then
                if Rec."Prices Including VAT" then
                    EXCCRIRetentionValue :=
                        EXCCRIRetentions.CalculaRetencion(
                            EXCCRIRetentionDocument,
                            EXCCRIVATAmount,
                            Rec."Amount Including VAT",
                            Rec.Amount)
                else
                    EXCCRIRetentionValue :=
                        EXCCRIRetentions.CalculaRetencion(
                            EXCCRIRetentionDocument,
                            EXCCRIVATAmount,
                            Rec.Amount,
                            Rec."Amount Including VAT");

            EXCCRIRetentionAmount[EXCCRICounter] :=
                EXCCRIRetentionValue;
        until EXCCRIRetentionDocument.Next() = 0;
    end;

    var
        EXCCRIRetentionCode: array[4] of Text[30];
        EXCCRIRetentionAmount: array[4] of Decimal;
}
