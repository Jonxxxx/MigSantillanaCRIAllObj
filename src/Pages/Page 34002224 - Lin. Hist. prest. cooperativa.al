page 34002224 "Lin. Hist. prest. cooperativa"
{
    PageType = ListPart;
    SourceTable = 34002200;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Prestamo"; "No. Prestamo")
                {
                    Visible = false;
                }
                field("Codigo Empleado"; "Codigo Empleado")
                {
                    Visible = false;
                }
                field("No. Cuota"; "No. Cuota")
                {
                }
                field("Fecha Transaccion"; "Fecha Transaccion")
                {
                }
                field("Saldo inicial"; "Saldo inicial")
                {
                }
                field(Interes; Interes)
                {
                }
                field("Importe cuota"; "Importe cuota")
                {
                }
                field(Amortizacion; Amortizacion)
                {
                }
                field("Saldo final"; "Saldo final")
                {
                }
                field("Importe mora"; "Importe mora")
                {
                    Visible = false;
                }
                field("Fecha mora"; "Fecha mora")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

