table 67060 "Temp Reportes APS"
{
    DrillDownPageID = 67027;
    LookupPageID = 67027;

    fields
    {
        field(10; "No. mov"; Integer)
        {
        }
        field(20; "Cod. Nivel"; Code[20])
        {
            NotBlank = true;
        }
        field(25; "Descripcion nivel"; Text[100])
        {
            CalcFormula = Lookup("Nivel Educativo APS".Descripci n WHERE (C digo=FIELD("Cod. Nivel")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30;"Linea de negocio";Code[20])
        {
        }
        field(40;Familia;Code[20])
        {
        }
        field(50;"Sub Familia";Code[20])
        {
        }
        field(55;"Cod. producto";Code[20])
        {
            Caption = 'C d. producto';
            TableRelation = Item;
        }
        field(56;"Descripcion producto";Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE (No.=FIELD("Cod. Producto")));
            Caption = 'Descripci n producto';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60;"Cdad. presupuestada";Decimal)
        {
            Caption = 'Cantidad presupuestada';
        }
        field(65;"Monto. presupuestado";Decimal)
        {
        }
        field(70;"Cdad. alcance";Decimal)
        {
            Caption = 'Cantidad alcance';
        }
        field(75;"Monto alcance";Decimal)
        {
        }
        field(80;"Cdad. mnto.";Decimal)
        {
            Caption = 'Cantidad mantenimiento';
        }
        field(90;"Cdad. conquista";Decimal)
        {
            Caption = 'Cantidad conquista';
        }
        field(100;"Cdad. perdida";Decimal)
        {
            Caption = 'Cantidad perdida';
        }
        field(110;Usuario;Code[20])
        {
        }
        field(120;"Fecha hora";DateTime)
        {
        }
    }

    keys
    {
        key(Key1;Usuario,"Fecha hora","No. mov")
        {
        }
        key(Key2;Usuario,"Fecha hora","Cod. Nivel","Linea de negocio",Familia,"Sub Familia","Cod. producto")
        {
        }
    }

    fieldgroups
    {
    }

    procedure TraerDescripcionLinNeg(): Text[50]
    var
        recCfgAPS Record: 67000;
        recDimValue Record: 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Lin. Negocio");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Lin. Negocio","Linea de negocio") THEN
          EXIT(recDimValue.Name)
    end;

    procedure TraerDescripcionFamilia(): Text[50]
    var
        recCfgAPS Record: 67000;
        recDimValue Record: 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Familia");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Familia",Familia) THEN
          EXIT(recDimValue.Name)
    end;

    procedure TraerDescripcionSubFamilia(): Text[50]
    var
        recCfgAPS Record: 67000;
        recDimValue Record: 349;
    begin
        recCfgAPS.GET;
        recCfgAPS.TESTFIELD(recCfgAPS."Cod. Dimension Sub Familia");

        IF recDimValue.GET(recCfgAPS."Cod. Dimension Sub Familia","Sub Familia") THEN
          EXIT(recDimValue.Name)
    end;
}

