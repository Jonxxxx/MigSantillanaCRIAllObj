table 67064 "Plan Lector Det."
{

    fields
    {
        field(1; "Cod. Colegio"; Code[10])
        {
            Editable = false;
        }
        field(2; "Cod. Local"; Code[10])
        {
            Editable = false;
        }
        field(3; "Cod. Turno"; Code[10])
        {
            Editable = false;
        }
        field(4; "Cod. Nivel"; Code[10])
        {
            Editable = false;
        }
        field(5; "Cod. Grado"; Code[10])
        {
            Editable = false;
        }
        field(6; "Cantidad Secciones"; Integer)
        {
        }
        field(7; "Cantidad Alumnos"; Integer)
        {
        }
        field(8; "Cantidad Docentes"; Integer)
        {
        }
        field(9; "Edit. 1"; Code[10])
        {
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(10; "Cant. x Alum 1"; Integer)
        {

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(11; "Edit. 2"; Code[10])
        {
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(12; "Cant. x Alum 2"; Integer)
        {

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(13; "Tipo Lectura 1"; Option)
        {
            OptionCaption = ' ,Colectiva,Libre';
            OptionMembers = " ",Colectiva,Libre;
        }
        field(14; "Modalidad Lectura 1"; Code[10])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Estado Colegio"));
        }
        field(17; "Total Obras Compradas x Alumno"; Integer)
        {
            Editable = false;
        }
        field(19; "Universo de T tulos u Obras"; Integer)
        {
            Editable = false;
        }
        field(20; "Adopci n real"; Integer)
        {
            Editable = false;
        }
        field(22; "Porc. Afinidad"; Integer)
        {
            Editable = false;
        }
        field(23; "Edit. 3"; Code[10])
        {
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(24; "Cant. x Alum 3"; Integer)
        {

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(25; "Edit. 4"; Code[10])
        {
            TableRelation = Editoras.Code;
            ValidateTableRelation = false;
        }
        field(26; "Cant. x Alum 4"; Integer)
        {

            trigger OnValidate()
            begin
                Totales;
            end;
        }
        field(50; "Campa a"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Campa a", "Cod. Colegio", "Cod. Local", "Cod. Turno", "Cod. Nivel", "Cod. Grado")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DetPL: Record 67064;
    begin
        DetPL.RESET;
        DetPL.SETRANGE(Campa a, Campa a);
        DetPL.SETRANGE("Cod. Colegio", "Cod. Colegio");
        DetPL.SETRANGE("Cod. Local", "Cod. Local");
        DetPL.SETRANGE("Cod. Turno", "Cod. Turno");
        DetPL.DELETEALL;
    end;

    procedure Totales()
    begin
        "Total Obras Compradas x Alumno" := "Cant. x Alum 1" + "Cant. x Alum 2" + "Cant. x Alum 3" + "Cant. x Alum 4;
        "Universo de T tulos u Obras" := "Total Obras Compradas x Alumno" * "Cantidad Alumnos";
        IF "Universo de T tulos u Obras" <> 0 THEN
            "Porc. Afinidad" := ROUND(("Adopci n real" / "Universo de T tulos u Obras" * 100), 1)
        ELSE
            "Porc. Afinidad" := 0;
    end;
}

