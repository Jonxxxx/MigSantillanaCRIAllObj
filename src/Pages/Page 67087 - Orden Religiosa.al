page 55649 "Orden Religiosa"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 55469;
    SourceTableView = WHERE("Tipo registro" = CONST("Orden religiosa"));
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

