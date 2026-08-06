tableextension 55034 EXCCRIPurchCrMemoHdr extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(55956; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Productos,Servicios;
        }
        field(55957; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(55958; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Rel. Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(55959; "Correccion Doc. NCF"; Boolean)
        {
            Caption = 'NCF Doc. Correction';
            DataClassification = CustomerContent;
        }
        field(55960; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = CustomerContent;
        }
        field(55961; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'NCF Credit Memo Series No.';
            DataClassification = CustomerContent;
        }
        field(55962; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class. Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(55964; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
        field(55965; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
        field(55030; Proporcionalidad; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,100% Admitido,% Admitido,0% Admitido,No Aplica';
            OptionMembers = " ","100% Admitido","% Admitido","0% Admitido","No Aplica";
        }
    }
}
