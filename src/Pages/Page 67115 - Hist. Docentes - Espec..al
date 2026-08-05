page 55574 "Hist. Docentes - Espec."
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55541;
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
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Especialidad"; Rec."Cod. Especialidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Especialidad';
                }
                field("Descripcion especialidad"; Rec."Descripcion especialidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion especialidad';
                    Editable = false;
                }
                field("Cod. grado"; Rec."Cod. grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. grado';
                }
                field("Nombre Docente"; Rec."Nombre Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Docente';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

