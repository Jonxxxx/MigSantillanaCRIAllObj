table 67069 "Historico Colegio - Grados"
{
    DrillDownPageID = 67037;
    LookupPageID = 67037;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(2; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(3; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo APS";
        }
        field(4; "Cod. Turno"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(5; "Cod. Grado"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(6; Seccion; Code[10])
        {
        }
        field(7; "Cantidad Secciones"; Integer)
        {
        }
        field(8; "Cantidad Alumnos"; Integer)
        {

            trigger OnValidate()
            begin
                ColAdopcionD.RESET;
                ColAdopcionD.SETRANGE("Cod. Colegio", "Cod. Colegio");
                ColAdopcionD.SETRANGE("Cod. Nivel", "Cod. Nivel");
                ColAdopcionD.SETRANGE("Cod. Grado", "Cod. Grado");
                ColAdopcionD.SETRANGE("Cod. Turno", "Cod. Turno");
                ColAdopcionD.SETRANGE(Seccion, Seccion);
                IF ColAdopcionD.FINDSET(TRUE, FALSE) THEN
                    REPEAT
                        ColAdopcionD."Cantidad Alumnos" := "Cantidad Alumnos";
                        ColAdopcionD.MODIFY;
                    UNTIL ColAdopcionD.NEXT = 0;
            end;
        }
        field(9; "Cantidad Docentes"; Integer)
        {
        }
        field(10; "Lista Utiles"; Boolean)
        {
        }
        field(11; "Lista Competencia"; Boolean)
        {
        }
        field(12; "Horas Ingles"; Decimal)
        {
        }
        field(13; "Fecha Decision"; Date)
        {
            Caption = 'Decision Date';
        }
        field(20; Campana; Code[4])
        {
            Caption = 'Campa a';
            TableRelation = Campaign;
        }
    }

    keys
    {
        key(Key1; Campana, "Cod. Colegio", "Cod. Nivel", "Cod. Turno", "Cod. Grado", Seccion)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Nivel", "Cod. Grado")
        {
        }
    }

    trigger OnDelete()
    begin
        ColAdopcionD.RESET;
        ColAdopcionD.SETRANGE("Cod. Colegio", "Cod. Colegio");
        ColAdopcionD.SETRANGE("Cod. Nivel", "Cod. Nivel");
        ColAdopcionD.SETRANGE("Cod. Grado", "Cod. Grado");
        ColAdopcionD.SETRANGE("Cod. Turno", "Cod. Turno");
        ColAdopcionD.SETRANGE(Seccion, Seccion);
        ColAdopcionD.SETRANGE(Adopcion, 1, 5);
        IF ColAdopcionD.FINDFIRST THEN
            ERROR(Err001);
    end;

    var
        DA: Record 67002;
        ColAdopcionD: Record 67053;
        Err001: Label 'This School = Grade already has Adopctions registered. You can''t delete it';
}

