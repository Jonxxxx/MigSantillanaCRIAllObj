pageextension 50080 EXCCRIDimensionValues extends "Dimension Values"
{
    layout
    {
        addbefore(Code)
        {
            field(EXCCRIDimensionCode; Rec."Dimension Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the dimension to which the dimension value belongs.';
            }
        }
        addafter(Name)
        {
            field(EXCCRIIndentation; Rec.Indentation)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the indentation level of the dimension value.';
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIMdMFunctions.GetDimValueEditable(Rec, true);
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIMdMFunctions.GetDimValueEditable(Rec, true);
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIMdMFunctions.GetDimValueEditable(Rec, true);
        exit(true);
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
}
