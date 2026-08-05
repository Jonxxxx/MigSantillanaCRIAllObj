page 55235 "Lin. Hoja de Ruta"
{
    // #4161  PLB  29/09/2014  Se muestra el campo "No. factura"
    // 
    // MOI - 11/12/2014 (#4700): Se mueve la ubicacion de No. Pedido para que aparezca al lado de No. Conduce.
    // MOI - 12/12/2014 (#4700): 1 Se añade el control para hacer editable un campo u otro según el valor de Entregado.
    //                           2 En el inicio se muestra
    // 
    // #29576  08/09/2015  FAA   Se crea nuevo Campo "Ruta de Distribucion" y otras modificaciones.

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = 55246;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Envio"; Rec."Tipo Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Envio';
                }
                field("No. Conduce"; Rec."No. Conduce")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Conduce';
                }
                field("No. Pedido"; Rec."No. Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Pedido';
                }
                field("No. Guia"; Rec."No. Guia")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Guia';
                    Enabled = false;
                }
                field("No. Factura"; Rec."No. Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Factura';
                }
                field("Ruta De Distribucion"; Rec."Ruta De Distribucion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ruta De Distribucion';
                    Visible = false;
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                    Editable = false;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cliente';
                }
                field("Cantidad de Bultos"; Rec."Cantidad de Bultos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad de Bultos';
                }
                field(Peso; Rec.Peso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Peso';
                }
                field("Unidad Medida"; Rec."Unidad Medida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unidad Medida';
                }
                field(Valor; Rec.Valor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor';
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentarios';
                }
                field("Fecha Entrega Requerida"; Rec."Fecha Entrega Requerida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrega Requerida';
                }
                field("Condiciones de Envio"; Rec."Condiciones de Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Condiciones de Envio';
                }
                field("Fecha Pedido"; Rec."Fecha Pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Pedido';
                }
                field("No Entregado"; Rec."No Entregado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Entregado';

                    trigger OnValidate()
                    begin
                        gbFechaEditable := NOT "No Entregado";
                        gbCausaEditable := "No Entregado";
                    end;
                }
                field("Fecha Entrega"; Rec."Fecha Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrega';
                    Editable = gbFechaEditable;
                    Enabled = gbFechaEditable;
                }
                field("Causa No Entrega"; Rec."Causa No Entrega")
                {
                    ApplicationArea = All;
                    ToolTip = 'Causa No Entrega';
                    Editable = gbCausaEditable;
                    Enabled = gbCausaEditable;
                }
                field("No Orden"; Rec."No Orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No Orden';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //MOI - 12/12/2014 (#4700):Inicio 2
        gbFechaEditable := NOT "No Entregado";
        gbCausaEditable := "No Entregado";
        //MOI - 12/12/2014 (#4700):Fin 2
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        recCabHojaRuta: Record 55245;
    begin
        //#29576 +++
        recCabHojaRuta.GET("No. Hoja Ruta");
        "Ruta De Distribucion" := recCabHojaRuta."No. Ruta Distribucion";
        //#29576 ---
    end;

    var
        gbFechaEditable: Boolean;
        [InDataSet]
        gbCausaEditable: Boolean;
}

