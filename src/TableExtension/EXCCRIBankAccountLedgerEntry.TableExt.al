tableextension 55042 EXCCRIBankAccountLedgerEntry extends "Bank Account Ledger Entry"
{
    fields
    {
        field(55013; "Forma de Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(55225; "Collector Code"; Code[10])
        {
            Caption = 'Collector code', Comment = 'ESP=Cod. cobrador';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Collector = const(true));
        }
        field(55956; Beneficiario; Text[250])
        {
            Caption = 'Beneficiary', Comment = 'ESP=Beneficiario';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55957; "Realizado Financ."; Text[30])
        {
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Code" = const('REALIZ_FINAN'), "Dimension Set ID" = field("Dimension Set ID")));
            FieldClass = FlowField;
        }
    }
}
