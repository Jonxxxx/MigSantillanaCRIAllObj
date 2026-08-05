page 55525 "Docentes - Aficiones"
{
    PageType = Card;
    SourceTable = 55515;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                    Visible = false;
                }
                field("Nombre Docente"; Rec."Nombre Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Docente';
                    Editable = false;
                    Visible = false;
                }
                field("Cod. aficion"; Rec."Cod. aficion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. aficion';
                }
                field("Descripcion aficion"; Rec."Descripcion aficion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion aficion';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

