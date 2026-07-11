page 50111 "Lista Lineas Ventas SIC"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50112;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo documento"; "Tipo documento")
                {
                }
                field("No. documento"; "No. documento")
                {
                }
                field("No. linea"; "No. linea")
                {
                }
                field("Cod. Cliente"; "Cod. Cliente")
                {
                }
                field(Fecha; Fecha)
                {
                }
                field("Cod. Moneda"; "Cod. Moneda")
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("Importe descuento"; "Importe descuento")
                {
                }
                field("Precio de venta"; "Precio de venta")
                {
                }
                field("Unidad de medida"; "Unidad de medida")
                {
                }
                field(Importe; Importe)
                {
                }
                field("Importe ITBIS Incluido"; "Importe ITBIS Incluido")
                {
                }
                field(codproducto; codproducto)
                {
                }
                field(Transferido; Transferido)
                {
                }
                field(ITBIS; ITBIS)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field(Origen; Origen)
                {
                }
                field(Cupon; Cupon)
                {
                }
                field("No. documento SIC"; "No. documento SIC")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

