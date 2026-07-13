tableextension 50023 EXCCRIVendorPostingGroup extends "Vendor Posting Group"
{
    fields
    {
        field(34003003; "Permite Emitir NCF"; Boolean)
        {
            Caption = 'Allow to Issue NCF';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Permite Emitir NCF" then
                    "NCF Obligatorio" := false;
            end;
        }
        field(34003004; "NCF Obligatorio"; Boolean)
        {
            Caption = 'NCF Mandatory';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "NCF Obligatorio" then
                    "Permite Emitir NCF" := false;
            end;
        }
        field(34003005; "No. Serie NCF Factura Compra"; Code[20])
        {
            Caption = 'Purch. Inv. NCF Serial No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003006; "No. Serie NCF Abonos Compra"; Code[20])
        {
            Caption = 'Purch. Credit memo NCF Serial No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003007; Internacional; Boolean)
        {
            Caption = 'International';
            DataClassification = ToBeClassified;
        }
    }
}
