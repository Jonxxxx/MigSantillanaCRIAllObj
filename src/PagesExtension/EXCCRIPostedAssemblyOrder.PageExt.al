pageextension 50091 EXCCRIPostedAssemblyOrder extends "Posted Assembly Order"
{
    actions
    {
        modify("Undo Post")
        {
            Enabled = EXCCRIUndoPostEnabled;
        }
    }

    trigger OnAfterGetRecord()
    begin
        EXCCRIUndoPostEnabled :=
            not Rec."Revertido completamente" and
            not Rec."Assemble to Order";
    end;

    var
        EXCCRIUndoPostEnabled: Boolean;
}
