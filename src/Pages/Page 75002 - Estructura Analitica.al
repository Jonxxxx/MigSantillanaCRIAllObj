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
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    end;

    trigger OnOpenPage()
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;
    end;

    var
        //TODO: Ver cFunMdm: Codeunit 75000;
        wEditable: Boolean;
}

