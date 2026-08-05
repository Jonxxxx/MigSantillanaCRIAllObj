tableextension 55040 EXCCRIGenBusinessPostingGroup extends "Gen. Business Posting Group"
{
    fields
    {
        field(55225; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = CustomerContent;
        }
        field(55226; Muestras; Boolean)
        {
            Caption = 'Samples';
            DataClassification = CustomerContent;
        }
        field(55227; Donaciones; Boolean)
        {
            Caption = 'Donations';
            DataClassification = CustomerContent;
        }
        field(55228; Destrucciones; Boolean)
        {
            Caption = 'Destruction';
            DataClassification = CustomerContent;
        }
    }
}
