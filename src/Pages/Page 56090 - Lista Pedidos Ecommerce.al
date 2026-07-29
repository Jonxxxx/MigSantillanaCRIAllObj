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
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                }
                field("Tasa de cambio"; Rec."Tasa de cambio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tasa de cambio';
                }
                field("Metodo de Envio Ecommerce"; Rec."Metodo de Envio Ecommerce")
                {
                    ApplicationArea = All;
                    ToolTip = 'Metodo de Envio Ecommerce';
                }
                field("Direccion 1"; Rec."Direccion 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion 1';
                }
                field("Direccion 2"; Rec."Direccion 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion 2';
                }
                field(Procesado; Rec.Procesado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Procesado';
                }
                field(Error; Rec.Error)
                {
                    ApplicationArea = All;
                    ToolTip = 'Error';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'E-Mail';
                }
                field("RNC/Cedula"; Rec."RNC/Cedula")
                {
                    ApplicationArea = All;
                    ToolTip = 'RNC/Cedula';
                }
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento';
                }
                field("Cod. Direccion de envio"; Rec."Cod. Direccion de envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Direccion de envio';
                }
                field("Tipo Comprobante"; Rec."Tipo Comprobante")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Comprobante';
                }
                field("No. Factura NCr"; Rec."No. Factura NCr")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Factura NCr';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                }
                field(Ship_date; Rec.Ship_date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship_date';
                }
                field("Comentario Svr Cte"; Rec."Comentario Svr Cte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Svr Cte';
                    Caption = 'Cod. Colegio';
                }
                field("Comentario CC"; Rec."Comentario CC")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario CC';
                }
                field("Comentario Alm"; Rec."Comentario Alm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario Alm';
                }
                field("No. documento NAV"; Rec."No. documento NAV")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento NAV';
                }
                field("Pedido via telefonica"; Rec."Pedido via telefonica")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pedido via telefonica';
                }
                field("Cod. Cupon"; Rec."Cod. Cupon")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cupon';
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
                    CabVentaNopCommerce: Record 50100;
                begin
                    CabVentaNopCommerce := Rec;
                    CurrPage.SETSELECTIONFILTER(CabVentaNopCommerce);
                    REPORT.RUNMODAL(REPORT::"Modificar Pedidos E-commerce", TRUE, TRUE, CabVentaNopCommerce);
                end;
            }
        }
    }
}

