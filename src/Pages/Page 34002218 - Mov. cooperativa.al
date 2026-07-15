page 34002218 "Mov. cooperativa"
{
    Caption = 'Cooperative entries';
    Editable = false;
    PageType = ListPart;
    SourceTable = 34002196;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Movimiento"; "No. Movimiento")
                {
                }
                field("Tipo miembro"; "Tipo miembro")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("No. documento"; "No. documento")
                {
                }
                field("Tipo transaccion"; "Tipo transaccion")
                {
                }
                field(Importe; Importe)
                {
                }
                field("Full name"; "Full name")
                {
                }
                field("Concepto salarial"; "Concepto salarial")
                {
                }
            }
        }
    }

    actions
    {
    }
}

