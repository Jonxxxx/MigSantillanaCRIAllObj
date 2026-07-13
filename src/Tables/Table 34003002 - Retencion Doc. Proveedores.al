table 34003002 "Retencion Doc. Proveedores"
{
    Caption = 'Vendor Document Retention';

    fields
    {
        field(1;"Cód. Proveedor";Code[20])
        {
            TableRelation = Vendor;
        }
        field(2;"Código Retención";Code[20])
        {
            NotBlank = true;
            TableRelation = "Config. Retencion Proveedores";
        }
        field(3;"Cta. Contable";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4;"Base Cálculo";Option)
        {
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5;Devengo;Option)
        {
            OptionMembers = "Facturación",Pago;
        }
        field(6;"Importe Retención";Decimal)
        {
        }
        field(7;"Tipo Retención";Option)
        {
            OptionMembers = Porcentaje,Importe;
        }
        field(8;"Aplica Productos";Boolean)
        {
        }
        field(9;"Aplica Servicios";Boolean)
        {
        }
        field(10;"Retencion ITBIS";Boolean)
        {
        }
        field(11;"Tipo documento";Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(12;"No. documento";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Cód. Proveedor","Código Retención","Tipo documento","No. documento")
        {
        }
        key(Key2;"Cód. Proveedor","Tipo documento","No. documento")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //
    end;
}

