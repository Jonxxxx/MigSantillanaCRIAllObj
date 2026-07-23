table 34002170 "Exemption types"
{
    DataPerCompany = false;
    DrillDownPageID = 34002185;
    LookupPageID = 34002185;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Wedge Code"; Code[10])
        {
            TableRelation = "Conceptos salariales".Codigo;
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Single,Married,Married filling separately';
            OptionMembers = Soltero,Casado,"Casado rinde separado";
        }
        field(5; "Exemption type"; Option)
        {
            Caption = 'Exemption type';
            NotBlank = true;
            OptionCaption = 'None,Half,Complete,Fix';
            OptionMembers = Ninguna,Mitad,Completa,Fijo;

            trigger OnValidate()
            begin
                IF "Exemption type" = 0 THEN
                    "Personal Exemption" := 0;
            end;
        }
        field(6; "Personal Exemption"; Decimal)
        {
            Caption = 'Personal Exemption';
        }
        field(7; Period; Option)
        {
            Caption = 'Period';
            OptionCaption = 'Weekly,Semimonthly,Monthly,Quarterly,Semiannual,Annual,Daily';
            OptionMembers = Semanal,Bisemanal,Quincenal,Mensual,Trimestral,Semestral,Diario;
        }
        field(8; "Exeption for Dependents"; Decimal)
        {
            Caption = 'Exeption for Dependents';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

