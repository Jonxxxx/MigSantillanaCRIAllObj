page 67138 "Estados colegios"
{
    AdditionalSearchTerms = 'School status';
    ApplicationArea = Basic,Suite;
    Caption = 'School status';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro,Codigo)
                      WHERE(Tipo registro=CONST(Estado Colegio));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo;Codigo)
                {
                }
                field(Descripcion;Descripcion)
                {
                }
            }
        }
    }

    actions
    {
    }
}

