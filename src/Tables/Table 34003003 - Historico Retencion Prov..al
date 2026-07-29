table 34003003 "Historico Retencion Prov."
{
    Caption = 'Posted Vendor Rentention';
    DrillDownPageID = 34003003;
    LookupPageID = 34003003;

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
            TableRelation = "Config. Retencion Proveedores";
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
        field(11; "Tipo documento"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(12; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(13; "Importe Retenido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Retenido';
        }
        field(14; "Fecha Registro"; Date)
        {
            Caption = 'Fecha Registro';
            CalcFormula = Lookup("Vendor Ledger Entry"."Posting Date" WHERE("Document Type" = FIELD("Tipo documento"),
                                                                             "Document No." = FIELD("No. documento")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Tipo documento", "No. documento", "Codigo Retencion")
        {
        }
    }

    fieldgroups
    {
    }
}

