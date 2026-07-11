page 75009 "Conf. Estructura Analitica"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 75009;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Nivel; Nivel)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Id Field"; "Id Field")
                {
                }
                field(FieldName; FieldName)
                {
                }
                field(Valor; Valor)
                {
                }
            }
        }
    }

    actions
    {
    }
}

