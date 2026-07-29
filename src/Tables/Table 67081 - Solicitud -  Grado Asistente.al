table 67081 "Solicitud -  Grado Asistente"
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));

            trigger OnValidate()
            var
                DA: Record 67002;
            begin
                IF "Cod. Grado" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Grados);
                    DA.SETRANGE(Codigo, "Cod. Grado");
                    DA.FINDFIRST;
                    Descripcion := DA.Descripcion;
                END;
            end;
        }
        field(3; "Descripcion"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "No. Asistentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Asistentes';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Grado")
        {
        }
    }

    fieldgroups
    {
    }
}

