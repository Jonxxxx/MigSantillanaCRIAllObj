tableextension 55231 EXCCRIGLAccount extends "G/L Account"
{
    fields
    {
        field(56035; CABYS; Code[20])
        {
            Caption = 'CABYS';
            DataClassification = CustomerContent;
        }
        field(34003001; "NCF Obligatorio"; Boolean)
        {
            Caption = 'NCF Requested';
            DataClassification = CustomerContent;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; "Tipo ingreso admitido"; Code[2])
        {
            Caption = 'Type of admitted income';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
    }
}
