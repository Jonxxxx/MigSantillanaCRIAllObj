tableextension 55079 EXCCRIHumanResourcesSetup extends "Human Resources Setup"
{
    fields
    {
        field(55741; "Candidate Nos."; Code[20])
        {
            Caption = 'Candidate Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55742; "No. serie acciones personal"; Code[20])
        {
            Caption = 'Personnel Actions Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55743; "No. serie entrenamientos"; Code[20])
        {
            Caption = 'Training Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
