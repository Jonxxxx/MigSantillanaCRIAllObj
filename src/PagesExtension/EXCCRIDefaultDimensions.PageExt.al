pageextension 50081 EXCCRIDefaultDimensions extends "Default Dimensions"
{
    layout
    {
        modify("Dimension Code")
        {
            Editable = EXCCRIEditable;
            Style = Strong;
            StyleExpr = not EXCCRIEditable;

            trigger OnAfterValidate()
            begin
                EXCCRIMdMFunctions.GetDimEditable(Rec, true);
            end;
        }
        modify("Dimension Value Code")
        {
            Editable = EXCCRIEditable;
            Style = Strong;
            StyleExpr = not EXCCRIEditable;
        }
        modify("Value Posting")
        {
            Editable = EXCCRIEditable;
            Style = Strong;
            StyleExpr = not EXCCRIEditable;
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIEditable := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetDimEditable(Rec, false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetDimEditable(Rec, false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetDimEditable(Rec, false);
        exit(EXCCRIEditable);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetDimEditable(Rec, false);
        exit(EXCCRIEditable);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIEditable := EXCCRIMdMFunctions.GetDimEditable(Rec, false);
        exit(EXCCRIEditable);
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIEditable: Boolean;
}
