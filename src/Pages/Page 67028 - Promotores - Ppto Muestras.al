page 67028 "Promotores - Ppto Muestras"
{
    Caption = 'Samples budget Commercial';
    DataCaptionFields = "Cod. Promotor", "Nombre Promotor";
    PageType = Card;
    SourceTable = 67028;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                    Visible = false;
                }
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                }
                field("Nombre Promotor"; Rec."Nombre Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Promotor';
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item Description';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                }
                field("Extended Quantity"; Rec."Extended Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Extended Quantity';
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
                    ApplicationArea = All;
                    Caption = '&Item card';
                    ToolTip = '&Item card';
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Cod. Producto");
                    ShortCutKey = 'Shift+F5';
                }
                action("&Equivalent Item card")
                {
                    ApplicationArea = All;
                    Caption = '&Equivalent Item card';
                    ToolTip = '&Equivalent Item card';
                    RunObject = Page 30;
                    RunPageLink = "No." = FIELD("Cod. producto equivalente");
                }

                action("&Insert Items")
                {

                    ApplicationArea = All;
                    Caption = '&Insert Items';
                    ToolTip = '&Insert Items';
                    trigger OnAction()
                    begin
                        CopiaProducto.RecibeDatos(Rec."Cod. Promotor", 1);
                        CopiaProducto.RUNMODAL();
                    end;
                }
                action("I&mport Budget")
                {
                    ApplicationArea = All;
                    Caption = 'I&mport Budget';
                    ToolTip = 'I&mport Budget';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcImportaPpto: Report 67002;
                    begin
                        ProcImportaPpto.RecibeParametros(1);
                        ProcImportaPpto.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        CopiaProducto: Report 67000;
}

