page 55651 "Equipos Talleres y Eventos"
{
    AutoSplitKey = true;
    PageType = List;
    SourceTable = 55526;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Editable = false;
                    Visible = false;
                }
                field("Codigo Equipo"; Rec."Codigo Equipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Equipo';
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                    Editable = false;
                    Visible = false;
                }
                field("Descripcion Equipo"; Rec."Descripcion Equipo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Equipo';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Costo Unitario"; Rec."Costo Unitario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costo Unitario';
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

