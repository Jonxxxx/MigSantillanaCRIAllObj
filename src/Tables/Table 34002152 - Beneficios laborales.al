table 34002152 "Beneficios laborales"
{
    Caption = 'Beneficios cargos';
    DrillDownPageID = 34002159;
    //TODO: Ver LookupPageID = 34002159;

    fields
    {
        field(2; "Tipo Beneficio"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Income,Others';
            OptionMembers = Ingresos,Otro;
        }
        field(3; Codigo; Code[20])
        {
            Caption = 'Code';
            TableRelation = IF ("Tipo Beneficio" = CONST(Ingresos)) "Conceptos salariales".Codigo WHERE("Tipo concepto" = CONST(Ingresos))
            ELSE IF ("Tipo Beneficio" = CONST(Otro)) "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Beneficio));

            trigger OnValidate()
            begin
                IF "Tipo Beneficio" = 0 THEN //Ingresos
                    BEGIN
                    IF Conceptossalariales.GET(Codigo) THEN
                        Descripcion := Conceptossalariales.Descripcion
                    ELSE
                        Descripcion := '';
                END
                ELSE BEGIN
                    IF DatosadicionalesRRHH.GET(0, Codigo) THEN
                        Descripcion := DatosadicionalesRRHH.Descripcion
                    ELSE
                        Descripcion := '';
                END;
            end;
        }
        field(4; Descripcion; Text[60])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Tipo Beneficio", Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Tipo Beneficio", Codigo, Descripcion)
        {
        }
    }

    var
        Conceptossalariales: Record 34002111;
        DatosadicionalesRRHH: Record 34002151;
}

