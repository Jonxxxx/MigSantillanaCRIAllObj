report 34002521 "DsPOS - Resumen del dia RD"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Resumen del dia RD.rdl';

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
                Caption = 'Tienda';
            }
            column(NombreTPV; "Nombre TPV")
            {
                IncludeCaption = true;
                Caption = 'TPV';
            }
            column(Fecha; Fecha)
            {
                IncludeCaption = true;
                Caption = 'Fecha';
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
                Caption = 'Apertura:';
            }
            column(HoraCierre; "Hora cierre")
            {
                IncludeCaption = true;
                Caption = 'Cierre:';
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
            dataitem(DetalleDePedidos; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha);
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Venta));
                column(Ped_Filtro; codFiltro)
                {
                }
                column(Ped_Fechas; Fecha)
                {
                    IncludeCaption = true;
                    Caption = 'Fecha';
                }
                column(Ped_ClienteCaption; lblCliente)
                {
                }
                column(Ped_NombreClienteCaption; lblNombreCliente)
                {
                }
                column(Ped_Cliente; "Cod. cliente")
                {
                    Caption = 'Cliente';
                }
                column(Ped_NombreCliente; "Nombre cliente")
                {
                    Caption = 'Nombre del cliente';
                }
                column(Ped_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    Caption = 'No de documento';
                }
                column(Ped_ImporteIVAInc; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    Caption = 'Importe';
                }
                //TODO: Ver
                /*
                column(Ped_NCF; cFComunes.Devolver_NCF(DetalleDePedidos))
                {
                }
                column(Ped_TNCF; cFDominicana.Devolver_Tipo_NCF(DetalleDePedidos))
                {
                }*/

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
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Abono));
                column(NC_Filtro; codFiltro)
                {
                }
                column(NC_Fecha; Fecha)
                {
                    IncludeCaption = true;
                    Caption = 'Fecha';
                }
                column(NC_ClienteCaption; lblCliente)
                {
                }
                column(NC_NombreCliente; "Nombre cliente")
                {
                    Caption = 'Cliente';
                }
                column(NC_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    Caption = 'No de nota de credito';
                }
                column(NC_Importe; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    Caption = 'Importe';
                }
                //TODO: Ver
                /*
                column(NC_NCF; cFComunes.Devolver_NCF(NotasDeCredito))
                {
                }
                column(NC_TNCF; cFDominicana.Devolver_Tipo_NCF(NotasDeCredito))
                {
                }*/

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
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Anulacion));
                column(Anul_Filtro; codFiltro)
                {
                }
                column(Anul_Fecha; Fecha)
                {
                    IncludeCaption = true;
                    Caption = 'Fecha';
                }
                column(Anul_ClienteCaption; lblCliente)
                {
                }
                column(Anul_NombreCliente; "Nombre cliente")
                {
                    Caption = 'Cliente';
                }
                column(Anul_NoDocumento; "No. Registrado")
                {
                    IncludeCaption = true;
                    Caption = 'No de anulacion';
                }
                column(Anul_Importe; "Importe IVA inc.")
                {
                    IncludeCaption = true;
                    Caption = 'Importe';
                }
                //TODO: Ver
                /*
                column(Anul_NCF; cFComunes.Devolver_NCF(Anulaciones))
                {
                }
                column(Anul_TNCF; cFDominicana.Devolver_Tipo_NCF(Anulaciones))
                {
                }*/

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
        TexPagina: Label 'No Pag.:';
        texTipoOperacion: Text;
        Text005: Label 'Notas de credito';
        Text006: Label 'Anulaciones';
        Text007: Label 'Detalle de Facturas';
        Text008: Label 'Ventas:';
        decImporteEnCaja: Decimal;
        Text009: Label 'nomero Compr. Fiscal';
        cFComunes: Codeunit 34002503;
}

