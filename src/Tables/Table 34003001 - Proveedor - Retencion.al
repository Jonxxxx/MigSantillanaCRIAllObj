table 55956 "Proveedor - Retencion"
{
    Caption = 'Vendor - Retention';
    DrillDownPageID = 55956;
    LookupPageID = 55956;

    fields
    {
        field(1; "Cod. Proveedor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Proveedor';
            TableRelation = Vendor;
        }
        field(2; "Codigo Retencion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Retencion';
            NotBlank = true;
            TableRelation = "Config. Retencion Proveedores";
        }
        field(3; "Cta. Contable"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contable';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(4; "Base Calculo"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Calculo';
            Editable = false;
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5; Devengo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Devengo';
            Editable = false;
            OptionMembers = "Facturacion",Pago;
        }
        field(6; "Importe Retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Retencion';
            Editable = false;
        }
        field(7; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Retencion';
            Editable = false;
            OptionMembers = Porcentaje,Importe;
        }
        field(8; "Aplica Productos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Productos';
            Editable = false;
        }
        field(9; "Aplica Servicios"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Servicios';
            Editable = false;
        }
        field(10; "Retencion ITBIS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Retencion ITBIS';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cod. Proveedor", "Codigo Retencion")
        {
        }
    }

    fieldgroups
    {
    }
}

