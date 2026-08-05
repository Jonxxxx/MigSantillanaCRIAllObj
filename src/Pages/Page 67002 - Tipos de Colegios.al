page 55469 "Tipos de Colegios"
{
    ApplicationArea = All;
    Caption = 'School types';
    PageType = List;
    SourceTable = 55469;
    SourceTableView = SORTING("Tipo registro", Codigo)
                      WHERE("Tipo registro" = CONST("Tipos de colegios"));
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

    trigger OnAfterGetRecord()
    begin
        CurrPage.CAPTION(FORMAT("Tipo registro"));
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tipo registro" := "Tipo registro"::"Tipos de colegios";
    end;
}

