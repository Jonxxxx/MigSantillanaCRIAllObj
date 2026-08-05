page 67128 "Historico Promotor - Ppto Vtas"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55537;
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
                field(Adopcion; Rec.Adopcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion';
                }
                field("Adopcion anterior"; Rec."Adopcion anterior")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion anterior';
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

