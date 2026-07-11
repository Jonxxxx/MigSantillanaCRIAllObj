table 67044 "Promotor - Rutas"
{
    DrillDownPageID = 67048;
    LookupPageID = 67048;

    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE(Tipo = CONST(Vendedor));
        }
        field(2; "Cod. Ruta"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Rutas));

            trigger OnValidate()
            begin
                IF "Cod. Ruta" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Rutas);
                    DA.SETRANGE(Codigo, "Cod. Ruta");
                    DA.FINDFIRST;
                    "Descripcion Ruta" := DA.Descripcion;
                END;
            end;
        }
        field(3; "Cod. Zona"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Zonas));

            trigger OnValidate()
            begin
                IF "Cod. Zona" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Zonas);
                    DA.SETRANGE(Codigo, "Cod. Zona");
                    DA.FINDFIRST;
                    "Descripcion zona" := DA.Descripcion;
                END;
            end;
        }
        field(4; "Nombre Promotor"; Text[100])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE (Code=FIELD(Cod. Promotor)));
            FieldClass = FlowField;
        }
        field(5;"Descripcion Ruta";Text[100])
        {
        }
        field(6;"Cod. Supervisor";Code[20])
        {
            Caption = 'Superviser code';
            TableRelation = Salesperson/Purchaser.Code WHERE (Tipo=CONST(Supervisor));
        }
        field(7;"Nombre Supervisor";Text[100])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE (Code=FIELD(Cod. Supervisor)));
            FieldClass = FlowField;
        }
        field(8;"Descripcion zona";Text[100])
        {
        }
        field(9;Delegacion;Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN
                   BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE(Delegacion,DimVal.Code);
                   END;

                CLEAR(DimForm);
            end;

            trigger OnValidate()
            begin
                IF Delegacion <> '' THEN
                   BEGIN
                    ConfAPS.GET();
                    ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code",ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type",DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code,Delegacion);
                    DimVal.FINDFIRST;
                    "Descripcion Delegacion" := DimVal.Name;
                   END;
            end;
        }
        field(10;"Descripcion Delegacion";Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Cod. Promotor","Cod. Ruta")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DA: Record 67002;
        ConfAPS: Record 67000;
        DimVal: Record 349;
        DimForm: Page560;
}

