table 75015 "Tipo Filtros Tipo. MdM Buffer"
{
    Caption = 'Tipo Filtros Tipologia MdM Buffer';
    DrillDownPageID = 75011;
    LookupPageID = 75011;

    fields
    {
        field(1;Id;Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(3;"Code";Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(11;Tipo;Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = Dimension,"Dato MdM",Otros;
        }
    }

    keys
    {
        key(Key1;Id)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Code")
        {
        }
    }
}

