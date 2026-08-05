table 55913 "Dimension Defecto Almacen"
{

    fields
    {
        field(55894; "Cod. Almacen"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Almacen';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = Location.Code;
        }
        field(55895; "Codigo Dimension"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Dimension';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(55896; "Valor Dimension"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Valor Dimension';
            Description = 'DsPOS Standar';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Codigo Dimension"));
        }
    }

    keys
    {
        key(Key1; "Cod. Almacen", "Codigo Dimension")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Cod. Almacen");
    end;
}

