page 34003015 "Pre Sales List"
{
    Caption = 'Sales List';
    CardPageID = "IT-1 Anexo A";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Pre pedido" = CONST(True));

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
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comment';
                    ShowCaption = false;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Promised Delivery Date';
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Requested Delivery Date';
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
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
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
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    ToolTip = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageID: Integer;
                    begin
                        CASE "Document Type" OF
                            "Document Type"::Quote:
                                PageID := PAGE::"Sales Quote";
                            "Document Type"::Order:
                                PageID := PAGE::"Sales Order";
                            "Document Type"::Invoice:
                                PageID := PAGE::"Sales Invoice";
                            "Document Type"::"Return Order":
                                PageID := PAGE::"Sales Return Order";
                            "Document Type"::"Credit Memo":
                                PageID := PAGE::"Sales Credit Memo";
                            "Document Type"::"Blanket Order":
                                PageID := PAGE::"Blanket Sales Order";
                        END;

                        PageID := GetPageId(PageID);

                        IF PageID <> 0 THEN
                            PAGE.RUN(PageID, Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                ApplicationArea = All;
                Caption = 'Sales Reservation Avail.';
                ToolTip = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }

    local procedure GetPageId(PageId: Integer): Integer
    var
        // TODO: Manual review - Standard table Mini Pages Mapping is unavailable and its only related logic remains disabled.
        // Original code: MiniPagesMapping: Record 1305;
    begin
        // TODO: Manual review - Mini Pages Mapping is unavailable, so the complete disabled page-substitution block cannot be restored.
        /*
        IF MiniPagesMapping.READPERMISSION THEN
            IF MiniPagesMapping.GET(PageId) THEN
                EXIT(MiniPagesMapping.SubstitutePageID);*/

        EXIT(PageId);
    end;
}

