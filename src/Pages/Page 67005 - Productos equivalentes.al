page 67005 "Productos equivalentes"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67005;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Producto"; "Cod. Producto")
                {
                }
                field("Nombre Producto"; "Nombre Producto")
                {
                    Editable = false;
                }
                field("Cod. Producto Anterior"; "Cod. Producto Anterior")
                {
                }
                field("Nombre Producto Anterior"; "Nombre Producto Anterior")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Item")
            {
                Caption = '&Item';
                action("&Item card")
                {
                    Caption = '&Item card';
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Cod. Producto");
                    ShortCutKey = 'Shift+F5';
                }
                action("&Equivalent Item card")
                {
                    Caption = '&Equivalent Item card';
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Cod. Producto Anterior");
                }

                action("&Import Items")
                {
                    Caption = '&Import Items';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    //TODO: Ver ImportaProdEquiv: Report 67001;
                    begin
                        //TODO: Ver ImportaProdEquiv.RUNMODAL;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }
}

