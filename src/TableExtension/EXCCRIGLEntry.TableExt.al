tableextension 55007 EXCCRIGLEntry extends "G/L Entry"
{
    fields
    {
        field(56045; "No. Mov. cliente provisionado"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55956; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
            DataClassification = CustomerContent;
        }
        field(55962; "Cod. Clasificacion Gasto"; Code[2])
        {
            Caption = 'Expense Classification Code';
            DataClassification = CustomerContent;
            TableRelation = "Clasificacion Gastos";
        }
        field(55963; RNC; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(55965; "Fecha vencimiento NCF"; Date)
        {
            Caption = 'NCF Due Date';
            DataClassification = CustomerContent;
        }
        field(55966; "Tipo de ingreso"; Code[2])
        {
            Caption = 'Income Type';
            DataClassification = CustomerContent;
            InitValue = '02';
            TableRelation = "Tipos de ingresos";
        }
    }

    keys
    {
        // Ver 
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
