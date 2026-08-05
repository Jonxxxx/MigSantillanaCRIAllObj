table 55473 "Promotor - Lista de Colegios"
{
    DrillDownPageID = 55546;
    LookupPageID = 55546;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact;

            trigger OnValidate()
            var
                recCP: Record 225;
            begin
                Colegio.GET("Cod. Colegio");

                "Nombre Colegio" := Colegio.Name;
            end;
        }
        field(3; "Cod. Ruta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Ruta';
            TableRelation = "Promotor - Rutas"."Cod. Ruta" WHERE("Cod. Promotor" = FIELD("Cod. Promotor"));

            trigger OnValidate()
            begin
                Rutas.RESET;
                Rutas.SETRANGE("Tipo registro", Rutas."Tipo registro"::Rutas);
                Rutas.SETRANGE(Codigo, "Cod. Ruta");
                Rutas.FINDFIRST;

                "Nombre Ruta" := Rutas.Descripcion;
            end;
        }
        field(4; "Nombre Promotor"; Text[60])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(5; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(6; "Nombre Ruta"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Ruta';
        }
        field(7; Seleccionar; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Seleccionar';
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Colegio")
        {
        }
        key(Key2; "Nombre Colegio")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Colegio", "Nombre Colegio", "Cod. Promotor", "Nombre Promotor")
        {
        }
    }

    var
        Colegio: Record 5050;
        Rutas: Record 55469;
}

