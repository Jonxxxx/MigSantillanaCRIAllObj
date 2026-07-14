tableextension 50057 EXCCRIDetailedCustLedgEntry extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        field(50000; "Grupo Contable"; Code[20])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Customer Posting Group" where("Entry No." = field("Cust. Ledger Entry No.")));
            Caption = 'Posting Group', Comment = 'ESP=Grupo Contable';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Act. Ledger Entry Amount"; Boolean)
        {
            Caption = 'Ledger Entry Amount Updated', Comment = 'ESP=Act. Ledger Entry Amount';
            DataClassification = ToBeClassified;
        }
    }
}
