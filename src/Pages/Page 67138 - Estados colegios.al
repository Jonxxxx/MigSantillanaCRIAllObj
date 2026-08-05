page 55597 "Estados colegios"
{
    AdditionalSearchTerms = 'School status';
    ApplicationArea = All;
    Caption = 'School status';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Estado Colegio"));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
            }
        }
    }

    actions
    {
    }
}

