page 67167 "Lista Atenciones"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67002;
    SourceTableView = WHERE("Tipo registro" = CONST(Atenciones));
    UsageCategory = Lists;

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
                field("Costo Unitario"; Rec."Costo Unitario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costo Unitario';
                }
            }
        }
    }

    actions
    {
    }
}

