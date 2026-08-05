table 55482 "Programac. Talleres y Eventos"
{
    // 0009 CAT Se modifica el campo Horas dictadas por Horas Pedag gicas

    DrillDownPageID = 55482;
    LookupPageID = 55482;

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Taller - Evento';
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
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
            TableRelation = "Tipos de Eventos";
        }
        field(3; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact WHERE("Type" = CONST(Company));

            trigger OnValidate()
            begin
                IF Col.GET("Cod. Colegio") THEN
                    "Nombre Colegio" := Col.Name;
            end;
        }
        field(4; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser" WHERE("Tipo" = CONST(Vendedor));

            trigger OnValidate()
            begin
                IF "Cod. Promotor" <> '' THEN BEGIN
                    Prom.GET("Cod. Promotor");
                    "Nombre Promotor" := Prom.Name;
                END;
            end;
        }
        field(5; "Description Tipo evento"; Text[100])
        {
            Caption = 'Description Tipo evento';
            CalcFormula = Lookup("Tipos de Eventos".Descripcion WHERE("Codigo" = FIELD("Tipo Evento")));
            FieldClass = FlowField;
        }
        field(6; "Description Taller"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description Taller';
        }
        field(7; "Nombre Colegio"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
        field(8; "Nombre Promotor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Promotor';
        }
        field(9; "Tipo de Expositor"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de Expositor';
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(10; Expositor; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expositor';
            TableRelation = IF ("Tipo de Expositor" = CONST(Docente)) Docentes WHERE("Expositor" = CONST(true))
            ELSE IF ("Tipo de Expositor" = CONST(Proveedor)) Vendor;
        }
        field(11; "Nombre Expositor"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Expositor';
        }
        field(12; Avisado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Avisado';
        }
        field(13; "Fecha inscripcion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion';
            Editable = false;
        }
        field(14; "Fecha programacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha programacion';
        }
        field(15; "Fecha de realizacion"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha de realizacion';

            trigger OnValidate()
            var
                Err001: Label 'La fecha de realizaci n no puede ser menor que la fecha de programacion.';
            begin
                IF "Fecha programacion" <> 0D THEN
                    IF "Fecha de realizacion" < "Fecha programacion" THEN
                        ERROR(Err001);
            end;
        }
        field(16; "Asistentes esperados"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Asistentes esperados';
        }
        field(17; "Nro. De asistentes reales"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Nro. De asistentes reales';
            Editable = true;
            FieldClass = Normal;
        }
        field(18; "Horas dictadas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas dictadas';

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 55392 * 60);
                "Horas Pedag gicas" := ROUND("Horas dictadas" * 60 / 40, 1);
            end;
        }
        field(19; "Horas Pedag gicas"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Horas Pedag gicas';
            Editable = false;
        }
        field(20; Observacion; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Observacion';
        }
        field(21; "Fecha Solicitud"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Solicitud';
        }
        field(22; Objetivo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Objetivo';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Objetivos));
        }
        field(23; "Descripcion observacion"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion observacion';
        }
        field(24; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
        }
        field(25; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = ' ,Done,Cancelled';
            OptionMembers = " ",Realizado,Anulado;

            trigger OnValidate()
            begin
                CabPEvento.GET("Cod. Taller - Evento", Expositor, Secuencia);
                IF (CabPEvento.Estado <> Estado) AND (CabPEvento.Estado > 0) THEN
                    ERROR(STRSUBSTNO(Err001, FIELDCAPTION(Estado)));
            end;
        }
        field(26; "Hora de Inicio"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora de Inicio';

            trigger OnValidate()
            begin
                //TESTFIELD("Hora de Inicio");
                //"Hora Final" := "Hora de Inicio" + ("Horas dictadas" * 55392 * 60);
                Horas;
            end;
        }
        field(27; "Hora Final"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Final';

            trigger OnValidate()
            begin
                Horas;
            end;
        }
        field(28; "No. Linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Linea';
        }
        field(29; "Fecha propuesta"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha propuesta';
        }
        field(30; "Hora Inicio Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Inicio Propuesta';
            Editable = false;
        }
        field(31; "Hora Fin Propuesta"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora Fin Propuesta';
            Editable = false;
        }
        field(32; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Grados));
        }
    }

    keys
    {
        key(Key1; "Cod. Taller - Evento", "Tipo Evento", "Tipo de Expositor", Expositor, Secuencia, "No. Linea")
        {
        }
        key(Key2; "Cod. Colegio", "Fecha inscripcion")
        {
        }
        key(Key3; "Fecha programacion", "Cod. Colegio", "Hora de Inicio")
        {
        }
        key(Key4; Expositor, "Fecha programacion")
        {
        }
        key(Key5; "Fecha programacion", "Nombre Colegio", "Hora de Inicio")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        rRec: Record 55482;
        rAsist: Record 55483;
        rAsist2: Record 55483;
    begin
        "Fecha inscripcion" := TODAY;
        "Fecha Solicitud" := TODAY;

        rRec.SETRANGE(rRec."Cod. Taller - Evento", "Cod. Taller - Evento");
        rRec.SETRANGE(rRec."Tipo Evento", "Tipo Evento");
        rRec.SETRANGE(rRec."Tipo de Expositor", "Tipo de Expositor");
        rRec.SETRANGE(rRec.Expositor, Expositor);
        rRec.SETRANGE(rRec.Secuencia, Secuencia);
        IF rRec.FINDLAST THEN
            "No. Linea" := rRec."No. Linea" + 1
        ELSE
            "No. Linea" := 1;


        CabPEvento.RESET;
        CabPEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        CabPEvento.SETRANGE(Expositor, Expositor);
        IF CabPEvento.FINDLAST THEN
            "Description Taller" := CabPEvento."Description Taller";


        IF "No. Linea" > 1 THEN BEGIN
            //Si la anterior programacion ya tiene asistentes inscritos, los incluimos en la programacion actual
            //Solo ocurrir  cuando se a ade una programacion y ya se inscribieron a los asistentes.
            rAsist.SETRANGE(rAsist."Cod. Taller - Evento", rRec."Cod. Taller - Evento");
            rAsist.SETRANGE(rAsist."Cod. Expositor", rRec.Expositor);
            rAsist.SETRANGE(rAsist.Secuencia, rRec.Secuencia);
            rAsist.SETRANGE(rAsist."Tipo de Expositor", rRec."Tipo de Expositor");
            rAsist.SETRANGE(rAsist."Tipo Evento", rRec."Tipo Evento");
            rAsist.SETRANGE("No Linea Programac.", rRec."No. Linea");
            IF rAsist.FINDSET THEN
                REPEAT
                    rAsist2 := rAsist;
                    rAsist2."No Linea Programac." := "No. Linea";
                    rAsist2.Confirmado := FALSE;
                    rAsist2.Asistio := FALSE;
                    rAsist2.INSERT;
                UNTIL rAsist.NEXT = 0;
        END;
    end;

    var
        Col: Record 5050;
        Prom: Record 13;
        TyE: Record 55478;
        CabPEvento: Record 55518;
        Err001: Label 'You must change the %1 to '' '' in the Header to modify this line';

    procedure Horas()
    var
        Err001: Label 'La hora de inicio no puede ser superior a la hora final.';
    begin

        IF "Hora de Inicio" > "Hora Final" THEN
            IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
                ERROR(Err001);

        IF ("Hora de Inicio" <> 0T) AND ("Hora Final" <> 0T) THEN
            VALIDATE("Horas dictadas", ROUND(("Hora Final" - "Hora de Inicio") / 3600000, 0.01))
        ELSE
            VALIDATE("Horas dictadas", 0);
    end;
}

