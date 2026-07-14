page 75001 "Datos MDM"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = 75001;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(TipoA)
            {
                Caption = 'Tipo';
                field(pTtipo; wTipo)
                {
                    Caption = 'Tipo';
                    Editable = wEditable;
                    Importance = Promoted;
                    OptionCaption = 'Tipo Producto,Soporte,Editora,Nivel,Plan Editorial,Autor,Ciclo,Linea,Asignatura,Grado,Sello,Edición,Estado,Campaña';

                    trigger OnValidate()
                    begin
                        ActualizaTipo;
                    end;
                }
            }
            repeater(Group)
            {
                Editable = wEditable;
                field(Tipo; Tipo)
                {
                    OptionCaption = '';
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Codigo Relacionado"; "Codigo Relacionado")
                {
                    Visible = false;
                }
                field(Bloqueado; Bloqueado)
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
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    end;

    trigger OnOpenPage()
    begin

        IF GETFILTER(Tipo) <> '' THEN
            wTipo := GETRANGEMIN(Tipo);
        ActualizaTipo;
        //TODO: Ver wEditable := cFunMdm.GetEditable;
        CurrPage.EDITABLE := wEditable;
    end;

    var
        wTipo: Option "Tipo Producto",Soporte,Editora,Nivel,"Plan Editorial",Autor,Ciclo,Linea,Asignatura,Grado,Sello,"Edición",Estado,"Campaña";
        //TODO: Ver cFunMdm: Codeunit 75000;
        wEditable: Boolean;

    procedure ActualizaTipo()
    begin
        // ActualizaTipo

        FILTERGROUP(2);
        SETRANGE(Tipo, wTipo);
        FILTERGROUP(0);
        CurrPage.UPDATE(Codigo <> '');
    end;
}

