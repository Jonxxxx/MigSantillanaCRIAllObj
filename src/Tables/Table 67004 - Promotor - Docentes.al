table 55471 "Promotor - Docentes"
{
    DrillDownPageID = 55471;
    LookupPageID = 55471;

    fields
    {
        field(1; "Codigo Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Docente';
            TableRelation = Docentes;
        }
        field(2; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(3; "Nombre Docente"; Text[60])
        {
            Caption = 'Nombre Docente';
            CalcFormula = Lookup(Docentes."Full Name" WHERE("No." = FIELD("Codigo Docente")));
            FieldClass = FlowField;
        }
        field(4; "Nombre Promotor"; Text[60])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(5; "Nivel decision"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel decision';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Nivel de decisi n"));

            trigger OnValidate()
            begin
                IF "Nivel decision" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Nivel de decisi n");
                    DA.SETRANGE(Codigo, "Nivel decision");
                    DA.FINDFIRST;
                END;
            end;
        }
        field(6; "Cod. Cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cargo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnValidate()
            begin
                IF "Cod. Cargo" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Cod. Cargo");
                    DA.FINDFIRST;
                    "Descripcion Cargo" := DA.Descripcion;
                END;
            end;
        }
        field(7; "Descripcion Cargo"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Cargo';
        }
    }

    keys
    {
        key(Key1; "Codigo Docente", "Cod. Promotor")
        {
        }
        key(Key2; "Cod. Promotor", "Codigo Docente")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 55469;
        ColNiv: Record 55503;
        NivelE: Record 55489;
        PromRuta: Record 55511;
        Promotor: Record 13;
        Docente: Record 55468;
        Cargo: Page 55500;
}

