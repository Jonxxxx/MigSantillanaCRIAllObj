page 56035 "Sales Order Call Center  List"
{
    // Proyecto: Implementacion Microsoft Dynamics Nav
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roman
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001     09-Agosto-12     AMS          Imprimir el estado de cuenta del cliente.

    Caption = 'Sales Orders';
    CardPageID = "Sales Order Call Center";
    Editable = false;
    PageType = List;
    SourceTable = Table36;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                }
                field("No. Serie NCF Facturas"; "No. Serie NCF Facturas")
                {
                }
                field("No. Comprobante Fiscal"; "No. Comprobante Fiscal")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; "Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    Visible = false;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; "Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; "Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = true;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Visible = false;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                    Visible = false;
                }
                field("Document Date"; "Document Date")
                {
                    Visible = false;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    Visible = false;
                }
                field("Campaign No."; "Campaign No.")
                {
                    Visible = false;
                }
                field(Status; Status)
                {
                    Visible = false;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Visible = false;
                }
                field("Due Date"; "Due Date")
                {
                    Visible = false;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    Visible = false;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    Visible = false;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Visible = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Visible = false;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    Visible = false;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Tipo pedido"; "Tipo pedido")
                {
                }
                field("Aprobado cobros"; "Aprobado cobros")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(; 9082)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                    Visible = true;
            }
            part(; 9084)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                    Visible = true;
            }
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
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
                        PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
                    end;
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
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
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
                action("Create Inventor&y Put-away/Pick")
                {
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;

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

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                        "Release Sales Document": Codeunit 414;
                    begin
                        //fes mig revisar IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
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
                        //fes mig revisar IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator()
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
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
                        PurchaseHeader Record: 38;
                    begin
                        /*//fes mig
                        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                          ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
                        */

                    end;
                }
                action("<Action1000000000>")
                {
                    Caption = '&Customer Statement';
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        //001
                        IF SH.GET("Document Type","No.") THEN
                          BEGIN
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.",SH."Bill-to Customer No.");
                            Cust.FINDFIRST;
                            REPORT.RUNMODAL(10072,TRUE,TRUE,Cust);
                          END
                        ELSE
                          REPORT.RUNMODAL(10072,TRUE,TRUE,Cust);
                        //001
                    end;
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
                        PurchaseHeader Record: 38;
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
                        PurchaseHeader Record: 38;
                        ApprovalMgt: Codeunit 1535;
                    begin
                        /*//fes
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
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
                    Promoted = true;
                    PromotedCategory = Process;

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
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.';
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }

    var
        DocPrint: Codeunit 229;
        ReportPrint: Codeunit 228;
        ApprovalMgt: Codeunit 1535;
        Usage: Option "Order Confirmation","Work Order";
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        Cust: Record 18;
        SH Record: 36;
}

