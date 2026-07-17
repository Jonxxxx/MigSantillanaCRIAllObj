pageextension 50074 EXCCRINoSeriesLines extends "No. Series Lines"
{
    layout
    {
        addafter("Ending No.")
        {
            field(EXCCRIResolutionNo; Rec."No. Resolucion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal resolution number associated with the number series line.';
            }
            field(EXCCRIGenerationType; Rec."Tipo Generacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the generation type associated with the number series line.';
            }
            field(EXCCRIResolutionDate; Rec."Fecha Resolucion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date of the fiscal resolution associated with the number series line.';
            }
            field(EXCCRIExpirationDate; Rec."Expiration date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the expiration date of the fiscal number series line.';
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        EXCCRINoSeriesLine: Record "No. Series Line";
    begin
        if EXCCRINoSeriesLine.Get(Rec."Series Code", Rec."Line No.") then begin
            EXCCRINoSeriesLine.SetRange("Series Code", Rec."Series Code");
            if EXCCRINoSeriesLine.FindLast() then
                Rec."Line No." := EXCCRINoSeriesLine."Line No." + 10000;
        end;

        exit(true);
    end;
}
