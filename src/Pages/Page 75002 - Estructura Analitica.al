page 55683 "Estructura Analitica"
{
    ApplicationArea = All;
    Caption = 'Estructura Analitica';
    PageType = List;
    SourceTable = 55683;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = wEditable;
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Nivel; Rec.Nivel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Blocked';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(Rec.TABLECAPTION);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(Rec.TABLECAPTION);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(Rec.TABLECAPTION);
    end;

    trigger OnOpenPage()
    begin
        wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;
    end;

    var
        cFunMdm: Codeunit 55681;
        wEditable: Boolean;
}

