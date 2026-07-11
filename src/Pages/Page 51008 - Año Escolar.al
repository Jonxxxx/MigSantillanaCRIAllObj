page 51008 "Año Escolar"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'School Year';
    PageType = List;
    SourceTable = 51013;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Cod. Ano"; "Cod. Ano")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Fecha Desde"; "Fecha Desde")
                {
                }
                field("Fecha Hasta"; "Fecha Hasta")
                {
                }
            }
        }
    }

    actions
    {
    }
}

