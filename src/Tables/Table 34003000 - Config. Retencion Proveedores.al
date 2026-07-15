table 34003000 "Config. Retencion Proveedores"
{
    Caption = 'Setup Vendor Retention';
    //TODO: Ver DrillDownPageID = 34003000;
    //TODO: Ver LookupPageID = 34003000;

    fields
    {
        field(1; "Codigo Retencion"; Code[20])
        {
            Caption = 'Retention Code';
            NotBlank = true;
        }
        field(2; "Descripcion"; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Cta. Contable"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(4; "Base Cálculo"; Option)
        {
            Caption = 'Base';
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5; Devengo; Option)
        {
            Caption = 'Accrual';
            OptionMembers = "Facturacion",Pago;
        }
        field(6; "Importe Retencion"; Decimal)
        {
            Caption = 'Retention Amount';
        }
        field(7; "Tipo Retencion"; Option)
        {
            Caption = 'Retention Type';
            OptionMembers = Porcentaje,Importe;
        }
        field(8; "Aplica Productos"; Boolean)
        {
            Caption = 'Apply Items';
        }
        field(9; "Aplica Servicios"; Boolean)
        {
            Caption = 'Apply Service';
        }
        field(10; "Retencion ITBIS"; Boolean)
        {
            Caption = 'ITBIS Retention';
        }
        field(50200; "Retencion Defecto Sub-Cont."; Boolean)
        {
            Caption = 'Sub-Contract Default Retention';
        }
        field(34003000; "Tipo retencion ISR"; Option)
        {
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
        fieldgroup(DropDown; "Codigo Retencion", "Descripcion", "Base Cálculo", "Importe Retencion", "Tipo Retencion")
        {
        }
    }
}

