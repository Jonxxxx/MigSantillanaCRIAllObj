table 55253 "Clas. dev. Comment Line"
{
    Caption = 'Returns clas. comment Line';
    DrillDownPageID = 69;
    LookupPageID = 69;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment,Posted Invoice,Posted Credit Memo,Posted Return Receipt';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt";
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
        field(7; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Line No.';
        }
        field(10000; "Print On Quote"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Quote';
        }
        field(10001; "Print On Pick Ticket"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Pick Ticket';
        }
        field(10002; "Print On Order Confirmation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Order Confirmation';
        }
        field(10003; "Print On Shipment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Shipment';
        }
        field(10004; "Print On Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Invoice';
        }
        field(10005; "Print On Credit Memo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Credit Memo';
        }
        field(10006; "Print On Return Authorization"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Return Authorization';
        }
        field(10007; "Print On Return Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Print On Return Receipt';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine()
    var
        SalesCommentLine: Record 44;
    begin
        SalesCommentLine.SETRANGE("Document Type", "Document Type");
        SalesCommentLine.SETRANGE("No.", "No.");
        SalesCommentLine.SETRANGE("Document Line No.", "Document Line No.");
        SalesCommentLine.SETRANGE(Date, WORKDATE);
        IF NOT SalesCommentLine.FIND('-') THEN
            Date := WORKDATE;
    end;
}

