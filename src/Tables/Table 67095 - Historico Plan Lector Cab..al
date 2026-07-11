table 67095 "Historico Plan Lector Cab."
{

    fields
    {
        field(1; "Cod. Colegio"; Code[10])
        {
            TableRelation = Contact WHERE(Type = CONST(Company),
                                           Tipo educacion=CONST(true));

            trigger OnValidate()
            var
                Colegio: Record 5050;
                DimVal: Record 349;
                ConfAPS: Record 67000;
            begin
            end;
        }
        field(2; "Nombre Colegio"; Text[50])
        {
            Editable = false;
        }
        field(3; "Cod. Local"; Code[10])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Descripcion Local"; Text[50])
        {
            Editable = false;
        }
        field(5; "Cod. Turno"; Code[10])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(6; "Descripcion Turno"; Text[30])
        {
            Editable = false;
        }
        field(7; Distrito; Text[30])
        {
            Editable = false;
        }
        field(8; "Cod. Delegacion"; Code[20])
        {
        }
        field(9; "Descripci n Delegacion"; Text[50])
        {
        }
        field(50; "Campa a"; Code[4])
        {
        }
    }

    keys
    {
        key(Key1; "Campa a", "Cod. Colegio", "Cod. Local", "Cod. Turno")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    var
        Text001: Label 'You cannot rename a %1.';
    begin
        ERROR(Text001, TABLECAPTION);
    end;
}

