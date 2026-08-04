table 56012 "Lin. Consig. Dev.Transfer Line"
{
    Caption = 'Lin. Consig. Dev.Transfer Line';
    DrillDownPageID = 5749;
    LookupPageID = 5749;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item;

        }
        field(4; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
        }
        field(6; "Qty. to Ship"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(7; "Qty. to Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(8; "Quantity Shipped"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(9; "Quantity Received"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(10; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(13; Description; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(14; "Gen. Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(15; "Inventory Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(17; "Outstanding Qty. (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(18; "Qty. to Ship (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(19; "Qty. Shipped (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; "Qty. to Receive (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(21; "Qty. Received (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

        }
        field(24; "Outstanding Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(25; "Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(26; "Net Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(27; "Unit Volume"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(30; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));


        }
        field(31; "Units per Parcel"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(32; "Description 2"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
        field(33; "In-Transit Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'In-Transit Code';
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
        }
        field(34; "Qty. in Transit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. in Transit';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(35; "Qty. in Transit (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. in Transit (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(36; "Transfer-from Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer-from Code';
            Editable = false;
            TableRelation = Location;
        }
        field(37; "Transfer-to Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer-to Code';
            Editable = false;
            TableRelation = Location;
        }
        field(38; "Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';
        }
        field(39; "Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Date';
        }
        field(40; "Derived From Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Derived From Line No.';
            TableRelation = "Transfer Line"."Line No." WHERE("Document No." = FIELD("Document No."));
        }
        field(41; "Shipping Agent Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(42; "Shipping Agent Service Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(50; "Reserved Quantity Inbnd."; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                  "Source Ref. No." = FIELD("Line No."),
                                                                  "Source Type" = CONST(5741),
                                                                  "Source Subtype" = CONST(1),
                                                                  "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                  "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity Inbnd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Reserved Quantity Outbnd."; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(5741),
                                                                   "Source Subtype" = CONST(0),
                                                                   "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                   "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity Outbnd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "Reserved Qty. Inbnd. (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                           "Source Ref. No." = FIELD("Line No."),
                                                                           "Source Type" = CONST(5741),
                                                                           "Source Subtype" = CONST(1),
                                                                           "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. Inbnd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; "Reserved Qty. Outbnd. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                            "Source Ref. No." = FIELD("Line No."),
                                                                            "Source Type" = CONST(5741),
                                                                            "Source Subtype" = CONST(0),
                                                                            "Source Prod. Order Line" = FIELD("Derived From Line No."),
                                                                            "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. Outbnd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Shipping Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Time';
        }
        field(55; "Reserved Quantity Shipped"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                  "Source Ref. No." = FILTER(<> 0),
                                                                  "Source Type" = CONST(5741),
                                                                  "Source Subtype" = CONST(1),
                                                                  "Source Prod. Order Line" = FIELD("Line No."),
                                                                  "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Reserved Qty. Shipped (Base)"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                           "Source Ref. No." = FILTER(<> 0),
                                                                           "Source Type" = CONST(5741),
                                                                           "Source Subtype" = CONST(1),
                                                                           "Source Prod. Order Line" = FIELD("Line No."),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "ID Usuario"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Usuario';
        }
        field(58; Marcada; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Marcada';
        }
        field(5704; "Item Category Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5707; "Product Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
            TableRelation = "Item Category".Code where("Parent Category" = field("Item Category Code"));
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completely Shipped';
            Editable = false;
        }
        field(5753; "Completely Received"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completely Received';
            Editable = false;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Outbound Whse. Handling Time';
        }
        field(5794; "Inbound Whse. Handling Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Inbound Whse. Handling Time';
        }
        field(7300; "Transfer-from Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer-from Bin Code';
            TableRelation = "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Transfer-from Code"),
                                                            "Item No." = FIELD("Item No."),
                                                            "Variant Code" = FIELD("Variant Code"));
        }
        field(7301; "Transfer-To Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer-To Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Transfer-to Code"),
                                            "Item Filter" = FIELD("Item No."),
                                            "Variant Filter" = FIELD("Variant Code"));
        }
        field(55225; "Precio Venta Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio Venta Consignacion';
        }
        field(55226; "Descuento % Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Descuento % Consignacion';
        }
        field(55227; "Importe Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Consignacion';
        }
        field(55228; "Importe Consignacion Original"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Consignacion Original';
        }
        field(55235; "No. Pedido Consignacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pedido Consignacion';
        }
        field(55236; "No. Linea Pedido Consignacion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea Pedido Consignacion';
        }
        field(55237; "No. Mov. Prod. Cosg. a Liq."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Mov. Prod. Cosg. a Liq.';
        }
        field(55239; "Cantidad Devuelta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Devuelta';
        }
        field(99000755; "Planning Flexibility"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemChargeAssgntPurch: Record 5805;
    begin
    end;

    trigger OnInsert()
    var
        TransLine2Record: Record 5741;
    begin
    end;

    var
        Text001: Label 'You cannot rename a %1.';
        Text002: Label 'must not be less than %1';
        Text003: Label 'Warehouse %1 is required for %2 = %3.';
        Text004: Label '\The entered information will be disregarded by warehouse operations.';
        Text005: Label 'You cannot ship more than %1 units.';
        Text006: Label 'All items have been shipped.';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'No items are currently in transit.';
        Text010: Label 'Change %1 from %2 to %3?';
        Text011: Label 'Outbound,Inbound';
        TransferRoute: Record 5742;
        Item: Record 27;
        TransHeader: Record 5740;
        Location: Record 14;
        Bin: Record 7354;
        WhseValidateSourceLine: Codeunit 5777;
        ReserveTransferLine: Codeunit 99000836;
        CheckDateConflict: Codeunit 99000815;
        WMSManagement: Codeunit 7302;
        TrackingBlocked: Boolean;
        "*** Santillana ***": Integer;
        cFuncionesSantillana: Codeunit 56000;
        wImporteDescuento: Decimal;
        NoLinea: Integer;
        rItem: Record 27;

    local procedure InitOutstandingQty()
    begin
    end;

    local procedure InitQtyToShip()
    begin
    end;

    local procedure InitQtyToReceive()
    begin
    end;

    local procedure InitQtyInTransit()
    begin
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
    end;

    local procedure GetTransHeader()
    begin
    end;

    local procedure GetItem()
    begin
    end;

    procedure BlockDynamicTracking(SetBlock: Boolean)
    begin
    end;

    procedure ShowDimensions()
    begin
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record 242;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
    end;

    local procedure CheckItemAvailable(CalledByFieldNo: Integer)
    var
    //ItemCheckAvail: Codeunit 311;
    begin
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location)
    begin
    end;

    procedure OpenItemTrackingLines(Direction: Option Outbound,Inbound)
    begin
    end;

    local procedure TestStatusOpen()
    begin
    end;

    procedure ShowReservation()
    var
        OptionNumber: Integer;
    begin
    end;

    procedure UpdateWithWarehouseShipReceive()
    begin
    end;

    local procedure CheckWarehouse(LocationCode: Code[10]; Receive: Boolean)
    var
        ShowDialog: Option " ",Message,Error;
        DialogText: Text[50];
    begin
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    begin
    end;

    local procedure GetDefaultBin(FromLocationCode: Code[10]; ToLocationCode: Code[10])
    begin
    end;
}

