table 55227 "Flash ventas (Cantidades)"
{

    fields
    {
        field(1; "Linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de negocio';
        }
        field(2; "Grupo contable producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo contable producto';
        }
        field(3; "Cantidad netas Periodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad netas Periodo 1';
        }
        field(4; "Cantidad liquidas Periodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad liquidas Periodo 1';
        }
        field(5; "Cant. Not. cred. Netas Perd. 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Not. cred. Netas Perd. 1';
        }
        field(6; "Cant. Not. cred. Liq. Per. 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Not. cred. Liq. Per. 1';
        }
        field(7; "Cantidad Netas Periodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Netas Periodo 2';
        }
        field(8; "Cantidad Liquidas Periodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Liquidas Periodo 2';
        }
        field(9; "Cant. N. cred. Netas Perd. 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. N. cred. Netas Perd. 2';
        }
        field(10; "Cant N. cred. Liq. Perd. 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant N. cred. Liq. Perd. 2';
        }
        field(11; "Cant. Netas Periodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Netas Periodo 3';
        }
        field(12; "Cant. Liquidas Periodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Liquidas Periodo 3';
        }
        field(13; "Cant. Notas cred. Net. Perd. 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Notas cred. Net. Perd. 3';
        }
        field(14; "Cant. Notas cred. Liq. Perd. 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Notas cred. Liq. Perd. 3';
        }
        field(15; "Cant. Importe presup. liquido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Importe presup. liquido';
        }
        field(16; "Cant. Netas periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Netas periodo acumulado';
        }
        field(17; "Cant. Liq. periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Liq. periodo acumulado';
        }
        field(18; "Notas cred. periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. periodo acumulado';
        }
        field(19; "Cant. Importe presupuesto neto"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Importe presupuesto neto';
        }
        field(20; "Presupuesto cant. liquida"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto cant. liquida';
        }
        field(21; "Cant. Imp. presp. liq. Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Imp. presp. liq. Dolares';
        }
        field(22; "Cant. Imp. presp. Neto Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cant. Imp. presp. Neto Dolares';
        }
        field(23; "Presupuesto cant. neta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto cant. neta';
        }
    }

    keys
    {
        key(Key1; "Linea de negocio", "Grupo contable producto")
        {
        }
    }

    fieldgroups
    {
    }
}

