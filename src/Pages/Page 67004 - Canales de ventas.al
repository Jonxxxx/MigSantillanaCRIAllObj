page 67004 "Canales de ventas"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Sales channels';
    PageType = List;
    SourceTable = 67002;
    SourceTableView = SORTING(Tipo registro, Codigo)
                      WHERE("Tipo registro" = CONST("Canal de venta"));
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
        "Tipo registro" := "Tipo registro"::"Canal de venta";
    end;
}

