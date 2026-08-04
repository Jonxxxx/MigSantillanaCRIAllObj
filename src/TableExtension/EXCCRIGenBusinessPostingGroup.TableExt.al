tableextension 55040 EXCCRIGenBusinessPostingGroup extends "Gen. Business Posting Group"
{
    fields
    {
        field(56000; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = CustomerContent;
        }
        field(56001; Muestras; Boolean)
        {
            Caption = 'Samples';
            DataClassification = CustomerContent;
        }
        field(56002; Donaciones; Boolean)
        {
            Caption = 'Donations';
            DataClassification = CustomerContent;
        }
        field(56003; Destrucciones; Boolean)
        {
            Caption = 'Destruction';
            DataClassification = CustomerContent;
        }
    }
}
