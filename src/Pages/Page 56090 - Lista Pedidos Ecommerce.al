page 56090 "Lista Pedidos Ecommerce"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = List;
    SourceTable = 50100;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. documento"; "No. documento")
                {
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("Cod. Vendedor"; "Cod. Vendedor")
                {
                }
                field("Tasa de cambio"; "Tasa de cambio")
                {
                }
                field("Metodo de Envio Ecommerce"; "Metodo de Envio Ecommerce")
                {
                }
                field("Direccion 1"; "Direccion 1")
                {
                }
                field("Direccion 2"; "Direccion 2")
                {
                }
                field(Procesado; Procesado)
                {
                }
                field(Error; Error)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("RNC/Cedula"; "RNC/Cedula")
                {
                }
                field("Tipo Documento"; "Tipo Documento")
                {
                }
                field("Cod. Direccion de envío"; "Cod. Direccion de envio")
                {
                }
                field("Tipo Comprobante"; "Tipo Comprobante")
                {
                }
                field("No. Factura NCr"; "No. Factura NCr")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field(Ship_date; Ship_date)
                {
                }
                field("Comentario Svr Cte"; "Comentario Svr Cte")
                {
                    Caption = 'Cod. Colegio';
                }
                field("Comentario CC"; "Comentario CC")
                {
                }
                field("Comentario Alm"; "Comentario Alm")
                {
                }
                field("No. documento NAV"; "No. documento NAV")
                {
                }
                field("Pedido vía telefonica"; "Pedido via telefonica")
                {
                }
                field("Cod. Cupon"; "Cod. Cupon")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Modificar Pedidos")
            {
                Image = "Report";

                trigger OnAction()
                var
                    //TODO: Ver ModificarPedidosEcommerce: Report 50000;
                    CabVentaNopCommerce: Record 50100;
                begin
                    CabVentaNopCommerce := Rec;
                    CurrPage.SETSELECTIONFILTER(CabVentaNopCommerce);
                    REPORT.RUNMODAL(50000, TRUE, TRUE, CabVentaNopCommerce);
                end;
            }
        }
    }
}

