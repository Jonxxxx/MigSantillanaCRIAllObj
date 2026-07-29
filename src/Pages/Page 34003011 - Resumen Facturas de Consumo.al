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
                field(CantidadNCF; Rec.CantidadNCF)
                {
                    ApplicationArea = All;
                    ToolTip = 'CantidadNCF';
                }
                field(TotalMontoFacturado; Rec.TotalMontoFacturado)
                {
                    ApplicationArea = All;
                    ToolTip = 'TotalMontoFacturado';
                }
                field(TotalITBISFacturado; Rec.TotalITBISFacturado)
                {
                    ApplicationArea = All;
                    ToolTip = 'TotalITBISFacturado';
                }
                field(ImpuestoSelectivoAlConsumo; Rec.ImpuestoSelectivoAlConsumo)
                {
                    ApplicationArea = All;
                    ToolTip = 'ImpuestoSelectivoAlConsumo';
                }
                field(TotalOtrosImpuestosTasas; Rec.TotalOtrosImpuestosTasas)
                {
                    ApplicationArea = All;
                    ToolTip = 'TotalOtrosImpuestosTasas';
                }
                field(TotalMontoPropinaLegal; Rec.TotalMontoPropinaLegal)
                {
                    ApplicationArea = All;
                    ToolTip = 'TotalMontoPropinaLegal';
                }
            }
            group("TIPO DE VENTAS")
            {
                field(MontoEfectivo; Rec.MontoEfectivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoEfectivo';
                }
                field(MontoChequeTransDeposito; Rec.MontoChequeTransDeposito)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoChequeTransDeposito';
                }
                field(MontoTarjeta; Rec.MontoTarjeta)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoTarjeta';
                }
                field(MontoCredito; Rec.MontoCredito)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoCredito';
                }
                field(MontoBonosCertificados; Rec.MontoBonosCertificados)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoBonosCertificados';
                }
                field(MontoPermuta; Rec.MontoPermuta)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoPermuta';
                }
                field(MontoOtrasFormaVentas; Rec.MontoOtrasFormaVentas)
                {
                    ApplicationArea = All;
                    ToolTip = 'MontoOtrasFormaVentas';
                }
            }
        }
    }

    actions
    {
    }
}

