tableextension 55023 EXCCRIVendorPostingGroup extends "Vendor Posting Group"
{
    fields
    {
        field(55958; "Permite Emitir NCF"; Boolean)
        {
            Caption = 'Allow to Issue NCF';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Permite Emitir NCF" then
                    "NCF Obligatorio" := false;
            end;
        }
        field(55959; "NCF Obligatorio"; Boolean)
        {
            Caption = 'NCF Mandatory';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "NCF Obligatorio" then
                    "Permite Emitir NCF" := false;
            end;
        }
        field(55960; "No. Serie NCF Factura Compra"; Code[20])
        {
            Caption = 'Purch. Inv. NCF Serial No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55961; "No. Serie NCF Abonos Compra"; Code[20])
        {
            Caption = 'Purch. Credit memo NCF Serial No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55962; Internacional; Boolean)
        {
            Caption = 'International';
            DataClassification = CustomerContent;
        }
    }
}
