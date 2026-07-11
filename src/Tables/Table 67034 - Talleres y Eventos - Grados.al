table 67034 "Talleres y Eventos - Grados"
{
    Caption = 'Branch';
    DrillDownPageID = 67034;
    LookupPageID = 67034;

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;

            trigger OnValidate()
            begin
                /*
                IF "Cod. Colegio" <> '' THEN
                   BEGIN
                    Colegio.GET("Cod. Colegio");
                    "Nombre Colegio" := Colegio.Name;
                    //Busco los Docentes del Colegio
                    ColDocentes.RESET;
                    ColDocentes.SETRANGE("Cod. Colegio","Cod. Colegio");
                    IF ColDocentes.FINDSET THEN
                       REPEAT
                        Docente.GET(ColDocentes."Cod. Docente");
                        IF Docente."Pertenece al CDS" THEN
                           BEGIN
                            CLEAR(ATE);
                            ATE."No. Solicitud"  := "No. Solicitud";
                            ATE.VALIDATE("Tipo Evento","Tipo de Evento");
                            ATE.VALIDATE("Cod. Taller - Evento","Cod. evento");
                            ATE.VALIDATE("Cod. Colegio","Cod. Colegio");
                            ATE.VALIDATE("Cod. Promotor","Cod. promotor");
                            IF "Codigo Expositor" <> '' THEN
                               ATE.VALIDATE("Cod. Expositor","Codigo Expositor");
                            ATE.VALIDATE("Cod. Docente",Docente."No.");
                            IF ATE.INSERT(TRUE) THEN;
                           END;
                       UNTIL ColDocentes.NEXT = 0;
                   END;
                */

            end;
        }
        field(3; "Cod. Local"; Code[20])
        {
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  Cod. Local=FIELD("Cod. Local"));
        }
        field(5;"Cod. Grado";Code[60])
        {
            TableRelation = "Colegio - Grados"."Cod. Grado" WHERE ("Cod. Colegio"=FIELD("Cod. Colegio"),
                                                                   Cod. Local=FIELD("Cod. Local"),
                                                                   Cod. Nivel=FIELD("Cod. Nivel"));
        }
        field(8;"Nombre Colegio";Text[60])
        {
        }
        field(9;"Descripcion Nivel";Text[60])
        {
        }
        field(10;"Descripcion Grado";Text[60])
        {
        }
    }

    keys
    {
        key(Key1;"No. Solicitud","Cod. Colegio","Cod. Local")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text033: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SolEvento: Record 67055;
        Evento: Record 67011;
        APSSetup: Record 67000;
        TipoEvento: Record 67010;
        Colegio: Record 5050;
        Promotor: Record 13;
        Expositor: Record 67021;
        FRBitMap: Record 67032;
        DA: Record 67002;
        Docente: Record 67001;
        ColDocentes: Record 67043;
        ATE: Record 67016;
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit 408;

    procedure DisplayMap()
    var
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
          MapMgt.MakeSelection(DATABASE::Contact,GETPOSITION)
        ELSE MESSAGE(Text033);
    end;
}

