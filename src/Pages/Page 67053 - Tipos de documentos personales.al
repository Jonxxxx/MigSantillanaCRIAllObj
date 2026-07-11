page 67053 "Tipos de documentos personales"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67045;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo Factura"; "Tipo Factura")
                {
                }
                field("Tax Identification Type"; "Tax Identification Type")
                {
                }
            }
        }
    }

    actions
    {
    }
}

