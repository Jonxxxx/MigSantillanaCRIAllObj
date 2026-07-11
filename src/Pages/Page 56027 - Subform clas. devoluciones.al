page 56027 "Subform clas. devoluciones"
{
    Caption = 'Returns classification subform';
    PageType = ListPart;
    SourceTable = Table56026;
    SourceTableView = WHERE("Processed" = CONST(false));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No."; "Item No.")
                {
                }
                field("Item Description"; "Item Description")
                {
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Con defecto"; "Con defecto")
                {
                }
                field(Recuperable; Recuperable)
                {
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Editable = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    Editable = false;
                }
                field(Inventory; Inventory)
                {
                    Editable = false;
                }
                field("Inventario en Consignacion"; "Inventario en Consignacion")
                {
                    Editable = false;
                }
                field("Receiving date"; "Receiving date")
                {
                }
                field(Comentario; Comentario)
                {
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
                action("Update Line")
                {
                    Caption = 'Update Line';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #56026. Unsupported part was commented. Please check it.
                        /*CurrPage.Detalle.PAGE.*/
                        Eliminar;

                    end;
                }
            }
        }
    }

    procedure Refrescar()
    begin
        CurrPage.UPDATE(FALSE);
    end;

    procedure Eliminar()
    begin
        DELETE;
    end;
}

