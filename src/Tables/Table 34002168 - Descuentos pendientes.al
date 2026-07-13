table 34002168 "Descuentos pendientes"
{

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            TableRelation = Employee;
        }
        field(2;"Cod. Concepto Salarial";Code[20])
        {
        }
        field(3;"Importe Pendiente";Decimal)
        {
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

