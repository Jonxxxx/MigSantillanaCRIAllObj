page 56016 "Lin. Hoja de Ruta Reg."
{
    // MOI - 12/12/2014 (#4700) : Se añaden las nuevas columnas Entregado, Fecha Entrega, Causa no Entrega.
    // JMB - 16/05/2016 (#50366): Se muestra el campo Nº factura en los detalle de la linea

    PageType = ListPart;
    SourceTable = 56023;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Conduce"; "No. Conduce")
                {
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field("Nombre Cliente"; "Nombre Cliente")
                {
                }
                field("Cantidad de Bultos"; "Cantidad de Bultos")
                {
                }
                field(Peso; Peso)
                {
                    Visible = false;
                }
                field("Unidad Medida"; "Unidad Medida")
                {
                }
                field(Valor; Valor)
                {
                    Visible = false;
                }
                field("No. Guia"; "No. Guia")
                {
                    Visible = false;
                }
                field("No. Factura"; "No. Factura")
                {
                }
                field(Comentarios; Comentarios)
                {
                }
                field("Fecha Entrega Requerida"; "Fecha Entrega Requerida")
                {
                    Visible = false;
                }
                field("Condiciones de Envio"; "Condiciones de Envio")
                {
                    Visible = false;
                }
                field("No. Pedido"; "No. Pedido")
                {
                }
                field("Fecha Pedido"; "Fecha Pedido")
                {
                    Visible = false;
                }
                field("No entregado"; "No entregado")
                {
                    Visible = false;
                }
                field(Entregado; Entregado)
                {
                    Editable = false;
                }
                field("Fecha Entrega"; "Fecha Entrega")
                {
                    Editable = false;
                }
                field("Causa No Entrega"; "Causa No Entrega")
                {
                    Editable = false;
                }
                field("No Orden"; "No Orden")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action("<Action1000000018>")
                {
                    Caption = '&Void Line';

                    trigger OnAction()
                    begin
                        "No entregado" := TRUE;
                        MODIFY;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }
}

