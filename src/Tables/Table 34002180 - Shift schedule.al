table 34002180 "Shift schedule"
{
    Caption = 'Shift schedule';
    DrillDownPageID = 34002177;
    //TODO: Ver LookupPageID = 34002177;

    fields
    {
        field(1; "Codigo turno"; Code[10])
        {
            Caption = 'Shift Code';
            TableRelation = Shift;

            trigger OnValidate()
            begin
                IF Turno.GET("Codigo turno") THEN
                    Descripcion := Turno.Descripcion;
            end;
        }
        field(4; Descripcion; Text[30])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(5; "Hora Inicio"; Time)
        {
            Caption = 'Date in';
        }
        field(6; "Hora Fin"; Time)
        {
            Caption = 'Date Out';
        }
        field(7; "Hora almuerzo"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Codigo turno", "Hora Inicio")
        {
        }
    }

    fieldgroups
    {
        //TODO: Ver ieldgroup(DropDown; "Codigo turno", Field2)
        //TODO: Ver {
        //TODO: Ver }
    }

    var
        Turno: Record 34002161;
}

