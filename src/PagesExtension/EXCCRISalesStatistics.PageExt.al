pageextension 50055 EXCCRISalesStatistics extends "Sales Statistics"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIMargin; EXCCRIMargin)
            {
                ApplicationArea = All;
                Caption = 'Margin';
                Editable = false;
                ToolTip = 'Specifies the sales amount including tax in local currency minus the estimated line cost in local currency.';
            }
            field(EXCCRIMarginPct; EXCCRIMarginPct)
            {
                ApplicationArea = All;
                Caption = 'Margin %';
                DecimalPlaces = 0 : 3;
                Editable = false;
                ToolTip = 'Specifies the calculated margin percentage for the sales document.';
            }
            field(EXCCRITotalDiscount; EXCCRITotalDiscount)
            {
                ApplicationArea = All;
                Caption = 'Invoice Discount Amount';
                Editable = false;
                ToolTip = 'Specifies the combined invoice and line discount amount of the sales document.';
            }
            field(EXCCRIDiscountPct; EXCCRIDiscountPct)
            {
                ApplicationArea = All;
                Caption = 'Invoice Discount %';
                DecimalPlaces = 0 : 3;
                Editable = false;
                ToolTip = 'Specifies the combined invoice and line discount amount as a percentage of the sales amount excluding tax.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRICalculateStatistics();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRICalculateStatistics();
    end;

    local procedure EXCCRICalculateStatistics()
    var
        EXCCRICurrencyExchangeRate: Record "Currency Exchange Rate";
        EXCCRISalesLine: Record "Sales Line";
        EXCCRISalesAmountLCY: Decimal;
        EXCCRITotalCostLCY: Decimal;
        EXCCRIUseDate: Date;
    begin
        Clear(EXCCRIMargin);
        Clear(EXCCRIMarginPct);
        Clear(EXCCRITotalDiscount);
        Clear(EXCCRIDiscountPct);
        Clear(EXCCRITotalCostLCY);

        EXCCRISalesLine.Reset();
        EXCCRISalesLine.SetRange("Document Type", Rec."Document Type");
        EXCCRISalesLine.SetRange("Document No.", Rec."No.");
        if EXCCRISalesLine.FindSet() then
            repeat
                EXCCRITotalDiscount +=
                    EXCCRISalesLine."Inv. Discount Amount" +
                    EXCCRISalesLine."Line Discount Amount";
                EXCCRITotalCostLCY +=
                    EXCCRISalesLine.Quantity *
                    EXCCRISalesLine."Unit Cost (LCY)";
            until EXCCRISalesLine.Next() = 0;

        Rec.CalcFields(Amount, "Amount Including VAT");
        EXCCRISalesAmountLCY := Rec."Amount Including VAT";

        if Rec."Currency Code" <> '' then begin
            EXCCRIUseDate := Rec."Posting Date";
            if EXCCRIUseDate = 0D then
                EXCCRIUseDate := WorkDate();

            EXCCRISalesAmountLCY :=
                EXCCRICurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    EXCCRIUseDate,
                    Rec."Currency Code",
                    EXCCRISalesAmountLCY,
                    Rec."Currency Factor");
        end;

        EXCCRIMargin := EXCCRISalesAmountLCY - EXCCRITotalCostLCY;
        if EXCCRISalesAmountLCY <> 0 then
            EXCCRIMarginPct :=
                Round(EXCCRIMargin / EXCCRISalesAmountLCY * 100, 0.001);

        if Rec.Amount <> 0 then
            EXCCRIDiscountPct :=
                Round(EXCCRITotalDiscount / Rec.Amount * 100, 0.001);
    end;

    var
        EXCCRIMargin: Decimal;
        EXCCRIMarginPct: Decimal;
        EXCCRITotalDiscount: Decimal;
        EXCCRIDiscountPct: Decimal;
}
