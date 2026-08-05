table 55012 "Productos - Ventas por cliente"
{
    //IGNORAR: Page no existe DrillDownPageID = 55012;
    //IGNORAR: Page no existe LookupPageID = 55012;

    fields
    {
        field(1; "Cod. cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. cliente';
        }
        field(2; "Nombre cliente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre cliente';
        }
        field(3; Producto; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Producto';
        }
        field(4; "Descripcion producto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion producto';
        }
        field(5; "Grupo contable producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo contable producto';
        }
        field(6; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(7; "Ventas brutas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ventas brutas';
        }
        field(8; "Costo de venta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Costo de venta';
        }
        field(9; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(10; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
        }
        field(11; "No. Movimiento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Movimiento';
        }
        field(12; Valor; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Valor';
        }
    }

    keys
    {
        key(Key1; "No. Movimiento")
        {
        }
    }

    fieldgroups
    {
    }
}

