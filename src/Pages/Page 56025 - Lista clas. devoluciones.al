page 55250 "Lista clas. devoluciones"
{
    ApplicationArea = All;
    Caption = 'Returns classification list';
    CardPageID = "Clasificacion devoluciones";
    PageType = List;
    SourceTable = 55250;
    SourceTableView = WHERE("Closed" = CONST(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Customer no."; Rec."Customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer no.';
                }
                field("Customer name"; Rec."Customer name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer name';
                }
                field("External document no."; Rec."External document no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External document no.';
                }
                field("Cod. Almacen"; Rec."Cod. Almacen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Almacen';
                }
                field("Receipt date"; Rec."Receipt date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Receipt date';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Insert")
                {

                    ApplicationArea = All;
                    Caption = '&Insert';
                    ToolTip = '&Insert';
                    trigger OnAction()
                    var
                        CPD: Record 55250;
                    begin
                        CLEAR(CPD);
                        CPD.INSERT(TRUE);
                        CurrPage.UPDATE;
                        FINDLAST;
                    end;
                }
                action("&Get Items")
                {
                    ApplicationArea = All;
                    Caption = '&Get Items';
                    ToolTip = '&Get Items';
                    RunObject = Page 55251;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

