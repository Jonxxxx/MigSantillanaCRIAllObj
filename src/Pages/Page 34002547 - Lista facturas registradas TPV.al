page 34002547 "Lista facturas registradas TPV"
{
    Caption = 'Posted Sales Invoices';
    CardPageID = "Posted Sales Invoice";
    Editable = false;
    PageType = List;
    SourceTable = 112;
    SourceTableView = SORTING("Posting Date", Tienda, "Venta TPV")
                      WHERE("Venta TPV" = CONST(True));

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("No."; "No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                    Visible = false;
                }
                field("Venta TPV"; "Venta TPV")
                {
                }
                field(Tienda; Tienda)
                {
                }
                field(TPV; TPV)
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Amount; Amount)
                {

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {

                    trigger OnDrillDown()
                    begin
                        SETRANGE("No.");
                        PAGE.RUNMODAL(PAGE::"Posted Sales Invoice", Rec)
                    end;
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
                field("Salesperson Code"; "Salesperson Code")
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
                //TODO: Ver 
                /*
                field("Electronic Document Status"; "Electronic Document Status")
                {
                }
                field("Date/Time Stamped"; "Date/Time Stamped")
                {
                    Visible = false;
                }
                field("Date/Time Sent"; "Date/Time Sent")
                {
                    Visible = false;
                }
                field("Date/Time Canceled"; "Date/Time Canceled")
                {
                    Visible = false;
                }
                field("Error Code"; "Error Code")
                {
                    Visible = false;
                }
                field("Error Description"; "Error Description")
                {
                    Visible = false;
                }*/
                field("No. Printed"; "No. Printed")
                {
                }
                field("Document Date"; "Document Date")
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
                field("Shipment Date"; "Shipment Date")
                {
                    Visible = false;
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        PAGE.RUN(PAGE::"Posted Sales Invoice", Rec)
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
                        IF "Tax Area Code" = '' THEN
                            PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
                        //TODO: Ver ELSE
                        //TODO: Ver    PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    //TODO: Ver RunObject = Page "Sales Comment Sheet";
                    //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
                    //TODO: Ver               "No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
        }
        area(processing)
        {
            group("&Electronic Document")
            {
                Caption = '&Electronic Document';
                action("S&end")
                {
                    Caption = 'S&end';
                    Ellipsis = true;
                    Image = SendTo;

                    trigger OnAction()
                    begin
                        //TODO: Ver RequestStampEDocument;
                    end;
                }
                action("Export E-Document as &XML")
                {
                    Caption = 'Export E-Document as &XML';
                    Image = ExportElectronicDocument;

                    trigger OnAction()
                    begin
                        //TODO: Ver ExportEDocument;
                    end;
                }
                action("&Cancel")
                {
                    Caption = '&Cancel';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        //TODO: Ver CancelEDocument;
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesInvHeader: Record 112;
                begin
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.PrintRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Navigate;
                end;
            }
            action("Sales - Invoice")
            {
                Caption = 'Sales - Invoice';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //TODO: Ver RunObject = Report 10074;
            }
        }
        area(reporting)
        {
            action("Outstanding Sales Order Aging")
            {
                Caption = 'Outstanding Sales Order Aging';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //TODO: Ver RunObject = Report 10055;
            }
            action("Outstanding Sales Order Status")
            {
                Caption = 'Outstanding Sales Order Status';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //TODO: Ver RunObject = Report 10056;
            }
            action("Daily Invoicing Report")
            {
                Caption = 'Daily Invoicing Report';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                //TODO: Ver RunObject = Report 10050;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetSecurityFilterOnRespCenter;
    end;
}

