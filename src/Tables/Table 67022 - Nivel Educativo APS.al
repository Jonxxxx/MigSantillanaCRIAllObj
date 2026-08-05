table 55489 "Nivel Educativo APS"
{
    DrillDownPageID = 55558;
    LookupPageID = 55558;

    fields
    {
        field(1; "Codigo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Verificaci n cruzada"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Verificaci n cruzada';
        }
        field(4; "Filtros Combinaciones Niveles"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtros Combinaciones Niveles';
        }
        field(5; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
    }

    keys
    {
        key(Key1; "Codigo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }
}

