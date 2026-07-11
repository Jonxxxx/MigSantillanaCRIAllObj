page 50037 ListaDescuentoProntoPago
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Posted Credit Memos (Discount Soon Payment)';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData 21 = r;
    SourceTable = Table21;
    SourceTableView = SORTING(Closed by Entry No.)
                      ORDER(Descending)
                      WHERE(Open = CONST(false),
                            Pmt. Disc. Given (LCY)=FILTER(>0),
                            No. Comprobante Fiscal DPP=FILTER(<>''));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No.";"Customer No.")
                {
                }
                field("Salesperson Code";"Salesperson Code")
                {
                }
                field(DetailedCustLedgEntry."Posting Date";DetailedCustLedgEntry."Posting Date")
                {
                    Caption = 'Fecha Registro';
                }
                field(DetailedCustLedgEntry."Document No.";DetailedCustLedgEntry."Document No.")
                {
                    Caption = 'Documento DPP';
                }
                field("Pmt. Disc. Given (LCY)";"Pmt. Disc. Given (LCY)")
                {
                }
                field("No. Comprobante Fiscal DPP";"No. Comprobante Fiscal DPP")
                {
                }
                field("Fecha vencimiento NCF DPP";"Fecha vencimiento NCF DPP")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Credit Memo (Discount Soon Payment) v2")
            {
                Caption = 'Print Credit Memo (Discount Soon Payment) v2';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CLEAR(CustLedgEntry);
                    CLEAR(ReporteDPPv2);

                    CurrPage.SETSELECTIONFILTER(CustLedgEntry);
                    ReporteDPPv2.SETTABLEVIEW(CustLedgEntry);
                    ReporteDPPv2.RUNMODAL;
                end;
            }
            action("Discount Soon Payment by customer v2")
            {
                Caption = 'Discount Soon Payment by customer v2';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CLEAR(ReporteDPPXclientev2);

                    ReporteDPPXclientev2.RUNMODAL;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.","Closed by Entry No.");
        DetailedCustLedgEntry.SETRANGE("Entry Type",DetailedCustLedgEntry."Entry Type"::"Payment Discount");
        IF DetailedCustLedgEntry.FINDFIRST THEN;
    end;

    var
        DetailedCustLedgEntry: Record 379;
        ReporteDPPv2: Report "50047;
                          ReporteDPPXclientev2: Report "50048;
                          CustLedgEntry: Record 21;
}

