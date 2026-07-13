table 34003012 "NCF Anulados - GT"
{
    Caption = 'VOID NCF';
    //TODO: Ver DrillDownPageID = 34003014;
    //TODO: Ver LookupPageID = 34003014;

    fields
    {
        field(1; "No. documento"; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "No. Serie NCF Facturas"; Code[10])
        {
            Caption = 'Invoice FDN Serial No.';
            TableRelation = "No. Series";
        }
        field(3; "No. Comprobante Fiscal"; Code[19])
        {
            Caption = 'Fiscal Document No.';
        }
        field(6; "No. Serie NCF Abonos"; Code[10])
        {
            Caption = 'Credit Memo NCF Serial No.';
            TableRelation = "No. Series";
        }
        field(7; "Fecha anulacion"; Date)
        {
            Caption = 'Void date';
        }
    }

    keys
    {
        key(Key1; "No. documento", "No. Comprobante Fiscal")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Err001: Label 'The percent total is higher than 100%';
}

