page 67157 "Pagos a Expositores Lista"
{
    ApplicationArea = Basic,Suite,Service;
    CardPageID = "Pagos a Expositores Ficha";
    Editable = false;
    PageType = List;
    SourceTable = Table67098;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Pago";"ID Pago")
                {
                }
                field("Cod. Expositor";"Cod. Expositor")
                {
                }
                field("Nombre Expositor";"Nombre Expositor")
                {
                }
                field(Fecha;Fecha)
                {
                }
                field("No. Documento";"No. Documento")
                {
                }
                field("Estado Pago";"Estado Pago")
                {
                }
            }
        }
    }

    actions
    {
    }
}

