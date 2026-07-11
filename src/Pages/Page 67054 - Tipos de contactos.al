page 67054 "Tipos de contactos"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Types of contacts';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE("Tipo registro" = CONST(Tipos de contactos));
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
        "Tipo registro" := "Tipo registro"::"Tipos de contactos";
    end;
}

