pageextension 70000075 pageextension70000075 extends "VAT Product Posting Groups" 
{
    Caption = 'VAT Product Posting Groups';
    layout
    {
        modify("Control 1000000000")
        {
            Visible = false;
        }
        modify("Control 1000000001")
        {
            Visible = false;
        }
        modify("Control 1000000003")
        {
            Visible = false;
        }
    }
}

