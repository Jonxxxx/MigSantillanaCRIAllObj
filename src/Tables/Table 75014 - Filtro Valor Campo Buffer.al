table 75014 "Filtro Valor Campo Buffer"
{
    // Esta tabla se cre  para utilizarse como temporal unicamente

    Caption = 'Valores';
    DrillDownPageID = 75014;
    LookupPageID = 75014;

    fields
    {
        field(1;"Table Id";Integer)
        {
        }
        field(2;"Field No";Integer)
        {
        }
        field(3;Id;Integer)
        {
        }
        field(10;Value;Text[100])
        {
            Caption = 'Valor';
        }
        field(11;Description;Text[100])
        {
            Caption = 'Descripci n';
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
        fieldgroup(DropDown;Value,Description)
        {
        }
    }
}

