table 67111 "Textos Principales"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(3; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
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
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category";
        }
        field(5; "Dim Linea_Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim Linea_Negocio';
            Editable = false;
        }
        field(6; "Dim Ediccion_Coleccion"; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim Ediccion_Coleccion';
            Editable = false;
        }
        field(7; "Product Group Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Group Code';
            Editable = false;
            Enabled = false;
            TableRelation = "Item Category".Code where("Parent Category" = field("Item Category Code"));
        }
        field(8; "Dim Subfamilia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dim Subfamilia';
            Editable = false;
            Enabled = false;
        }
        field(9; "Campana"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
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
        APSSetup: Record 55467;
    begin
        APSSetup.GET();
        APSSetup.TESTFIELD(APSSetup.Campana);
        EVALUATE(Campana, APSSetup.Campana);
    end;
}

