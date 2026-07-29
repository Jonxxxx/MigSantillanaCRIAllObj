page 34002153 "Areas de agrupacion"
{
    Caption = 'Grouping area';
    PageType = List;
    SourceTable = 34002151;
    SourceTableView = SORTING("Tipo registro", Code)
                      WHERE("Tipo registro" = CONST("Area de agrupacion"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
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

