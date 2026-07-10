table 52503 "Categoria Pedido Venta"
{
    DrillDownPageID = 52506;
    LookupPageID = 52506;

    fields
    {
        field(1;Codigo;Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2;Descripcion;Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3;"Filtrar Cod. Compartir";Boolean)
        {
            Caption = 'Filtrar Cod. Compartir';
            DataClassification = ToBeClassified;
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

