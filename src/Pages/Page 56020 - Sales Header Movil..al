page 56020 "Sales Header Movil."
{
    Editable = false;
    PageType = Document;
    SourceTable = Table56037;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                }
                field("Bill-to Address 2;"Bill -to Address 2")
                {
                }
                field("Bill-to City"; "Bill-to City")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
            }
            part(; 56012)
            {
                SubPageLink = Document Type=FIELD("Document Type"),
                              Document No.=FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

