table 75013 "Filtro Campo Buffer"
{
    // Esta tabla se cre  para utilizarse como temporal unicamente

    DrillDownPageID = 75013;
    LookupPageID = 75013;

    fields
    {
        field(1;"Table Id";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table Id';
        }
        field(2;"Field No";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Field No';
        }
        field(10;Name;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(11;Caption;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption';
        }
    }

    keys
    {
        key(Key1;"Table Id","Field No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Field No",Caption)
        {
        }
    }
}

