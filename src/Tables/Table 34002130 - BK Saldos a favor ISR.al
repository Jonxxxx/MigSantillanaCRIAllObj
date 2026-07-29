table 34002130 "BK Saldos a favor ISR"
{

    fields
    {
        field(1; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            TableRelation = Employee;
        }
        field(2; "Ano."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano.';
        }
        field(3; "Saldo a favor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Saldo a favor';

            trigger OnValidate()
            begin
                IF "Importe Pendiente" = 0 THEN
                    "Importe Pendiente" := "Saldo a favor";
            end;
        }
        field(4; "Importe Pendiente"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Cod. Empleado", "Ano.")
        {
        }
    }

    fieldgroups
    {
    }
}

