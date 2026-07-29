table 59002 "tmp Def Dim"
{

    fields
    {
        field(1;Cta;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta';
        }
        field(2;Codigo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3;Valor;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
        }
        field(5;"Value Posting";Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Value Posting';
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
    }

    keys
    {
        key(Key1;Cta,Codigo)
        {
        }
    }

    fieldgroups
    {
    }
}

