table 55492 "Libros Competencia"
{

    fields
    {
        field(1; "Cod. Editorial"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Editorial';
        }
        field(2; "Cod. Libro"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Libro';
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Nivel; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel';
            NotBlank = true;
            TableRelation = "Nivel Educativo APS";
        }
        field(5; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));

            trigger OnValidate()
            begin
                IF "Cod. Grado" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Grados);
                    DA.SETRANGE(Codigo, "Cod. Grado");
                    DA.FINDFIRST;
                END;
            end;
        }
        field(6; "Grupo de Negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Grupo de Negocio';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));

            trigger OnValidate()
            begin
                IF "Cod. Grado" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Grupo de Negocio");
                    DA.SETRANGE(Codigo, "Grupo de Negocio");
                    DA.FINDFIRST;
                END;
            end;
        }
        field(7; "Cod. Libro Santillana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Libro Santillana';
            TableRelation = Item;
        }
        field(8; "Description Santillana"; Text[100])
        {
            Caption = 'Description Santillana';
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Libro Santillana")));
            FieldClass = FlowField;
        }
        field(9; "Nombre Editorial"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Editorial';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; Precio; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio';
        }
        field(11; "Carga horaria"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Carga horaria';
            TableRelation = "Carga Horaria";
        }
        field(12; "Tipo Ingles"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Ingles';
            OptionCaption = ' ,USA,England';
            OptionMembers = " ",USA,England;
        }
        field(13; "Ano Edicion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano Edicion';
        }
        field(14; "Ano Uso"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano Uso';
        }
    }

    keys
    {
        key(Key1; "Cod. Editorial", "Cod. Libro", Nivel)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        DA: Record 55469;
}

