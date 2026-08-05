table 55926 "Datos Auxiliares Venta"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.


    fields
    {
        field(10; "No. Venta"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Venta';
            Description = 'DsPOS Standar';
        }
        field(11; "Nuevo Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nuevo Cliente';
            Description = 'DsPOS Standar';
            TableRelation = Customer;
        }
        field(20; "No. Autorizacion Manual"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Autorizacion Manual';
            Description = 'DsPOS Bolivia';
        }
        field(30; "No. Factura Manual"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Factura Manual';
            Description = 'DsPOS Bolivia';
        }
        field(40; "Fecha Registro"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Registro';
            Description = 'DsPOS Bolivia';
        }
    }

    keys
    {
        key(Key1; "No. Venta")
        {
        }
    }

    fieldgroups
    {
    }
}

