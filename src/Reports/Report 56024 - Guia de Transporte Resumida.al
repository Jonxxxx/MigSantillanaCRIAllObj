report 56024 "Guia de Transporte Resumida"
{
    // #4161     PLB  26/09/2014  Se pide que muestre el nº de factura que corresponde a la guía, pero esto no es posible
    //                            tal como trabajan. Si se factura desde el pedido, la factura y la guía no quedan
    //                            relacionados.
    // 
    // MOI - 12/12/2014: Se modifica el report para que aparezcan nuevos campos y desaparezcan antiguos.
    //                   Modificaciones:
    //                     Falta añadir label Nombre Cliente
    //                     Sobra columna Peso (Se oculta a nivel de Layout y se reduce)
    //                     Sobra columna Condiciones de envio (Se oculta a nivel de Layout y se reduce)
    //                     Añadida nueva columna Entregado
    //                     Añadida nueva columna Fecha entrega
    //                     Añadida nueva columna Causa no entrega.
    // 
    // YFC     : Yefrecis Francisco Cruz
    // ------------------------------------------------------------------------
    // No.         Firma     Fecha            Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC      17/02/2021       SANTINAV-2130 mejoras en desarrollo para E-Commerce
    DefaultLayout = RDLC;
    RDLCLayout = './Guia de Transporte Resumida.rdlc';

    Caption = 'Shipping Guide';

    dataset
    {
        dataitem("Cab. Hoja de Ruta Reg."; 56022)
        {
            RequestFilterFields = "No. Hoja Ruta";
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Cab__Hoja_de_Ruta_Reg__Hora; Hora)
            {
            }
            column(Cab__Hoja_de_Ruta_Reg___No__Hoja_Ruta_; "No. Hoja Ruta")
            {
            }
            column(Cab__Hoja_de_Ruta_Reg___Cod__Transportista_; "Cod. Transportista")
            {
            }
            column(Cab__Hoja_de_Ruta_Reg___Fecha_Registro_; "Fecha Registro")
            {
            }
            column(Nombre; Nombre)
            {
            }
            column(No__Caption; No__CaptionLbl)
            {
            }
            column(Chofer_Caption; Chofer_CaptionLbl)
            {
            }
            column(Fecha_Caption; Fecha_CaptionLbl)
            {
            }
            column(Pagina_Caption; Página_CaptionLbl)
            {
            }
            column(Hora_Caption; Hora_CaptionLbl)
            {
            }
            column(Ruta_Embarque_Caption; Ruta_Embarque_CaptionLbl)
            {
            }
            column(Relacion__EmbarqueCaption; Relación__EmbarqueCaptionLbl)
            {
            }
            column(No__LineaCaption; No__LíneaCaptionLbl)
            {
            }
            column(Cod__ClienteCaption; Cód__ClienteCaptionLbl)
            {
            }
            column(NombreClienteCaption; NombreClienteCaptionLbl)
            {
            }
            column(EstadoCaption; EstadoCaptionLbl)
            {
            }
            column(CiudadCaption; CiudadCaptionLbl)
            {
            }
            column(MunicipioCaption; MunicipioCaptionLbl)
            {
            }
            column(No__FacturaCaption; No__FacturaCaptionLbl)
            {
            }
            column(No__PedidoCaption; No__PedidoCaptionLbl)
            {
            }
            column(BultosCaption; BultosCaptionLbl)
            {
            }
            column(PesoCaption; PesoCaptionLbl)
            {
            }
            column(Fecha_Entrega_RequeridaCaption; Fecha_Entrega_RequeridaCaptionLbl)
            {
            }
            column(Condiciones_de_envioCaption; Condiciones_de_envíoCaptionLbl)
            {
            }
            column(Observaciones_Caption; Observaciones_CaptionLbl)
            {
            }
            column(Chofer; Chofer)
            {
            }
            column(Nombre_Chofer; "Nombre Chofer")
            {
            }
            column(Placa; Placa)
            {
            }
            column(EntregadoCaption; EntregadoLbl)
            {
            }
            column(FechaEntregaCaption; FechaEntregaLbl)
            {
            }
            column(CausaNoEntregaCaption; CausaNoEntregaLbl)
            {
            }
            dataitem("Lin. Hoja de Ruta Reg."; 56023)
            {
                DataItemLink = "No. Hoja Ruta" = FIELD("No. Hoja Ruta");
                DataItemTableView = SORTING("No. Hoja Ruta", "No. Linea")
                                    ORDER(Ascending);
                column(Lin__Hoja_de_Ruta_Reg___Cod__Cliente_; "Cod. Cliente")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg___Nombre_Cliente_; "Nombre Cliente")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg___Cantidad_de_Bultos_; "Cantidad de Bultos")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__Peso; Peso)
                {
                }
                column(Cust__Address_2_; Cust."Address 2")
                {
                }
                column(Cust__Territory_Code_; Cust."Territory Code")
                {
                }
                column(Cust_City; Cust.City)
                {
                }
                column(Lin__Hoja_de_Ruta_Reg___Lin__Hoja_de_Ruta_Reg____Fecha_Entrega_Requerida_; "Lin. Hoja de Ruta Reg."."Fecha Entrega Requerida")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg___Lin__Hoja_de_Ruta_Reg____Condiciones_de_Envio_; "Lin. Hoja de Ruta Reg."."Condiciones de Envio")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg___Lin__Hoja_de_Ruta_Reg___Comentarios; "Lin. Hoja de Ruta Reg.".Comentarios)
                {
                }
                column(Ecommerce; SIH."External Document No.")
                {
                }
                column(NoFact; "No. Factura")
                {
                }
                column(NoPed; "No. Pedido")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__No__Hoja_Ruta; "No. Hoja Ruta")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__No__Linea; "No. Linea")
                {
                }
                column(Ciudad; Ciudad)
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__Entregado; "Lin. Hoja de Ruta Reg.".Entregado)
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__Fecha_Entrega; "Lin. Hoja de Ruta Reg."."Fecha Entrega")
                {
                }
                column(Lin__Hoja_de_Ruta_Reg__Causa_No_Entrega; "Lin. Hoja de Ruta Reg."."Causa No Entrega")
                {
                }

                trigger OnAfterGetRecord()
                var
                    TSH: Record 5744;
                    SSHH: Record 110;
                    FinBucle: Boolean;
                begin
                    IF Cust.GET("Cod. Cliente") THEN;

                    //+#4161
                    //IF SSHH.GET("No. Conduce") THEN
                    //  NoPed := SSHH."Order No."
                    //ELSE
                    //  NoPed := '';
                    //
                    //NoFact := ''; //+#4161
                    //FinBucle := FALSE; //+#4161
                    //
                    //SIH.RESET;
                    //SIH.SETCURRENTKEY("Order No."); //+#4161
                    //SIH.SETRANGE("Order No.",SSHH."Order No.");
                    //IF SIH.FINDFIRST THEN
                    //  NoFact := SIH."No."
                    //ELSE
                    //  NoFact := '';
                    //-#4161

                    IF "Tipo Envio" = "Tipo Envio"::Transferencia THEN
                        IF TSH.GET("No. Conduce") THEN
                            Ciudad := TSH."Transfer-to City";

                    IF "Tipo Envio" = "Tipo Envio"::"Pedido Venta" THEN
                        IF SSHH.GET("No. Conduce") THEN
                            Ciudad := SSHH."Sell-to City";

                    //CLEAR(SIH);
                    IF SIH.GET("No. Factura") THEN; // 001-YFC
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ShpAgent.GET("Cod. Transportista") THEN
                    Nombre := ShpAgent.Name
                ELSE
                    Nombre := '';
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

    var
        NombreCliente: Text[100];
        Cust: Record 18;
        ShpAgent: Record 291;
        Nombre: Text[100];
        No__CaptionLbl: Label 'No.:';
        Chofer_CaptionLbl: Label 'Chofer:';
        Fecha_CaptionLbl: Label 'Fecha:';
        "Página_CaptionLbl": Label 'Página:';
        Hora_CaptionLbl: Label 'Hora:';
        Ruta_Embarque_CaptionLbl: Label 'Ruta Embarque:';
        "Relación__EmbarqueCaptionLbl": Label 'Relación  Embarque';
        "No__LíneaCaptionLbl": Label 'No. Línea';
        "Cód__ClienteCaptionLbl": Label 'Cód. Cliente';
        NombreClienteCaptionLbl: Label 'Nombre Cliente';
        EstadoCaptionLbl: Label 'Estado';
        CiudadCaptionLbl: Label 'Ciudad';
        MunicipioCaptionLbl: Label 'Municipio';
        No__FacturaCaptionLbl: Label 'No. Factura';
        No__PedidoCaptionLbl: Label 'No. Pedido';
        BultosCaptionLbl: Label 'Bultos';
        PesoCaptionLbl: Label 'Peso';
        Fecha_Entrega_RequeridaCaptionLbl: Label 'Fecha Entrega Requerida';
        "Condiciones_de_envíoCaptionLbl": Label 'Condiciones de envío';
        Observaciones_CaptionLbl: Label 'Observaciones ';
        Ciudad: Text[40];
        EntregadoLbl: Label 'Entregado';
        FechaEntregaLbl: Label 'Fecha Entrega';
        CausaNoEntregaLbl: Label 'Causa no entrega';
        SIH: Record 112;
}

