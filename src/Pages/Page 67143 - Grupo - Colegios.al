page 55602 "Grupo - Colegios"
{
    PageType = List;
    SourceTable = 55549;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
            }
        }
    }

    actions
    {
    }
}

