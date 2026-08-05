table 55555 "Historico Plan Lector Det."
{

    fields
    {
        field(1; "Cod. Colegio"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            Editable = false;
        }
        field(2; "Cod. Local"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            Editable = false;
        }
        field(3; "Cod. Turno"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Turno';
            Editable = false;
        }
        field(4; "Cod. Nivel"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            Editable = false;
        }
        field(5; "Cod. Grado"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            Editable = false;
        }
        field(6; "Cantidad Secciones"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Secciones';
        }
        field(7; "Cantidad Alumnos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Alumnos';
        }
        field(8; "Cantidad Docentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Docentes';
        }
        field(9; "Edit. 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Edit. 1';
        }
        field(10; "Cant. x Alum 1"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 1';
        }
        field(11; "Edit. 2"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Edit. 2';
        }
        field(12; "Cant. x Alum 2"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 2';
        }
        field(13; "Tipo Lectura 1"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Lectura 1';
            OptionCaption = ' ,Colectiva,Libre';
            OptionMembers = " ",Colectiva,Libre;
        }
        field(14; "Modalidad Lectura 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Modalidad Lectura 1';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Estado Colegio"));
        }
        field(17; "Total Obras Compradas x Alumno"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Obras Compradas x Alumno';
            Editable = false;
        }
        field(19; "Universo de Titulos u Obras"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Universo de Titulos u Obras';
            Editable = false;
        }
        field(20; "Adopcion real"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Adopcion real';
            Editable = false;
        }
        field(22; "Porc. Afinidad"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Porc. Afinidad';
            Editable = false;
        }
        field(23; "Edit. 3"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Edit. 3';
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(24; "Cant. x Alum 3"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 3';
        }
        field(25; "Edit. 4"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Edit. 4';
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(26; "Cant. x Alum 4"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 4';
        }
        field(50; "Campana"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; "Campana", "Cod. Colegio", "Cod. Local", "Cod. Turno", "Cod. Nivel", "Cod. Grado")
        {
        }
    }

    fieldgroups
    {
    }
}

