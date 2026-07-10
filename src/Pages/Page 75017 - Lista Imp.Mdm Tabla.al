page 75017 "Lista Imp.Mdm Tabla"
{
    CardPageID = "Imp.MdM Tabla";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = true;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Table75004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Id)
                {
                    Visible = false;
                }
                field(Operacion; Operacion)
                {
                    Visible = false;
                }
                field("Id Tabla"; "Id Tabla")
                {
                }
                field(cFumImp.GetTableCaption("Id Tabla");
                    cFumImp.GetTableCaption("Id Tabla"))
                {
                    Caption = 'Nombre Tabla';
                }
                field(Code; Code)
                {
                }
                field("Code MdM"; "Code MdM")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field("Nombre Elemento"; "Nombre Elemento")
                {
                }
                field(Visible; Visible)
                {
                }
                field(Procesado; Procesado)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Tabla)
            {
                Caption = 'Tabla';
                Image = "Table";
                action(Ver)
                {
                    Caption = 'Ver';
                    Image = View;
                    RunObject = Page 75004;
                    RunPageOnRec = true;
                }
                action(Ficha)
                {
                    Image = Form;

                    trigger OnAction()
                    begin

                        VerFicha;
                    end;
                }
            }
            action("Solo Pendientes")
            {

                trigger OnAction()
                begin
                    SETRANGE(Procesado, FALSE);
                end;
            }
        }
    }

    var
        cFumImp: Codeunit 75001;
}

