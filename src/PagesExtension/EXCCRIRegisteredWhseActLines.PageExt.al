pageextension 50147 EXCCRIRegisteredWhseActLines extends "Registered Whse. Act.-Lines"
{
    layout
    {
        addafter("Item No.")
        {
            field(EXCCRIPackingNo; Rec."No. Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing document number associated with the registered warehouse activity line.';
            }
            field(EXCCRIBoxNo; Rec."No. Caja")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the box number associated with the registered warehouse activity line.';
            }
            field(EXCCRIPackingLineNo; Rec."No. Linea Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing line number associated with the registered warehouse activity line.';
            }
            field(EXCRIRegisteredPackingNo; Rec."No. Packing Registrado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the registered packing document number associated with the warehouse activity line.';
            }
            field(EXCCRIPackingCompleted; Rec."Packing Completado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether packing has been completed for the registered warehouse activity line.';
            }
            field(EXCCRIPackedQuantity; Rec."Cantidad Empacada")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity packed for the registered warehouse activity line.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(EXCCRIClearPackedQuantity)
            {
                ApplicationArea = All;
                Caption = 'Set Packed Quantity to Zero';
                Image = ClearLog;
                ToolTip = 'Sets the packed quantity of the selected registered warehouse activity line to zero.';

                trigger OnAction()
                begin
                    Rec."Cantidad Empacada" := 0;
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
