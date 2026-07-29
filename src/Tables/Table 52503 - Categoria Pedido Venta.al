table 52503 "Categoria Pedido Venta"
{
    DrillDownPageID = 52506;
    LookupPageID = 52506;

    fields
    {
        field(1;Codigo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2;Descripcion;Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3;"Filtrar Cod. Compartir";Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filtrar Cod. Compartir';
            Description = 'SANTINAV-2745';
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
    }
}

