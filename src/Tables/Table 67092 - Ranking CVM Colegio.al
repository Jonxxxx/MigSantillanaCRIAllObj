table 67092 "Ranking CVM Colegio"
{
    Caption = 'Estadistica Ranking Colegio';
    DrillDownPageID = 67057;
    LookupPageID = 67057;

    fields
    {
        field(1; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            NotBlank = true;
            TableRelation = Contact WHERE("Type" = CONST(Company));
        }
        field(2; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(3; "CVM GN"; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'CVM GN';
        }
        field(4; INI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'INI';
        }
        field(5; PRI; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'PRI';
        }
        field(6; SEC; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'SEC';
        }
        field(7; "% Compra"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Compra';
        }
    }

    keys
    {
        key(Key1; "Cod. Colegio", "Grupo de Negocio", "CVM GN")
        {
        }
    }

    fieldgroups
    {
    }
}

