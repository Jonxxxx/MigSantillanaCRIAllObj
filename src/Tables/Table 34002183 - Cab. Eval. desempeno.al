table 34002183 "Cab. Eval. desempeno"
{
    Caption = 'Performance eval. header';
    DataCaptionFields = "Code",Description;
    DrillDownPageID = 5111;
    LookupPageID = 5109;

    fields
    {
        field(1;"Code";Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2;Description;Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LinEvaldesempeno.RESET;
        LinEvaldesempeno.SETRANGE(Code,Code);
        LinEvaldesempeno.DELETEALL(TRUE);
    end;

    var
        LinEvaldesempeno: Record "34002184";
}

