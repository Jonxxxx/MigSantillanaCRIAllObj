pageextension 50150 EXCCRISalesQuotes extends "Sales Quotes"
{
    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addlast(Processing)
        {
            action(EXCCRIPrintQuote)
            {
                ApplicationArea = All;
                Caption = 'Print Quote';
                Image = Print;
                ToolTip = 'Prints the custom sales quote report for the selected quote.';

                trigger OnAction()
                var
                    EXCCRISalesHeader: Record "Sales Header";
                begin
                    EXCCRISalesHeader.SetRange("No.", Rec."No.");
                    if EXCCRISalesHeader.FindFirst() then
                        Report.RunModal(
                            52546,
                            true,
                            false,
                            EXCCRISalesHeader);
                end;
            }
        }
        addlast(Reporting)
        {
            action(EXCCRIQuoteStatusReport)
            {
                ApplicationArea = All;
                Caption = 'Quote Status Report';
                Image = Report;
                ToolTip = 'Runs the custom quote status report.';

                trigger OnAction()
                begin
                    Report.RunModal(52548, true, true);
                end;
            }
        }
    }
}
