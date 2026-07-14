tableextension 50051 EXCCRIVATBusinessPostingGroup extends "VAT Business Posting Group"
{
    fields
    {
        field(51000; "Cliente de Exportacion"; Boolean)
        {
            Caption = 'Customer for Export', Comment = 'ESP=Cliente de Exportación';
            DataClassification = ToBeClassified;
        }
    }
}
