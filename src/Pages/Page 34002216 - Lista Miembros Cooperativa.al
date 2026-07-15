page 34002216 "Lista Miembros Cooperativa"
{
    Caption = 'Cooperative member list';
    CardPageID = "Ficha Miembros Coop.";
    Editable = false;
    PageType = List;
    SourceTable = 34002195;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo de miembro"; "Tipo de miembro")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                }
                field("Tipo de aporte"; "Tipo de aporte")
                {
                }
                field(Importe; Importe)
                {
                }
                field("Ahorro acumulado"; "Ahorro acumulado")
                {
                }
                field("Prestamos pendientes"; "Prestamos pendientes")
                {
                }
                field("Importe pendiente"; "Importe pendiente")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
        area(factboxes)
        {
            chartpart("Q9150-01"; "Q9150-01")
            {
            }
        }
    }

    actions
    {
    }
}

