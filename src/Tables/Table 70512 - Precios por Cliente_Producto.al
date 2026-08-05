table 55677 "Precios por Cliente_Producto"
{
    Caption = 'Sales Price';

    fields
    {
        field(1; "No. producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. producto';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Codigo ventas"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo ventas';
            TableRelation = IF ("Tipo Venta" = CONST("Customer Price Group")) "Customer Price Group"
            ELSE IF ("Tipo Venta" = CONST(Customer)) Customer
            ELSE IF ("Tipo Venta" = CONST(Campaign)) Campaign;
        }
        field(3; "Cod. Divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Divisa';
            TableRelation = Currency;
        }
        field(4; "Fecha Inicial"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Inicial';
        }
        field(5; Precio; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio';
            AutoFormatExpression = "Cod. Divisa";
            AutoFormatType = 2;
            MinValue = 0;
        }
        field(13; "Tipo Venta"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Venta';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer,"Customer Price Group","All Customers",Campaign;
        }
        field(15; "Fecha Final"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Final';
        }
    }

    keys
    {
        key(Key1; "No. producto", "Tipo Venta", "Codigo ventas", "Fecha Inicial", "Cod. Divisa", Precio)
        {
        }
    }

    fieldgroups
    {
    }

    var
        CustPriceGr: Record 6;
        Text000: Label '%1 cannot be after %2';
        Cust: Record 18;
        Text001: Label '%1 must be blank.';
        Campaign: Record 5071;
        Item: Record 27;
        Text002: Label 'You can only change the %1 and %2 from the Campaign Card when %3 = %4';
}

