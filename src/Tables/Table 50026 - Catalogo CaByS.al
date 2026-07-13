table 50026 "Catalogo CaByS"
{

    fields
    {
        field(1; "Codigo CABYS"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Descripcion"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Tipo CABYS"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Good, Service';
            OptionMembers = "Mercanc a",Servicio;
        }
        field(4; "Tarifa IVA"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Tipo Impuesto"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Taxable, Exempt, Not Subject';
            OptionMembers = Gravado,Exento,"No Sujeto";
        }
    }

    keys
    {
        key(Key1; "Codigo CABYS")
        {
        }
    }

    fieldgroups
    {
    }
}

