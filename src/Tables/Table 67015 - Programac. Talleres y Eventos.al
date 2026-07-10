table 67015 "Programac. Talleres y Eventos"
{
    // 0009 CAT Se modifica el campo Horas dictadas por Horas Pedag gicas

    DrillDownPageID = 67015;
    LookupPageID = 67015;

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
            TableRelation = Eventos."No.";

            trigger OnValidate()
            begin
                TyE.SETRANGE("No.", "Cod. Taller - Evento");
                TyE.FINDFIRST;
                VALIDATE("Tipo Evento", TyE."Tipo de Evento");
                //"Fecha de realizacion" := TyE."Horas programadas";
                //"Horas programadas":= TyE."Fecha invitacion";
            end;
        }
        field(2; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact WHERE(Type = CONST(Company));

            trigger OnValidate()
            begin
                IF Col.GET("Cod. Colegio") THEN
                    "Nombre Colegio" := Col.Name;
            end;
        }
        field(4; "Cod. Promotor"; Code[20])
        {
            TableRelation = Salesperson/Purchaser WHERE (Tipo=CONST(Vendedor));

            trigger OnValidate()
            begin
                IF "Cod. Promotor" <> '' THEN
                   BEGIN
                    Prom.GET("Cod. Promotor");
                    "Nombre Promotor":= Prom.Name;
                   END;
            end;
        }
        field(5;"Description Tipo evento";Text[100])
        {
            CalcFormula = Lookup("Tipos de Eventos".Descripcion WHERE (Codigo=FIELD(Tipo Evento)));
            FieldClass = FlowField;
        }
        field(6;"Description Taller";Text[100])
        {
        }
        field(7;"Nombre Colegio";Text[60])
        {
        }
        field(8;"Nombre Promotor";Text[60])
        {
        }
        field(9;"Tipo de Expositor";Option)
        {
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(10;Expositor;Code[20])
        {
            TableRelation = IF (Tipo de Expositor=CONST(Docente)) Docentes WHERE (Expositor=CONST(true))
                            ELSE IF (Tipo de Expositor=CONST(Proveedor)) Vendor;
        }
        field(11;"Nombre Expositor";Text[60])
        {
        }
        field(12;Avisado;Boolean)
        {
        }
        field(13;"Fecha inscripcion";Date)
        {
            Editable = false;
        }
        field(14;"Fecha programacion";Date)
        {
        }
        field(15;"Fecha de realizacion";Date)
        {

            trigger OnValidate()
            var
                Err001: Label 'La fecha de realizaci n no puede ser menor que la fecha de programaci n.';
            begin
                IF "Fecha programacion" <> 0D THEN
                  IF "Fecha de realizacion" < "Fecha programacion" THEN
                     ERROR(Err001);
            end;
        }
        field(16;"Asistentes esperados";Integer)
        {
            Caption = 'Expected Attendees';
        }
        field(17;"Nro. De asistentes reales";Integer)
        {
            Caption = 'Real Attendees';
            Editable = true;
            FieldClass = Normal;
        }
        field(18;"Horas dictadas";Decimal)
        {

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 60000 * 60);
                "Horas Pedag gicas" := ROUND("Horas dictadas" * 60 / 40,1);
            end;
        }
        field(19;"Horas Pedag gicas";Decimal)
        {
            Editable = false;
        }
        field(20;Observacion;Text[150])
        {
        }
        field(21;"Fecha Solicitud";Date)
        {
        }
        field(22;Objetivo;Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE (Tipo registro=CONST(Objetivos));
        }
        field(23;"Descripcion observacion";Text[100])
        {
        }
        field(24;Secuencia;Integer)
        {
        }
        field(25;Estado;Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Done,Cancelled';
            OptionMembers = " ",Realizado,Anulado;

            trigger OnValidate()
            begin
                CabPEvento.GET("Cod. Taller - Evento",Expositor,Secuencia);
                IF (CabPEvento.Estado <> Estado) AND (CabPEvento.Estado > 0) THEN
                   ERROR(STRSUBSTNO(Err001,FIELDCAPTION(Estado)));
            end;
        }
        field(26;"Hora de Inicio";Time)
        {
            Caption = 'Starting date';

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 60000 * 60);
                Horas;
            end;
        }
        field(27;"Hora Final";Time)
        {

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(28;"No. Linea";Integer)
        {
        }
        field(29;"Fecha propuesta";Date)
        {
        }
        field(30;"Hora Inicio Propuesta";Time)
        {
            Editable = false;
        }
        field(31;"Hora Fin Propuesta";Time)
        {
            Editable = false;
        }
        field(32;"Cod. Grado";Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE (Tipo registro=CONST(Grados));
        }
    }

    keys
    {
        key(Key1;"Cod. Taller - Evento","Tipo Evento","Tipo de Expositor",Expositor,Secuencia,"No. Linea")
        {
        }
        key(Key2;"Cod. Colegio","Fecha inscripcion")
        {
        }
        key(Key3;"Fecha programacion","Cod. Colegio","Hora de Inicio")
        {
        }
        key(Key4;Expositor,"Fecha programacion")
        {
        }
        key(Key5;"Fecha programacion","Nombre Colegio","Hora de Inicio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec Record: 67015;
        rAsist Record: 67016;
        rAsist2Record 67016;
    begin
        "Fecha inscripcion" := TODAY;
        "Fecha Solicitud"   := TODAY;

        rRec.SETRANGE(rRec."Cod. Taller - Evento","Cod. Taller - Evento");
        rRec.SETRANGE(rRec."Tipo Evento","Tipo Evento");
        rRec.SETRANGE(rRec."Tipo de Expositor","Tipo de Expositor");
        rRec.SETRANGE(rRec.Expositor,Expositor);
        rRec.SETRANGE(rRec.Secuencia,Secuencia);
        IF rRec.FINDLAST THEN
          "No. Linea" := rRec."No. Linea" + 1
        ELSE
         "No. Linea" := 1;


        CabPEvento.RESET;
        CabPEvento.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
        CabPEvento.SETRANGE(Expositor,Expositor);
        IF CabPEvento.FINDLAST THEN
           "Description Taller" := CabPEvento."Description Taller";


        IF "No. Linea" > 1 THEN BEGIN
          //Si la anterior programacion ya tiene asistentes inscritos, los incluimos en la programacion actual
          //Solo ocurrir  cuando se a ade una programaci n y ya se inscribieron a los asistentes.
          rAsist.SETRANGE(rAsist."Cod. Taller - Evento", rRec."Cod. Taller - Evento");
          rAsist.SETRANGE(rAsist."Cod. Expositor", rRec.Expositor);
          rAsist.SETRANGE(rAsist.Secuencia,  rRec.Secuencia);
          rAsist.SETRANGE(rAsist."Tipo de Expositor",  rRec."Tipo de Expositor");
          rAsist.SETRANGE(rAsist."Tipo Evento",    rRec."Tipo Evento");
          rAsist.SETRANGE("No Linea Programac.", rRec."No. Linea");
          IF rAsist.FINDSET THEN
            REPEAT
              rAsist2 := rAsist;
              rAsist2."No Linea Programac." := "No. Linea";
              rAsist2.Confirmado            := FALSE;
              rAsist2.Asistio               := FALSE;
              rAsist2.INSERT;
            UNTIL rAsist.NEXT=0;
        END;
    end;

    var
        Col: Record 5050;
        Prom: Record 13;
        TyE Record: 67011;
        CabPEvento Record: 67051;
        Err001: Label 'You must change the %1 to '' '' in the Header to modify this line';

    procedure Horas()
    var
        Err001: Label 'La hora de inicio no puede ser superior a la hora final.';
    begin

        IF "Hora de Inicio" > "Hora Final" THEN
         IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
          ERROR(Err001);

        IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
          VALIDATE("Horas dictadas", ROUND(("Hora Final" - "Hora de Inicio") / 3600000,0.01))
        ELSE
          VALIDATE("Horas dictadas",0);
    end;
}

