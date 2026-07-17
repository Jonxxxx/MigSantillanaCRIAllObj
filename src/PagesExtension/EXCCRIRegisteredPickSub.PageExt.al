pageextension 50127 EXCCRIRegisteredPickSub extends "Registered Pick Subform"
{
    layout
    {
        addafter("Source Document")
        {
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the line number of the registered warehouse activity line.';
            }
        }
        addafter("Shelf No.")
        {
            field(EXCCRIPackingNo; Rec."No. Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing document number associated with the registered pick line.';
            }
            field(EXCCRIBoxNo; Rec."No. Caja")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the box number associated with the registered pick line.';
            }
            field(EXCCRIPackingLineNo; Rec."No. Linea Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing line number associated with the registered pick line.';
            }
            field(EXCRIRegisteredPackingNo; Rec."No. Packing Registrado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the registered packing document number associated with the pick line.';
            }
            field(EXCCRIPackingCompleted; Rec."Packing Completado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether packing has been completed for the registered pick line.';
            }
            field(EXCCRIPackedQuantity; Rec."Cantidad Empacada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity packed for the registered pick line.';
            }
        }
    }
}
