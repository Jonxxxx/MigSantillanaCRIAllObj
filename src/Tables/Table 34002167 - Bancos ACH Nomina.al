table 34002167 "Bancos ACH Nomina"
{
    DataPerCompany = false;
    DrillDownPageID = 34002172;
    LookupPageID = 34002172;

    fields
    {
        field(1; "Cod. Banco"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Banco';
        }
        field(2; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Cod. Institucion Financiera"; Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Institucion Financiera';
        }
        field(4; "ACH Reservas"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ACH Reservas';
        }
        field(5; "Digito Chequeo"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Digito Chequeo';
        }
    }

    keys
    {
        key(Key1; "Cod. Banco")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Banco", Descripcion, "Cod. Institucion Financiera")
        {
        }
    }
}

