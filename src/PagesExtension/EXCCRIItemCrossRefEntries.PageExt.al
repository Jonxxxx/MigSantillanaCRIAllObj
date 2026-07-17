//TODO: Ver 
/*
pageextension 50111 EXCCRIItemCrossRefEntries extends "Item Cross Reference Entries"
{
    layout
    {
        addbefore("Cross-Reference Type")
        {
            field(EXCCRIItemNo; Rec."Item No.")
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies the item associated with the cross-reference entry.';
            }
        }
        modify("Cross-Reference Type")
        {
            Editable = EXCCRIEditable;

            trigger OnAfterValidate()
            begin
                EXCCRIValidateBarcodeEditable();
            end;
        }
        modify("Cross-Reference Type No.")
        {
            Editable = EXCCRIEditable;
        }
        modify("Cross-Reference No.")
        {
            Editable = EXCCRIEditable;
        }
        modify("Variant Code")
        {
            Editable = EXCCRIEditable;
        }
        modify("Unit of Measure")
        {
            Editable = EXCCRIEditable;
        }
        modify(Description)
        {
            Editable = EXCCRIEditable;
        }
        modify("Description 2")
        {
            Editable = EXCCRIEditable;
        }
        modify("Discontinue Bar Code")
        {
            Editable = EXCCRIEditable;
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRISetEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        EXCCRIEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIValidateBarcodeEditable();
        EXCCRISetEditable();
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIValidateBarcodeEditable();
        EXCCRISetEditable();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIValidateBarcodeEditable();
        EXCCRISetEditable();
        exit(true);
    end;

    local procedure EXCCRIValidateBarcodeEditable()
    begin
        if Rec."Cross-Reference Type" =
           Rec."Cross-Reference Type"::"Bar Code"
        then
            EXCCRIMdMFunctions.GetEditableErr(Rec.TableCaption());
    end;

    local procedure EXCCRISetEditable()
    begin
        if Rec."Cross-Reference Type" =
           Rec."Cross-Reference Type"::"Bar Code"
        then
            EXCCRIEditable := EXCCRIMdMFunctions.GetEditable()
        else
            EXCCRIEditable := true;
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIEditable: Boolean;
}
*/