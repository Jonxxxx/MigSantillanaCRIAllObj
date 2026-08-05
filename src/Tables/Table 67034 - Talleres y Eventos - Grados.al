table 55501 "Talleres y Eventos - Grados"
{
    Caption = 'Branch';
    DrillDownPageID = 55501;
    LookupPageID = 55501;

    fields
    {
        field(1; "No. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Solicitud';
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
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
            DataClassification = CustomerContent;
            Caption = 'Cod. Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(4; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  "Cod. Local" = FIELD("Cod. Local"));
        }
        field(5; "Cod. Grado"; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            TableRelation = "Colegio - Grados"."Cod. Grado" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                   "Cod. Local" = FIELD("Cod. Local"),
                                                                   "Cod. Nivel" = FIELD("Cod. Nivel"));
        }
        field(8; "Nombre Colegio"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(9; "Descripcion Nivel"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Nivel';
        }
        field(10; "Descripcion Grado"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Grado';
        }
    }

    keys
    {
        key(Key1; "No. Solicitud", "Cod. Colegio", "Cod. Local")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text033: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        SolEvento: Record 55522;
        Evento: Record 55478;
        APSSetup: Record 55467;
        TipoEvento: Record 55477;
        Colegio: Record 5050;
        Promotor: Record 13;
        Expositor: Record 55488;
        FRBitMap: Record 55499;
        DA: Record 55469;
        Docente: Record 55468;
        ColDocentes: Record 55510;
        ATE: Record 55483;

    procedure DisplayMap()
    var
        MapPoint: Record 800;
        MapMgt: Codeunit 802;
    begin
        IF MapPoint.FIND('-') THEN
            MapMgt.MakeSelection(DATABASE::Contact, GETPOSITION)
        ELSE
            MESSAGE(Text033);
    end;
}

