table 55544 "Hist. Docente - Materia"
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
        field(9; Campana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; Campana, "Cod. Colegio", "Cod. Docente", "Cod. Materia")
        {
        }
    }

    fieldgroups
    {
    }
}

