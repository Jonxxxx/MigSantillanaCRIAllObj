page 75008 "Conf.Filtros Tipologias MdM"
{
    Caption = 'Campos Filtro Tipologias MdM';
    PageType = List;
    SourceTable = Table75008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = wEditable;
                field(Id; Id)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field("Valor Id"; "Valor Id")
                {
                }
                field(GetIdName; GetIdName)
                {
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
        cFunMdm: Codeunit 75000;
        rCampos Record: 75008;
        wEditable: Boolean;
}

