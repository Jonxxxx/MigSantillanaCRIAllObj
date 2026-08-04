table 55027 TempImpuestoFE
{

    fields
    {
        field(1; Codigo; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; TarifaIva; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'TarifaIva';
        }
        field(3; MontoTotalImp; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MontoTotalImp';
        }
    }

    keys
    {
        key(Key1; Codigo, TarifaIva)
        {
        }
    }

    fieldgroups
    {
    }
}

