page 51005 "Lista Cupon"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Coupon List';
    CardPageID = "Ficha Cupon";
    Editable = false;
    PageType = List;
    SourceTable = 51009;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No. Cupon"; "No. Cupon")
                {
                }
                field(Pendiente; Pendiente)
                {
                }
                field("Cod. Vendedor"; "Cod. Vendedor")
                {
                }
                field("Valido Desde"; "Valido Desde")
                {
                }
                field("Valido Hasta"; "Valido Hasta")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Descuento a Padres de Familia"; "Descuento a Padres de Familia")
                {
                }
                field("Cantidad Limite"; "Cantidad Limite")
                {
                }
                field("Importe Dto. Limite"; "Importe Dto. Limite")
                {
                }
                field("No. Lote"; "No. Lote")
                {
                }
                field("Fecha Creacion"; "Fecha Creacion")
                {
                }
                field("Hora Creacion"; "Hora Creacion")
                {
                }
                field(Impreso; Impreso)
                {
                }
                field(Anulado; Anulado)
                {
                }
            }
        }
    }

    actions
    {
    }
}

