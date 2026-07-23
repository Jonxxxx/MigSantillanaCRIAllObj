table 56026 "Lin. clas. devoluciones"
{
    Caption = 'Returns classification lines';

    fields
    {
        field(1; "No. Documento"; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Receiving date"; Date)
        {
            Caption = 'Receiving date';
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                "Item Description" := Item.Description;
                "Unit of Measure Code" := Item."Base Unit of Measure";
            end;
        }
        field(5; "Item Description"; Text[60])
        {
            Caption = 'Item Description';
            Editable = false;
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            NotBlank = true;

            trigger OnValidate()
            var
                ItemLedgEntry: Record 32;
            begin
                IF Quantity <= 0 THEN
                    ERROR(Err001);
            end;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record 5402;
                ResUnitofMeasure: Record 205;
            begin
            end;
        }
        field(8; "Cross-Reference No."; Code[20])
        {
            Caption = 'EAN';

            trigger OnLookup()
            begin
                CrossReferenceNoLookUp;
            end;

            //TODO Ver: 
            /*
            trigger OnValidate()
            var
                ReturnedCrossRef: Record 5717;
            begin
                ReturnedCrossRef.INIT;
                IF "Cross-Reference No." <> '' THEN BEGIN
                    ReturnedCrossRef.SETRANGE("Cross-Reference No.", "Cross-Reference No.");
                    ReturnedCrossRef.FINDFIRST;
                    VALIDATE("Item No.", ReturnedCrossRef."Item No.");
                    IF ReturnedCrossRef."Unit of Measure" <> '' THEN
                        VALIDATE("Unit of Measure Code", ReturnedCrossRef."Unit of Measure");

                    IF ReturnedCrossRef."Variant Code" <> '' THEN
                        VALIDATE("Variant Code", ReturnedCrossRef."Variant Code");
                END;                
            end;
            */
        }
        field(9; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cust: Record 18;
            begin
                Cust.GET("Customer No.");
                //TODO Ver: Cust.TESTFIELD("Cod. Almacen Consignacion");
                "Customer name" := Cust.Name;
                //TODO Ver: "Cod. Almacen Consignacion" := Cust."Cod. Almacen Consignacion";
            end;
        }
        field(10; "Customer name"; Text[60])
        {
            Caption = 'Customer name';
            Editable = false;
        }
        field(11; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(12; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Location Code" = FIELD("Location Filter")));
            Caption = 'Quantity on Hand';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Inventario en Consignacion"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Cod. Almacen Consignacion"),
                                                                  "Posting Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(14; "Cod. Almacen Consignacion"; Code[20])
        {
            TableRelation = Location;
        }
        field(15; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(16; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(17; "Variant Filter"; Code[10])
        {
            Caption = 'Variant Filter';
            FieldClass = FlowFilter;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(18; "Receiving Time"; Time)
        {
        }
        field(19; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(21; "External Doc. Number"; Code[20])
        {
            Caption = 'External Doc. Number';
        }
        field(22; Comentario; Text[250])
        {
        }
        field(23; "Con defecto"; Boolean)
        {
        }
        field(24; Recuperable; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No. Documento", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Receiving date" := TODAY;
        "Receiving Time" := TIME;
    end;

    trigger OnModify()
    begin
        //TESTFIELD("Cross-Reference No.");
    end;

    var
        Item: Record 27;
        Err001: Label 'The quanitty to return can not be equal or less than zero';

    procedure CrossReferenceNoLookUp()
    var
        //TODO: Tabla no existe ItemCrossReference: Record 5717;
        ICGLAcc: Record 410;
    begin
        //TODO Ver: ItemCrossReference.RESET;
        //TODO Ver: ItemCrossReference.SETCURRENTKEY("Cross-Reference No.");
        //TODO Ver: ItemCrossReference.SETRANGE("Cross-Reference No.", "Cross-Reference No.");

        //TODO Ver: IF PAGE.RUNMODAL(PAGE::"Cross Reference List", ItemCrossReference) = ACTION::LookupOK THEN
        //TODO Ver:     VALIDATE("Cross-Reference No.", ItemCrossReference."Cross-Reference No.");
    end;
}

