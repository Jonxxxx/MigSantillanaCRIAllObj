page 75005 "Imp.MdM Campos"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 75005;
    SourceTableView = SORTING(Id Rel, Orden, Id);

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
                field("Id Rel"; "Id Rel")
                {
                    Visible = false;
                }
                field("Id Cab."; "Id Cab.")
                {
                    Visible = false;
                }
                field("Table Id"; "Table Id")
                {
                    Visible = false;
                }
                field("Id Field"; "Id Field")
                {
                }
                field(cFumImp.GetFieldCaption("Table Id","Id Field");
                    cFumImp.GetFieldCaption("Table Id","Id Field"))
                {
                    Caption = 'Nombre Campo';
                }
                field(Value; Value)
                {
                }
                field("MdM Value"; "MdM Value")
                {
                }
                field(Orden; Orden)
                {
                }
                field("Nombre Elemento"; "Nombre Elemento")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        cFumImp: Codeunit 75001;
}

