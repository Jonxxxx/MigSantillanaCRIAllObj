page 55952 "Ficha Notas Credito Pdtes POS"
{
    // #815  19/12/2013  PLB   Se muestra el campo "Texto de registro"

    ApplicationArea = All;
    Caption = 'Sales Credit Memo';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 36;
    SourceTableView = SORTING("Posting Date", "Venta TPV", Tienda, "Registrado TPV")
                      WHERE("Document Type" = FILTER("Credit Memo"),
                            "Venta TPV" = CONST(True));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = ESACC_F3_Editable;
                    HideValue = ESACC_F3_HideValue;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                    Editable = ESACC_F2_Editable;
                    HideValue = ESACC_F2_HideValue;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Contact No.';
                    Editable = ESACC_F5052_Editable;
                    Enabled = ESACC_F5052_Editable;
                    HideValue = ESACC_F5052_HideValue;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
                            IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
                                SETRANGE("Sell-to Contact No.");
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
                    Editable = ESACC_F79_Editable;
                    HideValue = ESACC_F79_HideValue;
                    Visible = true;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Address';
                    Editable = ESACC_F81_Editable;
                    HideValue = ESACC_F81_HideValue;
                    Importance = Additional;
                    Visible = true;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Address 2';
                    Editable = ESACC_F82_Editable;
                    HideValue = ESACC_F82_HideValue;
                    Importance = Additional;
                    Visible = true;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to City';
                    Editable = ESACC_F83_Editable;
                    HideValue = ESACC_F83_HideValue;
                    Visible = true;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to County';
                    Caption = 'Sell-to State / ZIP Code';
                    Editable = ESACC_F89_Editable;
                    HideValue = ESACC_F89_HideValue;
                    Visible = true;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Post Code';
                    Editable = ESACC_F88_Editable;
                    HideValue = ESACC_F88_HideValue;
                    Importance = Additional;
                    Visible = true;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Contact';
                    Editable = ESACC_F84_Editable;
                    HideValue = ESACC_F84_HideValue;
                    Visible = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                    Editable = ESACC_F20_Editable;
                    HideValue = ESACC_F20_HideValue;
                    Importance = Promoted;
                    Visible = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Editable = ESACC_F120_Editable;
                    HideValue = ESACC_F120_HideValue;
                    Importance = Promoted;
                    Visible = true;
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Correction';
                    Editable = ESACC_F98_Editable;
                    HideValue = ESACC_F98_HideValue;
                    Visible = true;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Description';
                    Editable = ESACC_F22_Editable;
                    HideValue = ESACC_F22_HideValue;
                    Visible = true;
                }
                field("No. Comprobante Fiscal"; Rec."No. Comprobante Fiscal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Comprobante Fiscal';
                    Editable = false;
                }
                field("No. Comprobante Fiscal Rel."; Rec."No. Comprobante Fiscal Rel.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Comprobante Fiscal Rel.';
                    Editable = false;
                }
            }
            part(SalesLines; 96)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(DsPOS)
            {
                Caption = 'DsPOS';
                Editable = false;
                field("Venta TPV"; Rec."Venta TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Venta TPV';
                    Editable = ESACC_F34002502_Editable;
                    HideValue = ESACC_F34002502_HideValue;
                    Visible = true;
                }
                field(Tienda; Rec.Tienda)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tienda';
                    Editable = ESACC_F34002504_Editable;
                    HideValue = ESACC_F34002504_HideValue;
                    Visible = true;
                }
                field(TPV; Rec.TPV)
                {
                    ApplicationArea = All;
                    ToolTip = 'TPV';
                    Editable = ESACC_F34002503_Editable;
                    HideValue = ESACC_F34002503_HideValue;
                    Visible = true;
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                    Editable = ESACC_F34002512_Editable;
                    HideValue = ESACC_F34002512_HideValue;
                    Visible = true;
                }
                field("ID Cajero"; Rec."ID Cajero")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Cajero';
                    Editable = ESACC_F34002500_Editable;
                    HideValue = ESACC_F34002500_HideValue;
                    Visible = true;
                }
                field("Hora creacion"; Rec."Hora creacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora creacion';
                    Editable = ESACC_F34002501_Editable;
                    HideValue = ESACC_F34002501_HideValue;
                    Visible = true;
                }
                field("Anulado TPV"; Rec."Anulado TPV")
                {
                    ApplicationArea = All;
                    ToolTip = 'Anulado TPV';
                    Editable = ESACC_F34002510_Editable;
                    HideValue = ESACC_F34002510_HideValue;
                    Visible = true;
                }
                field("Anulado por Documento"; Rec."Anulado por Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Anulado por Documento';
                    Editable = ESACC_F34002513_Editable;
                    HideValue = ESACC_F34002513_HideValue;
                    Visible = true;
                }
                field("No. Documento SIC"; Rec."No. Documento SIC")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento SIC';
                    Editable = false;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Customer No.';
                    Editable = ESACC_F4_Editable;
                    HideValue = ESACC_F4_HideValue;
                    Importance = Promoted;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Contact No.';
                    Editable = ESACC_F5053_Editable;
                    Enabled = ESACC_F5053_Editable;
                    HideValue = ESACC_F5053_HideValue;
                    Visible = true;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
                    Editable = ESACC_F5_Editable;
                    HideValue = ESACC_F5_HideValue;
                    Visible = ESACC_F5_Visible;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Address';
                    Editable = ESACC_F7_Editable;
                    HideValue = ESACC_F7_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F7_Visible;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Address 2';
                    Editable = ESACC_F8_Editable;
                    HideValue = ESACC_F8_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F8_Visible;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to City';
                    Editable = ESACC_F9_Editable;
                    HideValue = ESACC_F9_HideValue;
                    Visible = ESACC_F9_Visible;
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to County';
                    Caption = 'State / ZIP Code';
                    Editable = ESACC_F86_Editable;
                    HideValue = ESACC_F86_HideValue;
                    Visible = ESACC_F86_Visible;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Post Code';
                    Editable = ESACC_F85_Editable;
                    HideValue = ESACC_F85_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F85_Visible;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Contact';
                    Editable = ESACC_F10_Editable;
                    HideValue = ESACC_F10_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F10_Visible;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Editable = ESACC_F29_Editable;
                    HideValue = ESACC_F29_HideValue;
                    Visible = ESACC_F29_Visible;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                    Editable = ESACC_F30_Editable;
                    HideValue = ESACC_F30_HideValue;
                    Visible = ESACC_F30_Visible;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Terms Code';
                    Editable = ESACC_F23_Editable;
                    HideValue = ESACC_F23_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F23_Visible;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Due Date';
                    Editable = ESACC_F24_Editable;
                    HideValue = ESACC_F24_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F24_Visible;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Discount %';
                    Editable = ESACC_F25_Editable;
                    HideValue = ESACC_F25_HideValue;
                    Visible = ESACC_F25_Visible;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pmt. Discount Date';
                    Editable = ESACC_F26_Editable;
                    HideValue = ESACC_F26_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F26_Visible;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Payment Method Code';
                    Editable = ESACC_F104_Editable;
                    HideValue = ESACC_F104_HideValue;
                    Visible = ESACC_F104_Visible;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tax Area Code';
                    Editable = ESACC_F114_Editable;
                    HideValue = ESACC_F114_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F114_Visible;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tax Liable';
                    Editable = ESACC_F115_Editable;
                    HideValue = ESACC_F115_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F115_Visible;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Name';
                    Editable = ESACC_F13_Editable;
                    HideValue = ESACC_F13_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F13_Visible;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Address';
                    Editable = ESACC_F15_Editable;
                    HideValue = ESACC_F15_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F15_Visible;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Address 2';
                    Editable = ESACC_F16_Editable;
                    HideValue = ESACC_F16_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F16_Visible;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to City';
                    Editable = ESACC_F17_Editable;
                    HideValue = ESACC_F17_HideValue;
                    Visible = ESACC_F17_Visible;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to County';
                    Caption = 'Ship-to State / ZIP Code';
                    Editable = ESACC_F92_Editable;
                    HideValue = ESACC_F92_HideValue;
                    Visible = ESACC_F92_Visible;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Post Code';
                    Editable = ESACC_F91_Editable;
                    HideValue = ESACC_F91_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F91_Visible;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to Contact';
                    Editable = ESACC_F18_Editable;
                    HideValue = ESACC_F18_HideValue;
                    Importance = Additional;
                    Visible = ESACC_F18_Visible;
                }
                field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ship-to UPS Zone';
                    Editable = ESACC_F10005_Editable;
                    HideValue = ESACC_F10005_HideValue;
                    Visible = ESACC_F10005_Visible;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Editable = ESACC_F28_Editable;
                    HideValue = ESACC_F28_HideValue;
                    Visible = ESACC_F28_Visible;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Date';
                    Editable = ESACC_F21_Editable;
                    HideValue = ESACC_F21_HideValue;
                    Importance = Promoted;
                    Visible = ESACC_F21_Visible;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Currency Code';
                    Editable = ESACC_F32_Editable;
                    HideValue = ESACC_F32_HideValue;
                    Importance = Promoted;
                    Visible = true;

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
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    ToolTip = 'EU 3-Party Trade';
                    Editable = ESACC_F75_Editable;
                    HideValue = ESACC_F75_HideValue;
                    Visible = ESACC_F75_Visible;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transaction Type';
                    Editable = ESACC_F76_Editable;
                    HideValue = ESACC_F76_HideValue;
                    Visible = ESACC_F76_Visible;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transaction Specification';
                    Editable = ESACC_F102_Editable;
                    HideValue = ESACC_F102_HideValue;
                    Visible = ESACC_F102_Visible;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transport Method';
                    Editable = ESACC_F77_Editable;
                    HideValue = ESACC_F77_HideValue;
                    Visible = ESACC_F77_Visible;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Exit Point';
                    Editable = ESACC_F97_Editable;
                    HideValue = ESACC_F97_HideValue;
                    Visible = ESACC_F97_Visible;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                    ToolTip = 'Area';
                    Editable = ESACC_F101_Editable;
                    HideValue = ESACC_F101_HideValue;
                    Visible = ESACC_F101_Visible;
                }
            }
        }
        area(factboxes)
        {
            part(Part; 9080)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Part1; 9081)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Part2; 9082)
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Part3; 9084)
            {
                SubPageLink = "No." = FIELD("Sell-to Customer No.");
                Visible = true;
                ApplicationArea = All;
            }
            part(Part4; 9087)
            {
                Provider = SalesLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Part5; 9092)
            {
                SubPageLink = "Table ID" = CONST(36),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            part(Part6; 9108)
            {
                Provider = SalesLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Credit Memo")
            {
                Caption = '&Credit Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Enabled = ESACC_C51_Enabled;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = ESACC_C51_Visible;

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
                action(Customer)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                    ToolTip = 'Customer';
                    Enabled = ESACC_C52_Enabled;
                    Image = EditLines;
                    RunObject = Page 21;
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    Visible = ESACC_C52_Visible;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Enabled = ESACC_C53_Enabled;
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    Visible = ESACC_C53_Visible;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    Enabled = ESACC_C105_Enabled;
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = ESACC_C105_Visible;

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    ToolTip = 'Approvals';
                    Enabled = ESACC_C121_Enabled;
                    Image = Approvals;
                    Visible = ESACC_C121_Visible;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalDocumentType: Enum "Approval Document Type";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", ApprovalDocumentType::"Credit Memo", Rec."No.");
                        ApprovalEntries.RUN;
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
    end;

    var
        // TODO: Manual review - Custom security codeunit 14123801 is unavailable in the current repository.
        // Original code: ESACC_ESFLADSMgt: Codeunit 14123801;
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
        ESACC_C105_Visible: Boolean;
        [InDataSet]
        ESACC_C105_Enabled: Boolean;
        [InDataSet]
        ESACC_C121_Visible: Boolean;
        [InDataSet]
        ESACC_C121_Enabled: Boolean;
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
        ESACC_F22_Visible: Boolean;
        [InDataSet]
        ESACC_F22_Editable: Boolean;
        [InDataSet]
        ESACC_F22_HideValue: Boolean;
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
        ESACC_F98_Visible: Boolean;
        [InDataSet]
        ESACC_F98_Editable: Boolean;
        [InDataSet]
        ESACC_F98_HideValue: Boolean;
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
        ESACC_F827_Visible: Boolean;
        [InDataSet]
        ESACC_F827_Editable: Boolean;
        [InDataSet]
        ESACC_F827_HideValue: Boolean;
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
        ESACC_F10005_Visible: Boolean;
        [InDataSet]
        ESACC_F10005_Editable: Boolean;
        [InDataSet]
        ESACC_F10005_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002500_Visible: Boolean;
        [InDataSet]
        ESACC_F34002500_Editable: Boolean;
        [InDataSet]
        ESACC_F34002500_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002501_Visible: Boolean;
        [InDataSet]
        ESACC_F34002501_Editable: Boolean;
        [InDataSet]
        ESACC_F34002501_HideValue: Boolean;
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
        ESACC_F34002510_Visible: Boolean;
        [InDataSet]
        ESACC_F34002510_Editable: Boolean;
        [InDataSet]
        ESACC_F34002510_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002512_Visible: Boolean;
        [InDataSet]
        ESACC_F34002512_Editable: Boolean;
        [InDataSet]
        ESACC_F34002512_HideValue: Boolean;
        [InDataSet]
        ESACC_F34002513_Visible: Boolean;
        [InDataSet]
        ESACC_F34002513_Editable: Boolean;
        [InDataSet]
        ESACC_F34002513_HideValue: Boolean;
        ChangeExchangeRate: Page 511;
        CopySalesDoc: Report 292;
        MoveNegSalesLines: Report 6699;
        ReportPrint: Codeunit 228;
        UserMgt: Codeunit 5700;
        [InDataSet]

        JobQueueVisible: Boolean;

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
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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

