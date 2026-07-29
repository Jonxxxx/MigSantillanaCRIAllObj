page 67183 "Area Curricular - APS"
{
    PageType = List;
    SourceTable = 67002;
    //TODO: Option no existe en BC ver en NAV SourceTableView = WHERE("Tipo registro" = CONST(29));

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

