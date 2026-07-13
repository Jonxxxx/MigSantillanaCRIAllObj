table 75012 "Valores Filtros Tipologia MdM"
{
    // Este Tabla se cre  para utilizars unicamente como temnporal

    DrillDownPageID = 75012;
    LookupPageID = 75012;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Id Filtro"; Integer)
        {
        }
        field(3; "Code"; Code[20])
        {
            Caption = 'Codigo';
        }
        field(5; Description; Text[50])
        {
            Caption = 'Descripcion';
        }
        field(10; "Filtro Tipologia"; Code[10])
        {
            Description = 'FlowFilter';
            FieldClass = FlowFilter;
            TableRelation = "Item Category";
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

