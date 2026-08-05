page 55645 "Motivos de Perdida"
{
    ApplicationArea = All;
    Caption = 'Cause of loosing';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Motivos Perdida"));
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
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::"Motivos Perdida";
    end;
}

