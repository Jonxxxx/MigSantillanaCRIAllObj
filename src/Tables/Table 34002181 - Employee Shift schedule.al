table 34002181 "Employee Shift schedule"
{
    Caption = 'Shift schedule';
    //TODO: Ver DrillDownPageID = 34002177;
    //TODO: Ver LookupPageID = 34002177;

    fields
    {
        field(1; "Employee code"; Code[20])
        {
            Caption = 'Employee code';
            TableRelation = Employee;
        }
        field(2; "Codigo turno"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Shift;
        }
        field(3; "Fecha inicial"; Date)
        {
            Caption = ' From date';
        }
        field(5; "Full Name"; Text[50])
        {
            Caption = 'Full Name';
            Editable = false;
        }
        field(6; "Fecha final"; Date)
        {
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
        Turno: Record "34002161";
}

