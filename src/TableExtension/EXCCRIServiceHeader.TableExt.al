tableextension 55098 EXCCRIServiceHeader extends "Service Header"
{
    fields
    {
        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            DataClassification = CustomerContent;
        }
        field(34003004; "Razon anulacion NCF"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34003005; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(34003006; "Cod. Clasificacion Gasto"; Code[2])
        {
            DataClassification = CustomerContent;
        }
        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due Date', Comment = 'ESP=Fecha vencimiento NCF';
            DataClassification = CustomerContent;
        }
        field(34003008; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income Type', Comment = 'ESP=Tipo de ingreso';
            DataClassification = CustomerContent;
            InitValue = '01';
            TableRelation = "Tipos de ingresos";
        }
    }
}
