page 56036 "Sales Order Call Center"
{
    Caption = 'Sales Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = Table36;
    SourceTableView = WHERE(Document Type=FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No.";"Sell-to Contact No.")
                {
                    Importance = Additional;
                }
                field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                }
                field("Sell-to Address";"Sell-to Address")
                {
                    Importance = Additional;
                }
                field("Sell-to Address 2;"Sell-to Address 2")
                {
                    Importance = Additional;
                }
                field("Sell-to City";"Sell-to City")
                {
                }
                field("Sell-to County";"Sell-to County")
                {
                    Caption = 'Sell-to State / ZIP Code';
                }
                field("Sell-to Post Code";"Sell-to Post Code")
                {
                    Importance = Additional;
                }
                field("Sell-to Contact";"Sell-to Contact")
                {
                    Importance = Additional;
                }
                field("No. of Archived Versions";"No. of Archived Versions")
                {
                    Importance = Additional;
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Order Date";"Order Date")
                {
                    Importance = Promoted;
                }
                field("Shipment Date";"Shipment Date")
                {
                }
                field("Document Date";"Document Date")
                {
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                }
                field("Promised Delivery Date";"Promised Delivery Date")
                {
                    Importance = Additional;
                }
                field("Quote No.";"Quote No.")
                {
                    Importance = Additional;
                }
                field("External Document No.";"External Document No.")
                {
                    Importance = Promoted;
                }
                field("Salesperson Code";"Salesperson Code")
                {

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No.";"Campaign No.")
                {
                    Importance = Additional;
                }
                field("Opportunity No.";"Opportunity No.")
                {
                    Importance = Additional;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    Importance = Additional;
                }
                field("Assigned User ID";"Assigned User ID")
                {
                    Importance = Additional;
                }
                field("Tipo pedido";"Tipo pedido")
                {
                    Editable = false;
                }
                field(Status;Status)
                {
                    Importance = Promoted;
                }
                field("No. Comprobante Fiscal";"No. Comprobante Fiscal")
                {
                    Editable = false;
                }
                field("No. Serie NCF Facturas";"No. Serie NCF Facturas")
                {
                }
                field("VAT Registration No.";"VAT Registration No.")
                {
                }
            }
            part(SalesLines;46)
            {
                SubPageLink = Document No.=FIELD(No.);
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Location Code";"Location Code")
                {
                }
                field("Bill-to Contact No.";"Bill-to Contact No.")
                {
                    Importance = Additional;
                }
                field("Bill-to Name";"Bill-to Name")
                {
                }
                field("Bill-to Address";"Bill-to Address")
                {
                    Importance = Additional;
                }
                field("Bill-to Address 2;"Bill-to Address 2")
                {
                    Importance = Additional;
                }
                field("Bill-to City";"Bill-to City")
                {
                }
                field("Bill-to County";"Bill-to County")
                {
                    Caption = 'State / ZIP Code';
                }
                field("Bill-to Post Code";"Bill-to Post Code")
                {
                    Importance = Additional;
                }
                field("Bill-to Contact";"Bill-to Contact")
                {
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Due Date";"Due Date")
                {
                    Importance = Promoted;
                }
                field("Prices Including VAT";"Prices Including VAT")
                {
                }
                field("Payment Discount %";"Payment Discount %")
                {
                }
                field("Pmt. Discount Date";"Pmt. Discount Date")
                {
                }
                field("Payment Method Code";"Payment Method Code")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                    Importance = Promoted;
                }
                field("Tax Area Code";"Tax Area Code")
                {
                    Importance = Promoted;
                }
                field("Aprobado cobros";"Aprobado cobros")
                {
                }
                field("Pago recibido";"Pago recibido")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code";"Ship-to Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    Importance = Additional;
                }
                field("Ship-to Address 2;"Ship-to Address 2")
                {
                    Importance = Additional;
                }
                field("Ship-to City";"Ship-to City")
                {
                }
                field("Ship-to County";"Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    Importance = Additional;
                }
                field("Ship-to UPS Zone";"Ship-to UPS Zone")
                {
                }
                field("Outbound Whse. Handling Time";"Outbound Whse. Handling Time")
                {
                    Importance = Additional;
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                    Importance = Additional;
                }
                field("Shipping Agent Service Code";"Shipping Agent Service Code")
                {
                    Importance = Additional;
                }
                field("Shipping Time";"Shipping Time")
                {
                }
                field("Late Order Shipping";"Late Order Shipping")
                {
                    Importance = Additional;
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                    Importance = Additional;
                }
                field("Shipping Advice";"Shipping Advice")
                {
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code";"Currency Code")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                          VALIDATE("Currency Factor",ChangeExchangeRate.GetParameter);
                          CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("EU 3-Party Trade";"EU 3-Party Trade")
                {
                }
                field("Transaction Type";"Transaction Type")
                {
                }
                field("Transaction Specification";"Transaction Specification")
                {
                }
                field("Transport Method";"Transport Method")
                {
                }
                field("Exit Point";"Exit Point")
                {
                }
                field(Area;Area)
                {
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %";"Prepayment %")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment";"Compress Prepayment")
                {
                }
                field("Prepmt. Payment Terms Code";"Prepmt. Payment Terms Code")
                {
                }
                field("Prepayment Due Date";"Prepayment Due Date")
                {
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %";"Prepmt. Payment Discount %")
                {
                }
                field("Prepmt. Pmt. Discount Date";"Prepmt. Pmt. Discount Date")
                {
                }
                field("Prepmt. Include Tax";"Prepmt. Include Tax")
                {
                }
            }
        }
        area(factboxes)
        {
            part(;9080)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                Visible = true;
            }
            part(;9082)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                Visible = false;
            }
            part(;9084)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                Visible = false;
            }
            part(;9087)
            {
                Provider = SalesLines;
                SubPageLink = Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.);
                Visible = true;
            }
            part(;9089)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
                Visible = false;
            }
            part(;9092)
            {
                SubPageLink = Table ID=CONST(36),
                              Document Type=FIELD(Document Type),
                              Document No.=FIELD(No.),
                              Status=CONST(Open);
                Visible = false;
            }
            part(;9108)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
                Visible = false;
            }
            part(;9109)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
                Visible = false;
            }
            part(;9081)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action("Fast Screen")
                {
                    Caption = 'Fast Screen';
                    Image = GetStandardJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CapturarProductos;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Sales Order Statistics",Rec)
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Sales Order Stats.",Rec)
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 21;
                                    RunPageLink = No.=FIELD(Sell-to Customer No.);
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 67;
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page 142;
                                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                                    RunPageLink = Order No.=FIELD(No.);
                    RunPageView = SORTING(Order No.);
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    RunObject = Page "Posted Sales Invoices";
                                    RunPageLink = Prepayment Order No.=FIELD(No.);
                    RunPageView = SORTING(Prepayment Order No.);
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    RunObject = Page "Posted Sales Credit Memos"
                                    RunPageLink = Prepayment Order No.=FIELD(No.);
                    RunPageView = SORTING(Prepayment Order No.);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page658;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
                        ApprovalEntries.RUN;
                    end;
                }
                separator()
                {
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    RunObject = Page 7341;
                                    RunPageLink = Source Type=CONST(37),
                                  Source Subtype=FIELD(Document Type),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page 5774;
                                    RunPageLink = Source Document=CONST(Sales Order),
                                  Source No.=FIELD(No.);
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
                separator()
                {
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';

                    trigger OnAction()
                    var
                        SalesPlanPage: Page99000883;
                    begin
                        SalesPlanPage.SetSalesOrder("No.");
                        SalesPlanPage.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';

                    trigger OnAction()
                    var
                        OrderPromisingLine Record: 99000880" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type","Document Type");
                        OrderPromisingLine.SETRANGE("Source ID","No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines",OrderPromisingLine);
                    end;
                }
                separator()
                {
                }
                action("Credit Cards Transaction Lo&g Entries")
                {
                    Caption = 'Credit Cards Transaction Lo&g Entries';
                    RunObject = Page 829;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator()
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record 172;
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator()
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator()
                {
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment';

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT FIND('=><') THEN
                          INIT;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;

                        IF NOT FIND('=><') THEN
                          INIT;
                    end;
                }
                separator()
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                        "Release Sales Document": Codeunit 414;
                    begin
                        //fes mig IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                        "Release Sales Document": Codeunit 414;
                    begin
                        //fes mig IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator()
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                separator()
                {
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    Caption = 'Send IC Sales Order Cnfmn.';

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit 427;
                        ApprovalMgt: Codeunit 1535;
                        PurchaseHeader: Record 38;
                    begin
                        /*//fes mig
                        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                          ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                        */

                    end;
                }
                separator()
                {
                }
                separator()
                {
                }
                action(Authorize)
                {
                    Caption = 'Authorize';

                    trigger OnAction()
                    begin
                        //fes mig Authorize;
                    end;
                }
                action("Void A&uthorize")
                {
                    Caption = 'Void A&uthorize';

                    trigger OnAction()
                    begin
                        //fes mig Void;
                    end;
                }
                separator()
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record 38;
                        ApprovalMgt: Codeunit 1535;
                    begin
                        /*//fes mig
                        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN BEGIN
                          IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text001,"Document Type","No."))
                          ELSE BEGIN
                            IF ApprovalMgt.TestSalesPayment(Rec) THEN
                              ERROR(STRSUBSTNO(Text002,"Document Type","No."))
                            ELSE
                              CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)",Rec);
                          END;
                        END;
                        */

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record 38;
                        ApprovalMgt: Codeunit 1535;
                    begin
                        /*//fes mig
                        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN BEGIN
                          IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text001,"Document Type","No."))
                          ELSE BEGIN
                            IF ApprovalMgt.TestSalesPayment(Rec) THEN
                              ERROR(STRSUBSTNO(Text002,"Document Type","No."))
                            ELSE
                              CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print",Rec);
                          END;
                        END;
                        */

                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator()
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    action("Prepayment &Test Report")
                    {
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action("Post Prepayment &Invoice")
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            /*//fes mig
                            IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
                            */

                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            /*//fes mig
                            IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
                            */

                        end;
                    }
                    action("Post Prepayment &Credit Memo")
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            /*//fes mig
                            IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
                            */

                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;

                        trigger OnAction()
                        var
                            PurchaseHeader: Record 38;
                            SalesPostYNPrepmt: Codeunit 443;
                        begin
                            /*//fes mig
                            IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                              SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
                            */

                        end;
                    }
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec,Usage::"Work Order");
                    end;
                }
                action("Pick Ticket")
                {
                    Caption = 'Pick Ticket';

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec,Usage::"Pick Ticket");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Drop Shipment Status")
            {
                Caption = 'Drop Shipment Status';
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 10051;
            }
            action("Picking List by Order")
            {
                Caption = 'Picking List by Order';
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 10153;
            }
        }
    }

    trigger OnClosePage()
    begin
        //004
        AppTemp.RESET;
        AppTemp.SETRANGE("Table ID",36);
        AppTemp.SETRANGE(Enabled,TRUE);
        IF NOT AppTemp.FINDFIRST THEN
          BEGIN
            SalesLine.SETRANGE("Document Type","Document Type");
            SalesLine.SETRANGE("Document No.","No.");
            SalesLine.SETFILTER(Type,'>0');
            SalesLine.SETFILTER(Quantity,'<>0');
            IF SalesLine.FIND('-') THEN
              ReleaseSalesDoc.PerformManualRelease(Rec);
          END
        ELSE
        //  IF ApprovalMgt.SendSalesApprovalRequest_BO(Rec) THEN; //-$001
        //004
        /*
        IF GestBO THEN
          IF Status = Status::Open THEN
            IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
            //Message(Error002);
        //004
        */

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();

        "Venta Call Center" := TRUE;
        "Aprobado cobros" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
          FILTERGROUP(0);
        END;

        SETRANGE("Date Filter",0D,WORKDATE - 1);
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report "292;
                          MoveNegSalesLines: Report "6699;
                          ApprovalMgt: Codeunit 1535;
                          ReportPrint: Codeunit 228;
                          DocPrint: Codeunit 229;
                          ArchiveManagement: Codeunit 5063;
                          SalesInfoPaneMgt: Codeunit 7171;
                          SalesSetup: Record 311;
                          ChangeExchangeRate: Page511;
                          UserMgt: Codeunit 5700;
                          Usage: Option "Order Confirmation","Work Order","Pick Ticket";
                          Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        [InDataSet]
        BillToCommentPictVisible: Boolean;
        [InDataSet]
        BillToCommentBtnVisible: Boolean;
        [InDataSet]
        SalesHistoryStnVisible: Boolean;
        SH: Record 36;
        GestBO: Boolean;
        AjusBO: Report "56036;
                    AppTemp: Record 464;
                    SalesLine: Record 37;
                    ReleaseSalesDoc: Codeunit 414;
                    pgProductos: Page56037;

    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        /*//fes mig
        DifferSellToBillTo := "Sell-to Customer No." <> "Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
        SalesHistoryStnVisible := SalesInfoPaneMgt.DocExist(Rec,"Sell-to Customer No.");
        IF DifferSellToBillTo THEN
          SalesHistoryBtnVisible := SalesInfoPaneMgt.DocExist(Rec,"Bill-to Customer No.")
        */

    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    procedure GestBackOrd(GestionBO_loc: Boolean)
    begin
        GestBO := GestionBO_loc;
    end;

    procedure CapturarProductos()
    var
        lText001: Label 'Debe definirse un almacen';
        lText002: Label 'Debe crear un pedido.';
    begin
        CLEAR(pgProductos);
        IF "No." = '' THEN
            ERROR(lText002);
        IF "Location Code" = '' THEN
            ERROR(lText001);
        pgProductos.RecibeParametros("No.", "Location Code");
        pgProductos.LOOKUPMODE(FALSE);
        pgProductos.RUNMODAL;
        CurrPage.UPDATE;
    end;
}

