table 67038 "Promotor - Planif. Visita"
{
    // $001 02/05/14   JML   A ado la Delegacion del colegio para informes
    //                       Traigo el a o seg n la semana


    fields
    {
        field(1; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));
        }
        field(2; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = "Promotor - Lista de Colegios"."Cod. Colegio" WHERE("Cod. Promotor" = FIELD("Cod. Promotor"));

            trigger OnValidate()
            begin
                BuscaCabecera;
                CabPlanif.TESTFIELD(Semana);
                Semana := CabPlanif.Semana;
                IF "Cod. Colegio" <> '' THEN BEGIN
                    Col.GET("Cod. Colegio");
                    "Nombre Colegio" := Col.Name;
                    Delegacion := Col.Delegacion;   //$001
                END;
            end;
        }
        field(3; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(4; "Nombre Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(5; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ' ,Planned,Completed';
            OptionMembers = " ",Planificado,Completado;

            trigger OnValidate()
            begin


                IF Estado = Estado::Completado THEN BEGIN
                    TESTFIELD("Fecha Proxima Visita");
                    TESTFIELD("Estado Colegio");
                END;


                /*
                Fecha1.RESET;
                Fecha1.SETRANGE("Period Type", 0);
                Fecha1.SETRANGE("Period Start", "Fecha Proxima Visita");
                Fecha1.FINDFIRST;

                Fecha2.RESET;
                Fecha2.SETRANGE("Period Type", 1);
                Fecha2.SETRANGE("Period Start", CALCDATE('-' + FORMAT(Fecha1."Period No." - 1) + 'D', Fecha1."Period Start"));
                Fecha2.FINDFIRST;
                */

                CLEAR(CabPlanif);
                CabPlanif.VALIDATE("Cod. Promotor", "Cod. Promotor");
                CabPlanif.VALIDATE(Fecha, Fecha2."Period Start");
                CabPlanif.VALIDATE(Ano, DATE2DMY("Fecha Proxima Visita", 3));
                CabPlanif.VALIDATE(Semana, Fecha2."Period No.");
                IF CabPlanif.INSERT(TRUE) THEN;

                CLEAR(PromPlanVisit);
                PromPlanVisit.VALIDATE("Cod. Promotor", "Cod. Promotor");
                PromPlanVisit.Ano := CabPlanif.Ano;
                PromPlanVisit.Semana := CabPlanif.Semana;
                PromPlanVisit.Fecha := CabPlanif.Fecha;
                PromPlanVisit.VALIDATE("Cod. Colegio", "Cod. Colegio");
                PromPlanVisit.VALIDATE("Fecha Visita", "Fecha Proxima Visita");
                PromPlanVisit.INSERT(TRUE);
            end;
        }
        field(6; "Fecha Visita"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Visita';

            trigger OnValidate()
            var
                recFechas: Record 2000000007;
            begin

                BuscaCabecera;
                IF ("Fecha Visita" < CabPlanif."Fecha Inicial") OR
                   ("Fecha Visita" > CabPlanif."Fecha Final") THEN
                    ERROR(Err001, "Fecha Visita", CabPlanif.Semana);

                //$001 - Busca en la tabla fechas para evitar que la primera semana del a o aparezca como el a o anterior
                recFechas.RESET;
                recFechas.SETRANGE("Period Type", recFechas."Period Type"::Week);
                recFechas.SETFILTER("Period Start", '<=%1', "Fecha Visita");
                //recFechas.SETFILTER("Period End", '>=%1', "Fecha Visita");
                //recFechas.SETRANGE("Period No.", Semana);
                //IF recFechas.FINDFIRST THEN
                IF recFechas.FINDLAST THEN
                    Ano := DATE2DMY(recFechas."Period End", 3);
                //$001
            end;
        }
        field(7; "Hora Inicial Visita"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicial Visita';
        }
        field(8; "Hora Final Visita"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final Visita';
        }
        field(9; "Fecha Proxima Visita"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Proxima Visita';
        }
        field(10; Comentario; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Comentario';
        }
        field(11; "Nombre Promotor"; Text[60])
        {
            Caption = 'Nombre Promotor';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE("Code" = FIELD("Cod. Promotor")));
            FieldClass = FlowField;
        }
        field(12; Ano; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ano';
            Editable = false;
        }
        field(13; Semana; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Semana';
        }
        field(14; "Local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local';
            TableRelation = "Contact Alt. Address".Code WHERE("Contact No." = FIELD("Cod. Colegio"));
        }
        field(15; Turno; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Turno';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Turnos));
        }
        field(16; Nivel; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Nivel';
            TableRelation = "Nivel Educativo APS";
        }
        field(17; "Persona atendio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Persona atendio';
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"));

            trigger OnValidate()
            begin
                PersCol.RESET;
                PersCol.SETRANGE("Cod. Colegio", "Cod. Colegio");
                PersCol.SETRANGE("Cod. Docente", "Persona atendio");
                PersCol.FINDFIRST;
                "Nombre persona atendio" := PersCol."Nombre docente";
                Cargo := PersCol."Cod. Cargo";
                "Descripcion Cargo" := PersCol."Descripcion Cargo";

                Docente.GET("Persona atendio");
                IF NOT Docente."Pertenece al CDS" THEN
                    Tipo := 1;
            end;
        }
        field(18; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = ' ,CDS,Other';
            OptionMembers = " ",CDS,Otro;
        }
        field(19; Cargo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cargo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnValidate()
            begin
                IF Cargo <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, Cargo);
                    DA.FINDFIRST;

                    "Descripcion Cargo" := DA.Descripcion;
                END
            end;
        }
        field(20; "Nombre persona atendio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre persona atendio';
        }
        field(21; "Descripcion Cargo"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Cargo';
        }
        field(22; Tarea; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tarea';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Tareas));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Tareas);
                DA.SETRANGE(Codigo, Tarea);
                DA.FINDFIRST;
                "Descripcion Tarea" := DA.Descripcion;
            end;
        }
        field(23; "Descripcion Tarea"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Tarea';
        }
        field(24; Objetivo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Objetivo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Objetivos));

            trigger OnValidate()
            begin
                DA.RESET;
                DA.SETRANGE("Tipo registro", DA."Tipo registro"::Objetivos);
                DA.SETRANGE(Codigo, Objetivo);
                DA.FINDFIRST;
                "Descripcion Objetivo" := DA.Descripcion;
            end;
        }
        field(25; "Descripcion Objetivo"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Objetivo';
        }
        field(26; Delegacion; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delegacion';
        }
        field(27; Calificacion; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Calificacion';
            OptionCaption = ' ,Done,Not Done';
            OptionMembers = " ","Se Cumplio","No se Cumplio";
        }
        field(28; "Estado Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Colegio';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Estado Colegio"));
        }
    }

    keys
    {
        key(Key1; "Cod. Promotor", "Cod. Colegio", Semana, "Fecha Visita")
        {
        }
        key(Key2; "Cod. Promotor", "Cod. Colegio", Fecha)
        {
        }
        key(Key3; Delegacion, Nivel, "Cod. Promotor", Ano, Semana, "Fecha Visita")
        {
        }
        key(Key4; Fecha)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Estado > 1 THEN
            ERROR(Err002);
    end;

    trigger OnInsert()
    begin
        Fecha := TODAY;
        Ano := DATE2DMY(TODAY, 3);
    end;

    var
        Col: Record 5050;
        CabPlanif: Record 67023;
        Err001: Label 'The date %1 is out of range allowed for the week %2';
        PersCol: Record 67043;
        DA: Record 55469;
        Docente: Record 55468;
        Err002: Label 'You can''t delete lines with School with completed dates';
        Fecha1: Record 2000000007;
        Fecha2: Record 2000000007;
        PromPlanVisit: Record 67038;

    procedure BuscaCabecera()
    begin
        CabPlanif.GET("Cod. Promotor", Ano, Semana);
    end;
}

