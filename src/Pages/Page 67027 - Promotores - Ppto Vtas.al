page 67027 "Promotores - Ppto Vtas"
{
    Caption = 'Sales budget Commercial';
    DataCaptionFields = "Cod. Promotor", "Nombre Promotor";
    PageType = Card;
    SourceTable = 67027;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Visible = false;
                }
                field("Cod. Producto"; "Cod. Producto")
                {
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                }
                field("Item Description"; "Item Description")
                {
                    Editable = false;
                }
                field("Cod. producto equivalente"; "Cod. producto equivalente")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Cantidad Adoptada"; "Cantidad Adoptada")
                {
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
                    RunObject = Page "Item Card";
                    RunPageLink = No.=FIELD("Cod. Producto");
                    ShortCutKey = 'Shift+F5';
                }
                action("&Equivalent Item card")
                {
                    Caption = '&Equivalent Item card';
                    RunObject = Page "Item Card";
                                    RunPageLink = No.=FIELD("Cod. producto equivalente");
                }
                separator()
                {
                }
                action("&Insert Items")
                {
                    Caption = '&Insert Items';

                    trigger OnAction()
                    begin
                        CopiaProducto.RecibeDatos("Cod. Promotor",0);
                        CopiaProducto.RUNMODAL();
                    end;
                }
                action("I&mport Budget")
                {
                    Caption = 'I&mport Budget';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcImportaPpto: Report "67002;
                    begin
                        ProcImportaPpto.RecibeParametros(0);
                        ProcImportaPpto.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        CopiaProducto: Report "67000;
}

