table 55909 "Tipos de Tarjeta"
{
    DrillDownPageID = 55910;
    LookupPageID = 55909;

    fields
    {
        field(55894; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            Description = 'DsPOS Standar';
        }
        field(55895; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
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
        rFPago: Record 55907;
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

