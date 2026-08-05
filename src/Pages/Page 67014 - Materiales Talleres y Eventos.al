page 55481 "Materiales Talleres y Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = 55481;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                    Visible = false;
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Tipo de Material"; Rec."Tipo de Material")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Material';
                }
                field("Codigo Material"; Rec."Codigo Material")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Material';
                }
                field("Description Material"; Rec."Description Material")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Material';
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
            }
        }
    }

    actions
    {
    }
}

