table 55485 "Docente - Especialidad"
{
    Caption = 'Teacher - Speciality';

    fields
    {
        field(1; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            NotBlank = true;
            TableRelation = Docentes;
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(3; "Cod. grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. grado';
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(4; "Cod. Especialidad"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Especialidad';
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Especialidades));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Especialidades);
                DA.SETRANGE(Codigo, "Cod. Especialidad");
                DA.FINDFIRST;

                "Descripcion especialidad" := DA.Descripcion;
            end;
        }
        field(5; "Nombre Docente"; Text[60])
        {
            Caption = 'Nombre Docente';
            CalcFormula = Lookup(Docentes."Full Name" WHERE("No." = FIELD("Cod. Docente")));
            FieldClass = FlowField;
        }
        field(6; "Descripcion especialidad"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion especialidad';
        }
    }

    keys
    {
        key(Key1; "Cod. Docente", "Cod. Nivel", "Cod. grado", "Cod. Especialidad")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 55469;
}

