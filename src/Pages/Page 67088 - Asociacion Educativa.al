page 67088 "Asociacion Educativa"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = WHERE("Tipo registro" = CONST("Asociacion educativa"));
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
            }
        }
    }

    actions
    {
    }
}

