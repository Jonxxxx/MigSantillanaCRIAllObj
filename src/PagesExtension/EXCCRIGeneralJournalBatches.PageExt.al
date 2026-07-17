pageextension 50057 EXCCRIGeneralJournalBatches extends "General Journal Batches"
{
    layout
    {
        addafter("No. Series")
        {
            field(EXCCRIPOSBatch; Rec."Seccion POS")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the general journal batch is used by the POS process.';
            }
        }
    }
}
