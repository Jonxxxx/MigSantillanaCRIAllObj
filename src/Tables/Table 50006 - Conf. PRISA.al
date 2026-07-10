table 50006 "Conf. PRISA"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Filtro Sueldos y Salarios"; Text[250])
        {
            //TODO: Ver TableRelation = "Conceptos salariales".C digo;
            //ValidateTableRelation = false;
        }
        field(3; "Filtro Cargas Sociales"; Text[250])
        {
            //TODO: Ver TableRelation = "Conceptos salariales".C digo;
            //ValidateTableRelation = false;
        }
        field(4; "Filtro Gastos Sociales"; Text[250])
        {
            //TODO: Ver TableRelation = "Conceptos salariales".C digo;
            //ValidateTableRelation = false;
        }
        field(5; "Filtro Indemnizaciones"; Text[250])
        {
            //TODO: Ver TableRelation = "Conceptos salariales".C digo;
            //ValidateTableRelation = false;
        }
        field(6; "Filtro Bonos y Gratificaciones"; Text[250])
        {
            //TODO: Ver TableRelation = "Conceptos salariales".C digo;
            //ValidateTableRelation = false;
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

