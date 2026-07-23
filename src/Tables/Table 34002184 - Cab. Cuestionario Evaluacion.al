table 34002184 "Cab. Cuestionario Evaluacion"
{
    Caption = 'Profile Questionnaire Header';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = 34002209;
    //TODO: Ver LookupPageID = 34002208;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; Priority; Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionCaption = 'Very Low,Low,Normal,High,Very High';
            OptionMembers = "Very Low",Low,Normal,High,"Very High";

            trigger OnValidate()
            var
                EmptProfileAnswer: Record 34002192;
            begin
                EmptProfileAnswer.SETCURRENTKEY("Profile Questionnaire Code");
                EmptProfileAnswer.SETRANGE("Profile Questionnaire Code", Code);
                EmptProfileAnswer.MODIFYALL("Profile Questionnaire Priority", Priority);
                MODIFY;
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ProfileQuestnLine.RESET;
        ProfileQuestnLine.SETRANGE("Profile Questionnaire Code", Code);
        ProfileQuestnLine.DELETEALL(TRUE);
    end;

    var
        ProfileQuestnLine: Record 34002185;
}

