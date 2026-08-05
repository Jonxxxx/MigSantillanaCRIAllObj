page 55958 "Historico Retencion Prov."
{
    Editable = false;
    PageType = List;
    SourceTable = 55958;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Cod. Proveedor"; Rec."Cod. Proveedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Proveedor';
                }
                field("Codigo Retencion"; Rec."Codigo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Retencion';
                }
                field("Cta. Contable"; Rec."Cta. Contable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cta. Contable';
                }
                field("Base Calculo"; Rec."Base Calculo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base Calculo';
                }
                field(Devengo; Rec.Devengo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Devengo';
                }
                field("Importe Retencion"; Rec."Importe Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Retencion';
                }
                field("Importe Retenido"; Rec."Importe Retenido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Retenido';
                }
                field("Tipo Retencion"; Rec."Tipo Retencion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Retencion';
                }
                field("Aplica Productos"; Rec."Aplica Productos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Productos';
                }
                field("Aplica Servicios"; Rec."Aplica Servicios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Servicios';
                }
                field("Retencion ITBIS"; Rec."Retencion ITBIS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Retencion ITBIS';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
            }
        }
    }

    actions
    {
    }
}

