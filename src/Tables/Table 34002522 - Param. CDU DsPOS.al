table 34002522 "Param. CDU DsPOS"
{
    Caption = 'Parámatros CDU DsPOS';

    fields
    {
        field(10; Accion; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Accion';
            OptionCaption = 'LiquidarFactura,LiquidarNotaCredito';
            OptionMembers = LiquidarFactura,LiquidarNotaCredito;
        }
        field(20; Documento; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Documento';
        }
        field(21; Manual; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual';
        }
    }

    keys
    {
        key(Key1; Accion)
        {
        }
    }

    fieldgroups
    {
    }
}

