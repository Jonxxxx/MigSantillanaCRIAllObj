page 55759 "Niveles - Grados RH"
{
    Caption = 'Level - Grades';
    PageType = List;
    SourceTable = 55792;
    SourceTableView = WHERE("Tipo registro" = CONST("Niveles-Grados"));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
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

