page 34002526 "Facturas comprimidas"
{
    // #65232, RRT, 30.01.2018: Correccion para poder compilar.

    Caption = 'Sales Invoice';
    InsertAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Venta TPV" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = ESACC_F3_Editable;
                    HideValue = ESACC_F3_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F3_Visible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = ESACC_F2_Editable;
                    HideValue = ESACC_F2_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F2_Visible;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    Editable = ESACC_F5052_Editable;
                    Enabled = ESACC_F5052_Editable;
                    HideValue = ESACC_F5052_HideValue;
                    Visible = ESACC_F5052_Visible;

                    trigger OnValidate()
                    begin
                        IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = ESACC_F79_Editable;
                    HideValue = ESACC_F79_HideValue;
                    Visible = ESACC_F79_Visible;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    Editable = ESACC_F81_Editable;
                    HideValue = ESACC_F81_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F81_Visible;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    Editable = ESACC_F82_Editable;
                    HideValue = ESACC_F82_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F82_Visible;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    Editable = ESACC_F83_Editable;
                    HideValue = ESACC_F83_HideValue;
                    Visible = ESACC_F83_Visible;
                }
                field("Sell-to County"; "Sell-to County")
                {
                    Caption = 'Sell-to State / ZIP Code';
                    Editable = ESACC_F89_Editable;
                    HideValue = ESACC_F89_HideValue;
                    Visible = ESACC_F89_Visible;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Editable = ESACC_F88_Editable;
                    HideValue = ESACC_F88_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F88_Visible;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    Editable = ESACC_F84_Editable;
                    HideValue = ESACC_F84_HideValue;
                    Visible = ESACC_F84_Visible;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = ESACC_F20_Editable;
                    HideValue = ESACC_F20_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F20_Visible;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = ESACC_F99_Editable;
                    HideValue = ESACC_F99_HideValue;
                    Visible = ESACC_F99_Visible;
                }
                field("Incoming Document Entry No."; "Incoming Document Entry No.")
                {
                    Editable = ESACC_F165_Editable;
                    HideValue = ESACC_F165_HideValue;
                    Visible = false;
                }
                field("External Document No."; "External Document No.")
                {
                    Editable = ESACC_F100_Editable;
                    HideValue = ESACC_F100_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F100_Visible;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Editable = ESACC_F43_Editable;
                    HideValue = ESACC_F43_HideValue;
                    Visible = ESACC_F43_Visible;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; "Campaign No.")
                {
                    Editable = ESACC_F5050_Editable;
                    HideValue = ESACC_F5050_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F5050_Visible;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Editable = ESACC_F5700_Editable;
                    HideValue = ESACC_F5700_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F5700_Visible;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    Editable = ESACC_F9000_Editable;
                    HideValue = ESACC_F9000_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F9000_Visible;
                }
                field("Job Queue Status"; "Job Queue Status")
                {
                    Editable = ESACC_F160_Editable;
                    Enabled = ESACC_F160_Editable;
                    HideValue = ESACC_F160_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F160_Visible;
                }
                field(Status; Status)
                {
                    Editable = ESACC_F120_Editable;
                    HideValue = ESACC_F120_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F120_Visible;
                }
            }
            part(SalesLines; 47)
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Editable = ESACC_F4_Editable;
                    HideValue = ESACC_F4_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F4_Visible;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    Editable = ESACC_F5053_Editable;
                    Enabled = ESACC_F5053_Editable;
                    HideValue = ESACC_F5053_HideValue;
                    Visible = ESACC_F5053_Visible;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Editable = ESACC_F5_Editable;
                    HideValue = ESACC_F5_HideValue;
                    Visible = ESACC_F5_Visible;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    Editable = ESACC_F7_Editable;
                    HideValue = ESACC_F7_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F7_Visible;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    Editable = ESACC_F8_Editable;
                    HideValue = ESACC_F8_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F8_Visible;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    Editable = ESACC_F9_Editable;
                    HideValue = ESACC_F9_HideValue;
                    Visible = ESACC_F9_Visible;
                }
                field("Bill-to County"; "Bill-to County")
                {
                    Caption = 'State / ZIP Code';
                    Editable = ESACC_F86_Editable;
                    HideValue = ESACC_F86_HideValue;
                    Visible = ESACC_F86_Visible;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Editable = ESACC_F85_Editable;
                    HideValue = ESACC_F85_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F85_Visible;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    Editable = ESACC_F10_Editable;
                    HideValue = ESACC_F10_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F10_Visible;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = ESACC_F29_Editable;
                    HideValue = ESACC_F29_HideValue;
                    Visible = ESACC_F29_Visible;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = ESACC_F30_Editable;
                    HideValue = ESACC_F30_HideValue;
                    Visible = ESACC_F30_Visible;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Editable = ESACC_F23_Editable;
                    HideValue = ESACC_F23_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F23_Visible;
                }
                field("Due Date"; "Due Date")
                {
                    Editable = ESACC_F24_Editable;
                    HideValue = ESACC_F24_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F24_Visible;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    Editable = ESACC_F25_Editable;
                    HideValue = ESACC_F25_HideValue;
                    Visible = ESACC_F25_Visible;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    Editable = ESACC_F26_Editable;
                    HideValue = ESACC_F26_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F26_Visible;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    Editable = ESACC_F104_Editable;
                    HideValue = ESACC_F104_HideValue;
                    Visible = ESACC_F104_Visible;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    Editable = ESACC_F115_Editable;
                    HideValue = ESACC_F115_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F115_Visible;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    Editable = ESACC_F114_Editable;
                    HideValue = ESACC_F114_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F114_Visible;
                }
                field("Direct Debit Mandate ID"; "Direct Debit Mandate ID")
                {
                    Editable = ESACC_F1200_Editable;
                    HideValue = ESACC_F1200_HideValue;
                    Visible = ESACC_F1200_Visible;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; "Ship-to Code")
                {
                    Editable = ESACC_F12_Editable;
                    HideValue = ESACC_F12_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F12_Visible;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    Editable = ESACC_F13_Editable;
                    HideValue = ESACC_F13_HideValue;
                    Visible = ESACC_F13_Visible;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    Editable = ESACC_F15_Editable;
                    HideValue = ESACC_F15_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F15_Visible;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    Editable = ESACC_F16_Editable;
                    HideValue = ESACC_F16_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F16_Visible;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    Editable = ESACC_F17_Editable;
                    HideValue = ESACC_F17_HideValue;
                    Visible = ESACC_F17_Visible;
                }
                field("Ship-to County"; "Ship-to County")
                {
                    Caption = 'Ship-to State / ZIP Code';
                    Editable = ESACC_F92_Editable;
                    HideValue = ESACC_F92_HideValue;
                    Visible = ESACC_F92_Visible;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Editable = ESACC_F91_Editable;
                    HideValue = ESACC_F91_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F91_Visible;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Editable = ESACC_F18_Editable;
                    HideValue = ESACC_F18_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F18_Visible;
                }
                //TODO: Ver 
                /*
                field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                {
                    Editable = ESACC_F10005_Editable;
                    HideValue = ESACC_F10005_HideValue;
                    Visible = ESACC_F10005_Visible;
                }*/
                field("Location Code"; "Location Code")
                {
                    Editable = ESACC_F28_Editable;
                    HideValue = ESACC_F28_HideValue;
                    Visible = ESACC_F28_Visible;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    Editable = ESACC_F27_Editable;
                    HideValue = ESACC_F27_HideValue;
                    Visible = ESACC_F27_Visible;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Editable = ESACC_F105_Editable;
                    HideValue = ESACC_F105_HideValue;
                    Visible = ESACC_F105_Visible;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    Editable = ESACC_F106_Editable;
                    HideValue = ESACC_F106_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F106_Visible;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = ESACC_F21_Editable;
                    HideValue = ESACC_F21_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F21_Visible;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    Editable = ESACC_F32_Editable;
                    HideValue = ESACC_F32_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F32_Visible;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        IF "Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    Editable = ESACC_F75_Editable;
                    HideValue = ESACC_F75_HideValue;
                    Visible = ESACC_F75_Visible;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Editable = ESACC_F76_Editable;
                    HideValue = ESACC_F76_HideValue;
                    Visible = ESACC_F76_Visible;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    Editable = ESACC_F102_Editable;
                    HideValue = ESACC_F102_HideValue;
                    Visible = ESACC_F102_Visible;
                }
                field("Transport Method"; "Transport Method")
                {
                    Editable = ESACC_F77_Editable;
                    HideValue = ESACC_F77_HideValue;
                    Visible = ESACC_F77_Visible;
                }
                field("Exit Point"; "Exit Point")
                {
                    Editable = ESACC_F97_Editable;
                    HideValue = ESACC_F97_HideValue;
                    Visible = ESACC_F97_Visible;
                }
                field("Area"; "Area")
                {
                    Editable = ESACC_F101_Editable;
                    HideValue = ESACC_F101_HideValue;
                    Visible = ESACC_F101_Visible;
                }
            }
        }
        area(factboxes)
        {
            part(Fact1; 9080)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part(Fact2; 9081)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Fact3; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(Fact4; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part(Fact5; 9087)
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
            }
            part(Fact6; 9089)
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = true;
            }
            part(Fact7; 9092)
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part(Fact8; 9108)
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
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
                    Caption = 'Statistics';
                    Enabled = ESACC_C59_Enabled;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = ESACC_C59_Visible;

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        //TODO: Ver 
                        /*
                        IF "Tax Area Code" = '' THEN
                          PAGE.RUNMODAL(PAGE::"Sales Statistics",Rec)
                        ELSE
                          PAGE.RUNMODAL(PAGE::"Sales Order Stats.",Rec)*/
                    end;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Enabled = ESACC_C116_Enabled;
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = ESACC_C116_Visible;

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Customer)
                {
                    Caption = 'Customer';
                    Enabled = ESACC_C60_Enabled;
                    Image = Customer;
                    //TODO: Ver 
                    /*
                    RunObject = Page 21;
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");*/
                    ShortCutKey = 'Shift+F7';
                    Visible = ESACC_C60_Visible;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Enabled = ESACC_C162_Enabled;
                    Image = Approvals;
                    Visible = ESACC_C162_Visible;

                    trigger OnAction()
                    var
                    //TODO: Ver ApprovalEntries: Page "Approval Entries";
                    begin
                        //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        //TODO: Ver ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Enabled = ESACC_C61_Enabled;
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
                    //TODO: Ver               "No." = FIELD("No."),
                    //TODO: Ver               "Document Line No." = CONST(0);
                    Visible = ESACC_C61_Visible;
                }

            }
            group("CreditCard")
            {
                Caption = 'Credit Card';
                Image = CreditCardLog;
                action("Credit Cards Transaction Lo&g Entries")
                {
                    Caption = 'Credit Cards Transaction Lo&g Entries';
                    Enabled = ESACC_C172_Enabled;
                    Image = CreditCardLog;
                    //TODO: Ver RunObject = Page 829;
                    Visible = ESACC_C172_Visible;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release1)
                {
                    Caption = 'Re&lease';
                    Enabled = ESACC_C123_Enabled;
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = ESACC_C123_Visible;

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
                    Enabled = ESACC_C124_Enabled;
                    Image = ReOpen;
                    Visible = ESACC_C124_Visible;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Enabled = ESACC_C63_Enabled;
                    Image = CalculateInvoiceDiscount;
                    Visible = ESACC_C63_Visible;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }

                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Enabled = ESACC_C134_Enabled;
                    Image = CustomerCode;
                    Visible = ESACC_C134_Visible;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record 172;
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }

                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = ESACC_C64_Enabled;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ESACC_C64_Visible;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Enabled = ESACC_C115_Enabled;
                    Image = MoveNegativeLines;
                    Visible = ESACC_C115_Visible;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }

                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = ESACC_C159_Enabled;
                    Image = SendApprovalRequest;
                    Visible = ESACC_C159_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes mig IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = ESACC_C160_Enabled;
                    Image = Cancel;
                    Visible = ESACC_C160_Visible;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 1535;
                    begin
                        //fes mig IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }

            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = AuthorizeCreditCard;
                action(Authorize)
                {
                    Caption = 'Authorize';
                    Enabled = ESACC_C169_Enabled;
                    Image = AuthorizeCreditCard;
                    Visible = ESACC_C169_Visible;

                    trigger OnAction()
                    begin
                        //fes mig Authorize;
                    end;
                }
                action("Void A&uthorize")
                {
                    Caption = 'Void A&uthorize';
                    Enabled = ESACC_C170_Enabled;
                    Image = VoidCreditCard;
                    Visible = ESACC_C170_Visible;

                    trigger OnAction()
                    begin
                        //fes mig Void;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Enabled = ESACC_C71_Enabled;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = ESACC_C71_Visible;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Enabled = ESACC_C70_Enabled;
                    Image = TestReport;
                    Visible = ESACC_C70_Visible;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Enabled = ESACC_C72_Enabled;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    Visible = ESACC_C72_Visible;

                    trigger OnAction()
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Enabled = ESACC_C73_Enabled;
                    Image = PostBatch;
                    Visible = ESACC_C73_Visible;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Enabled = ESACC_C3_Enabled;
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter;
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
            FILTERGROUP(0);
        END;
        ;
        ESACC_EasySecurity(TRUE);
    end;

    var
        //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
        [InDataSet]
        ESACC_C3_Visible: Boolean;
        [InDataSet]
        ESACC_C3_Enabled: Boolean;
        [InDataSet]
        ESACC_C59_Visible: Boolean;
        [InDataSet]
        ESACC_C59_Enabled: Boolean;
        [InDataSet]
        ESACC_C60_Visible: Boolean;
        [InDataSet]
        ESACC_C60_Enabled: Boolean;
        [InDataSet]
        ESACC_C61_Visible: Boolean;
        [InDataSet]
        ESACC_C61_Enabled: Boolean;
        [InDataSet]
        ESACC_C63_Visible: Boolean;
        [InDataSet]
        ESACC_C63_Enabled: Boolean;
        [InDataSet]
        ESACC_C64_Visible: Boolean;
        [InDataSet]
        ESACC_C64_Enabled: Boolean;
        [InDataSet]
        ESACC_C70_Visible: Boolean;
        [InDataSet]
        ESACC_C70_Enabled: Boolean;
        [InDataSet]
        ESACC_C71_Visible: Boolean;
        [InDataSet]
        ESACC_C71_Enabled: Boolean;
        [InDataSet]
        ESACC_C72_Visible: Boolean;
        [InDataSet]
        ESACC_C72_Enabled: Boolean;
        [InDataSet]
        ESACC_C73_Visible: Boolean;
        [InDataSet]
        ESACC_C73_Enabled: Boolean;
        [InDataSet]
        ESACC_C115_Visible: Boolean;
        [InDataSet]
        ESACC_C115_Enabled: Boolean;
        [InDataSet]
        ESACC_C116_Visible: Boolean;
        [InDataSet]
        ESACC_C116_Enabled: Boolean;
        [InDataSet]
        ESACC_C123_Visible: Boolean;
        [InDataSet]
        ESACC_C123_Enabled: Boolean;
        [InDataSet]
        ESACC_C124_Visible: Boolean;
        [InDataSet]
        ESACC_C124_Enabled: Boolean;
        [InDataSet]
        ESACC_C134_Visible: Boolean;
        [InDataSet]
        ESACC_C134_Enabled: Boolean;
        [InDataSet]
        ESACC_C159_Visible: Boolean;
        [InDataSet]
        ESACC_C159_Enabled: Boolean;
        [InDataSet]
        ESACC_C160_Visible: Boolean;
        [InDataSet]
        ESACC_C160_Enabled: Boolean;
        [InDataSet]
        ESACC_C162_Visible: Boolean;
        [InDataSet]
        ESACC_C162_Enabled: Boolean;
        [InDataSet]
        ESACC_C169_Visible: Boolean;
        [InDataSet]
        ESACC_C169_Enabled: Boolean;
        [InDataSet]
        ESACC_C170_Visible: Boolean;
        [InDataSet]
        ESACC_C170_Enabled: Boolean;
        [InDataSet]
        ESACC_C172_Visible: Boolean;
        [InDataSet]
        ESACC_C172_Enabled: Boolean;
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
        ESACC_F7_Visible: Boolean;
        [InDataSet]
        ESACC_F7_Editable: Boolean;
        [InDataSet]
        ESACC_F7_HideValue: Boolean;
        [InDataSet]
        ESACC_F8_Visible: Boolean;
        [InDataSet]
        ESACC_F8_Editable: Boolean;
        [InDataSet]
        ESACC_F8_HideValue: Boolean;
        [InDataSet]
        ESACC_F9_Visible: Boolean;
        [InDataSet]
        ESACC_F9_Editable: Boolean;
        [InDataSet]
        ESACC_F9_HideValue: Boolean;
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
        ESACC_F15_Visible: Boolean;
        [InDataSet]
        ESACC_F15_Editable: Boolean;
        [InDataSet]
        ESACC_F15_HideValue: Boolean;
        [InDataSet]
        ESACC_F16_Visible: Boolean;
        [InDataSet]
        ESACC_F16_Editable: Boolean;
        [InDataSet]
        ESACC_F16_HideValue: Boolean;
        [InDataSet]
        ESACC_F17_Visible: Boolean;
        [InDataSet]
        ESACC_F17_Editable: Boolean;
        [InDataSet]
        ESACC_F17_HideValue: Boolean;
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
        ESACC_F21_Visible: Boolean;
        [InDataSet]
        ESACC_F21_Editable: Boolean;
        [InDataSet]
        ESACC_F21_HideValue: Boolean;
        [InDataSet]
        ESACC_F23_Visible: Boolean;
        [InDataSet]
        ESACC_F23_Editable: Boolean;
        [InDataSet]
        ESACC_F23_HideValue: Boolean;
        [InDataSet]
        ESACC_F24_Visible: Boolean;
        [InDataSet]
        ESACC_F24_Editable: Boolean;
        [InDataSet]
        ESACC_F24_HideValue: Boolean;
        [InDataSet]
        ESACC_F25_Visible: Boolean;
        [InDataSet]
        ESACC_F25_Editable: Boolean;
        [InDataSet]
        ESACC_F25_HideValue: Boolean;
        [InDataSet]
        ESACC_F26_Visible: Boolean;
        [InDataSet]
        ESACC_F26_Editable: Boolean;
        [InDataSet]
        ESACC_F26_HideValue: Boolean;
        [InDataSet]
        ESACC_F27_Visible: Boolean;
        [InDataSet]
        ESACC_F27_Editable: Boolean;
        [InDataSet]
        ESACC_F27_HideValue: Boolean;
        [InDataSet]
        ESACC_F28_Visible: Boolean;
        [InDataSet]
        ESACC_F28_Editable: Boolean;
        [InDataSet]
        ESACC_F28_HideValue: Boolean;
        [InDataSet]
        ESACC_F29_Visible: Boolean;
        [InDataSet]
        ESACC_F29_Editable: Boolean;
        [InDataSet]
        ESACC_F29_HideValue: Boolean;
        [InDataSet]
        ESACC_F30_Visible: Boolean;
        [InDataSet]
        ESACC_F30_Editable: Boolean;
        [InDataSet]
        ESACC_F30_HideValue: Boolean;
        [InDataSet]
        ESACC_F32_Visible: Boolean;
        [InDataSet]
        ESACC_F32_Editable: Boolean;
        [InDataSet]
        ESACC_F32_HideValue: Boolean;
        [InDataSet]
        ESACC_F43_Visible: Boolean;
        [InDataSet]
        ESACC_F43_Editable: Boolean;
        [InDataSet]
        ESACC_F43_HideValue: Boolean;
        [InDataSet]
        ESACC_F75_Visible: Boolean;
        [InDataSet]
        ESACC_F75_Editable: Boolean;
        [InDataSet]
        ESACC_F75_HideValue: Boolean;
        [InDataSet]
        ESACC_F76_Visible: Boolean;
        [InDataSet]
        ESACC_F76_Editable: Boolean;
        [InDataSet]
        ESACC_F76_HideValue: Boolean;
        [InDataSet]
        ESACC_F77_Visible: Boolean;
        [InDataSet]
        ESACC_F77_Editable: Boolean;
        [InDataSet]
        ESACC_F77_HideValue: Boolean;
        [InDataSet]
        ESACC_F79_Visible: Boolean;
        [InDataSet]
        ESACC_F79_Editable: Boolean;
        [InDataSet]
        ESACC_F79_HideValue: Boolean;
        [InDataSet]
        ESACC_F81_Visible: Boolean;
        [InDataSet]
        ESACC_F81_Editable: Boolean;
        [InDataSet]
        ESACC_F81_HideValue: Boolean;
        [InDataSet]
        ESACC_F82_Visible: Boolean;
        [InDataSet]
        ESACC_F82_Editable: Boolean;
        [InDataSet]
        ESACC_F82_HideValue: Boolean;
        [InDataSet]
        ESACC_F83_Visible: Boolean;
        [InDataSet]
        ESACC_F83_Editable: Boolean;
        [InDataSet]
        ESACC_F83_HideValue: Boolean;
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
        ESACC_F86_Visible: Boolean;
        [InDataSet]
        ESACC_F86_Editable: Boolean;
        [InDataSet]
        ESACC_F86_HideValue: Boolean;
        [InDataSet]
        ESACC_F88_Visible: Boolean;
        [InDataSet]
        ESACC_F88_Editable: Boolean;
        [InDataSet]
        ESACC_F88_HideValue: Boolean;
        [InDataSet]
        ESACC_F89_Visible: Boolean;
        [InDataSet]
        ESACC_F89_Editable: Boolean;
        [InDataSet]
        ESACC_F89_HideValue: Boolean;
        [InDataSet]
        ESACC_F91_Visible: Boolean;
        [InDataSet]
        ESACC_F91_Editable: Boolean;
        [InDataSet]
        ESACC_F91_HideValue: Boolean;
        [InDataSet]
        ESACC_F92_Visible: Boolean;
        [InDataSet]
        ESACC_F92_Editable: Boolean;
        [InDataSet]
        ESACC_F92_HideValue: Boolean;
        [InDataSet]
        ESACC_F97_Visible: Boolean;
        [InDataSet]
        ESACC_F97_Editable: Boolean;
        [InDataSet]
        ESACC_F97_HideValue: Boolean;
        [InDataSet]
        ESACC_F99_Visible: Boolean;
        [InDataSet]
        ESACC_F99_Editable: Boolean;
        [InDataSet]
        ESACC_F99_HideValue: Boolean;
        [InDataSet]
        ESACC_F100_Visible: Boolean;
        [InDataSet]
        ESACC_F100_Editable: Boolean;
        [InDataSet]
        ESACC_F100_HideValue: Boolean;
        [InDataSet]
        ESACC_F101_Visible: Boolean;
        [InDataSet]
        ESACC_F101_Editable: Boolean;
        [InDataSet]
        ESACC_F101_HideValue: Boolean;
        [InDataSet]
        ESACC_F102_Visible: Boolean;
        [InDataSet]
        ESACC_F102_Editable: Boolean;
        [InDataSet]
        ESACC_F102_HideValue: Boolean;
        [InDataSet]
        ESACC_F104_Visible: Boolean;
        [InDataSet]
        ESACC_F104_Editable: Boolean;
        [InDataSet]
        ESACC_F104_HideValue: Boolean;
        [InDataSet]
        ESACC_F105_Visible: Boolean;
        [InDataSet]
        ESACC_F105_Editable: Boolean;
        [InDataSet]
        ESACC_F105_HideValue: Boolean;
        [InDataSet]
        ESACC_F106_Visible: Boolean;
        [InDataSet]
        ESACC_F106_Editable: Boolean;
        [InDataSet]
        ESACC_F106_HideValue: Boolean;
        [InDataSet]
        ESACC_F114_Visible: Boolean;
        [InDataSet]
        ESACC_F114_Editable: Boolean;
        [InDataSet]
        ESACC_F114_HideValue: Boolean;
        [InDataSet]
        ESACC_F115_Visible: Boolean;
        [InDataSet]
        ESACC_F115_Editable: Boolean;
        [InDataSet]
        ESACC_F115_HideValue: Boolean;
        [InDataSet]
        ESACC_F120_Visible: Boolean;
        [InDataSet]
        ESACC_F120_Editable: Boolean;
        [InDataSet]
        ESACC_F120_HideValue: Boolean;
        [InDataSet]
        ESACC_F160_Visible: Boolean;
        [InDataSet]
        ESACC_F160_Editable: Boolean;
        [InDataSet]
        ESACC_F160_HideValue: Boolean;
        [InDataSet]
        ESACC_F165_Visible: Boolean;
        [InDataSet]
        ESACC_F165_Editable: Boolean;
        [InDataSet]
        ESACC_F165_HideValue: Boolean;
        [InDataSet]
        ESACC_F827_Visible: Boolean;
        [InDataSet]
        ESACC_F827_Editable: Boolean;
        [InDataSet]
        ESACC_F827_HideValue: Boolean;
        [InDataSet]
        ESACC_F1200_Visible: Boolean;
        [InDataSet]
        ESACC_F1200_Editable: Boolean;
        [InDataSet]
        ESACC_F1200_HideValue: Boolean;
        [InDataSet]
        ESACC_F5050_Visible: Boolean;
        [InDataSet]
        ESACC_F5050_Editable: Boolean;
        [InDataSet]
        ESACC_F5050_HideValue: Boolean;
        [InDataSet]
        ESACC_F5052_Visible: Boolean;
        [InDataSet]
        ESACC_F5052_Editable: Boolean;
        [InDataSet]
        ESACC_F5052_HideValue: Boolean;
        [InDataSet]
        ESACC_F5053_Visible: Boolean;
        [InDataSet]
        ESACC_F5053_Editable: Boolean;
        [InDataSet]
        ESACC_F5053_HideValue: Boolean;
        [InDataSet]
        ESACC_F5700_Visible: Boolean;
        [InDataSet]
        ESACC_F5700_Editable: Boolean;
        [InDataSet]
        ESACC_F5700_HideValue: Boolean;
        [InDataSet]
        ESACC_F9000_Visible: Boolean;
        [InDataSet]
        ESACC_F9000_Editable: Boolean;
        [InDataSet]
        ESACC_F9000_HideValue: Boolean;
        [InDataSet]
        ESACC_F10005_Visible: Boolean;
        [InDataSet]
        ESACC_F10005_Editable: Boolean;
        [InDataSet]
        ESACC_F10005_HideValue: Boolean;
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopySalesDoc: Report 292;
        MoveNegSalesLines: Report 6699;
        ReportPrint: Codeunit 228;
        UserMgt: Codeunit 5700;
        [InDataSet]

        JobQueueVisible: Boolean;

    local procedure ESACC_EasySecurity(OpenObject: Boolean)
    var
        TempBoolean: Boolean;
    begin
        //TODO: Ver
        /*
        IF OpenObject THEN BEGIN
            //+65232
            //SetFilters.Filter36(Rec,8,34002526);
            //-65232

            TempBoolean := CurrPage.EDITABLE;
            IF ESACC_ESFLADSMgt.PageGeneral(36, 34002526, TempBoolean) THEN
                CurrPage.EDITABLE := TempBoolean;
        END;

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 3,
          ESACC_C3_Visible, ESACC_C3_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 59,
          ESACC_C59_Visible, ESACC_C59_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 60,
          ESACC_C60_Visible, ESACC_C60_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 61,
          ESACC_C61_Visible, ESACC_C61_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 63,
          ESACC_C63_Visible, ESACC_C63_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 64,
          ESACC_C64_Visible, ESACC_C64_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 70,
          ESACC_C70_Visible, ESACC_C70_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 71,
          ESACC_C71_Visible, ESACC_C71_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 72,
          ESACC_C72_Visible, ESACC_C72_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 73,
          ESACC_C73_Visible, ESACC_C73_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 115,
          ESACC_C115_Visible, ESACC_C115_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 116,
          ESACC_C116_Visible, ESACC_C116_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 123,
          ESACC_C123_Visible, ESACC_C123_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 124,
          ESACC_C124_Visible, ESACC_C124_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 134,
          ESACC_C134_Visible, ESACC_C134_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 159,
          ESACC_C159_Visible, ESACC_C159_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 160,
          ESACC_C160_Visible, ESACC_C160_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 162,
          ESACC_C162_Visible, ESACC_C162_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 169,
          ESACC_C169_Visible, ESACC_C169_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 170,
          ESACC_C170_Visible, ESACC_C170_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 1, 172,
          ESACC_C172_Visible, ESACC_C172_Enabled, TempBoolean);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 2,
          ESACC_F2_Visible, ESACC_F2_Editable, ESACC_F2_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 3,
          ESACC_F3_Visible, ESACC_F3_Editable, ESACC_F3_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 4,
          ESACC_F4_Visible, ESACC_F4_Editable, ESACC_F4_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 5,
          ESACC_F5_Visible, ESACC_F5_Editable, ESACC_F5_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 7,
          ESACC_F7_Visible, ESACC_F7_Editable, ESACC_F7_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 8,
          ESACC_F8_Visible, ESACC_F8_Editable, ESACC_F8_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 9,
          ESACC_F9_Visible, ESACC_F9_Editable, ESACC_F9_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 10,
          ESACC_F10_Visible, ESACC_F10_Editable, ESACC_F10_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 12,
          ESACC_F12_Visible, ESACC_F12_Editable, ESACC_F12_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 13,
          ESACC_F13_Visible, ESACC_F13_Editable, ESACC_F13_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 15,
          ESACC_F15_Visible, ESACC_F15_Editable, ESACC_F15_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 16,
          ESACC_F16_Visible, ESACC_F16_Editable, ESACC_F16_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 17,
          ESACC_F17_Visible, ESACC_F17_Editable, ESACC_F17_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 18,
          ESACC_F18_Visible, ESACC_F18_Editable, ESACC_F18_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 20,
          ESACC_F20_Visible, ESACC_F20_Editable, ESACC_F20_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 21,
          ESACC_F21_Visible, ESACC_F21_Editable, ESACC_F21_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 23,
          ESACC_F23_Visible, ESACC_F23_Editable, ESACC_F23_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 24,
          ESACC_F24_Visible, ESACC_F24_Editable, ESACC_F24_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 25,
          ESACC_F25_Visible, ESACC_F25_Editable, ESACC_F25_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 26,
          ESACC_F26_Visible, ESACC_F26_Editable, ESACC_F26_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 27,
          ESACC_F27_Visible, ESACC_F27_Editable, ESACC_F27_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 28,
          ESACC_F28_Visible, ESACC_F28_Editable, ESACC_F28_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 29,
          ESACC_F29_Visible, ESACC_F29_Editable, ESACC_F29_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 30,
          ESACC_F30_Visible, ESACC_F30_Editable, ESACC_F30_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 32,
          ESACC_F32_Visible, ESACC_F32_Editable, ESACC_F32_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 43,
          ESACC_F43_Visible, ESACC_F43_Editable, ESACC_F43_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 75,
          ESACC_F75_Visible, ESACC_F75_Editable, ESACC_F75_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 76,
          ESACC_F76_Visible, ESACC_F76_Editable, ESACC_F76_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 77,
          ESACC_F77_Visible, ESACC_F77_Editable, ESACC_F77_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 79,
          ESACC_F79_Visible, ESACC_F79_Editable, ESACC_F79_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 81,
          ESACC_F81_Visible, ESACC_F81_Editable, ESACC_F81_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 82,
          ESACC_F82_Visible, ESACC_F82_Editable, ESACC_F82_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 83,
          ESACC_F83_Visible, ESACC_F83_Editable, ESACC_F83_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 84,
          ESACC_F84_Visible, ESACC_F84_Editable, ESACC_F84_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 85,
          ESACC_F85_Visible, ESACC_F85_Editable, ESACC_F85_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 86,
          ESACC_F86_Visible, ESACC_F86_Editable, ESACC_F86_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 88,
          ESACC_F88_Visible, ESACC_F88_Editable, ESACC_F88_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 89,
          ESACC_F89_Visible, ESACC_F89_Editable, ESACC_F89_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 91,
          ESACC_F91_Visible, ESACC_F91_Editable, ESACC_F91_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 92,
          ESACC_F92_Visible, ESACC_F92_Editable, ESACC_F92_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 97,
          ESACC_F97_Visible, ESACC_F97_Editable, ESACC_F97_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 99,
          ESACC_F99_Visible, ESACC_F99_Editable, ESACC_F99_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 100,
          ESACC_F100_Visible, ESACC_F100_Editable, ESACC_F100_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 101,
          ESACC_F101_Visible, ESACC_F101_Editable, ESACC_F101_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 102,
          ESACC_F102_Visible, ESACC_F102_Editable, ESACC_F102_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 104,
          ESACC_F104_Visible, ESACC_F104_Editable, ESACC_F104_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 105,
          ESACC_F105_Visible, ESACC_F105_Editable, ESACC_F105_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 106,
          ESACC_F106_Visible, ESACC_F106_Editable, ESACC_F106_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 114,
          ESACC_F114_Visible, ESACC_F114_Editable, ESACC_F114_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 115,
          ESACC_F115_Visible, ESACC_F115_Editable, ESACC_F115_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 120,
          ESACC_F120_Visible, ESACC_F120_Editable, ESACC_F120_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 160,
          ESACC_F160_Visible, ESACC_F160_Editable, ESACC_F160_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 165,
          ESACC_F165_Visible, ESACC_F165_Editable, ESACC_F165_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 827,
          ESACC_F827_Visible, ESACC_F827_Editable, ESACC_F827_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 1200,
          ESACC_F1200_Visible, ESACC_F1200_Editable, ESACC_F1200_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 5050,
          ESACC_F5050_Visible, ESACC_F5050_Editable, ESACC_F5050_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 5052,
          ESACC_F5052_Visible, ESACC_F5052_Editable, ESACC_F5052_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 5053,
          ESACC_F5053_Visible, ESACC_F5053_Editable, ESACC_F5053_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 5700,
          ESACC_F5700_Visible, ESACC_F5700_Editable, ESACC_F5700_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 9000,
          ESACC_F9000_Visible, ESACC_F9000_Editable, ESACC_F9000_HideValue);

        ESACC_ESFLADSMgt.PageControl(
          36, 34002526, 0, 10005,
          ESACC_F10005_Visible, ESACC_F10005_Editable, ESACC_F10005_HideValue);
        */
        ESACC_EasySecurityManual(OpenObject);
    end;

    local procedure ESACC_EasySecurityManual(OpenObject: Boolean)
    begin
    end;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
            IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
                SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        //fes mig CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;
}

