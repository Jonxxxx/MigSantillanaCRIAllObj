page 55500 "Lista Puestos"
{
    ApplicationArea = All;
    Caption = 'Jobs';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Puestos de trabajo"));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Aplica Jerarquia Colegio"; Rec."Aplica Jerarquia Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aplica Jerarquia Colegio';
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

