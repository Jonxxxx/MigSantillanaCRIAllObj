report 56023 "Guia Trans. Res. no registrada"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.                 Firma         Fecha           Descripción
    // ------------------------------------------------------------------------------
    // SANTINAV-301        FES           27-08-2019      Adicionar Campo Comentario" de la Tabla "Cab. Hoja de Ruta"
    // 001                 YFC           17/02/2021       SANTINAV-2130 mejoras en desarrollo para E-Commerce
    DefaultLayout = RDLC;
    RDLCLayout = './Guia Trans. Res. no registrada.rdlc';


    dataset
    {
        dataitem("Cab. Hoja de Ruta"; 56020)
        {
            column(No_Caption; "Cab. Hoja de Ruta"."No. Hoja Ruta")
            {
            }
            column(No_Hojaderuta_Label; Nhojaderuta)
            {
            }
            column(Codigo_Transportista_Caption; "Cab. Hoja de Ruta"."Cod. Transportista")
            {
            }
            column(Codigo_Transportista_Lable; CodTransportista)
            {
            }
            column(Nombre_Transportista_Caption; "Cab. Hoja de Ruta"."Nombre Transportista")
            {
            }
            column(Nombre_Transportista_Lable; NomTransportista)
            {
            }
            column(Hora_Caption; "Cab. Hoja de Ruta".Hora)
            {
            }
            column(Hora_Label; vHora)
            {
            }
            column(Fecha_Pedido_Caption; "Lin. Hoja de Ruta"."Fecha Pedido")
            {
            }
            column(Fecha_Pedido_Label; vFechaPedido)
            {
            }
            column(Pagina_Label; vPagina)
            {
            }
            column(Nombre_Company_Head; CompanyN)
            {
            }
            column(Comentario_label; Comentario_lbl)
            {
            }
            column(Comentario; Comentario)
            {
            }
            dataitem("Lin. Hoja de Ruta"; 56021)
            {
                DataItemLink = No. Hoja Ruta=FIELD(No. Hoja Ruta);
                column(Codigo_Cliente_Caption; "Lin. Hoja de Ruta"."Cod. Cliente")
                {
                }
                column(Codigo_Cliente_Label; vCodigoCliente)
                {
                }
                column(Nombre_Cliente_Caption; "Lin. Hoja de Ruta"."Nombre Cliente")
                {
                }
                column(Nombre_Cliente_Label; vNombreCliente)
                {
                }
                column(Estado_Caption; Cust.County)
                {
                }
                column(Estado_Label; vEstadoL)
                {
                }
                column(Municipio_Caption; Cust.City)
                {
                }
                column(Municipio_Label; vMunicipioL)
                {
                }
                column(Colonia_Caption; Cust."Address 2")
                {
                }
                column(Colonia_Label; vColonia)
                {
                }
                column(No_Factura_Caption; "Lin. Hoja de Ruta"."No. Factura")
                {
                }
                column(No_Factura_Label; vNoFactura)
                {
                }
                column(Bultos_Caption; "Lin. Hoja de Ruta"."Cantidad de Bultos")
                {
                }
                column(Bultos_Label; vBultos)
                {
                }
                column(Fecha_Entrega_Requerida_Caption; "Lin. Hoja de Ruta"."Fecha Entrega Requerida")
                {
                }
                column(Fecha_Entrega_Requerida_Label; vFeEntregaRe)
                {
                }
                column(Observaciones_Caption_OLD; "Lin. Hoja de Ruta".Comentarios)
                {
                }
                column(Observaciones_Caption; Direccion)
                {
                }
                column(Observaciones_Label; vObservaciones)
                {
                }
                column(Fecha_Entrega_Caption; "Lin. Hoja de Ruta"."Fecha Entrega")
                {
                }
                column(Fecha_Entrega_Label; vFechaEntrega)
                {
                }
                column(Causa_NoEntrega_Caption; "Lin. Hoja de Ruta"."Causa No Entrega")
                {
                }
                column(Causa_NoEntrega_Label; vCausaNoEntrega)
                {
                }
                column(No_Pedido_Caption; "Lin. Hoja de Ruta"."No. Pedido")
                {
                }
                column(No_Pedido_Label; vNoPedido)
                {
                }
                column(Ecommerce; SIH."External Document No.")
                {
                }
                column(ClienteEcommerce; SIH."Bill-to Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Cust.GET("Cod. Cliente") THEN;

                    // ++ 001-YFC
                    CLEAR(Direccion);
                    IF SIH.GET("No. Factura") THEN BEGIN
                        IF SIH."Metodo de Envio E-Commerce" = SIH."Metodo de Envio E-Commerce"::Terrestre THEN
                            Direccion := SIH."Ship-to Address"
                        ELSE BEGIN
                            IF CabNop.GET(SIH."External Document No.", SIH."Sell-to Customer No.") THEN
                                Direccion := CabNop."Metodo de Envio Ecommerce";
                        END;
                    END;

                    IF Direccion = '' THEN
                        Direccion := "Lin. Hoja de Ruta".Comentarios;
                    // -- 001-YFC
                end;
            }
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

    var
        Nhojaderuta: Label 'No.:';
        vHora: Label 'Hora:';
        CodTransportista: Label 'Cód. Transportista:';
        NomTransportista: Label 'Nombre Transportista:';
        CompanyN: Label 'Santillana Costa Rica';
        Cust: Record 18;
        rCHR: Record 56020;
        rTSH: Record 5744;
        vEstado: Text[30];
        vCiudad: Text[30];
        VMunicipio: Text[30];
        vCodigoCliente: Label 'Cód. Cliente';
        vNombreCliente: Label 'Nombre Cliente';
        vEstadoL: Label 'Estado';
        vCiudadL: Label 'Ciudad';
        vMunicipioL: Label 'Municipio';
        vNoFactura: Label 'No. Factura';
        vBultos: Label 'Bultos';
        vFeEntregaRe: Label 'Fecha Entrega Requerida';
        vObservaciones: Label 'Observaciones';
        vFechaEntrega: Label 'Fecha Entrega';
        vCausaNoEntrega: Label 'Causa No Entrega';
        vNoPedido: Label 'No. Pedido';
        rSSHH: Record 110;
        vPagina: Label 'Pagina:';
        vColonia: Label 'Colonia';
        vFechaPedido: Label 'Fecha:';
        Comentario_lbl: Label 'Comments';
        SalesHeader: Record 36;
        SIH: Record 112;
        Direccion: Code[100];
        CabNop: Record 50100;
}

