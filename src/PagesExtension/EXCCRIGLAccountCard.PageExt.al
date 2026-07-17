pageextension 50004 EXCCRIGLAccountCard extends "G/L Account Card"
{
    layout
    {
        addlast(Content)
        {
            group(EXCCRILocalization)
            {
                Caption = 'Localization';

                field(EXCCRINCFMandatory; Rec."NCF Obligatorio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a fiscal receipt number is mandatory for the general ledger account.';
                }
                field(EXCCRIExpenseClassification; Rec."Cod. Clasificacion Gasto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expense classification code assigned to the general ledger account.';
                }
                field(EXCCRIIndentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the indentation level of the general ledger account.';
                }
                field(EXCCRIBlocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether posting to the general ledger account is blocked.';
                }
                field(EXCCRICABYS; Rec.CABYS)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CABYS classification code assigned to the general ledger account.';
                }
            }
        }
    }
}
