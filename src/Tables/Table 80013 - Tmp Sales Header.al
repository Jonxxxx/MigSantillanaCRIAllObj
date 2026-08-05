table 55712 "Tmp Sales Header"
{
    // DSLoc1.01   GRN     09/01/2009    Para adicionar funcionalidad de Retenciones y NCF
    //             GRN     04/07/2011    Creacion de un nuevo tipo de documento para localizar Guatemala
    // 001         GRN     13/07/2011    Creacion de Pre pedidos
    // 
    // 002         AMS     18/07/2011    Dimension Almacen en pedidos TPV.
    // 
    // 003         AMS     18/07/2011    No se debe modificar el almacen en caso de que se cambie el cliente en Pedidos TPV.
    // 
    // 004         AMS     27/09/2011    Se Captura el nombre del colegio
    // 
    // 005         AMS     06/11/2011    Se valida el tipo de documento para en No. de Serie de NCF
    // 
    // 006         AMS     22/11/2011    Se eliminan los pagos TPV asociados al pedido TPV.

    Caption = 'Sales Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = 45;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Opp: Record 5092;
            begin
            end;
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
        field(5; "Bill-to Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to City';
        }
        field(10; "Bill-to Contact"; Text[50])
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
        field(13; "Ship-to Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to City';
        }
        field(18; "Ship-to Contact"; Text[50])
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
        field(22; "Posting Description"; Text[60])
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
            DecimalPlaces = 0 : 5;
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
            TableRelation = Currency;
        }
        field(33; "Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
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

            trigger OnValidate()
            var
                SalesLine: Record 37;
                Currency: Record 4;
                JobPostLine: Codeunit 1001;
                RecalculatePrice: Boolean;
            begin
            end;
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
            TableRelation = "Salesperson/Purchaser" WHERE("Collector" = CONST(false));

            trigger OnValidate()
            var
                ApprovalEntry: Record 454;
            begin
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No."),
                                                            "Document Line No." = CONST(0)));
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
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
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
        field(57; Ship; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ship';
            Editable = false;
        }
        field(58; Invoice; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            Caption = 'Amount Including VAT';
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Shipping No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping No.';
        }
        field(63; "Posting No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting No.';
        }
        field(64; "Last Shipping No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Sales Shipment Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
        }
        field(66; "Prepayment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment No.';
        }
        field(67; "Last Prepayment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Prepayment No.';
            TableRelation = "Sales Invoice Header";
        }
        field(68; "Prepmt. Cr. Memo No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(69; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Sales Cr.Memo Header";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Registration No.';
        }
        field(71; "Combine Shipments"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Combine Shipments';
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
        field(78; "VAT Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name';
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name 2';
        }
        field(81; "Sell-to Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Address';
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Address 2';
        }
        field(83; "Sell-to City"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to City';
        }
        field(84; "Sell-to Contact"; Text[50])
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
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Country/Region Code';
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
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Country/Region Code';
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
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to Country/Region Code';
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
        field(107; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(109; "Shipping No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping No. Series';
            TableRelation = "No. Series";
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
        field(117; Reserve; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(118; "Applies-to ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempCustLedgEntry: Record 21;
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

        }
        field(120; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Invoice Discount Value';
            AutoFormatType = 1;
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Send IC Document';
        }
        field(124; "IC Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Sell-to IC Partner Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Bill-to IC Partner Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(129; "IC Direction"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
        }
        field(130; "Prepayment %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(131; "Prepayment No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";
        }
        field(132; "Compress Prepayment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(133; "Prepayment Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Due Date';
        }
        field(134; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";
        }
        field(135; "Prepmt. Posting Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Posting Description';
        }
        field(138; "Prepmt. Pmt. Discount Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(139; "Prepmt. Payment Terms Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            var
                PaymentTerms: Record 3;
            begin
            end;
        }
        field(140; "Prepmt. Payment Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(151; "Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Quote No.';
            Editable = false;
        }
        field(825; "Authorization Required"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Authorization Required';
        }
        field(827; "Credit Card No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Card No.';
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Sales Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"),
                                                                          "No." = FIELD("No."),
                                                                          "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            var
                ChangeLogMgt: Codeunit 423;
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Template Code';
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record 5050;
                ContBusinessRelation: Record 5054;
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record 5054;
                Cont: Record 5050;
                Opportunity: Record 5092;
                ChangeLogMgt: Codeunit 423;
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record 5050;
                ContBusinessRelation: Record 5054;
            begin
            end;

            trigger OnValidate()
            var
                ContBusinessRelation: Record 5054;
                Cont: Record 5050;
            begin
            end;
        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Customer Template Code';
        }
        field(5055; "Opportunity No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Opportunity No.';
            TableRelation = IF ("Document Type" = FILTER(<> Order)) Opportunity."No." WHERE("Contact No." = FIELD("Sell-to Contact No."),
                                                                                      "Closed" = CONST(false))
            ELSE IF ("Document Type" = CONST(Order)) Opportunity."No." WHERE("Contact No." = FIELD("Sell-to Contact No."),
                                                                                                                                                  "Sales Document No." = FIELD("No."),
                                                                                                                                                  "Sales Document Type" = CONST(Order));

            trigger OnValidate()
            var
                Opportunity: Record 5092;
                SalesHeader: Record 36;
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Sales Line"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       "Type" = FILTER(<> ' '),
                                                                       "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Delivery Date';
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Promised Delivery Date';
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Time';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                                                    "Document No." = FIELD("No."),
                                                    "Shipment Date" = FIELD("Date Filter"),
                                                    "Outstanding Quantity" = FILTER(<> 0)));
            Caption = 'Late Order Shipping';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; Receive; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Receive';
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Receipt No.';
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Receipt No. Series';
            TableRelation = "No. Series";
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Return Receipt No.';
            Editable = false;
            TableRelation = "Return Receipt Header";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Line Disc.';
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Get Shipment Used';
            Editable = false;
        }
        field(8725; Signature; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(9000; "Assigned User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Assigned User ID';
            TableRelation = "User Setup";
        }
        field(10005; "Ship-to UPS Zone"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-to UPS Zone';
        }
        field(10009; "Outstanding Amount ($)"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = FIELD("Document Type"),
                                                                             "Document No." = FIELD("No.")));
            Caption = 'Outstanding Amount ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10015; "Tax Exemption No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Exemption No.';
        }
        field(10018; "STE Transaction ID"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'STE Transaction ID';
            Editable = false;
        }
        field(12600; "Prepmt. Include Tax"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. Include Tax';
        }
        field(55000; "Estado distribucion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado distribucion';
            OptionMembers = " ","Para Confirmar","Para empaque","Para despacho",Entregado;
        }
        field(55008; "No. copias Picking"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. copias Picking';
            Editable = false;
        }
        field(55009; "Nota de Credito"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Nota de Credito';
        }
        field(55010; "Tipo de Venta"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Venta';
            OptionCaption = 'Invoice,Consignation,Sample';
            OptionMembers = Factura,Consignacion,Muestra;
        }
        field(55011; "No. Bultos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Bultos';
        }
        field(55012; "Cantidad para devolucion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad para devolucion';
        }
        field(55013; "Cantidad en lineas"; Decimal)
        {
            Caption = 'Cantidad en lineas';
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No."),
                                                           "Type" = FILTER(Item)));
            FieldClass = FlowField;
        }
        field(55014; "PO Box address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PO Box address';
        }
        field(55221; "ID Cajero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Cajero';
        }
        field(55222; "Hora creacion"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora creacion';
        }
        field(55223; "Tipo pedido"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo pedido';
            OptionCaption = 'Order Type';
            OptionMembers = " ",TPV,Fact_comprimida;
        }
        field(53003; TPV; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TPV';
        }
        field(53004; "Factura comprimida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Factura comprimida';
        }
        field(53005; "Importe ITBIS Incl."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe ITBIS Incl.';
        }
        field(53006; "Venta a credito"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Venta a credito';
        }
        field(53007; "Importe a liquidar"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe a liquidar';
        }
        field(53008; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            TableRelation = "Bancos tienda";
        }
        field(53009; "Factura en Historico"; Boolean)
        {
            Caption = 'Factura en Historico';
            CalcFormula = Exist("Sales Invoice Header" WHERE("No." = FIELD("Posting No.")));
            FieldClass = FlowField;
        }
        field(55225; "Pedido Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pedido Consignacion';
        }
        field(55226; "Collector Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Collector Code';
            TableRelation = "Salesperson/Purchaser" WHERE("Collector" = CONST(true));
        }
        field(55227; "Pre pedido"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pre pedido';
        }
        field(55228; "Devolucion Consignacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Devolucion Consignacion';
        }
        field(55229; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cupon';
        }
        field(55230; "Siguiente No."; Code[20])
        {
            Caption = 'Siguiente No.';
            CalcFormula = Lookup("No. Series Line"."Last No. Used" WHERE("Series Code" = FIELD("No. Serie NCF Facturas")));
            FieldClass = FlowField;
        }
        field(55231; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact WHERE("Type" = FILTER(Company));
        }
        field(55232; "Nombre Colegio"; Text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(55233; "Re facturacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Re facturacion';
        }
        field(55956; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie NCF Facturas';
            TableRelation = "No. Series";
        }
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Comprobante Fiscal';
        }
        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Comprobante Fiscal Rel.';
        }
        field(55959; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Razon anulacion NCF';
            TableRelation = "Razones Anulacion NCF";
        }
        field(55960; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie NCF Abonos';
            TableRelation = "No. Series";
        }
        field(55961; "Cod. Clasificacion Gastos"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Clasificacion Gastos';
        }
        field(99008500; "Date Received"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Received';
        }
        field(99008501; "Time Received"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Time Received';
        }
        field(99008502; "BizTalk Request for Sales Qte."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Request for Sales Qte.';
        }
        field(99008503; "BizTalk Sales Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Sales Order';
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
        field(99008513; "BizTalk Sales Quote"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Sales Quote';
        }
        field(99008514; "BizTalk Sales Order Cnfmn."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BizTalk Sales Order Cnfmn.';
        }
        field(99008518; "Customer Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Quote No.';
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
        key(Key1; "Document Type", "No.")
        {
        }
        key(Key2; "No.", "Document Type")
        {
        }
        key(Key3; "Document Type", "Sell-to Customer No.", "No.")
        {
        }
        key(Key4; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code")
        {
        }
        key(Key5; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key6; "Document Type", "Sell-to Contact No.")
        {
        }
        key(Key7; "Bill-to Contact No.")
        {
        }
        key(Key8; "ID Cajero", "Tipo pedido")
        {
        }
        key(Key9; "External Document No.")
        {
        }
        key(Key10; "Document Type", "Sell-to Customer No.", Status)
        {
        }
        key(Key11; "Posting Date")
        {
        }
        key(Key12; "Requested Delivery Date")
        {
        }
        key(Key13; "Promised Delivery Date")
        {
        }
        key(Key14; "Shipment Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnRename()
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    var
        Text000: Label 'Do you want to print shipment %1?';
        Text001: Label 'Do you want to print invoice %1?';
        Text002: Label 'Do you want to print credit memo %1?';
        Text003: Label 'You cannot rename a %1.';
        Text004: Label 'Do you want to change %1?';
        Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
        Text006: Label 'You cannot change %1 because the order is associated with one or more purchase orders.';
        Text007: Label '%1 cannot be greater than %2 in the %3 table.';
        Text008: Label 'Deleting this document will cause a gap in the number series for shipments. ';
        Text009: Label 'An empty shipment %1 will be created to fill this gap in the number series.\\';
        Text010: Label 'Do you want to continue?';
        Text011: Label 'Deleting this document will cause a gap in the number series for posted invoices. ';
        Text012: Label 'An empty posted invoice %1 will be created to fill this gap in the number series.\\';
        Text013: Label 'Deleting this document will cause a gap in the number series for posted credit memos. ';
        Text014: Label 'An empty posted credit memo %1 will be created to fill this gap in the number series.\\';
        Text015: Label 'If you change %1, the existing sales lines will be deleted and new sales lines based on the new information on the header will be created.\\';
        Text017: Label 'You must delete the existing sales lines before you can change %1.';
        Text018: Label 'You have changed %1 on the sales header, but it has not been changed on the existing sales lines.\';
        Text019: Label 'You must update the existing sales lines manually.';
        Text020: Label 'The change may affect the exchange rate used in the price calculation of the sales lines.';
        Text021: Label 'Do you want to update the exchange rate?';
        Text022: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text023: Label 'Do you want to print return receipt %1?';
        Text024: Label 'You have modified the %1 field. Note that the recalculation of Tax may cause penny differences, so you must check the amounts afterwards. ';
        Text026: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text027: Label 'Your identification is set up to process from %1 %2 only.';
        Text028: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: Label 'Deleting this document will cause a gap in the number series for return receipts. ';
        Text030: Label 'An empty return receipt %1 will be created to fill this gap in the number series.\\';
        Text031: Label 'You have modified %1.\\';
        Text032: Label 'Do you want to update the lines?';
        Text067: Label '%1 %4 with amount of %2 has already been authorized on %3 and is not expired yet. You must void the previous authorization before you can re-authorize this %1.';
        Text068: Label 'There is nothing to void.';
        Text069: Label 'The selected operation cannot complete with the specified %1.';
        SalesSetup: Record 311;
        GLSetup: Record 98;
        GLAcc: Record 15;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        CustLedgEntry: Record 21;
        Cust: Record 18;
        PaymentTerms: Record 3;
        PaymentMethod: Record 289;
        CurrExchRate: Record 330;
        SalesCommentLine: Record 44;
        ShipToAddr: Record 222;
        PostCode: Record 225;
        BankAcc: Record 270;
        SalesShptHeader: Record 110;
        SalesInvHeader: Record 112;
        SalesCrMemoHeader: Record 114;
        ReturnRcptHeader: Record 6660;
        SalesInvHeaderPrepmt: Record 112;
        SalesCrMemoHeaderPrepmt: Record 114;
        GenBusPostingGrp: Record 250;
        GenJnILine: Record 81;
        RespCenter: Record 5714;
        InvtSetup: Record 313;
        Location: Record 14;
        WhseRequest: Record 5765;
        ShippingAgentService: Record 5790;
        TempReqLine: Record 246 temporary;
        UserMgt: Codeunit 5700;
        NoSeriesMgt: Codeunit "No. Series";
        CustCheckCreditLimit: Codeunit 312;
        TransferExtendedText: Codeunit 378;
        GenJnlApply: Codeunit 225;
        SalesPost: Codeunit 80;
        CustEntrySetApplID: Codeunit 101;
        DimMgt: Codeunit DimensionManagement;
        WhseSourceHeader: Codeunit 5781;
        ArchiveManagement: Codeunit 5063;
        SalesLineReserve: Codeunit 99000832;
        CurrencyDate: Date;
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        Text035: Label 'You cannot Release Quote or Make Order unless you specify a customer on the quote.\\Do you want to create customer(s) now?';
        Text037: Label 'Contact %1 %2 is not related to customer %3.';
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.';
        Text039: Label 'Contact %1 %2 is not related to a customer.';
        ReservEntry: Record 337;
        TempReservEntry: Record 337 temporary;
        Text040: Label 'A won opportunity is linked to this order.\';
        Text041: Label 'It has to be changed to status Lost before the Order can be deleted.\';
        Text042: Label 'Do you want to change the status for this opportunity now?';
        Text043: Label 'Wizard Aborted';
        Text044: Label 'The status of the opportunity has not been changed. The program has aborted deleting the order.';
        SkipSellToContact: Boolean;
        SkipBillToContact: Boolean;
        Text045: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text047: Label 'You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.';
        Text048: Label 'Sales quote %1 has already been assigned to opportunity %2. Would you like to reassign this quote?';
        Text049: Label 'The %1 field cannot be blank because this quote is linked to an opportunity.';
        InsertMode: Boolean;
        CompanyInfo: Record 79;
        Text050: Label 'If %1 is %2 in sales order no. %3, then all sales lines where type is %4 must use the same location.';
        HideCreditCheckDialogue: Boolean;
        Text051: Label 'The sales %1 %2 already exists.';
        Text052: Label 'The sales %1 %2 has item tracking. Do you want to delete it anyway?';
        Text053: Label 'You must cancel the approval process if you wish to change the %1.';
        Text054: Label 'The sales %1 %2 has item tracking. Do you want to delete it anyway?';
        Text055: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. ';
        Text056: Label 'An empty prepayment invoice %1 will be created to fill this gap in the number series.\\';
        Text057: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. ';
        Text058: Label 'An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\';
        Text061: Label '%1 is set up to process from %2 %3 only.';
        Text062: Label 'You cannot change %1 because the corresponding %2 %3 has been assigned to this %4.';
        Text063: Label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\';
        Text064: Label 'The warehouse shipment was not created because the Shipping Advice field is set to Complete, and item no. %1 is not available in location code %2.\\You can create the warehouse shipment by either changing the Shipping Advice field to Partial in sales order no. %3, or filling in the warehouse shipment document manually.';
        USText001: Label '%1 %2 has an applied payment in journal %3, %4 line %5';
        "*** Santillana ***": Integer;
        SantSetup: Record 55226;
        SalesLine1Record: Record 37;
        GenBusPostGrp: Record 250;
        Cliente: Record 18;
        Error0001: Label 'No puede modificar un pedido tipo TPV o Factura comprimida';
        txt001: Label 'Se eliminaran las l neas de ventas del pedido, confirma que desea continuar';
        Error002: Label 'Existe otro pedido tipo Consignacion para este cliente - No. Pedido %1';
        Error003: Label 'Existe un pedido de Devolucion de consignacion en borrador para este cliente - No. Pedido %1';
        Tienda: Record 55898;
        TPV: Record 55897;
        TransferHeader: Record 5740;
        "**002**": Integer;
        rDefDim: Record 352;
        rContacto: Record 5050;
        "**005**": Integer;
        rNoSeries: Record 308;
        "**006**": Integer;
        rPagosTPV: Record 55909;
}

