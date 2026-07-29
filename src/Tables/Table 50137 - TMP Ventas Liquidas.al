table 50137 "TMP: Ventas Liquidas"
{

    fields
    {
        field(1; "Nivel Educativo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel Educativo';
        }
        field(2; "Grupo Contable Producto"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Contable Producto';
            TableRelation = "Gen. Product Posting Group";
        }
        field(3; Ventas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ventas';
        }
        field(4; Notas; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas';
        }
        field(5; Neto; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Neto';
        }
        field(6; Costo; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo';
        }
        field(7; "Ventas P-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ventas P-1';
            Description = 'p-1=periodo igual del a o proximo anterior';
        }
        field(8; "Notas P-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas P-1';
        }
        field(9; "Neto P-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Neto P-1';
        }
        field(10; "Costo P-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo P-1';
        }
        field(11; "Ventas A-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ventas A-1';
            Description = 'a-1=todo el a o proximo anterior';
        }
        field(12; "Notas A-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas A-1';
        }
        field(13; "Neto A-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Neto A-1';
        }
        field(14; "Costo A-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo A-1';
        }
        field(15; "Ventas Actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ventas Actual';
        }
        field(16; "Notas Actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas Actual';
        }
        field(17; "Neto Actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Neto Actual';
        }
        field(18; "Costo Actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Actual';
        }
        field(19; "Ppto Anual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ppto Anual';
        }
        field(20; "Costo Notas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Notas';
        }
        field(21; "Costo Notas P-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Notas P-1';
        }
        field(22; "Costo Notas A-1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Notas A-1';
        }
        field(23; "Costo Notas Actual"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo Notas Actual';
        }
    }

    keys
    {
        key(Key1; "Grupo Contable Producto", "Nivel Educativo")
        {
        }
        key(Key2; "Nivel Educativo")
        {
        }
    }

    fieldgroups
    {
    }
}

