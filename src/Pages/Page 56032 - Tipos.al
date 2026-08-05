page 55257 Tipos
{
    // #6357  PLB   05/11/2014  Se ha creado la page

    PageType = List;
    SourceTable = 55231;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
            }
        }
    }

    actions
    {
    }
}

