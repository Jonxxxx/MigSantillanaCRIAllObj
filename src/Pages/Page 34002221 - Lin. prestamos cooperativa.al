page 34002221 "Lin. prestamos cooperativa"
{
    Caption = 'Cooperative loan lines';
    Editable = false;
    PageType = ListPart;
    SourceTable = 34002198;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo Empleado"; "Codigo Empleado")
                {
                    Visible = false;
                }
                field("No. Cuota"; "No. Cuota")
                {
                }
                field("Tipo prestamo"; "Tipo prestamo")
                {
                    Visible = false;
                }
                field("Fecha Transaccion"; "Fecha Transaccion")
                {
                    Visible = false;
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
                field(Capital; Capital)
                {
                }
                field(Saldo; Saldo)
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

