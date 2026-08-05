page 55689 "Conf.Filtros Tipologias MdM"
{
    Caption = 'Campos Filtro Tipologias MdM';
    PageType = List;
    SourceTable = 55689;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = wEditable;
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field("Valor Id"; Rec."Valor Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valor Id';
                }
                field(GetIdName; GetIdName)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF rCampos.FINDLAST THEN
            Id := rCampos.Id + 1
        ELSE
            Id := 1;
    end;

    trigger OnOpenPage()
    begin
        wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;
    end;

    var
        cFunMdm: Codeunit 55681;
        rCampos: Record 55689;
        wEditable: Boolean;
}

