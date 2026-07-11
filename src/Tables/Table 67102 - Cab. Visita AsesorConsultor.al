table 67102 "Cab. Visita Asesor/Consultor"
{

    fields
    {
        field(1; "No. Visita Asesor/Consultor"; Code[20])
        {
        }
        field(2; "Tipo Asesor/Consultor"; Option)
        {
            Enabled = false;
            OptionCaption = 'Docente,Proveedor';
            OptionMembers = Docente,Proveedor;
        }
        field(3; "Cod. Asesor/Consultor"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            var
                Doc: Record 67001;
                Prov: Record 23;
            begin

                /*
                ///tableRelation: IF (Tipo Asesor/Consultor=CONST(Docente)) Docentes.No. ELSE IF (Tipo Asesor/Consultor=CONST(Proveedor)) Vendor.No.
                IF "Cod. Asesor/Consultor" <> '' THEN BEGIN
                  CASE "Tipo Asesor/Consultor" OF
                    "Tipo Asesor/Consultor"::Docente :
                      BEGIN
                      IF Doc.GET("Cod. Asesor/Consultor") THEN
                        "Nombre Asesor/Consultor"    := Doc."Full Name";
                      END;
                    "Tipo Asesor/Consultor"::Proveedor :
                      BEGIN
                      IF Prov.GET("Cod. Asesor/Consultor") THEN
                        "Nombre Asesor/Consultor"    := Prov.Name;
                      END;
                  END;
                END
                ELSE
                 "Nombre Asesor/Consultor" := '';
                */

                IF "Cod. Asesor/Consultor" <> '' THEN BEGIN
                    IF Prov.GET("Cod. Asesor/Consultor") THEN
                        "Nombre Asesor/Consultor" := Prov.Name;
                END
                ELSE
                    "Nombre Asesor/Consultor" := '';

            end;
        }
        field(4; "Nombre Asesor/Consultor"; Text[100])
        {
            Editable = false;
        }
        field(5; "Delegaci n"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code;
        }
        field(6; "Grupo Negocio"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Grupo de Negocio"));
        }
        field(7; "Fecha Registro"; Date)
        {
            Editable = false;
        }
        field(8; "Hora Registro"; Time)
        {
            Editable = false;
        }
        field(9; "Tipo Visita"; Option)
        {
            OptionCaption = 'Solicitada,No Solicitada';
            OptionMembers = Solicitada,"No Solicitada";
        }
        field(10; "No. Solicitud"; Code[20])
        {

            trigger OnLookup()
            var
                fSol: Page67090;
                rSol: Record 67055;
            begin

                IF "Tipo Visita" = "Tipo Visita"::Solicitada THEN BEGIN
                    rSol.FILTERGROUP(2);
                    //rSol.SETFILTER(rSol.Status,'%1|%2',rSol.Status::Programada,rSol.Status::Realizada);
                    rSol.SETFILTER(rSol.Status, '%1', rSol.Status::Programada);
                    IF "Cod. Asesor/Consultor" <> '' THEN
                        rSol.SETRANGE("Cod. Expositor", "Cod. Asesor/Consultor");
                    rSol.FILTERGROUP(0);
                    fSol.SETTABLEVIEW(rSol);
                    fSol.LOOKUPMODE(TRUE);
                    fSol.EDITABLE(FALSE);
                    IF fSol.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        fSol.GETRECORD(rSol);
                        VALIDATE("No. Solicitud", rSol."No. Solicitud");
                    END;
                END;
            end;

            trigger OnValidate()
            var
                rSol: Record 67055;
                Err001: Label 'Solo se permite ingresar el No. Solicitud en una visita de Tipo Solicitada.';
                Err002: Label 'La solicitud seleccionada no es del cod. expositor %1.';
                Err003: Label 'La solicitud ingresada no se encuentra en estado Programada.';
            begin

                IF "Tipo Visita" <> "Tipo Visita"::Solicitada THEN
                    ERROR(Err001);

                IF rSol.GET("No. Solicitud") THEN BEGIN
                    //IF (rSol.Status <> rSol.Status::Programada) AND (rSol.Status <> rSol.Status::Realizada) THEN
                    IF (rSol.Status <> rSol.Status::Programada) THEN
                        ERROR(Err003);

                    IF "Cod. Asesor/Consultor" <> '' THEN
                        IF rSol."Cod. Expositor" <> "Cod. Asesor/Consultor" THEN
                            ERROR(STRSUBSTNO(Err002, "Cod. Asesor/Consultor"));

                    "No. Solicitud" := rSol."No. Solicitud";
                    "Grupo Negocio" := rSol."Grupo de Negocio";
                    "Tipo Evento" := rSol."Tipo de Evento";
                    "Cod. evento" := rSol."Cod. evento";
                    "Descripci n evento" := rSol."Descripcion evento";
                    "Cod. Nivel" := rSol."Cod. Nivel";

                    VALIDATE("Cod. Colegio", rSol."Cod. Colegio");
                    VALIDATE("Cod. promotor", rSol."Cod. promotor");
                    VALIDATE("Tipo Persona Contacto", rSol."Tipo Responsable");

                    "Cod. Persona Contacto" := rSol."Cod. Docente responsable";
                    "Nombre Persona Contacto" := rSol."Nombre responsable";
                    "Tel fono 1 Persona Contacto" := rSol."Telefono Responsable";
                    "Tel fono 2 Persona Contacto" := rSol."No. celular responsable";
                    "Cod. Cargo Persona Contacto" := rSol."Cod. Cargo Responsable";
                    "Desc. Cargo Persona Contacto" := rSol."Descripci n Cargo Responsable";
                    "E-mail Persona Contacto" := rSol."E-Mail Docente Responsable";

                    TraerNGyE(rSol."No. Solicitud");

                    TraerProgramac(rSol."No. Solicitud");
                END;
            end;
        }
        field(11; "Cod. Colegio"; Code[20])
        {
            TableRelation = Contact."No." WHERE("Type" = CONST(Company));

            trigger OnValidate()
            var
                Colegio: Record 5050;
            begin

                IF "Cod. Colegio" <> '' THEN BEGIN
                    Colegio.GET("Cod. Colegio");
                    Delegaci n := Colegio.Delegacion;
                    "Nombre Colegio" := Colegio.Name;
                    "Distrito Colegio" := Colegio.Distritos;
                    "Direcci n Colegio" := Colegio.Address;
                    "Tel fono 1 Colegio" := Colegio."Phone No.";
                    "Tel fono 2 Colegio" := Colegio."Mobile Phone No.";
                END;
            end;
        }
        field(12; "Nombre Colegio"; Text[100])
        {
            Editable = false;
        }
        field(13; "Direcci n Colegio"; Text[100])
        {
            Editable = false;
        }
        field(14; "Distrito Colegio"; Text[30])
        {
            Editable = false;
        }
        field(15; "Tel fono 1 Colegio"; Code[15])
        {
            Editable = false;
        }
        field(16; "Tel fono 2 Colegio"; Code[15])
        {
            Editable = false;
        }
        field(17; "Cod. promotor"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnLookup()
            var
                ColNivel: Record 67036;
                pgColNivel: Page67180;
            begin

                ColNivel.RESET;
                ColNivel.FILTERGROUP(2);
                ColNivel.SETRANGE("Cod. Colegio", "Cod. Colegio");
                ColNivel.SETRANGE("Cod. Nivel", "Cod. Nivel");
                ColNivel.FILTERGROUP(0);
                pgColNivel.SETTABLEVIEW(ColNivel);
                pgColNivel.EDITABLE(FALSE);
                pgColNivel.LOOKUPMODE(TRUE);
                IF pgColNivel.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    pgColNivel.GETRECORD(ColNivel);
                    VALIDATE("Cod. promotor", ColNivel."Cod. Promotor");
                END;
            end;

            trigger OnValidate()
            var
                rVendor: Record 23;
            begin
                IF "Cod. promotor" <> '' THEN BEGIN
                    IF rVendor.GET("Cod. promotor") THEN
                        "Nombre promotor" := rVendor.Name;
                END
                ELSE
                    "Nombre promotor" := '';
            end;
        }
        field(18; "Nombre promotor"; Text[100])
        {
            Editable = false;
        }
        field(19; "Cod. Nivel"; Code[20])
        {
            TableRelation = "Colegio - Nivel"."Cod. Nivel" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                  "Cod. Promotor" = FIELD("Cod. promotor"));

            trigger OnValidate()
            var
                ColNivel: Record 67036;
            begin
                ColNivel.RESET;
                ColNivel.SETRANGE("Cod. Colegio", "Cod. Colegio");
                ColNivel.SETRANGE("Cod. Nivel", "Cod. Nivel");
                IF ColNivel.FINDSET THEN
                    VALIDATE("Cod. promotor", ColNivel."Cod. Promotor");
            end;
        }
        field(20; "Tipo Evento"; Code[20])
        {
            TableRelation = "Tipos de Eventos";
        }
        field(21; "Tipo Persona Contacto"; Option)
        {
            OptionCaption = 'CDS,Otro';
            OptionMembers = CDS,Otro;

            trigger OnValidate()
            begin
                "Cod. Persona Contacto" := '';
                "Nombre Persona Contacto" := '';
                "Tel fono 1 Persona Contacto" := '';
                "Tel fono 2 Persona Contacto" := '';
                "E-mail Persona Contacto" := '';
                "Cod. Cargo Persona Contacto" := '';
                "Desc. Cargo Persona Contacto" := '';
            end;
        }
        field(22; "Cod. Persona Contacto"; Code[20])
        {
            TableRelation = "Colegio - Docentes"."Cod. Docente" WHERE("Cod. Colegio" = FIELD("Cod. Colegio"),
                                                                       "Pertenece al CDS" = CONST(true));

            trigger OnLookup()
            var
                rColDoc: Record 67043;
                pColDoc: Page67045;
            begin
                IF "Tipo Persona Contacto" = "Tipo Persona Contacto"::CDS THEN BEGIN
                    rColDoc.RESET;
                    rColDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                    rColDoc.SETRANGE("Pertenece al CDS", TRUE);
                    pColDoc.SETTABLEVIEW(rColDoc);
                    pColDoc.LOOKUPMODE(TRUE);
                    IF pColDoc.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        pColDoc.GETRECORD(rColDoc);
                        VALIDATE("Cod. Persona Contacto", rColDoc."Cod. Docente");
                        VALIDATE("Cod. Cargo Persona Contacto", rColDoc."Cod. Cargo");
                    END;
                END;
            end;

            trigger OnValidate()
            var
                Doc: Record 67001;
                ColDoc: Record 67043;
            begin
                IF "Tipo Persona Contacto" = "Tipo Persona Contacto"::CDS THEN
                    IF Doc.GET("Cod. Persona Contacto") THEN BEGIN
                        "Nombre Persona Contacto" := Doc."Full Name";
                        "Tel fono 1 Persona Contacto" := Doc."Phone No.";
                        "Tel fono 2 Persona Contacto" := Doc."Mobile Phone No.";
                        "E-mail Persona Contacto" := Doc."E-Mail";
                        ColDoc.SETRANGE("Cod. Colegio", "Cod. Colegio");
                        ColDoc.SETRANGE("Cod. Docente", "Cod. Persona Contacto");
                        IF ColDoc.FINDSET THEN BEGIN
                            "Cod. Cargo Persona Contacto" := ColDoc."Cod. Cargo";
                            "Desc. Cargo Persona Contacto" := ColDoc."Descripcion Cargo";
                        END;
                    END;
            end;
        }
        field(23; "Nombre Persona Contacto"; Text[100])
        {
        }
        field(24; "Cod. Cargo Persona Contacto"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST("Puestos de trabajo"));

            trigger OnValidate()
            var
                DA: Record 67002;
            begin
                IF "Cod. Cargo Persona Contacto" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::"Puestos de trabajo");
                    DA.SETRANGE(Codigo, "Cod. Cargo Persona Contacto");
                    DA.FINDFIRST;
                    "Desc. Cargo Persona Contacto" := DA.Descripcion;
                END
                ELSE
                    "Desc. Cargo Persona Contacto" := '';
            end;
        }
        field(25; "Desc. Cargo Persona Contacto"; Text[100])
        {
            Editable = false;
        }
        field(26; "Tel fono 1 Persona Contacto"; Code[15])
        {
        }
        field(27; "Tel fono 2 Persona Contacto"; Code[15])
        {
        }
        field(28; "E-mail Persona Contacto"; Text[30])
        {
        }
        field(29; "No. Asistentes Esperados"; Integer)
        {
        }
        field(30; "No. Asistentes Reales"; Integer)
        {
            CalcFormula = Count("Asis. Visitas Asesor/Consultor" WHERE("No. Visita" = FIELD("No. Visita Asesor/Consultor")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; Estado; Option)
        {
            OptionMembers = Programada,Ejecutada;
        }
        field(32; "Fecha Pr xima Visita"; Date)
        {
        }
        field(33; "C d. Objetivo Visita"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(Objetivos));

            trigger OnValidate()
            var
                DA: Record 67002;
            begin
                IF "C d. Objetivo Visita" <> '' THEN BEGIN
                    DA.RESET;
                    DA.SETRANGE("Tipo registro", DA."Tipo registro"::Objetivos);
                    DA.SETRANGE(Codigo, "C d. Objetivo Visita");
                    DA.FINDFIRST;
                    "Desc. Objetivo Visita" := DA.Descripcion;
                END
                ELSE
                    "Desc. Objetivo Visita" := '';
            end;
        }
        field(34; "Comentarios Visita"; Text[100])
        {
        }
        field(35; "Usuario Registro"; Code[50])
        {
            Editable = false;
        }
        field(36; "No. Series"; Code[20])
        {
        }
        field(37; "Desc. Objetivo Visita"; Text[100])
        {
            Editable = false;
        }
        field(38; "Cod. evento"; Code[20])
        {

            trigger OnLookup()
            var
                rEvExp: Record 67050;
                pEvExp: Page67100;
            begin
                rEvExp.RESET;
                IF "Tipo Evento" <> '' THEN
                    rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo Evento");
                rEvExp.SETRANGE(rEvExp.Delegacion, Delegaci n);
                rEvExp.SETRANGE(rEvExp."Cod. Expositor", "Cod. Asesor/Consultor");
                pEvExp.SETTABLEVIEW(rEvExp);
                pEvExp.LOOKUPMODE(TRUE);
                IF pEvExp.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    pEvExp.GETRECORD(rEvExp);
                    "Cod. evento" := rEvExp."Cod. Evento";
                    "Descripci n evento" := rEvExp."Descripcion Evento";
                    "Tipo Evento" := rEvExp."Tipo de Evento";
                END;
            end;

            trigger OnValidate()
            var
                rEvExp: Record 67050;
                err001: Label 'El cod. evento no est  asociado con el consultor %1.';
            begin
                rEvExp.RESET;
                IF "Tipo Evento" <> '' THEN
                    rEvExp.SETRANGE(rEvExp."Tipo de Evento", "Tipo Evento");
                rEvExp.SETRANGE(rEvExp.Delegacion, Delegaci n);
                rEvExp.SETRANGE(rEvExp."Cod. Expositor", "Cod. Asesor/Consultor");
                rEvExp.SETRANGE(rEvExp."Cod. Evento", "Cod. evento");
                IF rEvExp.FINDSET THEN BEGIN
                    "Descripci n evento" := rEvExp."Descripcion Evento";
                    "Tipo Evento" := rEvExp."Tipo de Evento";
                END
                ELSE
                    ERROR(STRSUBSTNO(err001, "Cod. Asesor/Consultor"));
            end;
        }
        field(39; "Descripci n evento"; Text[100])
        {
            Editable = false;
        }
        field(40; "Programa Seguimiento Uno a Uno"; Boolean)
        {
        }
        field(41; "Fecha programada"; Date)
        {
            CalcFormula = Lookup("Prog. Visitas Asesor/Consultor"."Fecha Programada" WHERE("No. Visita" = FIELD("No. Visita Asesor/Consultor")));
            FieldClass = FlowField;
        }
        field(42; "Fecha realizada"; Date)
        {
            CalcFormula = Lookup("Prog. Visitas Asesor/Consultor"."Fecha Realizada" WHERE("No. Visita" = FIELD("No. Visita Asesor/Consultor")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No. Visita Asesor/Consultor")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Err001: Label 'No se permite eliminar visitas con estado Ejecutada.';
        Text001: Label ' Est  seguro que desea eliminar la visita?';
        rProg: Record 67103;
        rAsis: Record 67106;
        rCC: Record 67104;
        rDescAsis: Record 67105;
    begin


        IF Estado = Estado::Ejecutada THEN
            ERROR(Err001);

        IF CONFIRM(Text001) THEN BEGIN
            rProg.SETRANGE("No. Visita", "No. Visita Asesor/Consultor");
            rProg.DELETEALL;

            rAsis.SETRANGE("No. Visita", "No. Visita Asesor/Consultor");
            rAsis.DELETEALL;

            rCC.SETRANGE("No. Visita Consultor/Asesor", "No. Visita Asesor/Consultor");
            rCC.DELETEALL;

            rDescAsis.SETRANGE(rDescAsis."No. Visita", "No. Visita Asesor/Consultor");
            rDescAsis.DELETEALL;
        END;
    end;

    trigger OnInsert()
    var
        APSSetup: Record 67000;
        NoSeriesMgt: Codeunit 396;
        Seg: Record 67107;
    begin

        IF "No. Visita Asesor/Consultor" = '' THEN BEGIN
            APSSetup.GET;
            APSSetup.TESTFIELD("No. Serie Visita Asesor/Consu.");
            NoSeriesMgt.InitSeries(APSSetup."No. Serie Visita Asesor/Consu.", xRec."No. Series", 0D, "No. Visita Asesor/Consultor", "No. Series");
        END;

        Seg.InsertarSeguimiento(Rec);

        //"Fecha Registro"    := TODAY;
        //"Hora Registro"     := TIME;
        "Usuario Registro" := USERID;
    end;

    trigger OnModify()
    var
        rProg: Record 67103;
        act: Boolean;
        rDoc: Record 67001;
        Seg: Record 67107;
    begin

        rProg.SETRANGE("No. Visita", "No. Visita Asesor/Consultor");
        IF rProg.FINDSET(TRUE, FALSE) THEN
            REPEAT
                //rProg."Tipo Asesor/Consultor"   := "Tipo Asesor/Consultor";
                rProg."Cod. Asesor/Consultor" := "Cod. Asesor/Consultor";
                rProg."Nombre Asesor/Consultor" := "Nombre Asesor/Consultor";
                rProg.Delegaci n := Delegaci n;
                rProg."Grupo Negocio" := "Grupo Negocio";
                rProg."Cod. promotor" := "Cod. promotor";
                rProg."Nombre promotor" := "Nombre promotor";
                rProg."Cod. Colegio" := "Cod. Colegio";
                rProg."Nombre Colegio" := "Nombre Colegio";
                rProg.MODIFY;
            UNTIL rProg.NEXT = 0;

        IF "Tipo Persona Contacto" = "Tipo Persona Contacto"::CDS THEN
            IF rDoc.GET("Cod. Persona Contacto") THEN
                IF ("Tel fono 1 Persona Contacto" <> rDoc."Phone No.") OR
                   ("Tel fono 2 Persona Contacto" <> rDoc."Mobile Phone No.") OR
                   ("E-mail Persona Contacto" <> rDoc."E-Mail") THEN BEGIN
                    rDoc."Phone No." := "Tel fono 1 Persona Contacto";
                    rDoc."Mobile Phone No." := "Tel fono 2 Persona Contacto";
                    rDoc."E-Mail" := "E-mail Persona Contacto";
                    rDoc.MODIFY;
                END;

        IF xRec.Estado <> Estado THEN
            Seg.InsertarSeguimiento(Rec);
    end;

    trigger OnRename()
    var
        Text003: Label 'You cannot rename a %1.';
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    procedure TraerNGyE(parSolicitud: Code[20])
    var
        rNivel: Record 67080;
        rGrado: Record 67081;
        rEspec: Record 67082;
        rNGE: Record 67105;
    begin

        IF "No. Visita Asesor/Consultor" <> '' THEN BEGIN
            rNGE.RESET;
            rNGE.SETRANGE(rNGE."No. Visita", "No. Visita Asesor/Consultor");
            rNGE.DELETEALL;
            rNGE.RESET;

            rNivel.SETRANGE(rNivel."No. Solicitud", parSolicitud);
            IF rNivel.FINDSET THEN
                REPEAT
                    rNGE.INIT;
                    rNGE."No. Visita" := "No. Visita Asesor/Consultor";
                    rNGE.Tipo := rNGE.Tipo::Nivel;
                    rNGE.Codigo := rNivel."Cod. Nivel";
                    rNGE.Descripci n := rNivel.Descripci n;
                    rNGE.INSERT;
                UNTIL rNivel.NEXT = 0;

            rGrado.SETRANGE(rGrado."No. Solicitud", parSolicitud);
            IF rGrado.FINDSET THEN
                REPEAT
                    rNGE.INIT;
                    rNGE."No. Visita" := "No. Visita Asesor/Consultor";
                    rNGE.Tipo := rNGE.Tipo::Grado;
                    rNGE.Codigo := rGrado."Cod. Grado";
                    rNGE.Descripci n := rGrado.Descripci n;
                    rNGE.INSERT;
                UNTIL rGrado.NEXT = 0;

            rEspec.SETRANGE(rEspec."No. Solicitud", parSolicitud);
            IF rEspec.FINDSET THEN
                REPEAT
                    rNGE.INIT;
                    rNGE."No. Visita" := "No. Visita Asesor/Consultor";
                    rNGE.Tipo := rNGE.Tipo::Especialidad;
                    rNGE.Codigo := rEspec."Cod. Especialidad";
                    rNGE.Descripci n := rEspec.Descripci n;
                    rNGE.INSERT;
                UNTIL rEspec.NEXT = 0;
        END;
    end;

    procedure TraerProgramac(parSolicitud: Code[20])
    var
        rProgVisita: Record 67103;
        rProgSolic: Record 67015;
        rCabPlanif: Record 67051;
    begin

        IF "No. Visita Asesor/Consultor" <> '' THEN BEGIN
            rCabPlanif.RESET;
            rCabPlanif.SETRANGE("No. Solicitud", "No. Solicitud");
            IF rCabPlanif.FINDSET THEN BEGIN
                rProgSolic.SETRANGE("Cod. Taller - Evento", rCabPlanif."Cod. Taller - Evento");
                rProgSolic.SETRANGE("Tipo Evento", rCabPlanif."Tipo Evento");
                rProgSolic.SETRANGE("Tipo de Expositor", rCabPlanif."Tipo de Expositor");
                rProgSolic.SETRANGE(Expositor, rCabPlanif.Expositor);
                rProgSolic.SETRANGE(Secuencia, rCabPlanif.Secuencia);
                IF rProgSolic.FINDSET THEN BEGIN
                    rProgVisita.RESET;
                    rProgVisita.SETRANGE(rProgVisita."No. Visita", "No. Visita Asesor/Consultor");
                    rProgVisita.DELETEALL;
                    rProgVisita.RESET;
                    REPEAT
                        rProgVisita.INIT;
                        rProgVisita."No. Visita" := "No. Visita Asesor/Consultor";
                        rProgVisita."Fecha Programada" := rProgSolic."Fecha programacion";
                        rProgVisita."Hora Inicio Programada" := rProgSolic."Hora de Inicio";
                        rProgVisita."Hora Fin Programada" := rProgSolic."Hora Final";
                        rProgVisita."Cod. Grado" := rProgSolic."Cod. Grado";
                        rProgVisita."No. asistentes" := rProgSolic."Asistentes esperados";
                        rProgVisita.INSERT(TRUE);
                    UNTIL rProgSolic.NEXT = 0;
                END;
            END;
        END;
    end;
}

