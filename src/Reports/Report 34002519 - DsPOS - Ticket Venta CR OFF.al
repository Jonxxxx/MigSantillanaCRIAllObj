report 34002519 "DsPOS - Ticket Venta CR OFF"
{
    // #52748  22/09/2016  JMB   Creacion de ticket - Modo OFFLINE
    // #217374 13.09.2019  RRT   Correcciones por actualizacion de campos. A´Š¢adir la posibilidad de imprimir notas de credito. Mostrar la parte impositiva.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Ticket Venta CR OFF.rdl';

    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            CalcFields = "Amount Including VAT";
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
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
            column(Clave; Clave)
            {
            }
            column(Consecutivo; Consecutivo)
            {
            }
            column(wTipoDoc; wTipoDoc)
            {
            }
            column(wTextoPago; wTextoPago)
            {
            }
            column(wTotalGravado; wTotalGravado)
            {
            }
            column(wTotalExento; wTotalExento)
            {
            }
            dataitem(Pago; 34002521)
            {
                DataItemLink = "No. Borrador" = FIELD("No.");
                DataItemLinkReference = "Sales Header";
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
                DataItemLinkReference = "Sales Header";
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
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Quantity = FILTER(<> 0),
                                          Type = FILTER(<> 'Charge (Item)'));
                column(Producto_Numero; "No.")
                {
                }
                column(Producto_Descripcion; Description)
                {
                }
                column(Producto_Importe_Total; "Amount Including VAT")
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
                column(Producto_IVA; FORMAT(Productos."VAT %") + '%')
                {
                }

                trigger OnAfterGetRecord()
                begin

                    Total_A_Pagar += "Amount Including VAT";

                    //+#217374
                    IF "VAT %" = 0 THEN
                        wTotalExento += "Amount Including VAT"
                    ELSE
                        wTotalGravado += "Amount Including VAT";
                    //-#217374
                end;
            }

            trigger OnAfterGetRecord()
            var
                rCajero: Record 34002505;
            begin

                IF rTPV.GET(Tienda) THEN;

                IF rCajero.GET(Tienda, "ID Cajero") THEN
                    NombreCajero := rCajero.Descripcion;

                //+#217374
                wTipoDoc := Texto_Factura;
                wTextoPago := Texto_A_Pagar;
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    wTipoDoc := Texto_NCR;
                    wTextoPago := Texto_A_Devolver;
                END;

                wTotalGravado := 0;
                wTotalExento := 0;
                //-#217374
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
        wTipoDoc: Text;
        wTextoPago: Text;
        Texto_Factura: Label 'Factura:';
        Texto_NCR: Label 'NCR:';
        Texto_A_Pagar: Label 'Total a pagar:';
        Texto_A_Devolver: Label 'Total a devolver:';
        wTotalExento: Decimal;
        wTotalGravado: Decimal;
}

