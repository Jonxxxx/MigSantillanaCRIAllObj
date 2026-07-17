pageextension 50126 EXCCRISourceDocuments extends "Source Documents"
{
    layout
    {
        addafter("Source No.")
        {
            field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales order category of the source warehouse request.';
            }
            field(EXCCRIRequestType; Rec.Type)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the warehouse request is inbound or outbound.';
            }
            field(EXCCRISourceDocumentComment; Rec."Comentario Doc. Origen")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the source document contains a comment.';
            }
            field(EXCCRIRequestedDeliveryDate; Rec."Fecha entrega requerida")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the requested delivery date of the source document.';
            }
            field(EXCCRIPromisedDeliveryDate; Rec."Fecha entrega prometida")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the promised delivery date of the source document.';
            }
            field(EXCCRIShipToCity; Rec."Envio a-Municipio/Ciudad")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ship-to municipality or city of the source document.';
            }
            field(EXCCRIOutstandingSalesQty; Rec."Cantidades Pendientes Ped. Vta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding quantity on the related sales order.';
            }
            field(EXCCRIOutstandingTransferQty; Rec."Cantidades Pendientes Ped. Tr.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding quantity on the related transfer order.';
            }
            field(EXCCRIOutstandingPurchQty; Rec."Cantidades Pend. Ped. Compra")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the outstanding quantity on the related purchase order.';
            }
            field(EXCCRISalesType; Rec."Tipo de Venta")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the sales type of the source document.';
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIWarehouseRequest: Record "Warehouse Request";
        EXCCRIProgressDialog: Dialog;
        EXCCRICounter: Integer;
        EXCCRITotalCount: Integer;
        EXCCRIOldFilterGroup: Integer;
    begin
        EXCCRIProgressDialog.Open(EXCCRICalculatingPendingMsg);

        EXCCRIWarehouseRequest.Reset();
        if EXCCRIWarehouseRequest.FindSet() then begin
            EXCCRITotalCount := EXCCRIWarehouseRequest.Count();

            repeat
                EXCCRICounter += 1;
                EXCCRIProgressDialog.Update(
                    1,
                    EXCCRIWarehouseRequest."Source No.");
                EXCCRIProgressDialog.Update(
                    2,
                    Round(
                        EXCCRICounter / EXCCRITotalCount * 10000,
                        1));

                EXCCRIWarehouseRequest.CalcFields(
                    "Cantidades Pendientes Ped. Vta",
                    "Cantidades Pendientes Ped. Tr.",
                    "Cantidades Pend. Ped. Compra");

                EXCCRIWarehouseRequest.Pendiente :=
                    (EXCCRIWarehouseRequest.
                        "Cantidades Pendientes Ped. Vta" <> 0) or
                    (EXCCRIWarehouseRequest.
                        "Cantidades Pendientes Ped. Tr." <> 0) or
                    (EXCCRIWarehouseRequest.
                        "Cantidades Pend. Ped. Compra" <> 0);
                EXCCRIWarehouseRequest.Modify();
            until EXCCRIWarehouseRequest.Next() = 0;
        end;

        EXCCRIProgressDialog.Close();
        Commit();

        EXCCRIOldFilterGroup := Rec.FilterGroup();
        Rec.FilterGroup(2);
        Rec.SetRange(Pendiente, true);
        Rec.FilterGroup(EXCCRIOldFilterGroup);
    end;

    var
        EXCCRICalculatingPendingMsg: Label
            'Calculating pending orders #1########## @2@@@@@@@@@@@@@';
}
