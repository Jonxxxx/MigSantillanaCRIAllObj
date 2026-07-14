tableextension 50063 EXCCRIICOutboxPurchaseHeader extends "IC Outbox Purchase Header"
{
    fields
    {
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.', Comment = 'ESP=No. Comprobante Fiscal';
            DataClassification = ToBeClassified;
        }
    }
}
