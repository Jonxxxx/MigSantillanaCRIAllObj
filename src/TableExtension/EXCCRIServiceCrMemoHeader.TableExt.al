tableextension 55102 EXCCRIServiceCrMemoHeader extends "Service Cr.Memo Header"
{
    fields
    {
        field(55956; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = CustomerContent;
        }
        field(55959; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
