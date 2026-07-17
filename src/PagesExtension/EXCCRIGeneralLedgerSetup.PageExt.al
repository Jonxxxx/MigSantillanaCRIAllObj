pageextension 50037 EXCCRIGeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRILocalization)
            {
                Caption = 'Localization';

                field(EXCCRILocalCurrencyName; Rec."Nombre Divisa Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the display name of the local currency.';
                }
            }
        }
    }
}
