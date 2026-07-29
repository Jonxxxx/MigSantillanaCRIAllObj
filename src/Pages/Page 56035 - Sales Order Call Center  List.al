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
    SourceTable = 36;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("No. Serie NCF Facturas"; Rec."No. Serie NCF Facturas")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Serie NCF Facturas';
                }
                field("No. Comprobante Fiscal"; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Comprobante Fiscal';
                }
                field("EXCCRI Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External Document No.';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Post Code';
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Country/Region Code';
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Contact';
                    Visible = false;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Registration No.';
                }
                field("EXC CRI Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Customer No.';
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Post Code';
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Country/Region Code';
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Contact';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Code';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Name';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Post Code';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Country/Region Code';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Contact';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salesperson Code';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Assigned User ID';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Date';
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Requested Delivery Date';
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Campaign No.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Terms Code';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Due Date';
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Discount %';
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Method Code';
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Agent Code';
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Date';
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Advice';
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount Including VAT';
                }
                field("Tipo pedido"; Rec."Tipo pedido")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo pedido';
                }
                field("Aprobado cobros"; Rec."Aprobado cobros")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aprobado cobros';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(PageStats; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(PageDetails; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
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
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
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
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalDocumentType: Enum "Approval Document Type";
                    begin
                        case Rec."Document Type" of
                            Rec."Document Type"::Quote:
                                ApprovalDocumentType := ApprovalDocumentType::Quote;
                            Rec."Document Type"::Order:
                                ApprovalDocumentType := ApprovalDocumentType::Order;
                            Rec."Document Type"::Invoice:
                                ApprovalDocumentType := ApprovalDocumentType::Invoice;
                            Rec."Document Type"::"Credit Memo":
                                ApprovalDocumentType := ApprovalDocumentType::"Credit Memo";
                            Rec."Document Type"::"Blanket Order":
                                ApprovalDocumentType := ApprovalDocumentType::"Blanket Order";
                            Rec."Document Type"::"Return Order":
                                ApprovalDocumentType := ApprovalDocumentType::"Return Order";
                        end;
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", ApprovalDocumentType, Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }

                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }

                action("Pla&nning")
                {
                    Caption = 'Pla&nning';

                    trigger OnAction()
                    var
                        SalesPlanPage: Page "Sales Order Planning";
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
                        OrderPromisingLine: Record 99000880 temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", "Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", "No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
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

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
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

                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    //"Release Sales Document": Codeunit: "Release Sales Document";
                    begin
                        //fes mig revisar IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    //"Release Sales Document": Codeunit: "Release Sales Document"
                    begin
                        //fes mig revisar IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
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
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }

                action("Send IC Sales Order Cnfmn.")
                {
                    Caption = 'Send IC Sales Order Cnfmn.';

                    trigger OnAction()
                    var
                        // TODO: Manual review - These declarations belong exclusively to a disabled intercompany approval block and cannot restore behavior independently.
                        // Original code preserved below.
                        // ICInOutboxMgt: Codeunit 427;
                        // ApprovalMgt: Codeunit "Approvals Mgmt.";
                        // PurchaseHeader: Record 38;
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
                        IF SH.GET("Document Type", "No.") THEN BEGIN
                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", SH."Bill-to Customer No.");
                            Cust.FINDFIRST;
                            REPORT.RUNMODAL(10072, TRUE, TRUE, Cust);
                        END
                        ELSE
                            REPORT.RUNMODAL(10072, TRUE, TRUE, Cust);
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
                        PurchaseHeader: Record 38;
                        // TODO: Manual review - This declaration belongs exclusively to a disabled posting approval block.
                        // Original code: ApprovalMgt: Codeunit "Approvals Mgmt.";
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
                        // TODO: Manual review - This declaration belongs exclusively to a disabled post-and-print approval block.
                        // Original code: ApprovalMgt: Codeunit "Approvals Mgmt.";
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
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
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
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
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
                RunObject = Report "Sales Reservation Avail.";
            }
        }
    }

    var
        DocPrint: Codeunit 229;
        ReportPrint: Codeunit 228;
        // TODO: Manual review - This global approval declaration has no active caller because the related approval blocks remain disabled.
        // Original code: ApprovalMgt: Codeunit "Approvals Mgmt.";
        Usage: Option "Order Confirmation","Work Order";
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        Cust: Record 18;
        SH: Record 36;
}

