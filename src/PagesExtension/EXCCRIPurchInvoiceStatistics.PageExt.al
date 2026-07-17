pageextension 50069 EXCCRIPurchInvoiceStatistics extends "Purchase Invoice Statistics"
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
                    ToolTip = 'Specifies the first retention code registered for the posted purchase invoice.';
                }
                field(EXCCRIRetentionAmount1; EXCCRIRetentionAmount[1])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 1';
                    Editable = false;
                    ToolTip = 'Specifies the amount registered for the first retention code.';
                }
                field(EXCCRIRetentionCode2; EXCCRIRetentionCode[2])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 2';
                    Editable = false;
                    ToolTip = 'Specifies the second retention code registered for the posted purchase invoice.';
                }
                field(EXCCRIRetentionAmount2; EXCCRIRetentionAmount[2])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 2';
                    Editable = false;
                    ToolTip = 'Specifies the amount registered for the second retention code.';
                }
                field(EXCCRIRetentionCode3; EXCCRIRetentionCode[3])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 3';
                    Editable = false;
                    ToolTip = 'Specifies the third retention code registered for the posted purchase invoice.';
                }
                field(EXCCRIRetentionAmount3; EXCCRIRetentionAmount[3])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 3';
                    Editable = false;
                    ToolTip = 'Specifies the amount registered for the third retention code.';
                }
                field(EXCCRIRetentionCode4; EXCCRIRetentionCode[4])
                {
                    ApplicationArea = All;
                    Caption = 'Retention Code 4';
                    Editable = false;
                    ToolTip = 'Specifies the fourth retention code registered for the posted purchase invoice.';
                }
                field(EXCCRIRetentionAmount4; EXCCRIRetentionAmount[4])
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Caption = 'Retention Amount 4';
                    Editable = false;
                    ToolTip = 'Specifies the amount registered for the fourth retention code.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRILoadRetentions();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRILoadRetentions();
    end;

    local procedure EXCCRILoadRetentions()
    var
        EXCCRIHistoricalRetention: Record 34003003;
        EXCCRICounter: Integer;
    begin
        Clear(EXCCRIRetentionCode);
        Clear(EXCCRIRetentionAmount);

        EXCCRIHistoricalRetention.Reset();
        EXCCRIHistoricalRetention.SetRange(
            "Tipo documento",
            EXCCRIHistoricalRetention."Tipo documento"::Invoice);
        EXCCRIHistoricalRetention.SetRange("No. documento", Rec."No.");

        if not EXCCRIHistoricalRetention.FindSet() then
            exit;

        repeat
            EXCCRICounter += 1;
            if EXCCRICounter > ArrayLen(EXCCRIRetentionCode) then
                exit;

            EXCCRIRetentionCode[EXCCRICounter] :=
                EXCCRIHistoricalRetention."Codigo Retencion";
            EXCCRIRetentionAmount[EXCCRICounter] :=
                EXCCRIHistoricalRetention."Importe Retenido";
        until EXCCRIHistoricalRetention.Next() = 0;
    end;

    var
        EXCCRIRetentionCode: array[4] of Text[30];
        EXCCRIRetentionAmount: array[4] of Decimal;
}
