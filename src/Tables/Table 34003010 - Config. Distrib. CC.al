table 55965 "Config. Distrib. CC"
{

    fields
    {
        field(1; "Cta. Contable"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cta. Contable';
            TableRelation = "G/L Account";
        }
        field(2; "Descripcion Cta. Contable"; Text[150])
        {
            Caption = 'Descripcion Cta. Contable';
            CalcFormula = Lookup("G/L Account".Name WHERE("No." = FIELD("Cta. Contable")));
            FieldClass = FlowField;
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
                ConfCC: Record 55965;
                "%Total": Decimal;
            begin
                "%Total" := "% a distribuir";
                ConfCC.SETRANGE("Cta. Contable", "Cta. Contable");
                ConfCC.SETFILTER(Codigo, '<>%1', Codigo);
                IF ConfCC.FINDSET THEN
                    REPEAT
                        "%Total" += ConfCC."% a distribuir";
                    UNTIL ConfCC.NEXT = 0;

                IF "%Total" > 100 THEN
                    ERROR(Err001);
            end;
        }
    }

    keys
    {
        key(Key1; "Cta. Contable", Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Err001: Label 'The percent total is higher than 100%';
}

