table 55252 "Doc. pendientes Cliente Movil."
{

    fields
    {
        field(1; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
        }
        field(2; Nombre; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(3; "Tipo Documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(4; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(5; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(6; "Fecha Vencimiento"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Vencimiento';
        }
        field(7; "Importe inicial"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe inicial';
        }
        field(8; "Importe Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente';
        }
        field(9; "Cod. Divisa"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Divisa';
        }
        field(10; "Fecha Ult. Actualizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ult. Actualizacion';
        }
        field(11; "No. Doc. Externo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Doc. Externo';
        }
        field(12; "Importe inicial ($)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe inicial ($)';
        }
        field(13; "Importe Pendiente ($)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente ($)';
        }
    }

    keys
    {
        key(Key1; "Cod. Cliente")
        {
        }
    }

    fieldgroups
    {
    }
}

