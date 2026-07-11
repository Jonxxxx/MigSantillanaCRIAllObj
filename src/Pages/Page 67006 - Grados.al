page 67006 Grados
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Grades';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE("Tipo registro" = CONST(Grados));
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::Grados;
    end;
}

