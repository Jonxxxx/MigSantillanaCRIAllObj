table 67073 "Hist. Docente - Expos - Espec."
{
    Caption = 'Specialty';

    fields
    {
        field(1; "Tipo Registro"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Registro';
            OptionCaption = 'Teacher,Exhibitor';
            OptionMembers = Docente,Expositor;
        }
        field(2; "Cod. Docente/Expositor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente/Expositor';
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
            DataClassification = CustomerContent;
            Caption = 'Cod. especialidad';
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
            DataClassification = CustomerContent;
            Caption = 'Nombre completo';
        }
        field(5; "Descripcion especialidad"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion especialidad';
        }
        field(6; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo";
        }
        field(7; "Cod. grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. grado';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
        field(8; Campana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; Campana, "Tipo Registro", "Cod. Docente/Expositor", "Cod. especialidad")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Docente: Record 55468;
        Expositor: Record 55488;
        DA: Record 55469;
}

