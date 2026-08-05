page 67078 "Promotores - Docentes"
{
    PageType = Card;
    SourceTable = 55471;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Codigo Docente"; Rec."Codigo Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Docente';
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field("Nombre Docente"; Rec."Nombre Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Docente';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                }
            }
        }
    }

    actions
    {
    }
}

