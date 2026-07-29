table 34002181 "Employee Shift schedule"
{
    Caption = 'Shift schedule';
    DrillDownPageID = 34002177;
    LookupPageID = 34002177;

    fields
    {
        field(1; "Employee code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee code';
            TableRelation = Employee;
        }
        field(2; "Codigo turno"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo turno';
            TableRelation = Shift;
        }
        field(3; "Fecha inicial"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inicial';
        }
        field(5; "Full Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Full Name';
            Editable = false;
        }
        field(6; "Fecha final"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha final';
        }
    }

    keys
    {
        key(Key1; "Employee code", "Codigo turno", "Fecha inicial")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee code", "Codigo turno")
        {
        }
    }

    var
        Turno: Record 34002161;
}

