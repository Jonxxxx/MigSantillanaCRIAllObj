page 67143 "Grupo - Colegios"
{
    PageType = List;
    SourceTable = 67090;

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

