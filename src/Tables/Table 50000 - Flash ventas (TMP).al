table 50000 "Flash ventas (TMP)"
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
        field(3; "Netas Periodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Netas Periodo 1';
        }
        field(4; "liquidas Periodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'liquidas Periodo 1';
        }
        field(5; "Notas cred. Netas Preiodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Netas Preiodo 1';
        }
        field(6; "Notas cred. Liquidas Preiodo 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Liquidas Preiodo 1';
        }
        field(7; "Netas Periodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Netas Periodo 2';
        }
        field(8; "Liquidas Periodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidas Periodo 2';
        }
        field(9; "Notas cred. Netas Preiodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Netas Preiodo 2';
        }
        field(10; "Notas cred. Liquidas Preiodo 2"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Liquidas Preiodo 2';
        }
        field(11; "Netas Periodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Netas Periodo 3';
        }
        field(12; "Liquidas Periodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Liquidas Periodo 3';
        }
        field(13; "Notas cred. Netas Preiodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Netas Preiodo 3';
        }
        field(14; "Notas cred. Liquidas Preiodo 3"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. Liquidas Preiodo 3';
        }
        field(15; "Importe presupuesto liquido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe presupuesto liquido';
        }
        field(16; "Netas periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Netas periodo acumulado';
        }
        field(17; "Luquidas periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Luquidas periodo acumulado';
        }
        field(18; "Notas cred. periodo acumulado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas cred. periodo acumulado';
        }
        field(19; "Importe presupuesto neto"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe presupuesto neto';
        }
        field(20; "Presupuesto Cantidades"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Presupuesto Cantidades';
        }
        field(21; "Imp. presup. liquido Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Imp. presup. liquido Dolares';
        }
        field(22; "Imp. presup. Neto Dolares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Imp. presup. Neto Dolares';
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

