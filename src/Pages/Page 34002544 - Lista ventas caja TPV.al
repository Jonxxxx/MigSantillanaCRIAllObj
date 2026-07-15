page 34002544 "Lista ventas caja TPV"
{
    Editable = false;
    PageType = List;
    SourceTable = 34002530;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. tienda"; "Cod. tienda")
                {
                }
                field("Cod. TPV"; "Cod. TPV")
                {
                }
                field(Fecha; Fecha)
                {
                }
                field("No. turno"; "No. turno")
                {
                }
                field("No. Transaccion"; "No. Transaccion")
                {
                }
                field("Tipo Transaccion"; "Tipo Transaccion")
                {
                }
                field("Id. cajero"; "Id. cajero")
                {
                }
                field(Hora; Hora)
                {
                }
                field(Importe; Importe)
                {
                }
                field("Importe IVA inc."; "Importe IVA inc.")
                {
                }
                field("No. Borrador"; "No. Borrador")
                {
                    Caption = 'No. Borrador';
                }
                field("No. Registrado"; "No. Registrado")
                {
                    Caption = 'No. Registrado';
                }
            }
        }
    }

    actions
    {
    }
}

