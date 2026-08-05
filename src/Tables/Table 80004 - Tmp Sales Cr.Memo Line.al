table 55703 "Tmp Sales Cr.Memo Line"
{
    Caption = 'Sales Cr.Memo Line';
    DrillDownPageID = 527;
    LookupPageID = 527;
    Permissions = TableData 32 = r,
                  TableData 5802 = r;

    fields
    {
        field(2; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            TableRelation = "Sales Cr.Memo Header";
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE IF (Type = CONST("Charge (Item)")) "Item Charge";
        }
        field(7; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';
        }
        field(11; Description; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Unit Price"));
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost (LCY)';
            AutoFormatType = 2;
        }
        field(25; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Discount Amount';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(29; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Including VAT';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Appl.-to Item Entry';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Customer Price Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(52; "Work Type Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inv. Discount Amount';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attached to Line No.';
            TableRelation = "Sales Cr.Memo Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(97; "Blanket Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Base Amount';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 2;
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Amount';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
        }
        field(104; "VAT Difference"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Difference';
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Partner Reference';
        }
        field(123; "Prepayment Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(131; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(1001; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Contract Entry No.';
            Editable = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"),
                                            "Item Filter" = FIELD("No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5600; "FA Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FA Posting Date';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Depr. until FA Posting Date';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference No.';
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
            TableRelation = IF (Type = CONST(Item)) "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where("Parent Category" = field("Item Category Code"));
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Appl.-from Item Entry';
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Receipt No.';
            Editable = false;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Return Receipt Line No.';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(10000; "Package Tracking No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Package Tracking No.';
        }
        field(55014; "Cod. Cupon"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cupon';
        }
        field(55015; "No. Linea Cupon"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea Cupon';
        }
        field(53004; "Cod. Vendedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Vendedor';
            TableRelation = "Salesperson/Purchaser";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key2; "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key3; "Sell-to Customer No.")
        {
        }
        key(Key4; "Return Receipt No.", "Return Receipt Line No.")
        {
        }
        key(Key5; "Job Contract Entry No.")
        {
        }
        key(Key6; "Bill-to Customer No.")
        {
        }
        key(Key7; "Document No.", Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SalesDocLineComments: Record 44;
    begin
    end;

    procedure GetCurrencyCode(): Code[10]
    var
        SalesCrMemoHeader: Record 114;
    begin
        IF "Document No." = SalesCrMemoHeader."No." THEN
            EXIT(SalesCrMemoHeader."Currency Code");
        IF SalesCrMemoHeader.GET("Document No.") THEN
            EXIT(SalesCrMemoHeader."Currency Code");
        EXIT('');
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record 2000000041;
    begin
        Field.GET(DATABASE::"Sales Cr.Memo Line", FieldNumber);
        EXIT(Field."Field Caption");
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        SalesCrMemoHeader: Record 114;
    begin
        IF NOT SalesCrMemoHeader.GET("Document No.") THEN
            SalesCrMemoHeader.INIT;
        IF SalesCrMemoHeader."Prices Including VAT" THEN
            EXIT('2,1,' + GetFieldCaption(FieldNumber))
        ELSE
            EXIT('2,0,' + GetFieldCaption(FieldNumber));
    end;

    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit 6500;
    begin
        EXIT(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Cr.Memo Line",
          0, "Document No.", '', 0, "Line No."));
    end;
}

