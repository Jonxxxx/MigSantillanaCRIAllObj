tableextension 50102 EXCCRIServiceCrMemoHeader extends "Service Cr.Memo Header"
{
    fields
    {
        field(34003001; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
        }
        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = ToBeClassified;
        }
        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
