page 56025 "Lista clas. devoluciones"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Returns classification list';
    CardPageID = "Clasificacion devoluciones";
    PageType = List;
    SourceTable = 56025;
    SourceTableView = WHERE("Closed" = CONST(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Customer no."; "Customer no.")
                {
                }
                field("Customer name"; "Customer name")
                {
                }
                field("External document no."; "External document no.")
                {
                }
                field("Cod. Almacen"; "Cod. Almacen")
                {
                }
                field("Receipt date"; "Receipt date")
                {
                }
                field(Comentario; Comentario)
                {
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
                    Caption = '&Insert';

                    trigger OnAction()
                    var
                        CPD: Record 56025;
                    begin
                        CLEAR(CPD);
                        CPD.INSERT(TRUE);
                        CurrPage.UPDATE;
                        FINDLAST;
                    end;
                }
                action("&Get Items")
                {
                    Caption = '&Get Items';
                    RunObject = Page 56026;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

