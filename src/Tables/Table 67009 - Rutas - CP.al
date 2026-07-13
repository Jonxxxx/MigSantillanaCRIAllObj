table 67009 "Rutas - CP"
{
    DrillDownPageID = 67009;
    LookupPageID = 67009;

    fields
    {
        field(1; "Cod. Ruta"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Rutas));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Rutas);
                DA.SETRANGE(Codigo, "Cod. Ruta");
                DA.FINDFIRST;

                "Name of route" := DA.Descripcion;
            end;
        }
        field(3; Description; Text[100])
        {
            Editable = false;
            Enabled = false;
        }
        field(4; "Name of route"; Text[100])
        {
            Caption = 'Name of Route';
        }
        field(5; "Cod. Dim. Delegacion"; Code[20])
        {
            Enabled = false;

            trigger OnValidate()
            var
                PostCode: Record 225;
            begin
            end;
        }
        field(6; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            Enabled = false;
            TableRelation = Territory;

            trigger OnValidate()
            var
                Territory: Record 286;
            begin
            end;
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                "Country/Region": Record 9;
            begin
            end;
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(10; County; Text[30])
        {
            Caption = 'State';
        }
    }

    keys
    {
        key(Key1; "Cod. Ruta", "Post Code")
        {
        }
        key(Key2; "Post Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cod. Ruta", "Name of route")
        {
        }
    }

    trigger OnInsert()
    begin
        /*ConfAPS.GET();
        ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");
        DimVal."Dimension Code" := ConfAPS."Cod. Dimension Delegacion";
        */

    end;

    var
        DA: Record 67002;
        PostCodeRec: Record 225;
        Colegio: Record 5050;
        PromRutas: Record 67044;
        PLC: Record 67006;
        Rutas: Page 67008;
        ConfAPS: Record 67000;
        DimVal: Record 349;
        DimForm: Page "Dimension Value List";
        PostCodeForm: Page 367;
        formTerritory: Page 429;
        RECcOUNTRY: Record 9;
        territory: Record 286;
        PostCode: Record 225;

    procedure AsignarColegios()
    begin
        //Asigno los Colegios que pertenecen al Codigo Postal
        Colegio.RESET;
        Colegio.SETCURRENTKEY("Post Code");
        Colegio.SETRANGE("Post Code", "Post Code");
        IF Colegio.FINDSET THEN
            REPEAT
                PromRutas.RESET;
                PromRutas.SETRANGE("Cod. Ruta", "Cod. Ruta");
                IF PromRutas.FINDSET THEN
                    REPEAT
                        PLC.INIT;
                        PLC.VALIDATE("Cod. Promotor", PromRutas."Cod. Promotor");
                        PLC.VALIDATE("Cod. Ruta", "Cod. Ruta");
                        PLC.VALIDATE("Cod. Colegio", Colegio."No.");
                        IF PLC.INSERT(TRUE) THEN;
                    UNTIL PromRutas.NEXT = 0;
            UNTIL Colegio.NEXT = 0;
    end;
}

