table 55516 "Padres - Aficiones"
{

    fields
    {
        field(1; "Cod. Padre"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Padre';
            TableRelation = Padres;
        }
        field(2; "Nombre Padre"; Text[100])
        {
            Caption = 'Nombre Padre';
            CalcFormula = Lookup(Padres."Full name" WHERE("DNI" = FIELD("Cod. Padre")));
            FieldClass = FlowField;
        }
        field(3; "Cod. aficion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. aficion';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Aficiones));

            trigger OnValidate()
            begin
                IF "Cod. aficion" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Aficiones);
                    DA.SETRANGE(Codigo, "Cod. aficion");
                    DA.FINDFIRST;
                    "Descripcion aficion" := DA.Descripcion;
                END;
            end;
        }
        field(4; "Descripcion aficion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion aficion';
        }
    }

    keys
    {
        key(Key1; "Cod. Padre", "Cod. aficion")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 55469;
}

