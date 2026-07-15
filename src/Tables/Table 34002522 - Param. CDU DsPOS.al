table 34002522 "Param. CDU DsPOS"
{
    Caption = 'Parámatros CDU DsPOS';

    fields
    {
        field(10; Accion; Option)
        {
            Caption = 'Accion';
            OptionCaption = 'LiquidarFactura,LiquidarNotaCredito';
            OptionMembers = LiquidarFactura,LiquidarNotaCredito;
        }
        field(20; Documento; Code[20])
        {
        }
        field(21; Manual; Boolean)
        {
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

