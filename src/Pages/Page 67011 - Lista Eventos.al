page 55478 "Lista Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Talleres - Eventos";
    Editable = false;
    PageType = List;
    SourceTable = 55478;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha creacion';
                }
                field("Capacidad de vacantes"; Rec."Capacidad de vacantes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Capacidad de vacantes';
                }
                field("Horas programadas"; Rec."Horas programadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas programadas';
                }
            }
        }
        area(factboxes)
        {
            part(PageEventos; 55576)
            {
                SubPageLink = "Cod. Evento" = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

