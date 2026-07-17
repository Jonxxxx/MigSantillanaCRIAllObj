pageextension 50019 EXCCRISalesQuote extends "Sales Quote"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRIAdditionalData)
            {
                Caption = 'Additional Data';

                field(EXCCRIVATRegistrationNo; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax registration number associated with the sales quote.';
                }
                field(EXCCRISalesOrderCategory; Rec."Categoria Pedido Venta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order category assigned to the sales quote.';
                }
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            begin
                if Rec.Status <> Rec.Status::Released then
                    Error(EXCCRISalesQuoteToOrderErr);
            end;
        }
        addlast(Processing)
        {
            action(EXCCRIPrint)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                ToolTip = 'Prints the sales quote using the custom sales quote report.';

                trigger OnAction()
                var
                    EXCCRISalesHeader: Record "Sales Header";
                begin
                    EXCCRISalesHeader.SetRange("No.", Rec."No.");
                    if EXCCRISalesHeader.FindFirst() then;
                    Report.RunModal(52546, true, false, EXCCRISalesHeader);
                end;
            }
        }
    }

    var
        EXCCRISalesQuoteToOrderErr: Label 'The status of the quote must be equal to Released.';
}
