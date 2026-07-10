table 56100 "Provisiones nominas"
{
    Caption = 'Provisiones nominas';

    fields
    {
        field(1;"Cod. Empleado";Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2;Periodo;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Concepto Salarial";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Conceptos salariales";
        }
        field(4;"Importe provisionado";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Cod. Empleado",Periodo,"Concepto Salarial")
        {
        }
    }

    fieldgroups
    {
    }
}

