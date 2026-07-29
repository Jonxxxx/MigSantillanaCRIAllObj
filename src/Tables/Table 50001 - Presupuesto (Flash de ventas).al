table 50001 "Presupuesto (Flash de ventas)"
{

    fields
    {
        field(1; "Grupo contable producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo contable producto';
            TableRelation = "Gen. Product Posting Group";
        }
        field(2; "Cod. linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. linea de negocio';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LINEA_NEGOCIO'));
        }
        field(3; "Presupuesto Importe Neto"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto Importe Neto';
        }
        field(4; "Presupuesto Importe liquido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto Importe liquido';
        }
        field(5; "Presupuesto cant. neta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto cant. neta';
        }
        field(6; "Imp. presup. liquido Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Imp. presup. liquido Dolares';
        }
        field(7; "Imp. presup. Neto Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Imp. presup. Neto Dolares';
        }
        field(8; "Presupuesto cant. liquidas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto cant. liquidas';
        }
    }

    keys
    {
        key(Key1; "Grupo contable producto", "Cod. linea de negocio")
        {
        }
    }

    fieldgroups
    {
    }
}

