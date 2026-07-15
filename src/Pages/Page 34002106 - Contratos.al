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
                field("Empresa cotizacion"; "Empresa cotizacion")
                {
                    Visible = false;
                }
                field("No. empleado"; "No. empleado")
                {
                    Visible = false;
                }
                field("No. Orden"; "No. Orden")
                {
                    Visible = false;
                }
                field("Cod. contrato"; "Cod. contrato")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Frecuencia de pago"; "Frecuencia de pago")
                {
                }
                field("Fecha inicio"; "Fecha inicio")
                {
                }
                field(Duracion; Duracion)
                {
                }
                field("Fecha finalizacion"; "Fecha finalizacion")
                {
                }
                field(Activo; Activo)
                {
                }
                field(Indefinido; Indefinido)
                {
                }
                field(Cargo; Cargo)
                {
                }
                field("Centro trabajo"; "Centro trabajo")
                {
                }
                field(Finalizado; Finalizado)
                {
                }
                field("Dias preaviso"; "Dias preaviso")
                {
                }
                field("Periodo prueba"; "Periodo prueba")
                {
                    Visible = false;
                }
                field(Jornada; Jornada)
                {
                    Visible = false;
                }
                field("Dias semana"; "Dias semana")
                {
                    Visible = false;
                }
                field("Horas dia"; "Horas dia")
                {
                    Visible = false;
                }
                field("Horas semana"; "Horas semana")
                {
                }
                field("Motivo baja"; "Motivo baja")
                {
                }
                field("Causa de la Baja"; "Causa de la Baja")
                {
                }
                field("Pagar preaviso"; "Pagar preaviso")
                {
                    Visible = false;
                }
                field("Pagar cesantia"; "Pagar cesantia")
                {
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

