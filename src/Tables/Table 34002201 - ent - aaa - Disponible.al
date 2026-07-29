table 34002201 "ent - aaa - Disponible"
{
    Caption = 'Training';

    fields
    {
        field(1; "Tipo entrenamiento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo entrenamiento';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Tipo Entrenamiento"));

            trigger OnValidate()
            begin
                IF "Tipo entrenamiento" <> '' THEN BEGIN
                    TiposEntrenamientos.RESET;
                    TiposEntrenamientos.SETRANGE("Tipo registro", TiposEntrenamientos."Tipo registro"::"Tipo Entrenamiento");
                    TiposEntrenamientos.SETRANGE(Code, "Tipo entrenamiento");
                    TiposEntrenamientos.FINDFIRST;
                    Descripcion := TiposEntrenamientos.Descripcion;
                END;
            end;
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Area Curricular"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Area Curricular';
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST("Area curricular"));
        }
        field(6; "Fecha creacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha creacion';
        }
        field(7; "Horas estimadas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas estimadas';
        }
        field(8; "Capacidad de asistentes"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Capacidad de asistentes';
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Internal, External';
            OptionMembers = Interno,Externo;
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
        key(Key2; "Tipo entrenamiento", Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Descripcion, "Area Curricular", "Horas estimadas")
        {
        }
        fieldgroup(Brick; Descripcion, "Area Curricular", "Horas estimadas")
        {
        }
    }

    trigger OnInsert()
    begin
        IF Codigo = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("No. serie entrenamientos");
            "No. Series" := HumanResSetup."No. serie entrenamientos";
            if NoSeriesMgt.AreRelated("No. Series", xRec."No. Series") then "No. Series" := xRec."No. Series";
            Codigo := NoSeriesMgt.GetNextNo("No. Series");
        END;
    end;

    var
        TiposEntrenamientos: Record 34002151;
        HumanResSetup: Record 5218;
        NoSeriesMgt: Codeunit "No. Series";

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        HumanResSetup.Get();
        HumanResSetup.TestField("No. serie entrenamientos");

        if NoSeriesMgt.LookupRelatedNoSeries(
             HumanResSetup."No. serie entrenamientos",
             xRec."No. Series",
             "No. Series")
        then begin
            Codigo := NoSeriesMgt.GetNextNo("No. Series");
            exit(true);
        end;

        exit(false);
    end;
}

