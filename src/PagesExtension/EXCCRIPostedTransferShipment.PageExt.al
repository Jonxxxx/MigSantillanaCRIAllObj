pageextension 50117 EXCCRIPostedTransferShipment extends "Posted Transfer Shipment"
{
    layout
    {
        addlast(General)
        {
            field(EXCCRIConsignmentAmount; Rec."Importe Consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the consignment amount of the posted transfer shipment.';
            }
            field(EXCCRIDeliveryPriority; Rec."Prioridad entrega consignacion")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the delivery priority of the posted consignment transfer shipment.';
            }
            field(EXCCRISalespersonCode; Rec."Cod. Vendedor")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the salesperson associated with the posted transfer shipment.';
            }
            field(EXCCRIPackageCount; Rec."No. Bultos")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the number of packages in the posted transfer shipment.';
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

                action(EXCCRIShipmentDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Document';
                    Image = Print;
                    ToolTip = 'Prints the shipping document for the posted transfer shipment.';

                    trigger OnAction()
                    var
                        EXCCRITransferShptHeader: Record "Transfer Shipment Header";
                    begin
                        EXCCRITransferShptHeader.SetRange("No.", Rec."No.");
                        EXCCRITransferShptHeader.PrintRecords(true);
                    end;
                }
                action(EXCCRIPackageLabels)
                {
                    ApplicationArea = All;
                    Caption = 'Package Labels';
                    Image = BarCode;
                    ToolTip = 'Prints one package label for each package in the posted transfer shipment.';

                    trigger OnAction()
                    var
                        EXCCRITransferShptHeader: Record "Transfer Shipment Header";
                        EXCCRIPackageNo: Integer;
                    begin
                        Rec.TestField("No. Bultos");

                        for EXCCRIPackageNo := 1 to Rec."No. Bultos" do begin
                            EXCCRITransferShptHeader.Reset();
                            EXCCRITransferShptHeader.SetRange("No.", Rec."No.");
                            Report.RunModal(
                                50036,
                                false,
                                true,
                                EXCCRITransferShptHeader);
                        end;
                    end;
                }
            }
        }
    }
}
