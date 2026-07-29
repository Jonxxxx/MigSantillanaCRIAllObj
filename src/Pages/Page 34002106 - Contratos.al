page 34002106 Contratos
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = 34002109;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Empresa cotizacion"; Rec."Empresa cotizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Empresa cotizacion';
                    Visible = false;
                }
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Visible = false;
                }
                field("No. Orden"; Rec."No. Orden")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Orden';
                    Visible = false;
                }
                field("Cod. contrato"; Rec."Cod. contrato")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. contrato';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Frecuencia de pago"; Rec."Frecuencia de pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Frecuencia de pago';
                }
                field("Fecha inicio"; Rec."Fecha inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inicio';
                }
                field(Duracion; Rec.Duracion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Duracion';
                }
                field("Fecha finalizacion"; Rec."Fecha finalizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha finalizacion';
                }
                field(Activo; Rec.Activo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Activo';
                }
                field(Indefinido; Rec.Indefinido)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indefinido';
                }
                field(Cargo; Rec.Cargo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cargo';
                }
                field("Centro trabajo"; Rec."Centro trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Centro trabajo';
                }
                field(Finalizado; Rec.Finalizado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Finalizado';
                }
                field("Dias preaviso"; Rec."Dias preaviso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias preaviso';
                }
                field("Periodo prueba"; Rec."Periodo prueba")
                {
                    ApplicationArea = All;
                    ToolTip = 'Periodo prueba';
                    Visible = false;
                }
                field(Jornada; Rec.Jornada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jornada';
                    Visible = false;
                }
                field("Dias semana"; Rec."Dias semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dias semana';
                    Visible = false;
                }
                field("Horas dia"; Rec."Horas dia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas dia';
                    Visible = false;
                }
                field("Horas semana"; Rec."Horas semana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas semana';
                }
                field("Motivo baja"; Rec."Motivo baja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Motivo baja';
                }
                field("Causa de la Baja"; Rec."Causa de la Baja")
                {
                    ApplicationArea = All;
                    ToolTip = 'Causa de la Baja';
                }
                field("Pagar preaviso"; Rec."Pagar preaviso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar preaviso';
                    Visible = false;
                }
                field("Pagar cesantia"; Rec."Pagar cesantia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar cesantia';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        ContratoCopiaBasica: Record 34002109;
}

