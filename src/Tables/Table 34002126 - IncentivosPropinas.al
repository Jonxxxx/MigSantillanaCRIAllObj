table 55767 "Incentivos/Propinas"
{

    fields
    {
        field(1; "Concepto Salarial"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto Salarial';
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(2; "Fecha de Corte"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de Corte';
        }
        field(3; "Monto a Distribuir"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto a Distribuir';
            DecimalPlaces = 2 : 2;
        }
        field(4; "Fecha Ult. Corte"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Ult. Corte';
        }
        field(5; Delegacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
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
        Incentivo: Record 55767;
}

