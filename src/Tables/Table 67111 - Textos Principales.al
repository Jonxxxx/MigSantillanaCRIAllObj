table 67111 "Textos Principales"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(3; "Grupo de Negocio"; Code[20])
        {
            Editable = false;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));

            trigger OnLookup()
            var
                GpoNegocio: Page 67093;
            begin
            end;
        }
        field(4; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category";
        }
        field(5; "Dim Linea_Negocio"; Code[20])
        {
            Editable = false;
        }
        field(6; "Dim Ediccion_Coleccion"; Text[70])
        {
            Editable = false;
        }
        field(7; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Editable = false;
            Enabled = false;
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(8; "Dim Subfamilia"; Code[20])
        {
            Editable = false;
            Enabled = false;
        }
        field(9; "Campa a"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        APSSetup: Record 67000;
    begin
        APSSetup.GET();
        APSSetup.TESTFIELD(APSSetup.Campana);
        EVALUATE(Campa a, APSSetup.Campana);
    end;
}

