table 75014 "Filtro Valor Campo Buffer"
{
    // Esta tabla se cre  para utilizarse como temporal unicamente

    Caption = 'Valores';
    DrillDownPageID = 75014;
    LookupPageID = 75014;

    fields
    {
        field(1; "Table Id"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table Id';
        }
        field(2; "Field No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No';
        }
        field(3; Id; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(10; Value; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Value';
        }
        field(11; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Value, Description)
        {
        }
    }
}

