pageextension 70000111 pageextension70000111 extends "Item Categories" 
{
    layout
    {

        //Unsupported feature: Property Deletion (Editable) on "Control 1".


        //Unsupported feature: Property Deletion (Editable) on "Control 2".


        //Unsupported feature: Property Deletion (Editable) on "Control 4".

        modify("Control 1000000005")
        {
            Visible = false;
        }
        modify("Control 1000000004")
        {
            Visible = false;
        }
        modify("Control 1000000003")
        {
            Visible = false;
        }
        modify("Control 1000000002")
        {
            Visible = false;
        }
        modify("Control 1000000000")
        {
            Visible = false;
        }
        modify("Control 1000000001")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Recalculate)
        {
            ToolTip = 'Update the tree of item categories based on recent changes.';
        }
    }

    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        StyleTxt := GetStyleText;
        CurrPage.ItemAttributesFactbox.PAGE.LoadCategoryAttributesData(Code);


        wEditable2 := wEditable OR (NOT MdM);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        StyleTxt := GetStyleText;
        CurrPage.ItemAttributesFactbox.PAGE.LoadCategoryAttributesData(Code);
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        StyleTxt := GetStyleText;

        //
        wEditable2 := wEditable OR (NOT MdM);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        StyleTxt := GetStyleText;
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ItemCategoryManagement.CheckPresentationOrder;


        // +MdM
        wEditable := cFunMdm.GetEditable;
        // -MdM
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ItemCategoryManagement.CheckPresentationOrder;
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetSelection(PROCEDURE 1)".

}

