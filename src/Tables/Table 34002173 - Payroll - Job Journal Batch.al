table 34002173 "Payroll - Job Journal Batch"
{
    //TODO: Ver DrillDownPageID = 34002195;
    //TODO: Ver LookupPageID = 34002195;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Payroll - Job Journal Template";
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", Name)
        {
        }
    }

    fieldgroups
    {
    }

    var
        JobJnlTemplate: Record 34002174;

    procedure SetupNewBatch()
    begin
        JobJnlTemplate.GET("Journal Template Name");
    end;
}

