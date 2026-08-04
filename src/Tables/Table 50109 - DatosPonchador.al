table 55109 DatosPonchador
{
    Caption = 'Time attendance log';
    DataPerCompany = false;
    LinkedObject = true;

    fields
    {
        field(1; IdUser; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IdUser';
            Editable = false;
            SQLDataType = Integer;
        }
        field(2; RecordTime; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'RecordTime';
            Editable = false;
        }
        field(3; MachineNumber; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'MachineNumber';
            Editable = false;
        }
        field(4; IdentificationNumber; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IdentificationNumber';
            Editable = false;
        }
        field(5; Name; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            Editable = false;
        }
        field(6; ProximityCard; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'ProximityCard';
            Editable = false;
        }
        field(7; CodigoBC; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CodigoBC';
            SQLDataType = Integer;
        }
    }

    keys
    {
        key(Key1; IdUser, RecordTime)
        {
        }
    }

    fieldgroups
    {
    }
}

