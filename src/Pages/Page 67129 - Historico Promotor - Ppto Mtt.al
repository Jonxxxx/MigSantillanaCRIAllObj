page 67129 "Historico Promotor - Ppto Mtt"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67071;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
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
                }
                field("Extended Quantity"; Rec."Extended Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Extended Quantity';
                }
                field("Cantidad camp. anterior"; Rec."Cantidad camp. anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad camp. anterior';
                }
                field("Cod. producto equivalente"; Rec."Cod. producto equivalente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. producto equivalente';
                }
                field("Cantidad consumida"; Rec."Cantidad consumida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad consumida';
                }
                field("Cantidad seleccionada"; Rec."Cantidad seleccionada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad seleccionada';
                }
                field("No. documento"; Rec."No. documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. documento';
                }
                field(Campaña; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
            }
        }
    }

    actions
    {
    }
}

