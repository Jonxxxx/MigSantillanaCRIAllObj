tableextension 55051 EXCCRIVATBusinessPostingGroup extends "VAT Business Posting Group"
{
    fields
    {
        field(55161; "Cliente de Exportacion"; Boolean)
        {
            Caption = 'Customer for Export', Comment = 'ESP=Cliente de Exportacion';
            DataClassification = CustomerContent;
        }
    }
}
