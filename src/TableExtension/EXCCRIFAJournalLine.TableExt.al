tableextension 50082 EXCCRIFAJournalLine extends "FA Journal Line"
{
    fields
    {
        modify("FA No.")
        {
            TableRelation = "Fixed Asset" where(Inactive = const(false));
        }
    }
}
