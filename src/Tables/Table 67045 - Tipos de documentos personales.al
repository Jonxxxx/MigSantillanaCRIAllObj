table 67045 "Tipos de documentos personales"
{
    DrillDownPageID = 67053;
    LookupPageID = 67053;

    fields
    {
        field(1;Codigo;Code[20])
        {
        }
        field(2;Descripcion;Text[100])
        {
        }
        field(3;"Tipo Factura";Option)
        {
            Caption = 'Invoice Type';
            Description = 'Boleta,Factura';
            OptionCaption = 'Ticket,Invoice';
            OptionMembers = Boleta,Factura;
        }
        field(4;"Tax Identification Type";Option)
        {
            Caption = 'Tax Identification Type';
            OptionCaption = 'Legal Entity,Natural Person';
            OptionMembers = "Legal Entity","Natural Person";
        }
    }

    keys
    {
        key(Key1;Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;Codigo,Descripcion)
        {
        }
    }
}

