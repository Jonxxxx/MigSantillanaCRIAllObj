tableextension 50042 EXCCRIBankAccountLedgerEntry extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50013; "Forma de Pago"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(56000; "Collector Code"; Code[10])
        {
            Caption = 'Collector code', Comment = 'ESP=Cód. cobrador';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(34003001; Beneficiario; Text[250])
        {
            Caption = 'Beneficiary', Comment = 'ESP=Beneficiario';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34003002; "Realizado Financ."; Text[30])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Code" = const('REALIZ_FINAN'), "Dimension Set ID" = field("Dimension Set ID")));
            FieldClass = FlowField;
        }
    }
}
