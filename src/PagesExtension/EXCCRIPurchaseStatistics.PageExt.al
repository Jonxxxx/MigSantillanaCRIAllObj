pageextension 50056 EXCCRIPurchaseStatistics extends "Purchase Statistics"
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
                    ToolTip = 'Specifies the first retention code calculated for the purchase document.';
                }
                field(EXCCRIRetentionAmount1; EXCCRIRetentionAmount[1])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Amount 1';
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the first retention code.';
                }
                field(EXCCRIRetentionCode2; EXCCRIRetentionCode[2])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 2';
                    Editable = false;
                    ToolTip = 'Specifies the second retention code calculated for the purchase document.';
                }
                field(EXCCRIRetentionAmount2; EXCCRIRetentionAmount[2])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Amount 2';
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the second retention code.';
                }
                field(EXCCRIRetentionCode3; EXCCRIRetentionCode[3])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 3';
                    Editable = false;
                    ToolTip = 'Specifies the third retention code calculated for the purchase document.';
                }
                field(EXCCRIRetentionAmount3; EXCCRIRetentionAmount[3])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Amount 3';
                    BlankZero = true;
                    Editable = false;
                    ToolTip = 'Specifies the amount calculated for the third retention code.';
                }
                field(EXCCRIRetentionCode4; EXCCRIRetentionCode[4])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 4';
                    Editable = false;
                    ToolTip = 'Specifies the fourth retention code calculated for the purchase document.';
                }
                field(EXCCRIRetentionAmount4; EXCCRIRetentionAmount[4])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Amount 4';
                    BlankZero = true;
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

            EXCCRIRetentionCode[EXCCRICounter] :=
                EXCCRIRetentionDocument."Codigo Retencion";

            if EXCCRIRetentionDocument."Base Cálculo" <>
               EXCCRIRetentionDocument."Base Cálculo"::Ninguno
            then
                if Rec."Prices Including VAT" then
                    EXCCRIRetentionAmount[EXCCRICounter] :=
                        EXCCRIRetentions.CalculaRetencion(
                            EXCCRIRetentionDocument,
                            EXCCRIVATAmount,
                            Rec."Amount Including VAT",
                            Rec.Amount)
                else
                    EXCCRIRetentionAmount[EXCCRICounter] :=
                        EXCCRIRetentions.CalculaRetencion(
                            EXCCRIRetentionDocument,
                            EXCCRIVATAmount,
                            Rec.Amount,
                            Rec."Amount Including VAT");
        until EXCCRIRetentionDocument.Next() = 0;
    end;

    var
        EXCCRIRetentionCode: array[4] of Text[30];
        EXCCRIRetentionAmount: array[4] of Decimal;
}
