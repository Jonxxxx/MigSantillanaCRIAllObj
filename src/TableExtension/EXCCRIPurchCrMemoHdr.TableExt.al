tableextension 50034 EXCCRIPurchCrMemoHdr extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(34003001; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Productos,Servicios;
        }
        field(34003002; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(34003003; "No. Comprobante Fiscal Rel."; Code[19])
        {
            Caption = 'Rel. Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(34003004; "Correccion Doc. NCF"; Boolean)
        {
            Caption = 'NCF Doc. Correction';
            DataClassification = CustomerContent;
        }
        field(34003005; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice NCF Series No.';
            DataClassification = CustomerContent;
        }
        field(34003006; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'NCF Credit Memo Series No.';
            DataClassification = CustomerContent;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Class. Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003009; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due date';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
        field(34003010; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income type';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
        field(34003030; Proporcionalidad; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,100% Admitido,% Admitido,0% Admitido,No Aplica';
            OptionMembers = " ","100% Admitido","% Admitido","0% Admitido","No Aplica";
        }
    }
}
