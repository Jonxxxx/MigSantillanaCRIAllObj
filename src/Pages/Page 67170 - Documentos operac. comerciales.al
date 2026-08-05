page 55629 "Documentos operac. comerciales"
{
    PageType = List;
    SourceTable = 55469;
    //TODO: Option no existe en BC ver desde NAV SourceTableView = WHERE("Tipo registro" = CONST(28));

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

