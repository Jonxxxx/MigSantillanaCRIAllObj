page 34002118 "Niveles - Grados RH"
{
    Caption = 'Level - Grades';
    PageType = List;
    SourceTable = 34002151;
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

