table 55320 "Provisiones nominas"
{
    Caption = 'Provisiones nominas';

    fields
    {
        field(1; "Cod. Empleado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            TableRelation = Employee;
        }
        field(2; Periodo; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Periodo';
        }
        field(3; "Concepto Salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales";
        }
        field(4; "Importe provisionado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe provisionado';
        }
    }

    keys
    {
        key(Key1; "Cod. Empleado", Periodo, "Concepto Salarial")
        {
        }
    }

    fieldgroups
    {
    }
}

