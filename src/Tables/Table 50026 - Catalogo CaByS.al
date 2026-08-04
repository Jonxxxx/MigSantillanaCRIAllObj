table 55026 "Catalogo CaByS"
{

    fields
    {
        field(1; "Codigo CABYS"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo CABYS';
        }
        field(2; "Descripcion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Tipo CABYS"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo CABYS';
            OptionCaption = 'Good, Service';
            OptionMembers = "Mercanc a",Servicio;
        }
        field(4; "Tarifa IVA"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tarifa IVA';
        }
        field(5; "Tipo Impuesto"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Impuesto';
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

