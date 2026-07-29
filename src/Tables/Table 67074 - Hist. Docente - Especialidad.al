table 67074 "Hist. Docente - Especialidad"
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
        field(7; Campana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; Campana, "Cod. Docente", "Cod. Nivel", "Cod. grado", "Cod. Especialidad")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
}

