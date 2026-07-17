pageextension 50143 EXCCRIWarehouseShipment extends "Warehouse Shipment"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRIPackageCount; Rec."Cantidad de Bultos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of packages included in the warehouse shipment.';
            }
            field(EXCCRIPackingCompleted; Rec."Packing Completo")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether packing has been completed for the warehouse shipment.';
            }
        }
        addafter("External Document No.")
        {
            field(EXCCRIBoxesQuantity; Rec."Boxes Quatity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of boxes included in the warehouse shipment.';
            }
            field(EXCCRIBagsQuantity; Rec."Bags Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of bags included in the warehouse shipment.';
            }
            field(EXCCRIDriverCode; Rec."Driver Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the driver assigned to the warehouse shipment.';
            }
            field(EXCCRIDriverName; Rec."Driver Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the driver assigned to the warehouse shipment.';
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIWarehouseRequest: Record "Warehouse Request";
        EXCCRISalesHeader: Record "Sales Header";
    begin
        EXCCRIWarehouseRequest.Reset();
        if EXCCRIWarehouseRequest.FindSet() then
            repeat
                case EXCCRIWarehouseRequest."Source Document" of
                    EXCCRIWarehouseRequest."Source Document"::"Sales Order":
                        begin
                            EXCCRISalesHeader.Reset();
                            EXCCRISalesHeader.SetRange(
                                "No.",
                                EXCCRIWarehouseRequest."Source No.");
                            if EXCCRISalesHeader.FindFirst() then begin
                                EXCCRIWarehouseRequest."Tipo de Venta" :=
                                    EXCCRISalesHeader."Tipo de Venta";
                                EXCCRIWarehouseRequest.Modify();
                            end;
                        end;
                end;
            until EXCCRIWarehouseRequest.Next() = 0;

        CurrPage.Update(false);
    end;
}
