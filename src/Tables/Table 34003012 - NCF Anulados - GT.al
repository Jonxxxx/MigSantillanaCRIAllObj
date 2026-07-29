table 34003012 "NCF Anulados - GT"
{
    Caption = 'VOID NCF';
    //IGNORAR: Page no existe DrillDownPageID = 34003014;
    //IGNORAR: Page no existe LookupPageID = 34003014;

    fields
    {
        field(1; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(2; "No. Serie NCF Facturas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie NCF Facturas';
            TableRelation = "No. Series";
        }
        field(3; "No. Comprobante Fiscal"; Code[19])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Comprobante Fiscal';
        }
        field(6; "No. Serie NCF Abonos"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Serie NCF Abonos';
            TableRelation = "No. Series";
        }
        field(7; "Fecha anulacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha anulacion';
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

