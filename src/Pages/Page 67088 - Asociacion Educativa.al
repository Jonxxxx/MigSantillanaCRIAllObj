page 55650 "Asociacion Educativa"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55469;
    SourceTableView = WHERE("Tipo registro" = CONST("Asociacion educativa"));
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

