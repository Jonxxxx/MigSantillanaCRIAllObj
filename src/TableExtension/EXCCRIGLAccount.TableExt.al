tableextension 50006 EXCCRIGLAccount extends "G/L Account"
{
    fields
    {
        field(56035; CABYS; Code[20])
        {
            Caption = 'CABYS';
            DataClassification = ToBeClassified;
        }
        field(34003001; "NCF Obligatorio"; Boolean)
        {
            Caption = 'NCF Requested';
            DataClassification = ToBeClassified;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = ToBeClassified;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; "Tipo ingreso admitido"; Code[2])
        {
            Caption = 'Type of admitted income';
            DataClassification = ToBeClassified;
            TableRelation = "Tipos de ingresos";
        }
    }
}
