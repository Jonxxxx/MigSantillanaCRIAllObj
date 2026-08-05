table 55821 "Shift schedule"
{
    Caption = 'Shift schedule';
    DrillDownPageID = 55818;
    LookupPageID = 55818;

    fields
    {
        field(1; "Codigo turno"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo turno';
            TableRelation = Shift;

            trigger OnValidate()
            begin
                IF Turno.GET("Codigo turno") THEN
                    Descripcion := Turno.Descripcion;
            end;
        }
        field(4; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
            Editable = false;
        }
        field(5; "Hora Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio';
        }
        field(6; "Hora Fin"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin';
        }
        field(7; "Hora almuerzo"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora almuerzo';
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
        fieldgroup(DropDown; "Codigo turno")
        {
        }
    }

    var
        Turno: Record 55802;
}

