table 55831 "Distribucion ED empleados"
{
    Caption = 'Employee JE distribution';

    fields
    {
        field(1; "Employee no."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee no.';
            TableRelation = Employee;
        }
        field(2; "Concepto salarial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Concepto salarial';
            NotBlank = true;
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(3; "Dimension Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(4; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
        field(5; Descripcion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(6; "% a distribuir"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% a distribuir';

            trigger OnValidate()
            var
                DistribED: Record 55831;
                "%Total": Decimal;
            begin
                "%Total" := "% a distribuir";
                DistribED.SETRANGE("Employee no.", "Employee no.");
                DistribED.SETRANGE("Concepto salarial", "Concepto salarial");
                DistribED.SETFILTER(Codigo, '<>%1', Codigo);
                IF DistribED.FINDSET THEN
                    REPEAT
                        "%Total" += DistribED."% a distribuir";
                    UNTIL DistribED.NEXT = 0;

                IF "%Total" > 100 THEN
                    ERROR(Err001);
            end;
        }
    }

    keys
    {
        key(Key1; "Employee no.", "Concepto salarial", Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Err001: Label 'The percent total is higher than 100%';
}

