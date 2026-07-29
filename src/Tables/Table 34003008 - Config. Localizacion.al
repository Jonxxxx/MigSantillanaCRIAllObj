table 34003008 "Config. Localizacion"
{
    Caption = 'Localization Setup';
    DataPerCompany = false;

    fields
    {
        field(1;Codigo;Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;"URL DGII consulta NCF";Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'URL DGII consulta NCF';
        }
        field(3;"URL DGII consulta RNC";Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'URL DGII consulta RNC';
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

