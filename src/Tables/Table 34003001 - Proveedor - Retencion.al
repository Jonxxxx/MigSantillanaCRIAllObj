table 34003001 "Proveedor - Retencion"
{
    Caption = 'Vendor - Retention';
    DrillDownPageID = 34003001;
    LookupPageID = 34003001;

    fields
    {
        field(1; "Cod. Proveedor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(2; "Codigo Retencion"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Config. Retencion Proveedores";
        }
        field(3; "Cta. Contable"; Code[20])
        {
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(4; "Base Cálculo"; Option)
        {
            Editable = false;
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5; Devengo; Option)
        {
            Editable = false;
            OptionMembers = "Facturacion",Pago;
        }
        field(6; "Importe Retencion"; Decimal)
        {
            Editable = false;
        }
        field(7; "Tipo Retencion"; Option)
        {
            Editable = false;
            OptionMembers = Porcentaje,Importe;
        }
        field(8; "Aplica Productos"; Boolean)
        {
            Editable = false;
        }
        field(9; "Aplica Servicios"; Boolean)
        {
            Editable = false;
        }
        field(10; "Retencion ITBIS"; Boolean)
        {
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

