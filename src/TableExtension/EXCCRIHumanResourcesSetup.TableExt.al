tableextension 50079 EXCCRIHumanResourcesSetup extends "Human Resources Setup"
{
    fields
    {
        field(34002100; "Candidate Nos."; Code[20])
        {
            Caption = 'Candidate Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34002101; "No. serie acciones personal"; Code[20])
        {
            Caption = 'Personnel Actions Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34002102; "No. serie entrenamientos"; Code[20])
        {
            Caption = 'Training Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
