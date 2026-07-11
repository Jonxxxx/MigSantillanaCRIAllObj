page 56010 "Lin. Hoja de Ruta"
{
    // #4161  PLB  29/09/2014  Se muestra el campo "No. factura"
    // 
    // MOI - 11/12/2014 (#4700): Se mueve la ubicacion de No. Pedido para que aparezca al lado de No. Conduce.
    // MOI - 12/12/2014 (#4700): 1 Se añade el control para hacer editable un campo u otro según el valor de Entregado.
    //                           2 En el inicio se muestra
    // 
    // #29576  08/09/2015  FAA   Se crea nuevo Campo "Ruta de Distribución" y otras modificaciones.

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = 56021;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Envio"; "Tipo Envio")
                {
                }
                field("No. Conduce"; "No. Conduce")
                {
                }
                field("No. Pedido"; "No. Pedido")
                {
                }
                field("No. Guia"; "No. Guia")
                {
                    Enabled = false;
                }
                field("No. Factura"; "No. Factura")
                {
                }
                field("Ruta De Distribucion"; "Ruta De Distribucion")
                {
                    Visible = false;
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                    Editable = false;
                }
                field("Nombre Cliente"; "Nombre Cliente")
                {
                }
                field("Cantidad de Bultos"; "Cantidad de Bultos")
                {
                }
                field(Peso; Peso)
                {
                }
                field("Unidad Medida"; "Unidad Medida")
                {
                }
                field(Valor; Valor)
                {
                }
                field(Comentarios; Comentarios)
                {
                }
                field("Fecha Entrega Requerida"; "Fecha Entrega Requerida")
                {
                }
                field("Condiciones de Envio"; "Condiciones de Envio")
                {
                }
                field("Fecha Pedido"; "Fecha Pedido")
                {
                }
                field("No Entregado"; "No Entregado")
                {

                    trigger OnValidate()
                    begin
                        gbFechaEditable := NOT "No Entregado";
                        gbCausaEditable := "No Entregado";
                    end;
                }
                field("Fecha Entrega"; "Fecha Entrega")
                {
                    Editable = gbFechaEditable;
                    Enabled = gbFechaEditable;
                }
                field("Causa No Entrega"; "Causa No Entrega")
                {
                    Editable = gbCausaEditable;
                    Enabled = gbCausaEditable;
                }
                field("No Orden"; "No Orden")
                {
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
        recCabHojaRuta: Record 56020;
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

