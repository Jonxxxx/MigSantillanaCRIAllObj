report 34002504 "DsPOS - Resumen del turno"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Resumen del turno.rdlc';

    dataset
    {
        dataitem(Turno; 34002529)
        {
            DataItemTableView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno");
            RequestFilterFields = "No. tienda", "No. TPV", Fecha, "No. turno";
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
            column(NoTurno; "No. turno")
            {
                IncludeCaption = true;
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
            dataitem(DetalleDePedidos; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Venta));
                column(Ped_Filtro; codFiltro)
                {
                }
                column(Ped_ClienteCaption; lblCliente)
                {
                }
                column(Ped_NombreClienteCaption; lblNombreCliente)
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
                column(Ped_Hora; Hora)
                {
                    OptionCaption = 'Time';
                }
                column(Ped_NCF; cFComunes.Devolver_NCF(DetalleDePedidos))
                {
                    OptionCaption = 'N´Š¢ Compr. Fiscal';
                }

                trigger OnPreDataItem()
                begin
                    codFiltro := 'VTAS';
                end;
            }
            dataitem(NotasDeCredito; 34002530)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Abono));
                column(NC_Filtro; codFiltro)
                {
                }
                column(NC_ClienteCaption; lblCliente)
                {
                }
                column(NC_NombreClienteCaption; lblNombreCliente)
                {
                }
                column(NC_Cliente; "Cod. cliente")
                {
                    OptionCaption = 'Cliente';
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
                column(NC_Hora; Hora)
                {
                    OptionCaption = 'Time';
                }
                column(NC_NCF; cFComunes.Devolver_NCF(NotasDeCredito))
                {
                    OptionCaption = 'N´Š¢ Compr. Fiscal';
                }

                trigger OnAfterGetRecord()
                var
                    recCabAbo: Record 114;
                begin
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
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
                                    WHERE("Tipo Transaccion" = CONST(Anulacion));
                column(Anul_Filtro; codFiltro)
                {
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
                column(Anul_Hora; Hora)
                {
                    OptionCaption = 'Time';
                }
                column(Anul_NCF; cFComunes.Devolver_NCF(Anulaciones))
                {
                    OptionCaption = 'N´Š¢ Compr. Fiscal';
                }
                column(Anul_Cliente; "Cod. cliente")
                {
                    OptionCaption = 'Cliente';
                }
                column(Anul_NombreClienteCaption; lblNombreCliente)
                {
                }

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
        WITH Turno DO BEGIN
            IF GETFILTER("No. tienda") = '' THEN
                ERROR(Error001, FIELDCAPTION("No. tienda"));

            IF GETFILTER("No. TPV") = '' THEN
                ERROR(Error001, FIELDCAPTION("No. TPV"));

            IF GETFILTER(Fecha) = '' THEN
                ERROR(Error001, FIELDCAPTION(Fecha));

            IF GETFILTER("No. turno") = '' THEN
                ERROR(Error001, FIELDCAPTION("No. turno"));
        END;
    end;

    var
        codFiltro: Text;
        lblApertura: Label 'Apertura:';
        lblCierre: Label 'Cierre:';
        TexNombreInforme: Label 'RESUMEN DE VENTAS';
        lblCliente: Label 'Cliente';
        lblNombreCliente: Label 'Nombre cliente';
        TexPagina: Label 'N´Š¢ Pag.:';
        texTipoOperacion: Text;
        Text005: Label 'Notas de credito';
        Text006: Label 'Anulaciones';
        Text007: Label 'Detalle de Facturas';
        Text008: Label 'Ventas:';
        decImporteEnCaja: Decimal;
        cFComunes: Codeunit 34002503;
}

