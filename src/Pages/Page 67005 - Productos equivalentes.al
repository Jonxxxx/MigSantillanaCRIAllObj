page 55472 "Productos equivalentes"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 55472;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Producto"; Rec."Cod. Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto';
                }
                field("Nombre Producto"; Rec."Nombre Producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Producto';
                    Editable = false;
                }
                field("Cod. Producto Anterior"; Rec."Cod. Producto Anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto Anterior';
                }
                field("Nombre Producto Anterior"; Rec."Nombre Producto Anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Producto Anterior';
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
                    RunPageLink = "No." = FIELD("Cod. Producto Anterior");
                }

                action("&Import Items")
                {
                    ApplicationArea = All;
                    Caption = '&Import Items';
                    ToolTip = '&Import Items';
                    Image = Excel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ImportaProdEquiv: Report 55468;
                    begin
                        ImportaProdEquiv.RUNMODAL;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }
}

