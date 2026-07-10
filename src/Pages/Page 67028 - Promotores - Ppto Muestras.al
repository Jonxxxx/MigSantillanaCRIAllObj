page 67028 "Promotores - Ppto Muestras"
{
    Caption = 'Samples budget Commercial';
    DataCaptionFields = "Cod. Promotor", "Nombre Promotor";
    PageType = Card;
    SourceTable = Table67028;

    layout
    {
        area(content)
        {
            repeater()
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
                field(Quantity; Quantity)
                {
                }
                field("Extended Quantity"; "Extended Quantity")
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
                    RunPageLink = No.=FIELD(Cod. Producto);
                    ShortCutKey = 'Shift+F5';
                }
                action("&Equivalent Item card")
                {
                    Caption = '&Equivalent Item card';
                    RunObject = Page "Item Card";
                                    RunPageLink = No.=FIELD(Cod. producto equivalente);
                }
                separator()
                {
                }
                action("&Insert Items")
                {
                    Caption = '&Insert Items';

                    trigger OnAction()
                    begin
                        CopiaProducto.RecibeDatos("Cod. Promotor",1);
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
                        ProcImportaPpto.RecibeParametros(1);
                        ProcImportaPpto.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        CopiaProducto: Report "67000;
}

