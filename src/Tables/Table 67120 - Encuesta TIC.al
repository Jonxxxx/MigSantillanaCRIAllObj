table 67120 "Encuesta TIC"
{

    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; "Cod. Delegacion"; Code[20])
        {
            TableRelation = "Dimension Value".Code;

            trigger OnLookup()
            var
                APSSetup: Record 67000;
                DefDim: Record 352;
                DimVal: Record 349;
                DimForm: Page560;
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
            Editable = false;
        }
        field(4; "Cod. Promotor"; Code[20])
        {
            TableRelation = Salesperson/Purchaser.Code;

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
        field(5;Promotor;Text[100])
        {
            Editable = false;
        }
        field(6;"Campa a";Code[10])
        {
        }
        field(7;"Cod. Colegio";Code[20])
        {
            TableRelation = Contact."No.";

            trigger OnValidate()
            var
                Col: Record 5050;
            begin
                Delegacion       := '';
                Colegio  := '';
                Distrito := '';
                IF "Cod. Colegio" <> '' THEN BEGIN
                  Col.GET("Cod. Colegio");
                  VALIDATE("Cod. Delegacion",Col.Delegacion);
                  Colegio  := Col.Name;
                  Distrito := Col.Distritos;
                END
            end;
        }
        field(8;Colegio;Text[100])
        {
            Editable = false;
        }
        field(9;Distrito;Text[30])
        {
            Editable = false;
        }
        field(10;"Coordinador TIC";Text[50])
        {
        }
        field(11;Correo;Text[30])
        {
        }
        field(12;Celular;Text[30])
        {
        }
        field(13;"Tiene Equipos";Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT "Tiene Equipos" THEN BEGIN
                  Computadora                  := 0;
                  Portatiles                   := 0;
                  TV                           := 0;
                  "Pizarra interactiva"        := 0;
                  "Proyectores multimedia"     := 0;
                  Otros                        := '';
                  "Aulas con Equipos"          := 0;
                  "Cantidad Aulas con Equipos" := 0;
                END;
            end;
        }
        field(14;Computadora;Integer)
        {
        }
        field(15;Portatiles;Integer)
        {
        }
        field(16;TV;Integer)
        {
        }
        field(17;"Pizarra interactiva";Integer)
        {
        }
        field(18;"Proyectores multimedia";Integer)
        {
        }
        field(19;Otros;Text[100])
        {
        }
        field(20;"Aulas con Equipos";Option)
        {
            OptionCaption = ' ,En todas,En algunas';
            OptionMembers = " ","En todas","En algunas";

            trigger OnValidate()
            begin
                IF "Aulas con Equipos" = 0 THEN
                  "Cantidad Aulas con Equipos" := 0;
            end;
        }
        field(21;"Cantidad Aulas con Equipos";Integer)
        {

            trigger OnValidate()
            begin
                IF "Cantidad Aulas con Equipos" <> 0 THEN
                  TESTFIELD("Aulas con Equipos");
            end;
        }
        field(22;"Tiene Intranet";Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT "Tiene Intranet" THEN
                  "Uso principal intranet"   := 0;
            end;
        }
        field(23;"Uso principal intranet";Option)
        {
            OptionCaption = ' ,Matricula,Comunicacion con PP.FF.,Agenda,Bancos de recursos didacticos,Banco de datos,Comunicacion con alumnnos,Aula virtual,Otros';
            OptionMembers = " ",Matricula,"Comunicacion con PP.FF.",Agenda,"Bancos de recursos didacticos","Banco de datos","Comunicacion con alumnnos","Aula virtual",Otros;
        }
        field(24;"Tiene Internet";Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT "Tiene Internet" THEN BEGIN
                  "En laboratorio"              := FALSE;
                  "Cantidad laboratorios"       := 0;
                  "Aulas con Internet"          := 0;
                  "Cantidad Aulas con Internet"  := 0;
                  "Sala Profesores"             := FALSE;
                  "Otros zonas"               := '';
                END;
            end;
        }
        field(25;"Tiene WIFI";Boolean)
        {
        }
        field(26;"En laboratorio";Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT "En laboratorio" THEN
                  "Cantidad laboratorios" := 0;
            end;
        }
        field(27;"Cantidad laboratorios";Integer)
        {

            trigger OnValidate()
            begin
                IF "Cantidad laboratorios" <> 0 THEN
                  TESTFIELD("En laboratorio");
            end;
        }
        field(28;"Aulas con Internet";Option)
        {
            OptionCaption = ' ,En todas,En algunas';
            OptionMembers = " ","En todas","En algunas";

            trigger OnValidate()
            begin
                IF "Aulas con Internet" = 0 THEN
                  "Cantidad Aulas con Internet" := 0;
            end;
        }
        field(29;"Cantidad Aulas con Internet";Integer)
        {

            trigger OnValidate()
            begin
                IF "Cantidad Aulas con Internet" <> 0 THEN
                  TESTFIELD("Aulas con Internet");
            end;
        }
        field(30;"Sala Profesores";Boolean)
        {
        }
        field(31;"Otros zonas";Text[100])
        {
        }
        field(32;"PC laboratorio";Integer)
        {
        }
        field(33;"PC laboratorio internet";Option)
        {
            OptionCaption = ' ,Todas,Solo una,Ninguna';
            OptionMembers = " ",Todas,"Solo una",Ninguna;
        }
        field(34;"Especificar PC labor. Internet";Integer)
        {
        }
        field(35;"PC laboratorio2"; Integer)
        {
        }
        field(36;"PC laboratorio3"; Integer)
        {
        }
    }

    keys
    {
        key(Key1;ID)
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
        Campa a := FORMAT(Config.Campana);
    end;
}

