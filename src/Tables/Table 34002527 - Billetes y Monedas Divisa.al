table 34002527 "Billetes y Monedas Divisa"
{
    Caption = 'Billetes y Monedas Divisa';

    fields
    {
        field(10;"Cod. divisa";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
            TableRelation = Currency;
        }
        field(20;Tipo;Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'Coin,Note,Roll';
            OptionMembers = Moneda,Billete;
        }
        field(30;Importe;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
    }

    keys
    {
        key(Key1;"Cod. divisa",Tipo,Importe)
        {
        }
    }

    fieldgroups
    {
    }
}

