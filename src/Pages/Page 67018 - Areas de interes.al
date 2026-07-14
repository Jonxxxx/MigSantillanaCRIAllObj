page 67018 "Areas de interes"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Areas of interest';
    PageType = List;
    SourceTable = 67002;
    //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
    //TODO: Ver WHERE("Tipo registro" = CONST("Areas de interes"));
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //TODO: Ver "Tipo registro" := "Tipo registro"::"Areas de interés";
    end;
}

