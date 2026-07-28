report 34002505 "DsPOS - Resumen del dia"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Resumen del dia.rdlc';

    dataset
    {
        dataitem(Dia; 34002524)
        {
            DataItemTableView = SORTING("No. tienda", "No. TPV", Fecha);
            RequestFilterFields = "No. tienda", "No. TPV", Fecha;
            column(NombreInformeCaption; TexNombreInforme)
            {
            }
            column(PaginaCaption; TexPagina)
            {
            }
            column(NombreTienda; "Nombre tienda")
            {
                IncludeCaption = true;
                OptionCaption = 'Tienda';
            }
            column(NombreTPV; "Nombre TPV")
            {
                IncludeCaption = true;
                OptionCaption = 'TPV';
            }
            column(Fecha; Fecha)
            {
                IncludeCaption = true;
                OptionCaption = 'Fecha';
            }
            column(AperturaCaption; lblApertura)
            {
            }
            column(CierreCaption; lblCierre)
            {
            }
            column(HoraApertura; "Hora apertura")
            {
                IncludeCaption = true;
                OptionCaption = 'Apertura:';
            }
            column(HoraCierre; "Hora cierre")
            {
                IncludeCaption = true;
                OptionCaption = 'Cierre:';
            }
            column(UsuarioApertura; "Usuario apertura")
            {
                IncludeCaption = true;
            }
            column(UsuarioCierre; "Usuario cierre")
            {
                IncludeCaption = true;
            }
            column(NC_Lbl; Text005)
            {
            }
            column(Anul_lbl; Text006)
            {
            }
            column(Pedidos_lbl; Text007)
            {
            }
            column(VTAS_lbl; Text008)
            {
            }
            column(NCF_lbl; Text009)
            {
            }
            column(wTotalVentas_; wTotalVentas)
            {
            }
            column(wTotalAnual_; wTotalAnul)
            {
            }
            dataitem(DetalleDePedidos; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha);
                DataItemTableView = SORTING("No. Registrado")
                                    ORDER(Ascending)
                                    WHERE("Tipo Transaccion" = CONST(Venta));
                column(Ped_Filtro; codFiltro)
                {
                }
                column(Ped_Fechas; Fecha)
                {
                    IncludeCaption = true;
                    OptionCaption = 'Fecha';
                }
                column(Ped_ClienteCaption; lblCliente)
                {
                }
                column(Ped_NombreClienteCaptions; lblNombreCliente)
                {
                }
                column(Ped_Cliente; "Cod. cliente")
                {
                    OptionCaption = 'Cliente';
                }
                column(Ped_NombreCliente; "Nombre cliente")
                {
                    OptionCaption = 'Nombre del cliente';
                }
                column(Ped_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    OptionCaption = 'N´Š¢ de documento';
                }
                column(Ped_ImporteIVAInc; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Importe';
                }
                column(Ped_NCF; cFComunes.Devolver_NCF(DetalleDePedidos))
                {
                }
                column(Ped_AnuladoPor; cFComunes.AnulaA_AnuladoPor(DetalleDePedidos))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    wTotalVentas += DetalleDePedidos."Importe IVA inc.";
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'VTAS';
                end;
            }
            dataitem(NotasDeCredito; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha);
                DataItemTableView = SORTING("No. Registrado")
                                    ORDER(Ascending)
                                    WHERE("Tipo Transaccion" = CONST(Abono));
                column(NC_Filtro; codFiltro)
                {
                }
                column(NC_Fecha; Fecha)
                {
                    IncludeCaption = true;
                    OptionCaption = 'Fecha';
                }
                column(NC_ClienteCaption; lblCliente)
                {
                }
                column(NC_NombreCliente; "Nombre cliente")
                {
                    OptionCaption = 'Cliente';
                }
                column(NC_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    OptionCaption = 'N´Š¢ de nota de credito';
                }
                column(NC_Importe; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Importe';
                }
                column(NC_NCF; cFComunes.Devolver_NCF(NotasDeCredito))
                {
                }
                column(NC_AnulaA; cFComunes.AnulaA_AnuladoPor(NotasDeCredito))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    wTotalAnul += NotasDeCredito."Importe IVA inc.";
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'NC';
                end;
            }
            dataitem(Anulaciones; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha);
                DataItemTableView = SORTING("No. Registrado")
                                    ORDER(Ascending)
                                    WHERE("Tipo Transaccion" = CONST(Anulacion));
                column(Anul_Filtro; codFiltro)
                {
                }
                column(Anul_Fecha; Fecha)
                {
                    IncludeCaption = true;
                    OptionCaption = 'Fecha';
                }
                column(Anul_ClienteCaption; lblCliente)
                {
                }
                column(Anul_NombreCliente; "Nombre cliente")
                {
                    OptionCaption = 'Cliente';
                }
                column(Anul_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    OptionCaption = 'N´Š¢ de anulacion';
                }
                column(Anul_Importe; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Importe';
                }
                column(Anul_NCF; cFComunes.Devolver_NCF(Anulaciones))
                {
                }
                column(Anul_AnulaA; cFComunes.AnulaA_AnuladoPor(Anulaciones))
                {
                }

                trigger OnAfterGetRecord()
                begin

                    wTotalAnul += Anulaciones."Importe IVA inc.";
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'ANUL';
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

    trigger OnPreReport()
    var
        Error001: Label 'Debe indicar filtro %1';
    begin
        WITH Dia DO BEGIN
            IF GETFILTER("No. tienda") = '' THEN
                ERROR(Error001, FIELDCAPTION("No. tienda"));

            IF GETFILTER("No. TPV") = '' THEN
                ERROR(Error001, FIELDCAPTION("No. TPV"));

            IF GETFILTER(Fecha) = '' THEN
                ERROR(Error001, FIELDCAPTION(Fecha));

        END;
    end;

    var
        codFiltro: Text;
        lblApertura: Label 'Apertura:';
        lblCierre: Label 'Cierre:';
        TexNombreInforme: Label 'RESUMEN DE VENTAS DEL Dia';
        lblCliente: Label 'Cliente';
        lblNombreCliente: Label 'Nombre cliente';
        TexPagina: Label 'N´Š¢ Pag.:';
        texTipoOperacion: Text;
        Text005: Label 'Notas de credito';
        Text006: Label 'Anulaciones';
        Text007: Label 'Detalle de Facturas';
        Text008: Label 'Ventas:';
        decImporteEnCaja: Decimal;
        Text009: Label 'nomero Compr. Fiscal';
        cFComunes: Codeunit 34002503;
        cFDominicana: Codeunit 34002504;
        wTotalVentas: Decimal;
        wTotalAnul: Decimal;
}

