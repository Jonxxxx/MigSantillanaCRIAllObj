page 67041 "Lista de Talleres - Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha Talleres - Eventos";
    Editable = false;
    PageType = List;
    SourceTable = 67011;
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
                field(Categoria; Rec.Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Categoria';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field(Expositores; Rec.Expositores)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositores';
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                }
                field("Fecha creacion"; Rec."Fecha creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha creacion';
                }
                field("Horas programadas"; Rec."Horas programadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas programadas';
                }
                field("Capacidad de vacantes"; Rec."Capacidad de vacantes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Capacidad de vacantes';
                }
                field("Eventos programados"; Rec."Eventos programados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Eventos programados';
                }
                field("Importe Gasto Expositor"; Rec."Importe Gasto Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gasto Expositor';
                }
                field("Importe Gasto mensajeria"; Rec."Importe Gasto mensajeria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gasto mensajeria';
                }
                field("ImporteGastos Impresion"; Rec."ImporteGastos Impresion")
                {
                    ApplicationArea = All;
                    ToolTip = 'ImporteGastos Impresion';
                }
                field("Importe Utiles"; Rec."Importe Utiles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Utiles';
                }
                field("Importe Atenciones"; Rec."Importe Atenciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Atenciones';
                }
                field("Otros Importes"; Rec."Otros Importes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Otros Importes';
                }
            }
        }
    }

    actions
    {
    }
}

