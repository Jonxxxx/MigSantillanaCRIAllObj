table 34003003 "Historico Retencion Prov."
{
    Caption = 'Posted Vendor Rentention';
    //TODO: Ver DrillDownPageID = 34003003;
    //TODO: Ver LookupPageID = 34003003;

    fields
    {
        field(1; "Cód. Proveedor"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(2; "Código Retención"; Code[20])
        {
            TableRelation = "Config. Retencion Proveedores";
        }
        field(3; "Cta. Contable"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Base Cálculo"; Option)
        {
            OptionMembers = ITBIS,"B. Imponible","Total Fra.",Ninguno;
        }
        field(5; Devengo; Option)
        {
            OptionMembers = "Facturación",Pago;
        }
        field(6; "Importe Retención"; Decimal)
        {
        }
        field(7; "Tipo Retención"; Option)
        {
            OptionMembers = Porcentaje,Importe;
        }
        field(8; "Aplica Productos"; Boolean)
        {
        }
        field(9; "Aplica Servicios"; Boolean)
        {
        }
        field(10; "Retencion ITBIS"; Boolean)
        {
        }
        field(11; "Tipo documento"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(12; "No. documento"; Code[20])
        {
        }
        field(13; "Importe Retenido"; Decimal)
        {
            Caption = 'Retained Amount';
        }
        field(14; "Fecha Registro"; Date)
        {
            CalcFormula = Lookup("Vendor Ledger Entry"."Posting Date" WHERE("Document Type" = FIELD("Tipo documento"),
                                                                             "Document No." = FIELD("No. documento")));
            Caption = 'Posting date';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Tipo documento", "No. documento", "Código Retención")
        {
        }
    }

    fieldgroups
    {
    }
}

