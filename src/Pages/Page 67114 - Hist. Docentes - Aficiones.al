page 55573 "Hist. Docentes - Aficiones"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55542;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
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

