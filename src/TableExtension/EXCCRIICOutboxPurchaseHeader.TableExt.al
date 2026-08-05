tableextension 55063 EXCCRIICOutboxPurchaseHeader extends "IC Outbox Purchase Header"
{
    fields
    {
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.', Comment = 'ESP=No. Comprobante Fiscal';
            DataClassification = CustomerContent;
        }
    }
}
