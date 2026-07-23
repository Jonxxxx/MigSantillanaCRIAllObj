pageextension 50020 EXCCRISalesOrder extends "Sales Order"
{
    layout
    {
        modify("Posting Date")
        {
            Editable = EXCCRICanModifySalesDates;
        }
        modify("Order Date")
        {
            Editable = EXCCRICanModifySalesDates;
        }
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRISchoolCode; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the school code associated with the sales order.';
                }
                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the sales order.';
                }
                field(EXCCRICustomerDiscountGroup; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer discount group assigned to the sales order.';
                }
                field(EXCCRINCFInvoiceNoSeries; Rec."No. Serie NCF Facturas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number series used for invoices.';
                }
                field(EXCCRICollectorCode; Rec."Collector Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the collector assigned to the sales order.';
                }
                field(EXCCRIJobQueueStatus; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of the job queue entry that handles the sales order.';
                }
                field(EXCCRISaleType; Rec."Tipo de Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sale type assigned to the sales order.';
                }
                field(EXCCRIElectronicDocumentType; Rec."Tipo Doc Electronico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic document type assigned to the sales order.';
                }
                field(EXCCRIConsignmentOrder; Rec."Pedido Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the sales order is a consignment order.';
                }
                field(EXCCRICopyrightNotApplicable; Rec."No aplica Derechos de Autor")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies whether copyright charges do not apply to the sales order.';
                }
                field(EXCCRIOrderType; Rec."Tipo pedido")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the custom order type assigned to the sales order.';
                }
                field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order category assigned to the document.';
                }
                field(EXCCRIApprovalPercentage; Rec."% de aprobacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval percentage calculated for the sales order.';
                }
                field(EXCCRIResponsibilityCenter; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsibility center assigned to the sales order.';
                }
                field(EXCCRIElectronicInvoiceEmail; Rec."E-Mail-FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address used for the electronic invoice.';
                }
                field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fiscal receipt number assigned to the sales order.';
                }
                field(EXCCRIRelatedFiscalReceiptNo; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related fiscal receipt number assigned to the sales order.';
                }
                field(EXCCRIIncomeType; Rec."Tipo de ingreso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the income type assigned to the sales order.';
                }
                field(EXCCRINCFVoidReason; Rec."Razon anulacion NCF")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason for voiding the fiscal receipt number.';
                }
                field(EXCCRIReferencedDocumentType; Rec."Tipo Doc. Ref.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the referenced document.';
                }
                field(EXCCRIHistoricalDocumentNo; Rec."No. Doc Historico")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the historical document number associated with the sales order.';
                }
                field(EXCCRIElectronicReferenceNo; Rec."Numero Referencia FE")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the electronic invoicing reference number.';
                }
                field(EXCCRIECommerceShippingMethod; Rec."Metodo de Envio E-Commerce")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the shipping method received from the e-commerce integration.';
                }
                field(EXCCRIPhoneNo; Rec."No. Telefono")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the telephone number associated with the sales order.';
                }
                field(EXCCRITaxIdentificationType; Rec."Tax Identification Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the tax identification type associated with the sales order.';
                }
                field(EXCCRIGenBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general business posting group assigned to the sales order.';
                }
                field(EXCCRIPackingStatus; Rec."Estado packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the packing status of the sales order.';
                }
            }
        }
    }

    actions
    {
        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField(Origen, Rec.Origen::Estandar);
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                EXCCRIValidateSharingCode();
            end;
        }
        addlast(Processing)
        {
            group(EXCCRICustomActions)
            {
                Caption = 'Custom Actions';

                action(EXCCRIGetConsignmentInventory)
                {
                    ApplicationArea = All;
                    Caption = 'Get Consignment Inventory';
                    ToolTip = 'Loads the customer consignment inventory into the sales order.';

                    trigger OnAction()
                    var
                        EXCCRICustomer: Record Customer;
                        EXCCRISalesLine: Record "Sales Line";
                        EXCCRIConsignmentLinesPage: Page 56052;
                    begin
                        EXCCRISalesLine.Reset();
                        EXCCRISalesLine.SetRange("Document Type", Rec."Document Type");
                        EXCCRISalesLine.SetRange("Document No.", Rec."No.");
                        if EXCCRISalesLine.FindFirst() then
                            Error(EXCCRIConsignmentLinesExistErr);

                        EXCCRICustomer.Get(Rec."Sell-to Customer No.");
                        EXCCRICustomer.TestField(Blocked, EXCCRICustomer.Blocked::" ");
                        Rec.TestField("Pedido Consignacion");

                        EXCCRIConsignmentLinesPage.RecibeNoPedido(Rec."No.");
                        EXCCRIConsignmentLinesPage.RunModal();
                        Clear(EXCCRIConsignmentLinesPage);
                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRIInvoiceSamples)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Samples';
                    Image = FilterLines;
                    ToolTip = 'Runs the process that invoices samples for the sales order.';

                    trigger OnAction()
                    var
                    // EXCCRIInvoiceSamplesReport: Report 67008;
                    begin
                        // EXCCRIInvoiceSamplesReport.RecibeParametros(
                        //     Rec."Document Type",
                        //     Rec."No.");
                        // EXCCRIInvoiceSamplesReport.RunModal();
                    end;
                }
                action(EXCCRIInvoiceAdoptions)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Adoptions';
                    Image = CalculatePlan;
                    ToolTip = 'Runs the process that invoices adoptions for the sales order.';

                    trigger OnAction()
                    var
                    // EXCCRIInvoiceAdoptionsReport: Report 67044;
                    begin
                        // EXCCRIInvoiceAdoptionsReport.RecibeParametros(
                        //     Rec."Document Type",
                        //     Rec."No.");
                        // EXCCRIInvoiceAdoptionsReport.RunModal();
                    end;
                }
                action(EXCCRIDistributeItemCharge)
                {
                    ApplicationArea = All;
                    Caption = 'Distribute Item Charge';
                    ToolTip = 'Distributes item charges among the sales lines.';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.Page.SplitIC();
                    end;
                }
                action(EXCCRIImportSalesOrderExcel)
                {
                    ApplicationArea = All;
                    Caption = 'Import Sales Order from Excel';
                    ToolTip = 'Imports sales order lines from the custom Excel import process.';

                    trigger OnAction()
                    var
                        EXCCRISantillanaFunctions: Codeunit 56000;
                    begin
                        EXCCRISantillanaFunctions.RecibeNoDoc(Rec."No.");
                        Report.RunModal(51006);
                        CurrPage.Update(false);
                    end;
                }
                action(EXCCRIAdjustBackorder)
                {
                    ApplicationArea = All;
                    Caption = 'Adjust Backorder';
                    ToolTip = 'Runs the backorder adjustment process for the selected sales order.';

                    trigger OnAction()
                    var
                        EXCCRISalesHeader: Record "Sales Header";
                    begin
                        CurrPage.SetSelectionFilter(EXCCRISalesHeader);
                        Report.RunModal(56036, true, true, EXCCRISalesHeader);
                    end;
                }
                action(EXCCRIOrderTracking)
                {
                    ApplicationArea = All;
                    Caption = 'Order Tracking';
                    Image = Navigate;
                    ToolTip = 'Opens the custom tracking page for the sales order.';

                    trigger OnAction()
                    var
                        EXCCRIOrderTrackingPage: Page 56081;
                    begin
                        EXCCRIOrderTrackingPage.SetDoc(1, Rec."No.");
                        EXCCRIOrderTrackingPage.Run();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIUserSetup: Record "User Setup";
    begin
        Rec.FilterGroup(2);
        Rec.SetRange("Pre pedido", false);
        Rec.SetFilter("Tipo pedido", '<>%1', Rec."Tipo pedido"::TPV);
        Rec.FilterGroup(0);

        EXCCRICanModifySalesDates := false;
        if EXCCRIUserSetup.Get(UserId()) then
            EXCCRICanModifySalesDates :=
                EXCCRIUserSetup."Modifica Fecha Pedidos Venta";
    end;

    trigger OnClosePage()
    var
        EXCCRIApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if EXCCRIGestBackorder then
            if Rec.Status = Rec.Status::Open then
                EXCCRIApprovalsMgmt.CheckSalesApprovalPossible(Rec);
    end;

    procedure GestBackOrd(GestionBO: Boolean)
    begin
        EXCCRIGestBackorder := GestionBO;
    end;

    local procedure EXCCRIValidateSharingCode()
    var
        EXCCRISalesOrderCategory: Record 52503;
        EXCCRISalesLine: Record "Sales Line";
    begin
        if Rec."Categoria Pedido Venta" = '' then
            exit;

        EXCCRISalesOrderCategory.Reset();
        EXCCRISalesOrderCategory.SetRange(
            Codigo,
            Rec."Categoria Pedido Venta");
        EXCCRISalesOrderCategory.SetRange(
            "Filtrar Cod. Compartir",
            true);

        if not EXCCRISalesOrderCategory.FindFirst() then
            exit;

        EXCCRISalesLine.Reset();
        EXCCRISalesLine.SetRange(
            "Document Type",
            Rec."Document Type");
        EXCCRISalesLine.SetRange("Document No.", Rec."No.");

        if EXCCRISalesLine.FindSet() then
            repeat
                if EXCCRISalesLine.Compartir =
                   EXCCRISalesLine.Compartir::" "
                then
                    Error(
                        EXCCRISharingCodeRequiredErr,
                        EXCCRISalesLine."Line No.");
            until EXCCRISalesLine.Next() = 0;
    end;

    var
        EXCCRICanModifySalesDates: Boolean;
        EXCCRIGestBackorder: Boolean;
        EXCCRIConsignmentLinesExistErr: Label 'Before loading consignment inventory, you must delete the existing sales order lines.';
        EXCCRISharingCodeRequiredErr: Label 'The Compartir field must have a value on sales line %1.';
}
