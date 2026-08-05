table 67082 "Solicitud -  Especialidad Asi."
{

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Especialidad"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Especialidad';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Especialidades));

            trigger OnValidate()
            var
                DA: Record 55469;
            begin
                IF "Cod. Especialidad" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Especialidades);
                    DA.SETRANGE(Codigo, "Cod. Especialidad");
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

