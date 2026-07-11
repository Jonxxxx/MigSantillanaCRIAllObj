table 67008 "Docente - Expos - Especialidad"
{
    Caption = 'Specialty';

    fields
    {
        field(1; "Tipo Registro"; Option)
        {
            OptionCaption = 'Teacher,Exhibitor';
            OptionMembers = Docente,Expositor;
        }
        field(2; "Cod. Docente/Expositor"; Code[20])
        {
            TableRelation = IF ("Tipo registro" = CONST(Docente)) Docentes
            ELSE IF ("Tipo registro" = CONST(Expositor)) "Expositores - aps";

            trigger OnValidate()
            begin
                IF "Tipo Registro" = 0 THEN BEGIN
                    Docente.GET("Cod. Docente/Expositor");
                    "Nombre completo" := Docente."Full Name";
                END
                ELSE BEGIN
                    Expositor.GET("Cod. Docente/Expositor");
                    "Nombre completo" := Expositor.Name;
                END;
            end;
        }
        field(3; "Cod. especialidad"; Code[20])
        {
            Caption = 'Specialism code';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Especialidades));

            trigger OnValidate()
            begin
                IF "Cod. especialidad" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Especialidades);
                    DA.SETRANGE(Codigo, "Cod. especialidad");
                    DA.FINDFIRST;
                    "Descripcion especialidad" := DA.Descripcion;
                END;
            end;
        }
        field(4; "Nombre completo"; Text[60])
        {
            Caption = 'Full name';
        }
        field(5; "Descripcion especialidad"; Text[100])
        {
            Caption = 'Specialism description';
        }
        field(6; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Nivel Educativo";
        }
        field(7; "Cod. grado"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
    }

    keys
    {
        key(Key1; "Tipo Registro", "Cod. Docente/Expositor", "Cod. especialidad")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Docente: Record 67001;
        Expositor: Record 67021;
        DA: Record 67002;
}

