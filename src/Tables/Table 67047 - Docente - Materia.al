table 55514 "Docente - Materia"
{

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact;
        }
        field(2; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = Docentes;
        }
        field(3; "Cod. Materia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Materia';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Materia));
        }
        field(4; "Descripcion Nivel"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Nivel';
        }
        field(5; "Descripcion Grado"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Grado';
        }
        field(6; "Descripcion Materia"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Materia';
        }
        field(8; "Nombre Colegio"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Cod. Docente", "Cod. Materia")
        {
        }
    }

    fieldgroups
    {
    }
}

