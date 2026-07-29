table 34002168 "Descuentos pendientes"
{

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
            TableRelation = Employee;
        }
        field(2;"Cod. Concepto Salarial";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Concepto Salarial';
        }
        field(3;"Importe Pendiente";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe Pendiente';
        }
    }

    keys
    {
        key(Key1;"Cod. Empleado","Cod. Concepto Salarial")
        {
        }
    }

    fieldgroups
    {
    }
}

