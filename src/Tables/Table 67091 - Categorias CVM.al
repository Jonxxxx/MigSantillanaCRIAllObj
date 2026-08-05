table 55550 "Categorias CVM"
{

    fields
    {
        field(1; "Campana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
            Editable = false;
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            Editable = false;
        }
        field(3; "Grupo Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo Negocio';
            Editable = false;
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            Editable = false;
        }
        field(5; Categoria; Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
        }
        field(6; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
            Editable = false;
        }
        field(7; "Cod. Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Delegacion';
        }
    }

    keys
    {
        key(Key1; "Campana", "Cod. Colegio", "Grupo Negocio", "Cod. Nivel")
        {
        }
    }

    fieldgroups
    {
    }
}

