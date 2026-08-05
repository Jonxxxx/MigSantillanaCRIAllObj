table 55793 "Beneficios laborales"
{
    Caption = 'Beneficios cargos';
    DrillDownPageID = 55800;
    LookupPageID = 55800;

    fields
    {
        field(2; "Tipo Beneficio"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Beneficio';
            OptionCaption = 'Income,Others';
            OptionMembers = Ingresos,Otro;
        }
        field(3; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
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
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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
        Conceptossalariales: Record 55752;
        DatosadicionalesRRHH: Record 55792;
}

