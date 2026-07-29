table 50017 "Sales Invoice Header (TMP)"
{
    Caption = 'Sales Invoice Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    DrillDownPageID = 143;
    LookupPageID = 143;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(5; "Bill-to Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Contact';
        }
        field(11; "Your Reference"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(13; "Ship-to Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Order Date';
        }
        field(20; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(21; "Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';
        }
        field(22; "Posting Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(24; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 6;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(28; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prices Including VAT';
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Disc. Code';
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(41; "Language Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(44; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = CONST("Posted Invoice"),
                                                            "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,,,,,,,,,,,Bill';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,,,,,,,,,,,Bill;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Doc. No.';
        }
        field(55; "Bal. Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
        }
        field(56; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Invoice Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Registration No.';
        }
        field(73; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(77; "Transport Method"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(78; "VAT Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Country Code';
            TableRelation = "Country/Region";
        }
        field(79; "Sell-to Customer Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name';
        }
        field(80; "Sell-to Customer Name 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to City';
        }
        field(84; "Sell-to Contact"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Contact';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(86; "Bill-to County"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to County';
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Sell-to County"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to County';
        }
        field(90; "Sell-to Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Country Code';
            TableRelation = "Country/Region";
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Ship-to County"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(97; "Exit Point"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(98; Correction; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(100; "External Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(101; "Area"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
            TableRelation = Area;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(104; "Payment Method Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(106; "Package Tracking No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Package Tracking No.';
        }
        field(107; "Pre-Assigned No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre-Assigned No. Series';
            TableRelation = "No. Series";
        }
        field(108; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(110; "Order No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No. Series';
            TableRelation = "No. Series";
        }
        field(111; "Pre-Assigned No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre-Assigned No.';
        }
        field(112; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(113; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(114; "Tax Area Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(115; "Tax Liable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Liable';
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 6;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5050; "Campaign No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Campaign No.';
            TableRelation = Campaign;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Service Mgt. Document';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Line Disc.';
        }
        field(50000; "Tipo pedido"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo pedido';
            Description = 'A adido para el desarrollo de pedidos consignacion (ESL).';
            OptionMembers = Normal,Consignacion;

            trigger OnValidate()
            var
                rSalesLine: Record 37;
            begin
            end;
        }
        field(50001; "No. Comp. Fiscal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Comp. Fiscal';
            Description = 'JOR SGD NCF';
        }
        field(50002; "No. Serie Comp. Fiscal"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie Comp. Fiscal';
            Description = 'JOR SGD NCF';
        }
        field(50003; "Tipo de NCF"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de NCF';
            Description = 'JOR SGD NCF';
        }
        field(7000000; "Applies-to Bill No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to Bill No.';
        }
        field(7000001; "Cust. Bank Acc. Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cust. Bank Acc. Code';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Bill-to Customer No."));
        }
        field(7000003; "Pay-at Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay-at Code';
            //TODO: Tabla no existe TableRelation = 7000014.Field2 WHERE("Field1" = FIELD("Bill-to Customer No."));
        }
        field(99008509; "Date Sent"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Sent';
        }
        field(99008510; "Time Sent"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Sent';
        }
        field(99008516; "BizTalk Sales Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Sales Invoice';
        }
        field(99008519; "Customer Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Order No.';
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Document Sent';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Order No.")
        {
        }
        key(Key3; "Pre-Assigned No.")
        {
        }
        key(Key4; "Service Mgt. Document")
        {
        }
        key(Key5; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key6; "Sell-to Customer No.", "Order Date")
        {
        }
        key(Key7; "Sell-to Customer No.", "No.")
        {
        }
        key(Key8; "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SalesInvHeader: Record 112;
        SalesCommentLine: Record 44;
        CustLedgEntry: Record 21;
        PostCode: Record 225;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        ReportSelection: Record 77;
    begin
    end;
}

