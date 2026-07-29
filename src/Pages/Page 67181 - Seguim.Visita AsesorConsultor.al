page 67181 "Seguim.Visita Asesor/Consultor"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67107;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Cambio"; Rec."No. Cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cambio';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field(Usuario; Rec.Usuario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
            }
        }
    }

    actions
    {
    }
}

