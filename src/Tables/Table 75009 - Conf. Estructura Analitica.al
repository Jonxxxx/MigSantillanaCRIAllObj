table 75009 "Conf. Estructura Analitica"
{
    // El objetivo de esta tabla es poder realizar una serie de configuraci n de valores a partir de la tabla Estructura Analitica


    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(10; Codigo; Code[21])
        {
            Caption = 'Codigo';
            TableRelation = "Estructura Analitica";
        }
        field(11; Nivel; Integer)
        {
            CalcFormula = Lookup("Estructura Analitica".Nivel WHERE("Codigo" = FIELD("Codigo")));
            Caption = 'Nivel';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Descripcion; Text[100])
        {
            CalcFormula = Lookup("Estructura Analitica".Descripcion WHERE("Codigo" = FIELD("Codigo")));
            Caption = 'Descripcion';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Id Field"; Integer)
        {
            BlankZero = true;
            Caption = 'Campo';
            TableRelation = "Filtro Campo Buffer"."Field No" WHERE("Table Id" = CONST(27),
                                                                    "Field No" = FILTER(56022));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Id Field" <> 0 THEN BEGIN
                    // De momento limitados los ids de campos
                    IF NOT ("Id Field" IN [56022]) THEN
                        ERROR(Text001, "Id Field");
                END;
                pFiltrCmp.TestCampo(27, "Id Field");
                Valor := '';
            end;
        }
        field(101; FieldName; Text[30])
        {
            CalcFormula = Lookup(Field."Field Caption" WHERE("TableNo" = CONST(27),
                                                              "No." = FIELD("Id Field")));
            Caption = 'Nombre Campo';
            Editable = false;
            FieldClass = FlowField;
        }
        field(110; Valor; Text[30])
        {
            TableRelation = "Filtro Valor Campo Buffer".Value WHERE("Table Id" = CONST(27),
                                                                     "Field No" = FIELD("Id Field"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CompDupl;
    end;

    trigger OnModify()
    begin
        CompDupl;
    end;

    var
        pFiltrCmp: Page 75014;
        Text001: Label 'El campo %1 No est  permitido';
        Text002: Label 'Ya existe el registro';

    procedure CompDupl()
    var
        lrConfAn: Record 75009;
    begin
        // CompDupl
        // Comprueba Duplicidad

        CLEAR(lrConfAn);
        lrConfAn.SETRANGE(Codigo, Codigo);
        lrConfAn.SETRANGE("Id Field", "Id Field");
        lrConfAn.SETFILTER(Id, '<>%1', Id);
        IF lrConfAn.FINDFIRST THEN
            ERROR(Text002);
    end;
}

