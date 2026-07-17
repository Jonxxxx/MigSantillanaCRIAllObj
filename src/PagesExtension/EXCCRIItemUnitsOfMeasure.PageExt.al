pageextension 50107 EXCCRIItemUnitsOfMeasure extends "Item Units of Measure"
{
    layout
    {
        modify(Code)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify("Qty. per Unit of Measure")
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(Height)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(Width)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(Length)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(Cubage)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(Weight)
        {
            Editable = EXCCRIEditableMdM;
        }
        modify(ItemUnitOfMeasure)
        {
            Editable = EXCCRIEditableMdM;
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIItem: Record Item;
    begin
        if Rec.GetFilter("Item No.") <> '' then begin
            EXCCRIItem.SetFilter("No.", Rec.GetFilter("Item No."));
            if EXCCRIItem.FindFirst() then begin
                EXCCRIEditableMdM :=
                    EXCCRIMdMFunctions.GetEditableP(EXCCRIItem, true);
                exit;
            end;
        end;

        EXCCRIEditableMdM := EXCCRIMdMFunctions.GetEditable();
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIEditableMdM: Boolean;
}
