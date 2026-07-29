table 34002506 "Menu ventas TPV"
{
    Caption = 'Sales POS menu';
    LookupPageID = 34002511;

    fields
    {
        field(1; "Menu ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Menu ID';
            NotBlank = true;
        }
        field(2; Columnas; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Columnas';
        }
        field(3; Filas; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Filas';
        }
        field(4; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(5; "Cantidad de botones"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad de botones';
        }
        field(6; "Menu pagos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Menu pagos';
        }
        field(7; "Sub-Menu ID"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sub-Menu ID';
            OptionCaption = ',1,2,3,4';
            OptionMembers = ,"1","2","3","4";
        }
    }

    keys
    {
        key(Key1; "Menu ID")
        {
        }
    }

    fieldgroups
    {
    }
}

