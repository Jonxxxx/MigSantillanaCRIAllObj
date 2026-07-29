report 34002518 "DsPOS - Ticket Venta CR ON"
{
    // #52748  22/09/2016  JMB   Creacion de ticket - Modo ONLINE
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Ticket Venta CR ON.rdl';

    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";
            column(Empresa_Nombre; rEmpresa.Name)
            {
            }
            column(Empresa_Ruc; 'Ced. Juredica: ' + rEmpresa."VAT Registration No.")
            {
            }
            column(Empresa_Direccion; rEmpresa.Address)
            {
            }
            column(Empresa_Colonia; rEmpresa."Address 2")
            {
            }
            column(Empresa_Telefono; 'Tel´Š¢fonos: ' + rEmpresa."Phone No." + '/' + rEmpresa."Phone No. 2")
            {
            }
            column(TPV_Descripcion; rTPV.Descripcion)
            {
            }
            column(TPV_Direccion; rTPV.Direccion)
            {
            }
            column(TPV_Numero_Autorizacion; rTPV."Permite NC en otro TPV")
            {
            }
            column(Venta_Factura; "No.")
            {
            }
            column(Venta_Fecha; FORMAT("Order Date"))
            {
            }
            column(Venta_Hora; FORMAT("Hora creacion"))
            {
            }
            column(Venta_Total; Total_A_Pagar)
            {
            }
            column(Cliente_Nombre; UPPERCASE("Bill-to Name"))
            {
            }
            column(Cliente_Ruc; "VAT Registration No.")
            {
            }
            column(Cajero_Nombre; UPPERCASE(NombreCajero))
            {
            }
            dataitem(Pago; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = WHERE(Cambio = CONST(false));
                column(Pago_Forma; UPPERCASE(FormaDePago))
                {
                }
                column(Pago_Divisa; UPPERCASE(DivisaDePago))
                {
                }
                column(Pago_Importe; Importe)
                {
                }
                column(Pago_Filtro; 'Pago_Filtro')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DivisaDePago := "Cod. divisa";
                    FormaDePago := Pago."Forma pago TPV";

                    IF (FormaDePago = 'COLON') OR (FormaDePago = 'COLOR') THEN
                        FormaDePago := 'EFECTIVO'
                    ELSE
                        FormaDePago := 'TARJETA';

                    IF DivisaDePago = '' THEN
                        DivisaDePago := 'COLONES'
                    ELSE
                        DivisaDePago := 'D´Š¢LARES';
                end;
            }
            dataitem(Cambio; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = WHERE(Cambio = CONST(true));
                column(Cambio_Forma; UPPERCASE(FormaDePago))
                {
                }
                column(Cambio_Divisa; UPPERCASE(DivisaDePago))
                {
                }
                column(Cambio_Importe; Importe)
                {
                }
                column(Cambio_Filtro; 'Cambio_Filtro')
                {
                }
            }
            dataitem(Productos; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0),
                                          Type = FILTER(<> 'Charge (Item)'));
                column(Producto_Numero; "No.")
                {
                }
                column(Producto_Descripcion; Description)
                {
                }
                column(Producto_Importe_Total; "Line Amount")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Producto_Importe_Unitario; ROUND("Unit Price"))
                {
                }
                column(Producto_Cantidad; Quantity)
                {
                }
                column(Producto_Numero_Documento; "Document No.")
                {
                }
                column(Producto_Numero_Linea; "Line No.")
                {
                }
                column(Producto_Descuento; FORMAT("Line Discount %") + '%')
                {
                }
                column(Producto_Filtro; 'Producto_Filtro')
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Total_A_Pagar += "Line Amount";
                end;
            }

            trigger OnAfterGetRecord()
            var
                rCajero: Record 34002505;
            begin

                IF rTPV.GET(Tienda) THEN;

                IF rCajero.GET(Tienda, "ID Cajero") THEN
                    NombreCajero := rCajero.Descripcion;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        rEmpresa.GET();
    end;

    var
        rEmpresa: Record 79;
        rTPV: Record 34002503;
        rGLSetUp: Record 98;
        NombreCajero: Text[200];
        DivisaDePago: Code[20];
        FormaDePago: Text[200];
        Total_A_Pagar: Decimal;
}

