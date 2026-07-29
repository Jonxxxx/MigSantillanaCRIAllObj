table 67075 "Hist. Docente - Aficiones"
{
    DrillDownPageID = 67058;
    LookupPageID = 67058;

    fields
    {
        field(1; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = Docentes;
        }
        field(2; "Nombre Docente"; Text[60])
        {
            Caption = 'Nombre Docente';
            CalcFormula = Lookup(Docentes."Full Name" WHERE("No." = FIELD("Cod. Docente")));
            FieldClass = FlowField;
        }
        field(3; "Cod. aficion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. aficion';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Aficiones));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Aficiones);
                DA.SETRANGE(Codigo, "Cod. aficion");
                DA.FINDFIRST;
                "Descripcion aficion" := DA.Descripcion;
            end;
        }
        field(4; "Descripcion aficion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion aficion';
        }
        field(5; Campana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
    }

    keys
    {
        key(Key1; Campana, "Cod. Docente", "Cod. aficion")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
}

