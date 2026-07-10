page 50030 "Catalogo Parametros FE-DGT"
{
    Caption = 'Catalogo Parametros FE-DGT';
    PageType = List;
    QueryCategory = '#Basic,#Suite';
    SourceTable = Table50030;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Parametro";"Tipo Parametro")
                {
                }
                field(Codigo;Codigo)
                {
                }
                field(Descripcion;Descripcion)
                {
                }
                field(Inactivo;Inactivo)
                {
                }
                field("Descuento Asumido Fabrica";"Descuento Asumido Fabrica")
                {
                }
            }
        }
    }

    actions
    {
    }
}

