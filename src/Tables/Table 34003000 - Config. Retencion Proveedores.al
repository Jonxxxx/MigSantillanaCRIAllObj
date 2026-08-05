table 55955 "Config. Retencion Proveedores"
{
    Caption = 'Setup Vendor Retention';
    DrillDownPageID = 55955;
    LookupPageID = 55955;

    fields
    {
        field(1; "Codigo Retencion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Retencion';
            NotBlank = true;
        }
        field(2; "Descripcion"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Cta. Contable"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contable';
            TableRelation = "G/L Account";
        }
        field(4; "Base Calculo"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Calculo';
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5; Devengo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Devengo';
            OptionMembers = "Facturacion",Pago;
        }
        field(6; "Importe Retencion"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Retencion';
        }
        field(7; "Tipo Retencion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Retencion';
            OptionMembers = Porcentaje,Importe;
        }
        field(8; "Aplica Productos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Productos';
        }
        field(9; "Aplica Servicios"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Aplica Servicios';
        }
        field(10; "Retencion ITBIS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Retencion ITBIS';
        }
        field(55154; "Retencion Defecto Sub-Cont."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Retencion Defecto Sub-Cont.';
        }
        field(55955; "Tipo retencion ISR"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo retencion ISR';
            OptionCaption = ' ,01 - ALQUILERES,02 - HONORARIOS POR SERVICIOS,03 - OTRAS RENTAS,04 - OTRAS RENTAS (Rentas Presuntas),05 - INTERESES PAGADOS A PERSONAS JURIDICAS RESIDENTES,06 - INTERESES PAGADOS A PERSONAS FISICAS RESIDENTES,07 - RETENCION POR PROVEEDORES DEL ESTADO,08 - JUEGOS TELEFONICOS';
            OptionMembers = " ","01 - ALQUILERES","02 - HONORARIOS POR SERVICIOS","03 - OTRAS RENTAS","04 - OTRAS RENTAS (Rentas Presuntas)","05 - INTERESES PAGADOS A PERSONAS JURIDICAS RESIDENTES","06 - INTERESES PAGADOS A PERSONAS FISICAS RESIDENTES","07 - RETENCION POR PROVEEDORES DEL ESTADO","08 - JUEGOS TELEFONICOS";
        }
    }

    keys
    {
        key(Key1; "Codigo Retencion")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo Retencion", "Descripcion", "Base Calculo", "Importe Retencion", "Tipo Retencion")
        {
        }
    }
}

