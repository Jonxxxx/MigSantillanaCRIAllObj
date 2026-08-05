table 55274 "Order Tracking buffer"
{
    // --------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // --------------------------------------------------------------------------
    // #117    21-10-2013      PLB           Tabla para el seguimiento de pedidos
    // #50366  13-05-2016      JMB           Se a ade el campo "Reference"

    Caption = 'Order Tracking buffer';

    fields
    {
        field(1; "Entry no."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry no.';
        }
        field(2; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Table ID';
        }
        field(3; "Table Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Table Name';
        }
        field(4; Indentation; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Indentation';
        }
        field(5; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(6; Reference; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference';
            Description = '#50366';
        }
    }

    keys
    {
        key(Key1; "Entry no.")
        {
        }
    }

    fieldgroups
    {
    }
}

