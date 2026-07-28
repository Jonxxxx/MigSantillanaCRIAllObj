report 34002503 "DsPOS - Cuadre de caja"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Cuadre de caja.rdlc';

    dataset
    {
        dataitem(Turno; 34002529)
        {
            DataItemTableView = SORTING("No. tienda", "No. TPV", Fecha, "No. turno");
            RequestFilterFields = "No. tienda", "No. TPV", Fecha, "No. turno";
            column(Detallado; blnDetallado)
            {
            }
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
            column(TurnoCaption; lblTurno)
            {
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
            column(EnCajaCaption; lblEnCaja)
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
            column(Cobros_Lbl; Text003)
            {
            }
            column(Oper_lbl; Text004)
            {
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
            column(Total_lbl; lblTotal)
            {
            }
            column(EnCaja_lbl; lblEnCaja)
            {
            }
            dataitem(Pagos; 34002523)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Forma de pago")
                                    WHERE("Tipo transaccion" = FILTER(Cobro TPV|Anulacion));
                column(Pagos_TipoMov; TipoMov)
                {
                }
                column(Pagos_Filtro; codFiltro)
                {
                }
                column(Pagos_FormaDePago; "Forma de pago")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Forma de pago';
                }
                column(Pagos_Importe; Importe)
                {
                    IncludeCaption = true;
                }
                column(Pagos_ImporteDL; "Importe (DL)")
                {
                    IncludeCaption = true;
                }
                column(Pagos_NoFactura; "No. Registrado")
                {
                    IncludeCaption = true;
                }
                column(Pagos_NCF; cfComunes.Devolver_NCF_TransCaja(Pagos))
                {
                }
                column(Pagos_Hora; Hora)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin

                    CASE Pagos."Tipo transaccion" OF
                        Pagos."Tipo transaccion"::"Cobro TPV":
                            TipoMov := TipoMov::"Cobro TPV";
                        Pagos."Tipo transaccion"::Anulacion:
                            TipoMov := TipoMov::Anulacion;
                    END;

                    IF Pagos.Cambio THEN
                        TipoMov := TipoMov::Cambio;
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'PAGOS';
                end;
            }
            dataitem(FondoCaja; 34002523)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. transaccion")
                                    WHERE("Tipo transaccion" = CONST(Fondo));
                column(FC_Filtro; codFiltro)
                {
                }
                column(FC_Caption; lblFondo)
                {
                }
                column(FC_Importe; "Importe (DL)")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Fondo de caja:';
                }

                trigger OnPreDataItem()
                begin
                    codFiltro := 'FC';
                end;
            }
            dataitem(OperacionesCaja; 34002523)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Tipo transaccion")
                                    WHERE("Tipo transaccion" = FILTER(Entrada | Salida));
                column(OC_Filtro; codFiltro)
                {
                }
                column(OC_Tipo; texTipoOperacion)
                {
                }
                column(OC_Importe; "Importe (DL)")
                {
                    IncludeCaption = true;
                    OptionCaption = 'Fondo de caja:';
                }

                trigger OnAfterGetRecord()
                begin
                    CASE "Tipo transaccion" OF
                        "Tipo transaccion"::Entrada:
                            texTipoOperacion := Text001;
                        "Tipo transaccion"::Salida:
                            texTipoOperacion := Text002;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'OC';
                end;
            }
            dataitem(TotalesCaja; 34002523)
            {
                DataItemLink = "Cod. tienda" = FIELD("No. tienda"),
                               "Cod. TPV" = FIELD("No. TPV"),
                               Fecha = FIELD(Fecha),
                               "No. turno" = FIELD("No. turno");
                DataItemTableView = SORTING("Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Cod. divisa");
                column(TC_Filtro; codFiltro)
                {
                }
                column(TC_Divisa; "Cod. divisa")
                {
                    IncludeCaption = true;
                }
                column(TC_DescripcionDivisa; TraerDescripcionDivisa)
                {
                }
                column(TC_Importe; Importe)
                {
                    IncludeCaption = true;
                }
                column(TC_ImporteDL; "Importe (DL)")
                {
                    IncludeCaption = true;
                }
                column(TC_FactorDivisa; "Factor divisa")
                {
                    IncludeCaption = true;
                }
                column(TC_TotalEnCaja; "Total caja turno (DL)")
                {
                }
                column(TC_TotalEnCaja_lbl; lblTotalEnCaja)
                {
                }

                trigger OnAfterGetRecord()
                var
                    recTrans: Record 34002523;
                begin
                end;

                trigger OnPreDataItem()
                begin
                    codFiltro := 'TC';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group()
                {
                    field(blnDetallado; blnDetallado)
                    {
                        Caption = 'Mostrar detalle';
                    }
                }
            }
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
        lblFondo: Label 'Fondo de caja:';
        codFiltro: Text;
        texNombreCliente: Text[50];
        codCliente: Code[20];
        lblTotal: Label 'Total para:';
        lblEnCaja: Label 'Totales por Divisa:';
        lblApertura: Label 'Apertura:';
        lblCierre: Label 'Cierre:';
        lblTurno: Label 'Turno n´Š¢:';
        lblTotalEnCaja: Label 'Valor en caja en divisa local:';
        TexNombreInforme: Label 'CUADRE DE CAJA';
        TexCliente: Label 'Cliente';
        TexPagina: Label 'N´Š¢ Pag.:';
        Text001: Label 'Entradas de caja:';
        Text002: Label 'Salidas de caja:';
        texTipoOperacion: Text;
        Text003: Label 'Cobros:';
        Text004: Label 'Operaciones de caja:';
        Text005: Label 'Notas de credito';
        Text006: Label 'Anulaciones';
        Text007: Label 'Detalle de pedidos';
        Text008: Label 'Ventas:';
        blnDetallado: Boolean;
        cfComunes: Codeunit 34002503;
        TipoMov: Option "Cobro TPV",Anulacion,Cambio;

    procedure TraerDescripcionDivisa(): Text
    var
        recDivisa: Record 4;
        recFormaPago: Record 34002513;
        Text001: Label 'Divisa local';
    begin
        IF recFormaPago.GET(TotalesCaja."Forma de pago") THEN
            IF recFormaPago."Efectivo Local" THEN
                EXIT(Text001);

        EXIT(TotalesCaja."Cod. divisa");
    end;
}

