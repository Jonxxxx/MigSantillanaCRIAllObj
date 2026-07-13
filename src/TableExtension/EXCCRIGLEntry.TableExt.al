tableextension 50007 EXCCRIGLEntry extends "G/L Entry"
{
    fields
    {
        field(56045; "No. Mov. cliente provisionado"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34003001; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = ToBeClassified;
        }
        field(34003007; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = ToBeClassified;
            TableRelation = "Clasificacion Gastos";
        }
        field(34003008; RNC; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34003010; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due Date';
            DataClassification = ToBeClassified;
        }
        field(34003011; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income Type';
            DataClassification = ToBeClassified;
            InitValue = '02';
            TableRelation = "Tipos de ingresos";
        }
    }

    keys
    {
        //TODO: Ver 
        /*
        key(EXCCRIProvisionedCustomer; "No. Mov. cliente provisionado", "Document Date")
        {
            SumIndexFields = Amount;
        }
        key(EXCCRISourceProvisioned; "Source No.", "Document Date", "No. Mov. cliente provisionado", "Source Type")
        {
            SumIndexFields = Amount;
        }*/
    }
}
