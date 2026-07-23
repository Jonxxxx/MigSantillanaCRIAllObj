table 34002154 "Seguridad Usuarios RH"
{
    Caption = 'HR User permission';
    DrillDownPageID = 34002161;
    //TODO: Ver LookupPageID = 34002161;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit 418;
            begin
                //TODO: Ver UserMgt.LookupUserID("User ID");
                VALIDATE("User ID");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit 418;
            begin
                //TODO: Ver UserMgt.ValidateUserID("User ID");
                User.RESET;
                User.SETRANGE("User Name", "User ID");
                IF User.FINDFIRST THEN
                    "Full name" := User."Full Name";
            end;
        }
        field(2; "Full name"; Text[60])
        {
            Caption = 'Full name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Revisado por"; Boolean)
        {
            Caption = 'Alloow Reviewed by';
        }
        field(4; "Autorizado por"; Boolean)
        {
            Caption = 'Allow Authorized by';
        }
        field(7; "E-Mail"; Text[100])
        {
            Caption = 'E-Mail';
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(8; "Visualiza salario"; Boolean)
        {
            Caption = 'Salary visible';
            DataClassification = ToBeClassified;
        }
        field(9; "Visualiza Calc. Nomina"; Boolean)
        {
            Caption = 'Calc payroll visible';
            DataClassification = ToBeClassified;
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

