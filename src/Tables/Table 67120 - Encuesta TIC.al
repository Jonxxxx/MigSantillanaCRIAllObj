table 67120 "Encuesta TIC"
{

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
        }
        field(2; "Cod. Delegacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Delegacion';
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                APSSetup: Record 67000;
                DefDim: Record 352;
                DimVal: Record 349;
                DimForm: Page 560;
            begin
                APSSetup.GET();
                APSSetup.TESTFIELD(APSSetup."Cod. Dimension Delegacion");
                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", APSSetup."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE("Cod. Delegacion", DimVal.Code);
                END;

                CLEAR(DimForm);
            end;

            trigger OnValidate()
            var
                APSSetup: Record 67000;
                DimVal: Record 349;
            begin
                APSSetup.GET();
                APSSetup.TESTFIELD(APSSetup."Cod. Dimension Delegacion");

                IF "Cod. Delegacion" <> '' THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", APSSetup."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, "Cod. Delegacion");
                    DimVal.FINDFIRST;
                    Delegacion := DimVal.Name;
                END;
            end;
        }
        field(3; Delegacion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
            Editable = false;
        }
        field(4; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate()
            var
                Promo: Record 13;
            begin
                Promotor := '';
                IF "Cod. Promotor" <> '' THEN BEGIN
                    Promo.GET("Cod. Promotor");
                    Promotor := Promo.Name;
                END;
            end;
        }
        field(5; Promotor; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Promotor';
            Editable = false;
        }
        field(6; "Campana"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(7; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                Col: Record 5050;
            begin
                Delegacion := '';
                Colegio := '';
                Distrito := '';
                IF "Cod. Colegio" <> '' THEN BEGIN
                    Col.GET("Cod. Colegio");
                    VALIDATE("Cod. Delegacion", Col.Delegacion);
                    Colegio := Col.Name;
                    Distrito := Col.Distritos;
                END
            end;
        }
        field(8; Colegio; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Colegio';
            Editable = false;
        }
        field(9; Distrito; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Distrito';
            Editable = false;
        }
        field(10; "Coordinador TIC"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Coordinador TIC';
        }
        field(11; Correo; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Correo';
        }
        field(12; Celular; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Celular';
        }
        field(13; "Tiene Equipos"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiene Equipos';

            trigger OnValidate()
            begin
                IF NOT "Tiene Equipos" THEN BEGIN
                    Computadora := 0;
                    Portatiles := 0;
                    TV := 0;
                    "Pizarra interactiva" := 0;
                    "Proyectores multimedia" := 0;
                    Otros := '';
                    "Aulas con Equipos" := 0;
                    "Cantidad Aulas con Equipos" := 0;
                END;
            end;
        }
        field(14; Computadora; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Computadora';
        }
        field(15; Portatiles; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Portatiles';
        }
        field(16; TV; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'TV';
        }
        field(17; "Pizarra interactiva"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pizarra interactiva';
        }
        field(18; "Proyectores multimedia"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Proyectores multimedia';
        }
        field(19; Otros; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Otros';
        }
        field(20; "Aulas con Equipos"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Aulas con Equipos';
            OptionCaption = ' ,En todas,En algunas';
            OptionMembers = " ","En todas","En algunas";

            trigger OnValidate()
            begin
                IF "Aulas con Equipos" = 0 THEN
                    "Cantidad Aulas con Equipos" := 0;
            end;
        }
        field(21; "Cantidad Aulas con Equipos"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Aulas con Equipos';

            trigger OnValidate()
            begin
                IF "Cantidad Aulas con Equipos" <> 0 THEN
                    TESTFIELD("Aulas con Equipos");
            end;
        }
        field(22; "Tiene Intranet"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiene Intranet';

            trigger OnValidate()
            begin
                IF NOT "Tiene Intranet" THEN
                    "Uso principal intranet" := 0;
            end;
        }
        field(23; "Uso principal intranet"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Uso principal intranet';
            OptionCaption = ' ,Matricula,Comunicacion con PP.FF.,Agenda,Bancos de recursos didacticos,Banco de datos,Comunicacion con alumnnos,Aula virtual,Otros';
            OptionMembers = " ",Matricula,"Comunicacion con PP.FF.",Agenda,"Bancos de recursos didacticos","Banco de datos","Comunicacion con alumnnos","Aula virtual",Otros;
        }
        field(24; "Tiene Internet"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiene Internet';

            trigger OnValidate()
            begin
                IF NOT "Tiene Internet" THEN BEGIN
                    "En laboratorio" := FALSE;
                    "Cantidad laboratorios" := 0;
                    "Aulas con Internet" := 0;
                    "Cantidad Aulas con Internet" := 0;
                    "Sala Profesores" := FALSE;
                    "Otros zonas" := '';
                END;
            end;
        }
        field(25; "Tiene WIFI"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiene WIFI';
        }
        field(26; "En laboratorio"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'En laboratorio';

            trigger OnValidate()
            begin
                IF NOT "En laboratorio" THEN
                    "Cantidad laboratorios" := 0;
            end;
        }
        field(27; "Cantidad laboratorios"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad laboratorios';

            trigger OnValidate()
            begin
                IF "Cantidad laboratorios" <> 0 THEN
                    TESTFIELD("En laboratorio");
            end;
        }
        field(28; "Aulas con Internet"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Aulas con Internet';
            OptionCaption = ' ,En todas,En algunas';
            OptionMembers = " ","En todas","En algunas";

            trigger OnValidate()
            begin
                IF "Aulas con Internet" = 0 THEN
                    "Cantidad Aulas con Internet" := 0;
            end;
        }
        field(29; "Cantidad Aulas con Internet"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad Aulas con Internet';

            trigger OnValidate()
            begin
                IF "Cantidad Aulas con Internet" <> 0 THEN
                    TESTFIELD("Aulas con Internet");
            end;
        }
        field(30; "Sala Profesores"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sala Profesores';
        }
        field(31; "Otros zonas"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Otros zonas';
        }
        field(32; "PC laboratorio"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PC laboratorio';
        }
        field(33; "PC laboratorio internet"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'PC laboratorio internet';
            OptionCaption = ' ,Todas,Solo una,Ninguna';
            OptionMembers = " ",Todas,"Solo una",Ninguna;
        }
        field(34; "Especificar PC labor. Internet"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Especificar PC labor. Internet';
        }
        field(35; "PC laboratorio2"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PC laboratorio2';
        }
        field(36; "PC laboratorio3"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'PC laboratorio3';
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Encuesta: Record 67120;
        Config: Record 67000;
    begin
        IF Encuesta.FINDLAST THEN
            ID := Encuesta.ID + 1
        ELSE
            ID += 1;

        Config.GET;
        Campana := FORMAT(Config.Campana);
    end;
}

