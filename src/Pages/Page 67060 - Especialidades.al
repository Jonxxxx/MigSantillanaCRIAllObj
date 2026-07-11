page 67060 Especialidades
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Specialties';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE("Tipo registro" = CONST(Especialidades));
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
        "Tipo registro" := "Tipo registro"::Especialidades;
    end;
}

