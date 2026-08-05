tableextension 55006 EXCCRIGLAccount extends "G/L Account"
{
    fields
    {
        field(55260; CABYS; Code[20])
        {
            Caption = 'CABYS';
            DataClassification = CustomerContent;
        }
        field(55956; "NCF Obligatorio"; Boolean)
        {
            Caption = 'NCF Requested';
            DataClassification = CustomerContent;
        }
        field(55962; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(55963; "Tipo ingreso admitido"; Code[2])
        {
            Caption = 'Type of admitted income';
            DataClassification = CustomerContent;
            TableRelation = "Tipos de ingresos";
        }
    }
}
