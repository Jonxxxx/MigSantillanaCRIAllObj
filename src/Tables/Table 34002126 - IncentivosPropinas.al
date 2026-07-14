table 34002126 "Incentivos/Propinas"
{

    fields
    {
        field(1; "Concepto Salarial"; Code[10])
        {
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(2; "Fecha de Corte"; Date)
        {
        }
        field(3; "Monto a Distribuir"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(4; "Fecha Ult. Corte"; Date)
        {
        }
        field(5; Delegacion; Code[20])
        {
            TableRelation = "Centros de Trabajo";
        }
    }

    keys
    {
        key(Key1; "Concepto Salarial", "Fecha de Corte")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Incentivo.SETRANGE("Concepto Salarial", "Concepto Salarial");
        IF Incentivo.FINDLAST THEN
            "Fecha Ult. Corte" := xRec."Fecha de Corte";
    end;

    var
        Incentivo: Record 34002126;
}

