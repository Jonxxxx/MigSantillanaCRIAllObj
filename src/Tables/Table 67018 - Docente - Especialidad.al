table 67018 "Docente - Especialidad"
{
    Caption = 'Teacher - Speciality';

    fields
    {
        field(1; "Cod. Docente"; Code[20])
        {
            NotBlank = true;
            TableRelation = Docentes;
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(3; "Cod. grado"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(4; "Cod. Especialidad"; Code[20])
        {
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
            CalcFormula = Lookup(Docentes."Full Name" WHERE(No.=FIELD(Cod. Docente)));
            FieldClass = FlowField;
        }
        field(6;"Descripcion especialidad";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Cod. Docente","Cod. Nivel","Cod. grado","Cod. Especialidad")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
}

