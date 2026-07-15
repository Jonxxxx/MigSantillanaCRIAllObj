page 34002222 "Lista Hist. Prest. Cooperativa"
{
    Caption = 'Posted Cooperative Loans List';
    CardPageID = "Cab. Hist. prest. cooperativa";
    Editable = false;
    PageType = List;
    SourceTable = 34002199;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Prestamo"; "No. Prestamo")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Tipo de miembro"; "Tipo de miembro")
                {
                }
                field("Tipo prestamo"; "Tipo prestamo")
                {
                }
                field(Importe; Importe)
                {
                }
                field("% Interes"; "% Interes")
                {
                }
                field("Cantidad de Cuotas"; "Cantidad de Cuotas")
                {
                }
                field("Fecha Inicio Deduccion"; "Fecha Inicio Deduccion")
                {
                }
                field("Motivo Prestamo"; "Motivo Prestamo")
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Concepto Salarial"; "Concepto Salarial")
                {
                }
                field("Importe Pendiente"; "Importe Pendiente")
                {
                }
                field("Motivo de cierre"; "Motivo de cierre")
                {
                }
            }
        }
    }

    actions
    {
    }
}

