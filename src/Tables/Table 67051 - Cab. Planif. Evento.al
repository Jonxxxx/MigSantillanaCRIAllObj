table 67051 "Cab. Planif. Evento"
{
    DrillDownPageID = 67059;
    LookupPageID = 67059;

    fields
    {
        field(1; "Cod. Taller - Evento"; Code[20])
        {
            TableRelation = Eventos."No.";

            trigger OnValidate()
            begin
                TyE.RESET;
                TyE.SETRANGE("No.", "Cod. Taller - Evento");
                TyE.SETRANGE("Tipo de Evento", "Tipo Evento");
                IF TyE.FINDFIRST THEN BEGIN
                    "Description Taller" := TyE.Descripcion;
                    "Asistentes esperados" := TyE."Capacidad de vacantes";
                    Delegacion := TyE.Delegacion;
                    "Descripcion Delegacion" := TyE."Descripcion Delegacion";
                END;
            end;
        }
        field(2; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";

            trigger OnValidate()
            begin
                IF TipoEvent.GET("Tipo Evento") THEN
                    "Description Tipo evento" := TipoEvent.Descripcion;
            end;
        }
        field(3; Expositor; Code[20])
        {
            TableRelation = IF ("Tipo de Expositor" = CONST(Docente)) Docentes WHERE("Expositor" = CONST(true))
            ELSE IF ("Tipo de Expositor" = CONST(Proveedor)) Vendor;

            trigger OnValidate()
            begin
                IF Expositor <> '' THEN BEGIN
                    IF "Tipo de Expositor" = 0 THEN BEGIN
                        Exposit.GET(Expositor);
                        "Nombre Expositor" := Exposit."Full Name";
                    END
                    ELSE BEGIN
                        Vend.GET(Expositor);
                        "Nombre Expositor" := Vend.Name;
                    END;
                END;
            end;
        }
        field(4; Secuencia; Integer)
        {
        }
        field(5; "Description Tipo evento"; Text[100])
        {
            CalcFormula = Lookup("Tipos de Eventos".Descripcion WHERE("Codigo" = FIELD("Tipo Evento")));
            FieldClass = FlowField;
        }
        field(6; "Description Taller"; Text[100])
        {
        }
        field(7; "Nombre Expositor"; Text[60])
        {
        }
        field(8; "Tipo de Expositor"; Option)
        {
            OptionCaption = 'Teacher,Vendor';
            OptionMembers = Docente,Proveedor;
        }
        field(9; "Numero de sesiones"; Integer)
        {
            Caption = 'Sessions number';
        }
        field(10; "Fecha Inicio"; Date)
        {
        }
        field(11; Lunes; Boolean)
        {
            Caption = 'Monday';
        }
        field(12; Martes; Boolean)
        {
            Caption = 'Tuesday';
        }
        field(13; Miercoles; Boolean)
        {
            Caption = 'Wednesday';
        }
        field(14; Jueves; Boolean)
        {
            Caption = 'Thursday';
        }
        field(15; Viernes; Boolean)
        {
            Caption = 'Friday';
        }
        field(16; Sabados; Boolean)
        {
            Caption = 'Saturday';
        }
        field(17; Domingos; Boolean)
        {
            Caption = 'Sunday';
        }
        field(18; "Asistentes esperados"; Integer)
        {
        }
        field(19; "Total registrados"; Integer)
        {
            CalcFormula = Count("Asistentes Talleres y Eventos" WHERE("Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                                                       "Tipo Evento" = FIELD("Tipo Evento"),
                                                                       "Cod. Expositor" = FIELD("Expositor"),
                                                                       "Secuencia" = FIELD("Secuencia")));
            FieldClass = FlowField;
        }
        field(20; Estado; Option)
        {
            OptionCaption = ' ,Done,Cancelled';
            OptionMembers = " ",Realizado,Anulado;

            trigger OnValidate()
            var
                ProgEvent: Record 67015;
            begin
                ProgEvent.RESET;
                ProgEvent.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                ProgEvent.SETRANGE("Tipo Evento", "Tipo Evento");
                ProgEvent.SETRANGE(Expositor, Expositor);
                ProgEvent.SETRANGE(Secuencia, Secuencia);
                IF ProgEvent.COUNT > 1 THEN BEGIN
                    IF ProgEvent.FINDSET THEN
                        REPEAT
                            ProgEvent.TESTFIELD(Estado);
                        UNTIL ProgEvent.NEXT = 0;
                END
                ELSE BEGIN
                    IF ProgEvent.FINDFIRST THEN BEGIN
                        IF Estado > 0 THEN
                            ProgEvent.TESTFIELD(Estado, Estado);
                    END;
                END;
            end;
        }
        field(21; "No. Solicitud"; Code[20])
        {
        }
        field(22; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact;
        }
        field(23; "Cod. Promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(24; "Fecha Programada"; Date)
        {
        }
        field(25; "Fecha Realizada"; Date)
        {
        }
        field(26; "Cod. Nivel"; Code[20])
        {
        }
        field(27; Delegacion; Code[20])
        {

            trigger OnLookup()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");

                DimVal.RESET;
                DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                DimForm.SETTABLEVIEW(DimVal);
                DimForm.SETRECORD(DimVal);
                DimForm.LOOKUPMODE(TRUE);
                IF DimForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    DimForm.GETRECORD(DimVal);
                    VALIDATE(Delegacion, DimVal.Code);
                END;

                CLEAR(DimForm);
            end;

            trigger OnValidate()
            begin
                ConfAPS.GET();
                ConfAPS.TESTFIELD(ConfAPS."Cod. Dimension Delegacion");

                IF Delegacion <> '' THEN BEGIN
                    DimVal.RESET;
                    DimVal.SETRANGE("Dimension Code", ConfAPS."Cod. Dimension Delegacion");
                    DimVal.SETRANGE("Dimension Value Type", DimVal."Dimension Value Type"::Standard);
                    DimVal.SETRANGE(Code, Delegacion);
                    DimVal.FINDFIRST;
                    "Descripcion Delegacion" := DimVal.Name;
                END;
            end;
        }
        field(28; "Descripcion Delegacion"; Text[60])
        {
            Caption = 'Descripci n Delegaci n';
        }
        field(29; "Asistentes reales"; Integer)
        {
        }
        field(30; Pagado; Boolean)
        {
        }
        field(31; "Importe pago"; Decimal)
        {
        }
        field(32; "No. Documento Pago"; Code[20])
        {
        }
        field(33; "Tipo Documento Pago"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(28));
        }
        field(34; "Fecha Pago"; Date)
        {
        }
        field(35; "Nombre Colegio"; Text[90])
        {
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(36; "Distrito Colegio"; Text[30])
        {
            CalcFormula = Lookup(Contact.Distritos WHERE("No." = FIELD("Cod. Colegio")));
            FieldClass = FlowField;
        }
        field(37; "Estado Solicitud"; Option)
        {
            CalcFormula = Lookup("Solicitud de Taller - Evento".Status WHERE("No. Solicitud" = FIELD("No. Solicitud")));
            FieldClass = FlowField;
            OptionCaption = ' ,Sent by salesperson,Approved,Programmed,Voided,Rejected,Done';
            OptionMembers = " ","Enviada por promotor",Aprobada,Programada,Cancelada,Rechazada,Realizada;
        }
        field(38; "Grupo Negocio"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Cod. Taller - Evento", Expositor, Secuencia)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Asistentes.RESET;
        Asistentes.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        //Asistentes.SETRANGE("Tipo Evento","Tipo Evento");
        Asistentes.SETRANGE("Cod. Expositor", Expositor);
        Asistentes.SETRANGE(Secuencia, Secuencia);
        IF Asistentes.FINDSET(TRUE, FALSE) THEN
            REPEAT
                Asistentes.TESTFIELD(Asistio, FALSE);
                Asistentes.DELETE;
            UNTIL Asistentes.NEXT = 0;

        MatTallerEvento.RESET;
        MatTallerEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        //MatTallerEvento.SETRANGE("Tipo Evento","Tipo Evento");
        MatTallerEvento.SETRANGE(Expositor, Expositor);
        MatTallerEvento.SETRANGE(Secuencia, Secuencia);
        IF MatTallerEvento.FINDSET(TRUE, FALSE) THEN
            MatTallerEvento.DELETEALL;

        ProgTallerEvento.RESET;
        ProgTallerEvento.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        //ProgTallerEvento.SETRANGE("Tipo Evento","Tipo Evento");
        ProgTallerEvento.SETRANGE(Expositor, Expositor);
        ProgTallerEvento.SETRANGE(Secuencia, Secuencia);
        IF ProgTallerEvento.FINDSET(TRUE, FALSE) THEN
            ProgTallerEvento.DELETEALL;
    end;

    trigger OnInsert()
    begin
        CabPlanEvent.RESET;
        CabPlanEvent.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        CabPlanEvent.SETRANGE(Expositor, Expositor);
        IF NOT CabPlanEvent.FINDLAST THEN
            CabPlanEvent.INIT;

        Secuencia := CabPlanEvent.Secuencia + 1;
    end;

    var
        Exposit: Record 67001;
        Vend: Record 23;
        TyE: Record 67011;
        TipoEvent: Record 67010;
        CabPlanEvent: Record 67051;
        ConfAPS: Record 67000;
        DimVal: Record 349;
        MatTallerEvento: Record 67014;
        ProgTallerEvento: Record 67015;
        Asistentes: Record 67016;
        DimForm: Page 560;

    procedure CalculaMonto() rtnImporte: Decimal
    var
        rTar: Record 67068;
        rSol: Record 67055;
        rCol: Record 5050;
    begin
        rtnImporte := 0;

        rTar.RESET;
        rTar.SETRANGE("Tipo Evento", "Tipo Evento");
        IF "No. Solicitud" <> '' THEN BEGIN
            rSol.GET("No. Solicitud");
            IF rCol.GET("Cod. Colegio") THEN BEGIN
                rTar.SETRANGE("Post Code", rCol."Post Code");
                rTar.SETRANGE(County, rCol.County);
                rTar.SETRANGE(City, rCol.City);
                IF NOT rTar.FINDFIRST THEN BEGIN
                    rTar.SETRANGE("Post Code");
                    rTar.SETRANGE(County);
                    rTar.SETRANGE(City);
                END;
            END;
        END;
        IF rTar.FINDSET THEN
            CASE rTar."Tipo Pago" OF
                rTar."Tipo Pago"::"Por Hora":
                    rtnImporte := rTar.Monto * GetHoras;
                rTar."Tipo Pago"::"Por Unidad":
                    rtnImporte := rTar.Monto;
                rTar."Tipo Pago"::"Por Grupo":
                    rtnImporte := rTar.Monto * GetGrupos;
            END;
    end;

    procedure GetHoras() rtnHoras: Decimal
    var
        rProg: Record 67015;
    begin

        rtnHoras := 0;
        rProg.RESET;
        rProg.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        rProg.SETRANGE("Tipo Evento", "Tipo Evento");
        rProg.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
        rProg.SETRANGE(Expositor, Expositor);
        rProg.SETRANGE(Secuencia, Secuencia);
        IF rProg.FINDSET THEN
            REPEAT
                rtnHoras += rProg."Horas dictadas";
            UNTIL rProg.NEXT = 0;
    end;

    procedure GetGrupos() rtnGrupos: Integer
    var
        rProg: Record 67015;
    begin

        rtnGrupos := 0;
        rProg.RESET;
        rProg.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
        rProg.SETRANGE("Tipo Evento", "Tipo Evento");
        rProg.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
        rProg.SETRANGE(Expositor, Expositor);
        rProg.SETRANGE(Secuencia, Secuencia);
        IF rProg.FINDSET THEN
            rtnGrupos := rProg.COUNT;
    end;
}

