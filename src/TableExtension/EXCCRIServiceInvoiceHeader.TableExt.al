tableextension 50101 EXCCRIServiceInvoiceHeader extends "Service Invoice Header"
{
    fields
    {
        field(34003001; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = ToBeClassified;
        }
        field(34003007; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due Date', Comment = 'ESP=Fecha vencimiento NCF';
            DataClassification = ToBeClassified;
        }
        field(34003008; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income Type', Comment = 'ESP=Tipo de ingreso';
            DataClassification = ToBeClassified;
            InitValue = '02';
            TableRelation = "Tipos de ingresos";
        }
    }
}
