page 56027 "Subform clas. devoluciones"
{
    Caption = 'Returns classification subform';
    PageType = ListPart;
    SourceTable = 56026;
    SourceTableView = WHERE("Processed" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item No.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit of Measure Code';
                    Editable = false;
                }
                field("Con defecto"; Rec."Con defecto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Con defecto';
                }
                field(Recuperable; Rec.Recuperable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Recuperable';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cross-Reference No.';
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Variant Code';
                    Editable = false;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inventory';
                    Editable = false;
                }
                field("Inventario en Consignacion"; Rec."Inventario en Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inventario en Consignacion';
                    Editable = false;
                }
                field("Receiving date"; Rec."Receiving date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Receiving date';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
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

