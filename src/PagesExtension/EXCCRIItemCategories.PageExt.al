pageextension 50112 EXCCRIItemCategories extends "Item Categories"
{
    layout
    {
        modify(Code)
        {
            Editable = EXCCRIEditable;
        }
        modify(Description)
        {
            Editable = EXCCRIEditable;
        }
        addafter(Description)
        {
            //TODO: Ver 
            /*
            field(EXCCRIDefGenProdPostingGroup; Rec."Def. Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies the default general product posting group for items in the category.';
            }
            field(EXCCRIDefInventoryPostingGroup; Rec."Def. Inventory Posting Group")
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies the default inventory posting group for items in the category.';
            }
            field(EXCCRIDefVATProdPostingGroup; Rec."Def. VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies the default VAT product posting group for items in the category.';
            }
            field(EXCCRIDefCostingMethod; Rec."Def. Costing Method")
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies the default costing method for items in the category.';
            }*/
            field(EXCCRIMdM; Rec.MdM)
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                ToolTip = 'Specifies whether the item category is managed by MdM.';
            }
            field(EXCCRIBlocked; Rec.Bloqueado)
            {
                ApplicationArea = All;
                Editable = EXCCRIEditable;
                Visible = false;
                ToolTip = 'Specifies whether the item category is blocked.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        EXCCRIUserEditable := EXCCRIMdMFunctions.GetEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        EXCCRISetEditable();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EXCCRISetEditable();
    end;

    local procedure EXCCRISetEditable()
    begin
        EXCCRIEditable := EXCCRIUserEditable or not Rec.MdM;
    end;

    var
        EXCCRIMdMFunctions: Codeunit 75000;
        EXCCRIUserEditable: Boolean;
        EXCCRIEditable: Boolean;
}
