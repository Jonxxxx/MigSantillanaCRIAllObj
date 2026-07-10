table 50027 TempImpuestoFE
{

    fields
    {
        field(1;Codigo;Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(2;TarifaIva;Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(3;MontoTotalImp;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Codigo,TarifaIva)
        {
        }
    }

    fieldgroups
    {
    }
}

