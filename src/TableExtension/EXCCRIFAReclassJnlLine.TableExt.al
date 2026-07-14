tableextension 50083 EXCCRIFAReclassJnlLine extends "FA Reclass. Journal Line"
{
    fields
    {
        modify("FA No.")
        {
            TableRelation = "Fixed Asset" where(Inactive = const(false));
        }
        modify("New FA No.")
        {
            TableRelation = "Fixed Asset" where(Inactive = const(false));
        }
    }
}
