page 55506 "Promotor - Entrega de Muestras"
{
    PageType = Card;
    SourceTable = 55506;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Visible = false;
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Fecha Visita"; Rec."Fecha Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Visita';
                }
                field("Hora Inicial Visita"; Rec."Hora Inicial Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicial Visita';
                }
                field("Hora Inicial Final"; Rec."Hora Inicial Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Inicial Final';
                }
                field("Fecha Proxima Visita"; Rec."Fecha Proxima Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Proxima Visita';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
            }
        }
    }

    actions
    {
    }
}

