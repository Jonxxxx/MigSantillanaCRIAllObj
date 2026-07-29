table 50006 "Conf. PRISA"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; "Filtro Sueldos y Salarios"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Sueldos y Salarios';
            TableRelation = "Conceptos salariales"."Codigo";
            ValidateTableRelation = false;
        }
        field(3; "Filtro Cargas Sociales"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Cargas Sociales';
            TableRelation = "Conceptos salariales"."Codigo";
            ValidateTableRelation = false;
        }
        field(4; "Filtro Gastos Sociales"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Gastos Sociales';
            TableRelation = "Conceptos salariales"."Codigo";
            ValidateTableRelation = false;
        }
        field(5; "Filtro Indemnizaciones"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Indemnizaciones';
            TableRelation = "Conceptos salariales"."Codigo";
            ValidateTableRelation = false;
        }
        field(6; "Filtro Bonos y Gratificaciones"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Bonos y Gratificaciones';
            TableRelation = "Conceptos salariales"."Codigo";
            ValidateTableRelation = false;
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

