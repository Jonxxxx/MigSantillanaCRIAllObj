pageextension 50089 EXCCRIAssemblyOrder extends "Assembly Order"
{
    layout
    {
        addafter("No.")
        {
            field(EXCCRILocationCode; Rec."Location Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the location where the assembly order is processed.';
            }
        }
    }
}
