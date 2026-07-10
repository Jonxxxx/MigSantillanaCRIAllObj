table 67082 "Solicitud -  Especialidad Asi."
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "Cod. Especialidad"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE(Tipo registro=CONST(Especialidades));

            trigger OnValidate()
            var
                DA Record: 67002;
            begin
                IF "Cod. Especialidad" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Especialidades);
                    DA.SETRANGE(Codigo, "Cod. Especialidad");
                    DA.FINDFIRST;
                    Descripci n := DA.Descripcion;
                END;
            end;
        }
        field(3; "Descripci n"; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Especialidad")
        {
        }
    }

    fieldgroups
    {
    }
}

