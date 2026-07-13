table 34002190 "Distribucion ED empleados"
{
    Caption = 'Employee JE distribution';

    fields
    {
        field(1; "Employee no."; Code[20])
        {
            Caption = 'Employee no.';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Concepto salarial"; Code[20])
        {
            Caption = 'Wage Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Conceptos salariales".Código;
        }
        field(3; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(4; Codigo; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
        field(5; Descripcion; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "% a distribuir"; Decimal)
        {
            Caption = '% to distribute';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DistribED: Record 34002190;
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

