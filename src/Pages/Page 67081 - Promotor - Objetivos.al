page 67081 "Promotor - Objetivos"
{
    ApplicationArea = Basic,Suite,Service;
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro,Codigo)
                      WHERE(Tipo registro=CONST(Objetivos));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater()
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::Objetivos;
    end;
}

