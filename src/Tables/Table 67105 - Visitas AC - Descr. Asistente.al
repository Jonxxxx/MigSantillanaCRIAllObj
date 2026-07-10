table 67105 "Visitas A/C - Descr. Asistente"
{

    fields
    {
        field(1; "No. Visita"; Code[20])
        {
        }
        field(2; Codigo; Code[20])
        {
            TableRelation = IF (Tipo = CONST(Nivel)) "Nivel Educativo APS".C digo
                            ELSE IF (Tipo=CONST(Especialidad)) "Datos auxiliares".Codigo WHERE (Tipo registro=CONST(Especialidades))
                            ELSE IF (Tipo=CONST(Grado)) "Datos auxiliares".Codigo WHERE (Tipo registro=CONST(Grados));

            trigger OnValidate()
            var
                Nivel Record: 67022;
                DA Record: 67002;
            begin

                IF Codigo <> '' THEN BEGIN
                    CASE Tipo OF
                        Tipo::Nivel:
                            BEGIN
                                Nivel.GET(Codigo);
                                Descripci n := Nivel.Descripci n;
                            END;
                        Tipo::Grado:
                            BEGIN
                                DA.RESET;
                                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Grados);
                                DA.SETRANGE(Codigo, Codigo);
                                DA.FINDFIRST;
                                Descripci n := DA.Descripcion;
                            END;
                        Tipo::Especialidad:
                            BEGIN
                                DA.RESET;
                                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Especialidades);
                                DA.SETRANGE(Codigo, Codigo);
                                DA.FINDFIRST;
                                Descripci n := DA.Descripcion;
                            END;
                    END;
                END
                ELSE
                    Descripci n := '';
            end;
        }
        field(3; "Descripci n"; Text[80])
        {
        }
        field(4; "No. Asistentes"; Integer)
        {
        }
        field(5; Tipo; Option)
        {
            OptionCaption = 'Nivel,Grado,Especialidad';
            OptionMembers = Nivel,Grado,Especialidad;
        }
    }

    keys
    {
        key(Key1; "No. Visita", Tipo, Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

