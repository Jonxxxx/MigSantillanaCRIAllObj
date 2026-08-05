table 55715 "Tmp productos a devolver"
{

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(4; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(5; "Cantidad defectuosa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad defectuosa';
        }
        field(10; "Inventario en Consignacion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventario en Consignacion';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Document No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

