page 55940 "Lista de facturas TPV"
{
    Caption = 'Sales Invoices';
    CardPageID = "Sales Invoice";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = CONST(Invoice),
                            "Venta TPV" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = ESACC_F3_Editable;
                    HideValue = ESACC_F3_HideValue;
                    Visible = ESACC_F3_Visible;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                    Editable = ESACC_F20_Editable;
                    HideValue = ESACC_F20_HideValue;
                    Visible = false;
                }
                field("Venta TPV"; Rec."Venta TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta TPV';
                    Editable = ESACC_F34002502_Editable;
                    HideValue = ESACC_F34002502_HideValue;
                    Visible = ESACC_F34002502_Visible;
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                    Editable = ESACC_F34002504_Editable;
                    HideValue = ESACC_F34002504_HideValue;
                    Visible = ESACC_F34002504_Visible;
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                    Editable = ESACC_F34002503_Editable;
                    HideValue = ESACC_F34002503_HideValue;
                    Visible = ESACC_F34002503_Visible;
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                    Editable = ESACC_F34002512_Editable;
                    HideValue = ESACC_F34002512_HideValue;
                    Visible = ESACC_F34002512_Visible;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                    Editable = ESACC_F2_Editable;
                    HideValue = ESACC_F2_HideValue;
                    Visible = ESACC_F2_Visible;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
                    Editable = ESACC_F79_Editable;
                    HideValue = ESACC_F79_HideValue;
                    Visible = ESACC_F79_Visible;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Post Code';
                    Editable = ESACC_F88_Editable;
                    HideValue = ESACC_F88_HideValue;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Country/Region Code';
                    Editable = ESACC_F90_Editable;
                    HideValue = ESACC_F90_HideValue;
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Contact';
                    Editable = ESACC_F84_Editable;
                    HideValue = ESACC_F84_HideValue;
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Customer No.';
                    Editable = ESACC_F4_Editable;
                    HideValue = ESACC_F4_HideValue;
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
                    Editable = ESACC_F5_Editable;
                    HideValue = ESACC_F5_HideValue;
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Post Code';
                    Editable = ESACC_F85_Editable;
                    HideValue = ESACC_F85_HideValue;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Country/Region Code';
                    Editable = ESACC_F87_Editable;
                    HideValue = ESACC_F87_HideValue;
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Contact';
                    Editable = ESACC_F10_Editable;
                    HideValue = ESACC_F10_HideValue;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Code';
                    Editable = ESACC_F12_Editable;
                    HideValue = ESACC_F12_HideValue;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Name';
                    Editable = ESACC_F13_Editable;
                    HideValue = ESACC_F13_HideValue;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Post Code';
                    Editable = ESACC_F91_Editable;
                    HideValue = ESACC_F91_HideValue;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Country/Region Code';
                    Editable = ESACC_F93_Editable;
                    HideValue = ESACC_F93_HideValue;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Contact';
                    Editable = ESACC_F18_Editable;
                    HideValue = ESACC_F18_HideValue;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Editable = ESACC_F28_Editable;
                    HideValue = ESACC_F28_HideValue;
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Salesperson Code';
                    Editable = ESACC_F43_Editable;
                    HideValue = ESACC_F43_HideValue;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(PartPage1; 9084)
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Enabled = ESACC_C1102601021_Enabled;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = ESACC_C1102601021_Visible;

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        IF "Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
                        ELSE
                            PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Enabled = ESACC_C1102601023_Enabled;
                    Image = ViewComments;
                    RunObject = Page 67;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    Visible = ESACC_C1102601023_Visible;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    Enabled = ESACC_C1102601024_Enabled;
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = ESACC_C1102601024_Visible;

                    trigger OnAction()
                    begin
                        ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    ToolTip = 'Approvals';
                    Enabled = ESACC_C1102601025_Enabled;
                    Image = Approvals;
                    Visible = ESACC_C1102601025_Visible;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                        ApprovalDocumentType: Enum "Approval Document Type";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", ApprovalDocumentType::Invoice, Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    ToolTip = 'Re&lease';
                    Enabled = ESACC_C1102601017_Enabled;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = ESACC_C1102601017_Visible;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    ToolTip = 'Re&open';
                    Enabled = ESACC_C1102601018_Enabled;
                    Image = ReOpen;
                    Visible = ESACC_C1102601018_Visible;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send A&pproval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    ToolTip = 'Send A&pproval Request';
                    Enabled = ESACC_C1102601014_Enabled;
                    Image = SendApprovalRequest;
                    Visible = ESACC_C1102601014_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes mig IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    ToolTip = 'Cancel Approval Re&quest';
                    Enabled = ESACC_C1102601015_Enabled;
                    Image = Cancel;
                    Visible = ESACC_C1102601015_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes mig IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    ToolTip = 'Test Report';
                    Ellipsis = true;
                    Enabled = ESACC_C53_Enabled;
                    Image = TestReport;
                    Visible = ESACC_C53_Visible;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    ToolTip = 'P&ost';
                    Enabled = ESACC_C51_Enabled;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = ESACC_C51_Visible;

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    ToolTip = 'Post and &Print';
                    Enabled = ESACC_C52_Enabled;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = ESACC_C52_Visible;

                    trigger OnAction()
                    begin
                        SendToPosting(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    ToolTip = 'Post &Batch';
                    Ellipsis = true;
                    Enabled = ESACC_C50_Enabled;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ESACC_C50_Visible;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    ToolTip = 'Remove From Job Queue';
                    Enabled = ESACC_C5_Enabled;
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record 311;
    begin
        SetSecurityFilterOnRespCenter;
        JobQueueActive := SalesSetup.JobQueueActive;
    end;

    var
        // TODO: Manual review - Custom security codeunit 14123801 is unavailable in the current repository.
        // Original code: ESACC_ESFLADSMgt: Codeunit 14123801;
        [InDataSet]
        ESACC_C5_Visible: Boolean;
        [InDataSet]
        ESACC_C5_Enabled: Boolean;
        [InDataSet]
        ESACC_C50_Visible: Boolean;
        [InDataSet]
        ESACC_C50_Enabled: Boolean;
        [InDataSet]
        ESACC_C51_Visible: Boolean;
        [InDataSet]
        ESACC_C51_Enabled: Boolean;
        [InDataSet]
        ESACC_C52_Visible: Boolean;
        [InDataSet]
        ESACC_C52_Enabled: Boolean;
        [InDataSet]
        ESACC_C53_Visible: Boolean;
        [InDataSet]
        ESACC_C53_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601014_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601014_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601015_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601015_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601017_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601017_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601018_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601018_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601021_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601021_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601023_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601023_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601024_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601024_Enabled: Boolean;
        [InDataSet]
        ESACC_C1102601025_Visible: Boolean;
        [InDataSet]
        ESACC_C1102601025_Enabled: Boolean;
        [InDataSet]
        ESACC_F2_Visible: Boolean;
        [InDataSet]
        ESACC_F2_Editable: Boolean;
        [InDataSet]
        ESACC_F2_HideValue: Boolean;
        [InDataSet]
        ESACC_F3_Visible: Boolean;
        [InDataSet]
        ESACC_F3_Editable: Boolean;
        [InDataSet]
        ESACC_F3_HideValue: Boolean;
        [InDataSet]
        ESACC_F4_Visible: Boolean;
        [InDataSet]
        ESACC_F4_Editable: Boolean;
        [InDataSet]
        ESACC_F4_HideValue: Boolean;
        [InDataSet]
        ESACC_F5_Visible: Boolean;
        [InDataSet]
        ESACC_F5_Editable: Boolean;
        [InDataSet]
        ESACC_F5_HideValue: Boolean;
        [InDataSet]
        ESACC_F10_Visible: Boolean;
        [InDataSet]
        ESACC_F10_Editable: Boolean;
        [InDataSet]
        ESACC_F10_HideValue: Boolean;
        [InDataSet]
        ESACC_F12_Visible: Boolean;
        [InDataSet]
        ESACC_F12_Editable: Boolean;
        [InDataSet]
        ESACC_F12_HideValue: Boolean;
        [InDataSet]
        ESACC_F13_Visible: Boolean;
        [InDataSet]
        ESACC_F13_Editable: Boolean;
        [InDataSet]
        ESACC_F13_HideValue: Boolean;
        [InDataSet]
        ESACC_F18_Visible: Boolean;
        [InDataSet]
        ESACC_F18_Editable: Boolean;
        [InDataSet]
        ESACC_F18_HideValue: Boolean;
        [InDataSet]
        ESACC_F20_Visible: Boolean;
        [InDataSet]
        ESACC_F20_Editable: Boolean;
        [InDataSet]
        ESACC_F20_HideValue: Boolean;
        [InDataSet]
        ESACC_F28_Visible: Boolean;
        [InDataSet]
        ESACC_F28_Editable: Boolean;
        [InDataSet]
        ESACC_F28_HideValue: Boolean;
        [InDataSet]
        ESACC_F43_Visible: Boolean;
        [InDataSet]
        ESACC_F43_Editable: Boolean;
        [InDataSet]
        ESACC_F43_HideValue: Boolean;
        [InDataSet]
        ESACC_F79_Visible: Boolean;
        [InDataSet]
        ESACC_F79_Editable: Boolean;
        [InDataSet]
        ESACC_F79_HideValue: Boolean;
        [InDataSet]
        ESACC_F84_Visible: Boolean;
        [InDataSet]
        ESACC_F84_Editable: Boolean;
        [InDataSet]
        ESACC_F84_HideValue: Boolean;
        [InDataSet]
        ESACC_F85_Visible: Boolean;
        [InDataSet]
        ESACC_F85_Editable: Boolean;
        [InDataSet]
        ESACC_F85_HideValue: Boolean;
        [InDataSet]
        ESACC_F87_Visible: Boolean;
        [InDataSet]
        ESACC_F87_Editable: Boolean;
        [InDataSet]
        ESACC_F87_HideValue: Boolean;
        [InDataSet]
        ESACC_F88_Visible: Boolean;
        [InDataSet]
        ESACC_F88_Editable: Boolean;
        [InDataSet]
        ESACC_F88_HideValue: Boolean;
        [InDataSet]
        ESACC_F90_Visible: Boolean;
        [InDataSet]
        ESACC_F90_Editable: Boolean;
        [InDataSet]
        ESACC_F90_HideValue: Boolean;
        [InDataSet]
        ESACC_F91_Visible: Boolean;
        [InDataSet]
        ESACC_F91_Editable: Boolean;
        [InDataSet]
        ESACC_F91_HideValue: Boolean;
        [InDataSet]
        ESACC_F93_Visible: Boolean;
        [InDataSet]
        ESACC_F93_Editable: Boolean;
        [InDataSet]
        ESACC_F93_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002502_Visible: Boolean;
        [InDataSet]
        ESACC_F34002502_Editable: Boolean;
        [InDataSet]
        ESACC_F34002502_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002503_Visible: Boolean;
        [InDataSet]
        ESACC_F34002503_Editable: Boolean;
        [InDataSet]
        ESACC_F34002503_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002504_Visible: Boolean;
        [InDataSet]
        ESACC_F34002504_Editable: Boolean;
        [InDataSet]
        ESACC_F34002504_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002512_Visible: Boolean;
        [InDataSet]
        ESACC_F34002512_Editable: Boolean;
        [InDataSet]
        ESACC_F34002512_HideValue: Boolean;
        ReportPrint: Codeunit 228;
        [InDataSet]
        JobQueueActive: Boolean;
}

