page 75002 "Estructura Analitica"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Estructura Analitica';
    PageType = List;
    SourceTable = 75002;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = wEditable;
                field(Codigo; Codigo)
                {
                }
                field(Nivel; Nivel)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Blocked; Blocked)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnOpenPage()
    begin
        wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;
    end;

    var
        cFunMdm: Codeunit 75000;
        wEditable: Boolean;
}

