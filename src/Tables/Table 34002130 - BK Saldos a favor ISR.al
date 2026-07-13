table 34002130 "BK Saldos a favor ISR"
{

    fields
    {
        field(1;"Cód. Empleado";Code[20])
        {
            TableRelation = Employee;
        }
        field(2;"Ano.";Integer)
        {
        }
        field(3;"Saldo a favor";Decimal)
        {

            trigger OnValidate()
            begin
                IF "Importe Pendiente" = 0 THEN
                   "Importe Pendiente" := "Saldo a favor";
            end;
        }
        field(4;"Importe Pendiente";Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Cód. Empleado","Ano.")
        {
        }
    }

    fieldgroups
    {
    }
}

