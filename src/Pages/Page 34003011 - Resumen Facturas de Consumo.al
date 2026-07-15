page 34003011 "Resumen Facturas de Consumo"
{
    Caption = 'Resumen General de Facturas de Consumo (F.C)';
    DataCaptionFields = "Codigo reporte";
    Description = 'Resumen General de Facturas de Consumo (F.C)';
    Editable = false;
    PageType = Card;
    SourceTable = 34003004;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(GENERAL)
            {
                field(CantidadNCF; CantidadNCF)
                {
                }
                field(TotalMontoFacturado; TotalMontoFacturado)
                {
                }
                field(TotalITBISFacturado; TotalITBISFacturado)
                {
                }
                field(ImpuestoSelectivoAlConsumo; ImpuestoSelectivoAlConsumo)
                {
                }
                field(TotalOtrosImpuestosTasas; TotalOtrosImpuestosTasas)
                {
                }
                field(TotalMontoPropinaLegal; TotalMontoPropinaLegal)
                {
                }
            }
            group("TIPO DE VENTAS")
            {
                field(MontoEfectivo; MontoEfectivo)
                {
                }
                field(MontoChequeTransDeposito; MontoChequeTransDeposito)
                {
                }
                field(MontoTarjeta; MontoTarjeta)
                {
                }
                field(MontoCredito; MontoCredito)
                {
                }
                field(MontoBonosCertificados; MontoBonosCertificados)
                {
                }
                field(MontoPermuta; MontoPermuta)
                {
                }
                field(MontoOtrasFormaVentas; MontoOtrasFormaVentas)
                {
                }
            }
        }
    }

    actions
    {
    }
}

