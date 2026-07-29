page 56020 "Sales Header Movil."
{
    Editable = false;
    PageType = Document;
    SourceTable = 56037;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Address';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Address 2';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to City';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Order Date';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Date';
                }
            }
            part(PageLin; 56012)
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

