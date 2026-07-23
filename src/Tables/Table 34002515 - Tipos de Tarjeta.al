table 34002515 "Tipos de Tarjeta"
{
    DrillDownPageID = 34002516;
    //TODO: Ver LookupPageID = 34002515;

    fields
    {
        field(34002500; Codigo; Code[10])
        {
            Description = 'DsPOS Standar';
        }
        field(34002501; Descripcion; Text[30])
        {
            Description = 'DsPOS Standar';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, Descripcion)
        {
        }
    }

    trigger OnDelete()
    var
        rFPago: Record 34002513;
    begin

        rFPago.RESET;
        rFPago.SETCURRENTKEY("Tipo Tarjeta");
        rFPago.SETRANGE("Tipo Tarjeta", Codigo);
        IF rFPago.FINDSET THEN
            ERROR(Error001, rFPago."ID Pago");
    end;

    var
        Error001: Label 'El Tipo de Tarjeta que intenta borrar esta definido para la forma de pago %1';
}

