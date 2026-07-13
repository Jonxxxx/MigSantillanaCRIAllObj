table 34002201 "ent - aaa - Disponible"
{
    Caption = 'Training';

    fields
    {
        field(1; "Tipo entrenamiento"; Code[20])
        {
            Caption = 'Training type';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Tipo Entrenamiento));

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
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Area Curricular"; Code[20])
        {
            Caption = 'Trainer code';
            DataClassification = ToBeClassified;
            TableRelation = "Datos adicionales RRHH".Code WHERE("Tipo registro" = CONST(Area curricular));
        }
        field(6; "Fecha creacion"; Date)
        {
            Caption = 'Date of creation';
            DataClassification = ToBeClassified;
        }
        field(7; "Horas estimadas"; Decimal)
        {
            Caption = 'Estimated hours';
            DataClassification = ToBeClassified;
        }
        field(8; "Capacidad de asistentes"; Integer)
        {
            Caption = 'Attendee capacity';
            DataClassification = ToBeClassified;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; Tipo; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
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
            NoSeriesMgt.InitSeries(HumanResSetup."No. serie entrenamientos", xRec."No. Series", 0D, Codigo, "No. Series");
        END;
    end;

    var
        TiposEntrenamientos: Record 34002151;
        HumanResSetup: Record 5218;
        NoSeriesMgt: Codeunit 396;

    [Scope('Personalization')]
    procedure AssistEdit(): Boolean
    begin
        HumanResSetup.GET;
        HumanResSetup.TESTFIELD("No. serie entrenamientos");
        IF NoSeriesMgt.SelectSeries(HumanResSetup."No. serie entrenamientos", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(Codigo);
            EXIT(TRUE);
        END;
    end;
}

