table 34002154 "Seguridad Usuarios RH"
{
    Caption = 'HR User permission';
    DrillDownPageID = 34002161;
    LookupPageID = 34002161;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User."User Name";

            trigger OnValidate()
            var
                UserMgt: Codeunit 418;
            begin
                User.RESET;
                User.SETRANGE("User Name", "User ID");
                IF User.FINDFIRST THEN
                    "Full name" := User."Full Name";
            end;
        }
        field(2; "Full name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Full name';
            Editable = false;
        }
        field(3; "Revisado por"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Revisado por';
        }
        field(4; "Autorizado por"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Autorizado por';
        }
        field(7; "E-Mail"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(8; "Visualiza salario"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Visualiza salario';
        }
        field(9; "Visualiza Calc. Nomina"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Visualiza Calc. Nomina';
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID", "Full name")
        {
        }
    }

    var
        User: Record 2000000120;
}

