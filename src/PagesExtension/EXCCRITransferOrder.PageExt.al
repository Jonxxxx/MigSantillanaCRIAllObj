pageextension 50114 EXCCRITransferOrder extends "Transfer Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field(EXCCRIComments; Rec.Observaciones)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the comments associated with the transfer order.';
            }
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                Caption = 'PVA Amount';
                ToolTip = 'Specifies the consignment amount associated with the transfer order.';
            }
            field(EXCCRISalespersonCode; Rec."Cod. Vendedor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the salesperson associated with the transfer order.';
            }
            field(EXCCRIApprovalPercent; Rec."% de aprobacion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the approval percentage associated with the transfer order.';

                trigger OnValidate()
                begin
                    CurrPage.Update(false);
                end;
            }
            field(EXCCRISkipPacking; Rec."Obviar Packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the packing process can be skipped for the transfer order.';
            }
            field(EXCCRIPackingStatus; Rec."Estado packing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the packing status of the transfer order.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRISantillana)
            {
                Caption = 'Santillana';

                action(EXCCRIImportFromExcel)
                {
                    ApplicationArea = All;
                    Caption = 'Import Order from Excel';
                    Image = ImportExcel;
                    ToolTip = 'Imports transfer order lines from the custom Excel process.';

                    trigger OnAction()
                    begin
                        EXCCRISantillanaFunctions.RecibeNoDoc(Rec."No.");
                        Report.RunModal(50002);

                        if not EXCCRISantillanaFunctions.
                           BuscaLineasPendientesEntrega(Rec)
                        then begin
                            Commit();
                            EXCCRITransferHeader.Get(Rec."No.");
                            EXCCRITransferHeader.Delete(true);
                        end;
                    end;
                }
                action(EXCCRIManualScanner)
                {
                    ApplicationArea = All;
                    Caption = 'Manual Scanner';
                    Image = BarCode;
                    ToolTip = 'Opens the custom manual scanner page for the transfer order.';

                    trigger OnAction()
                    begin
                        EXCCRIManualScannerPage.RecibeParam(Rec."No.");
                        EXCCRIManualScannerPage.RunModal();
                        Clear(EXCCRIManualScannerPage);
                    end;
                }
                action(EXCCRICopyTransfer)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Transfer';
                    Image = CopyDocument;
                    ToolTip = 'Runs the custom process to copy the transfer order.';

                    trigger OnAction()
                    begin
                        EXCCRISantillanaFunctions.RecibeNoDoc(Rec."No.");
                        Report.RunModal(50003);
                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRIGetConsignmentInventory)
                {
                    ApplicationArea = All;
                    Caption = 'Get Consignment Inventory';
                    Image = GetLines;
                    ToolTip = 'Adds consignment inventory lines to the transfer order.';

                    trigger OnAction()
                    begin
                        EXCCRISantillanaFunctions.
                            InsertaInvConsigTransfer(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRISendOrderEmail)
                {
                    ApplicationArea = All;
                    Caption = 'Send Order by Email';
                    Image = Email;
                    ToolTip = 'Creates the custom email for the consignment transfer order.';

                    trigger OnAction()
                    begin
                        EXCCRISantillanaFunctions.CreaEmailPedidoConsg(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRIUpdatePriceDiscount)
                {
                    ApplicationArea = All;
                    Caption = 'Update Price/Discount';
                    Image = UpdateUnitCost;
                    ToolTip = 'Revalidates the quantity to ship on the transfer order lines.';

                    trigger OnAction()
                    begin
                        EXCCRITransferLine.Reset();
                        EXCCRITransferLine.SetRange(
                            "Document No.",
                            Rec."No.");
                        EXCCRITransferLine.SetRange(
                            "Derived From Line No.",
                            0);

                        if EXCCRITransferLine.FindSet() then
                            repeat
                                EXCCRITransferLine.Validate(
                                    "Qty. to Ship");
                                EXCCRITransferLine.Modify();
                            until EXCCRITransferLine.Next() = 0;

                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRIUpdateDimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Update Dimensions';
                    Image = Dimensions;
                    ToolTip = 'Revalidates items, consignment prices, discounts and quantities on the transfer lines.';

                    trigger OnAction()
                    var
                        EXCCRIQuantity: Decimal;
                        EXCCRIPrice: Decimal;
                        EXCCRIQtyToShip: Decimal;
                        EXCCRIDiscountPercent: Decimal;
                    begin
                        EXCCRITransferLine.Reset();
                        EXCCRITransferLine.SetRange(
                            "Document No.",
                            Rec."No.");

                        if EXCCRITransferLine.FindSet() then
                            repeat
                                EXCCRIQuantity :=
                                    EXCCRITransferLine.Quantity;
                                EXCCRIPrice :=
                                    EXCCRITransferLine.
                                    "Precio Venta Consignacion";
                                EXCCRIQtyToShip :=
                                    EXCCRITransferLine."Qty. to Ship";
                                EXCCRIDiscountPercent :=
                                    EXCCRITransferLine.
                                    "Descuento % Consignacion";

                                EXCCRITransferLine.Validate(
                                    "Item No.");
                                EXCCRITransferLine.Validate(
                                    "Precio Venta Consignacion",
                                    EXCCRIPrice);
                                EXCCRITransferLine.Validate(
                                    "Descuento % Consignacion",
                                    EXCCRIDiscountPercent);
                                EXCCRITransferLine.Validate(
                                    Quantity,
                                    EXCCRIQuantity);
                                EXCCRITransferLine.Validate(
                                    "Qty. to Ship",
                                    EXCCRIQtyToShip);
                            until EXCCRITransferLine.Next() = 0;
                    end;
                }
                action(EXCCRIUndoShipment)
                {
                    ApplicationArea = All;
                    Caption = 'Undo Shipment';
                    Image = UndoShipment;
                    ToolTip = 'Runs the custom undo shipment process on the transfer lines.';

                    trigger OnAction()
                    begin
                        CurrPage.TransferLines.Page.DeshacerEnvio();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIOldFilterGroup: Integer;
    begin
        EXCCRIOldFilterGroup := Rec.FilterGroup();
        Rec.FilterGroup(2);
        Rec.SetRange("Devolucion Consignacion", false);
        Rec.SetRange("Pedido Consignacion", false);
        Rec.FilterGroup(EXCCRIOldFilterGroup);
    end;

    var
        EXCCRITransferHeader: Record "Transfer Header";
        EXCCRITransferLine: Record "Transfer Line";
        EXCCRIManualScannerPage: Page 50000;
        EXCCRISantillanaFunctions: Codeunit 56000;
}
