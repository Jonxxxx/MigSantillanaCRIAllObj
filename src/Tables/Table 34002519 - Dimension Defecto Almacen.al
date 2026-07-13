table 34002519 "Dimension Defecto Almacen"
{

    fields
    {
        field(34002500;"Cod. Almacen";Code[20])
        {
            Caption = 'Location Code';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = Location.Code;
        }
        field(34002501;"Codigo Dimension";Code[20])
        {
            Caption = 'Dimension Code';
            Description = 'DsPOS Standar';
            NotBlank = true;
            TableRelation = Dimension.Code;
        }
        field(34002502;"Valor Dimension";Text[100])
        {
            Caption = 'Dimension Value';
            Description = 'DsPOS Standar';
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=FIELD(Codigo Dimension));
        }
    }

    keys
    {
        key(Key1;"Cod. Almacen","Codigo Dimension")
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

