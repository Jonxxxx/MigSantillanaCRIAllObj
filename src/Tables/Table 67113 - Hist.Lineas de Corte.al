table 67113 "Hist.Lineas de Corte"
{

    fields
    {
        field(1; "Campana"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(2; "Linea Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea Negocio';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));

            trigger OnValidate()
            var
                da: Record 55469;
            begin
            end;
        }
        field(3; Categoria; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
            OptionCaption = ' ,Inicial,Nidos,Primaria,Secundaria';
            OptionMembers = " ",Inicial,Nidos,Primaria,Secundaria;
        }
        field(4; Delegacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';

            trigger OnLookup()
            var
                DimVal: Record 349;
                DimForm: Page 560;
                APSSetup: Record 55467;
            begin
            end;

            trigger OnValidate()
            var
                DimVal: Record 349;
                APSSetup: Record 55467;
            begin
            end;
        }
        field(5; "L1 - Ejemplares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L1 - Ejemplares';
            Editable = false;

            trigger OnValidate()
            begin
                "L1 - Importe" := ROUND("L1 - Ejemplares" * "PVP Unitario");
            end;
        }
        field(6; "L2 - Ejemplares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L2 - Ejemplares';

            trigger OnValidate()
            begin
                "L2 - Importe" := ROUND("L2 - Ejemplares" * "PVP Unitario");
                VALIDATE("L1 - Ejemplares", ROUND("L2 - Ejemplares" / 2, 0.1));
                IF ("L2 - Ejemplares" <> 0) AND ("L4 - Ejemplares" <> 0) THEN
                    VALIDATE("L3 - Ejemplares", ROUND((("L4 - Ejemplares" - "L2 - Ejemplares") / 2) + +"L2 - Ejemplares", 0.1));
            end;
        }
        field(7; "L3 - Ejemplares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L3 - Ejemplares';
            Editable = false;

            trigger OnValidate()
            begin
                "L3 - Importe" := ROUND("L3 - Ejemplares" * "PVP Unitario");
            end;
        }
        field(8; "L4 - Ejemplares"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L4 - Ejemplares';

            trigger OnValidate()
            begin
                "L4 - Importe" := ROUND("L4 - Ejemplares" * "PVP Unitario");
                IF ("L2 - Ejemplares" <> 0) AND ("L4 - Ejemplares" <> 0) THEN
                    VALIDATE("L3 - Ejemplares", ROUND((("L4 - Ejemplares" - "L2 - Ejemplares") / 2) + "L2 - Ejemplares", 0.1));
            end;
        }
        field(9; "PVP Unitario"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PVP Unitario';

            trigger OnValidate()
            begin
                "L1 - Importe" := ROUND("L1 - Ejemplares" * "PVP Unitario");
                "L2 - Importe" := ROUND("L2 - Ejemplares" * "PVP Unitario");
                "L3 - Importe" := ROUND("L3 - Ejemplares" * "PVP Unitario");
                "L4 - Importe" := ROUND("L4 - Ejemplares" * "PVP Unitario");
            end;
        }
        field(10; "L1 - Importe"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L1 - Importe';
            Editable = false;
        }
        field(11; "L2 - Importe"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L2 - Importe';
            Editable = false;
        }
        field(12; "L3 - Importe"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L3 - Importe';
            Editable = false;
        }
        field(13; "L4 - Importe"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'L4 - Importe';
            Editable = false;
        }
        field(14; "Nombre Delegacion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Delegacion';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Campana", "Linea Negocio", Categoria, Delegacion)
        {
        }
        key(Key2; "Campana", "Linea Negocio", Delegacion)
        {
        }
        key(Key3; "Campana", Delegacion, Categoria)
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
    end;
}

