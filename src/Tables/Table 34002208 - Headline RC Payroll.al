table 34002208 "Headline RC Payroll"
{
    Caption = 'Headline RC Order Processor';

    fields
    {
        field(1;"Key";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Key';
        }
        field(2;"Workdate for computations";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Workdate for computations';
        }
    }

    keys
    {
        key(Key1;"Key")
        {
        }
    }

    fieldgroups
    {
    }
}

