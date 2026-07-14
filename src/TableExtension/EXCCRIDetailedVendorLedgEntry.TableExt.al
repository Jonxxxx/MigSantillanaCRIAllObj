tableextension 50058 EXCCRIDetailedVendorLedgEntry extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50000; "Grupo Contable"; Code[20])
        {
            CalcFormula = lookup("Vendor Ledger Entry"."Vendor Posting Group" where("Entry No." = field("Vendor Ledger Entry No.")));
            Caption = 'Posting Group', Comment = 'ESP=Grupo Contable';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
