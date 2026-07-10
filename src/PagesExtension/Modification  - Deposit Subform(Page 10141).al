pageextension 70000002 pageextension70000002 extends "Deposit Subform" 
{
    layout
    {
        modify("Control 1020011.OnValidate")
        {
            Visible = false;
        }
        modify("Control 1000000004")
        {
            Visible = false;
        }
        modify("Control 1000000001")
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
    }
    actions
    {
        modify(ApplyEntries)
        {
            ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded. ';
        }
    }

    //Unsupported feature: Property Modification (Attributes) on "ShowAccountCard(PROCEDURE 1020002)".


    //Unsupported feature: Property Modification (Attributes) on "ShowAccountLedgerEntries(PROCEDURE 1020003)".


    //Unsupported feature: Property Modification (Attributes) on "ShowApplyEntries(PROCEDURE 1020004)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensionEntries(PROCEDURE 1020005)".

}

