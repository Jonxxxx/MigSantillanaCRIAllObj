table 55531 "Plan Lector Det."
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
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(10; "Cant. x Alum 1"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 1';

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(11; "Edit. 2"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Edit. 2';
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(12; "Cant. x Alum 2"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. x Alum 2';

            trigger OnValidate()
            begin
                Totales;
            end;
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

            trigger OnValidate()
            begin
                Totales;
            end;
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

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(50; "Campana"; Code[20])
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

    trigger OnDelete()
    var
        DetPL: Record 55531;
    begin
        DetPL.RESET;
        DetPL.SETRANGE(Campana, Campana);
        DetPL.SETRANGE("Cod. Colegio", "Cod. Colegio");
        DetPL.SETRANGE("Cod. Local", "Cod. Local");
        DetPL.SETRANGE("Cod. Turno", "Cod. Turno");
        DetPL.DELETEALL;
    end;

    procedure Totales()
    begin
        "Total Obras Compradas x Alumno" := "Cant. x Alum 1" + "Cant. x Alum 2" + "Cant. x Alum 3" + "Cant. x Alum 4";
        "Universo de Titulos u Obras" := "Total Obras Compradas x Alumno" * "Cantidad Alumnos";
        IF "Universo de Titulos u Obras" <> 0 THEN
            "Porc. Afinidad" := ROUND(("Adopcion real" / "Universo de Titulos u Obras" * 100), 1)
        ELSE
            "Porc. Afinidad" := 0;
    end;
}

