page 67033 "Lista Puestos"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Jobs';
    PageType = List;
    SourceTable = 67002;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Puestos de trabajo"));
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
                field("Aplica Jerarquia Colegio"; "Aplica Jerarquia Colegio")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::"Puestos de trabajo";
    end;
}

