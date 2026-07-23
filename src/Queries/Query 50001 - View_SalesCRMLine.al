query 50001 View_SalesCRMLine
{

    elements
    {
        dataitem(Sales_Cr_Memo_Line; "Sales Cr.Memo Line")
        {
            column(Document_No; "Document No.")
            {
            }
            column(Compartir; Compartir)
            {
            }

            column(Sum_Quantity; Quantity)
            {
                Method = Sum;
            }
            column(Sum_Unit_Price; "Unit Price")
            {
                Method = Sum;
            }
            column(Sum_Amount; Amount)
            {
                Method = Sum;
            }
            column(Sum_Amount_Including_VAT; "Amount Including VAT")
            {
                Method = Sum;
            }
            column(Sum_Line_Discount; "Line Discount %")
            {
                Method = Sum;
            }
            column(Sum_Line_Discount_Amount; "Line Discount Amount")
            {
                Method = Sum;
            }
            column(Sum_VAT; "VAT %")
            {
                Method = Sum;
            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {
            }
            column(VAT_Prod_Posting_Group; "VAT Prod. Posting Group")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        //SETFILTER(Document_No,'VNR-047875');
    end;
}

