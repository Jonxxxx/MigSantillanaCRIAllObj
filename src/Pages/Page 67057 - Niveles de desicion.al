page 55524 "Niveles de desicion"
{
    ApplicationArea = All;
    Caption = 'Decision level';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Nivel de decisi n"));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
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

