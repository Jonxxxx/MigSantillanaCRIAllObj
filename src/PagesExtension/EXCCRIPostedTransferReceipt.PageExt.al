pageextension 50119 EXCCRIPostedTransferReceipt extends "Posted Transfer Receipt"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consignment amount of the posted transfer receipt.';
            }
            field(EXCCRIDeliveryPriority; Rec."Prioridad entrega consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the delivery priority of the posted consignment transfer receipt.';
            }
            field(EXCCRISalespersonCode; Rec."Cod. Vendedor")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the salesperson associated with the posted transfer receipt.';
            }
            field(EXCCRICustomerName; EXCCRICustomer.Name)
            {
                ApplicationArea = All;
                Caption = 'Name';
                Editable = false;
                ToolTip = 'Specifies the name of the customer identified by the transfer-to code.';
            }
            field(EXCCRICustomerAddress; EXCCRICustomer.Address)
            {
                ApplicationArea = All;
                Caption = 'Address';
                Editable = false;
                ToolTip = 'Specifies the address of the customer identified by the transfer-to code.';
            }
            field(EXCCRICustomerCity; EXCCRICustomer.City)
            {
                ApplicationArea = All;
                Caption = 'City';
                Editable = false;
                ToolTip = 'Specifies the city of the customer identified by the transfer-to code.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the external document number of the posted transfer receipt.';
            }
            field(EXCCRIConsignmentOrder; Rec."Pedido Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies whether the posted transfer receipt belongs to a consignment order.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            group(EXCCRIPrint)
            {
                Caption = 'Print';

                action(EXCCRIReceiptDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Receipt Document';
                    Image = Print;
                    ToolTip = 'Prints the receipt document for the posted transfer receipt.';

                    trigger OnAction()
                    var
                        EXCCRITransferRcptHeader: Record "Transfer Receipt Header";
                    begin
                        EXCCRITransferRcptHeader.SetRange("No.", Rec."No.");
                        EXCCRITransferRcptHeader.PrintRecords(true);
                    end;
                }
                action(EXCCRIConsignmentReceipt)
                {
                    ApplicationArea = All;
                    Caption = 'Consignment Receipt';
                    Image = Print;
                    ToolTip = 'Prints the custom consignment receipt report for the posted transfer receipt.';

                    trigger OnAction()
                    var
                        EXCCRITransferRcptHeader: Record "Transfer Receipt Header";
                    begin
                        EXCCRITransferRcptHeader.SetRange("No.", Rec."No.");
                        Report.RunModal(
                            51007,
                            true,
                            true,
                            EXCCRITransferRcptHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(EXCCRICustomer);
        if not EXCCRICustomer.Get(Rec."Transfer-to Code") then
            Clear(EXCCRICustomer);
    end;

    var
        EXCCRICustomer: Record Customer;
}
