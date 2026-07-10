page 67018 "Areas de interes"
{
    ApplicationArea = Basic,Suite,Service;
    Caption = 'Areas of interest';
    PageType = List;
    SourceTable = Table67002;
    SourceTableView = SORTING(Tipo registro,Codigo)
                      WHERE(Tipo registro=CONST(Areas de interés));
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
        "Tipo registro" := "Tipo registro"::"Areas de interés";
    end;
}

