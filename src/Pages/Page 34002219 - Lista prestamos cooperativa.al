page 34002219 "Lista prestamos cooperativa"
{
    Caption = 'Cooperative loans list';
    CardPageID = "Cab. prestamos cooperativa";
    Editable = false;
    PageType = List;
    SourceTable = 34002197;

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
                field("No. afiliado"; "No. afiliado")
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
                field("1ra Quincena"; "1ra Quincena")
                {
                }
                field("2da Quincena"; "2da Quincena")
                {
                }
                field("Motivo Prestamo"; "Motivo Prestamo")
                {
                }
                field("Full name"; "Full name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

