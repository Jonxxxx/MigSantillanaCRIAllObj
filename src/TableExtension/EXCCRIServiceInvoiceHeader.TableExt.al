tableextension 55101 EXCCRIServiceInvoiceHeader extends "Service Invoice Header"
{
    fields
    {
        field(55956; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
        }
        field(55962; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due Date', Comment = 'ESP=Fecha vencimiento NCF';
            DataClassification = CustomerContent;
        }
        field(55963; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income Type', Comment = 'ESP=Tipo de ingreso';
            DataClassification = CustomerContent;
            InitValue = '02';
            TableRelation = "Tipos de ingresos";
        }
    }
}
