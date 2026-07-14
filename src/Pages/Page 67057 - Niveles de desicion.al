page 67057 "Niveles de desicion"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Decision level';
    PageType = List;
    SourceTable = 67002;
    //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
    //TODO: Ver                   WHERE("Tipo registro" = CONST("Nivel de decision"));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
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

