table 55814 "Payroll - Job Journal Batch"
{
    DrillDownPageID = 55836;
    LookupPageID = 55836;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Payroll - Job Journal Template";
        }
        field(2; Name; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
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
        JobJnlTemplate: Record 55815;

    procedure SetupNewBatch()
    begin
        JobJnlTemplate.GET("Journal Template Name");
    end;
}

