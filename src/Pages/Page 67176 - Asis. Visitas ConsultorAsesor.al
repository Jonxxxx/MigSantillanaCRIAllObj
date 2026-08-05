page 55635 "Asis. Visitas Consultor/Asesor"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 55565;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fecha programacion"; Rec."Fecha programacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programacion';
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                }
                field("Nombre Docente"; Rec."Nombre Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Docente';
                }
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document ID';
                }
                field("Fecha inscripcion"; Rec."Fecha inscripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion';
                }
                field(Inscrito; Rec.Inscrito)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inscrito';
                }
                field(Confirmado; Rec.Confirmado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Confirmado';
                }
                field(Asistio; Rec.Asistio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistio';
                }
            }
        }
    }

    actions
    {
    }
}

