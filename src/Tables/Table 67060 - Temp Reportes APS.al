table 67060 "Temp Reportes APS"
{
    DrillDownPageID = 55494;
    LookupPageID = 55494;

    fields
    {
        field(10; "No. mov"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. mov';
        }
        field(20; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            NotBlank = true;
        }
        field(25; "Descripcion nivel"; Text[100])
        {
            Caption = 'Descripcion nivel';
            CalcFormula = Lookup("Nivel Educativo APS".Descripcion WHERE("Codigo" = FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Linea de negocio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Linea de negocio';
        }
        field(40; Familia; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Familia';
        }
        field(50; "Sub Familia"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub Familia';
        }
        field(55; "Cod. producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. producto';
            TableRelation = Item;
        }
        field(56; "Descripcion producto"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Cod. Producto")));
            Caption = 'Descripcion producto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Cdad. presupuestada"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cdad. presupuestada';
        }
        field(65; "Monto. presupuestado"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto. presupuestado';
        }
        field(70; "Cdad. alcance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cdad. alcance';
        }
        field(75; "Monto alcance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto alcance';
        }
        field(80; "Cdad. mnto."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cdad. mnto.';
        }
        field(90; "Cdad. conquista"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cdad. conquista';
        }
        field(100; "Cdad. perdida"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cdad. perdida';
        }
        field(110; Usuario; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
        field(120; "Fecha hora"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha hora';
        }
    }

    keys
    {
        key(Key1; Usuario, "Fecha hora", "No. mov")
        {
        }
        key(Key2; Usuario, "Fecha hora", "Cod. Nivel", "Linea de negocio", Familia, "Sub Familia", "Cod. producto")
        {
        }
    }

    fieldgroups
    {
    }

    procedure TraerDescripcionLinNeg(): Text[50]
    var
        recCfgAPS: Record 55467;
        recDimValue: Record 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Lin. Negocio");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Lin. Negocio", "Linea de negocio") THEN
            EXIT(recDimValue.Name)
    end;

    procedure TraerDescripcionFamilia(): Text[50]
    var
        recCfgAPS: Record 55467;
        recDimValue: Record 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Familia");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Familia", Familia) THEN
            EXIT(recDimValue.Name)
    end;

    procedure TraerDescripcionSubFamilia(): Text[50]
    var
        recCfgAPS: Record 55467;
        recDimValue: Record 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Sub Familia");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Sub Familia", "Sub Familia") THEN
            EXIT(recDimValue.Name)
    end;
}

