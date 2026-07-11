page 67032 "Tipo de Educacion"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Education type';
    PageType = List;
    SourceTable = 67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE("Tipo registro" = CONST("Tipo de educacion"));
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
        "Tipo registro" := "Tipo registro"::"Tipo de educacion";
    end;
}

