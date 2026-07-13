page 67016 "Asistentes Talleres y Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 67016;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; "No. Solicitud")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Promotor"; "Nombre Promotor")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha inscripcion"; "Fecha inscripcion")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha del Evento"; "Fecha del Evento")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha de realizacion"; "Fecha de realizacion")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Fecha programacion"; "Fecha programacion")
                {
                    Editable = false;
                }
                field("Cod. Docente"; "Cod. Docente")
                {
                    Editable = false;
                    TableRelation = Docentes WHERE("Pertenece al CDS" = CONST(true));
                }
                field("Nombre Docente"; "Nombre Docente")
                {
                    Editable = false;
                }
                field("Document ID"; "Document ID")
                {
                    Editable = false;
                }
                field(Inscrito; Inscrito)
                {
                }
                field(Confirmado; Confirmado)
                {
                }
                field(Asistio; Asistio)
                {

                    trigger OnValidate()
                    begin
                        IF Asistio THEN
                            wAsistentesAsistieron += 1
                        ELSE
                            wAsistentesAsistieron -= 1;
                    end;
                }
            }
            group(Assistants)
            {
                Caption = 'Assistants';
                field(TotDocentes; TotDocentes)
                {
                    Caption = 'Total Capacity';
                    Editable = false;
                }
                field(COUNT; COUNT)
                {
                    Caption = 'Selected Teachers';
                    Editable = false;
                }
                field(wAsistentesAsistieron; wAsistentesAsistieron)
                {
                    Caption = 'Docentes Asistieron';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000037>")
            {
                Caption = '&Exhibitor';
                action("<Action1000000040>")
                {
                    Caption = '&Select Teachers';
                    Image = EditList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        SelDoc.RecibeParametros(GETRANGEMIN("Cod. Taller - Evento"), GETRANGEMIN("Cod. Expositor"), GETRANGEMIN(Secuencia), gTipoEvento);
                        SelDoc.RUNMODAL;
                        CLEAR(SelDoc);

                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        /*"Cod. Taller - Evento" := CabPlanEvento."Cod. Taller - Evento";
        "Cod. Expositor" := CabPlanEvento.Expositor;
        Secuencia :=  CabPlanEvento.Secuencia;
        */
        "Tipo Evento" := CabPlanEvento."Tipo Evento";
        //TotSeleccionados := COUNT;

    end;

    trigger OnOpenPage()
    begin
        IF gNoSolicitud <> '' THEN BEGIN
            SETRANGE("Tipo Evento", gTipoEvento);
            SETRANGE("Cod. Taller - Evento", gCodTaller);
            SETRANGE("Cod. Expositor", gCodExpositor);
            SETRANGE("No. Solicitud", gNoSolicitud);
            SETRANGE(Secuencia, gSec);
            CabPlanEvento.RESET;
            CabPlanEvento.SETRANGE("Tipo Evento", gTipoEvento);
            CabPlanEvento.SETRANGE("Cod. Taller - Evento", gCodTaller);
            CabPlanEvento.SETRANGE(Expositor, gCodExpositor);
            IF gNoSolicitud <> '' THEN
                CabPlanEvento.SETRANGE("No. Solicitud", gNoSolicitud);
            IF CabPlanEvento.FINDFIRST THEN;
        END
        ELSE BEGIN
            CabPlanEvento.RESET;
            CabPlanEvento.SETRANGE("Tipo Evento", GETRANGEMIN("Tipo Evento"));
            CabPlanEvento.SETRANGE("Cod. Taller - Evento", GETRANGEMIN("Cod. Taller - Evento"));
            CabPlanEvento.SETRANGE(Expositor, GETRANGEMIN("Cod. Expositor"));
            CabPlanEvento.SETRANGE(Secuencia, GETRANGEMIN(Secuencia));

            CabPlanEvento.FINDFIRST;
            gTipoEvento := CabPlanEvento."Tipo Evento";
        END;

        ProgEvento.RESET;
        ProgEvento.SETRANGE("Cod. Taller - Evento", CabPlanEvento."Cod. Taller - Evento");
        ProgEvento.SETRANGE("Tipo Evento", CabPlanEvento."Tipo Evento");
        ProgEvento.SETRANGE("Cod. Taller - Evento", CabPlanEvento."Cod. Taller - Evento");
        ProgEvento.SETRANGE(Expositor, CabPlanEvento.Expositor);
        ProgEvento.SETRANGE("No. Linea", gLinProg);
        ProgEvento.FINDFIRST;

        TotDocentes := ProgEvento."Asistentes esperados";
        SETRANGE(Asistio, TRUE);
        wAsistentesAsistieron := COUNT;
        SETRANGE(Asistio);
    end;

    var
        CabPlanEvento: Record 67051;
        SelDoc: Page 67103;
        TotDocentes: Integer;
        gCodTaller: Code[20];
        gCodExpositor: Code[20];
        gSec: Integer;
        gTipoEvento: Code[20];
        gNoSolicitud: Code[20];
        ProgEvento: Record 67015;
        gTipoExp: Option Docente,Proveedor;
        gLinProg: Integer;
        wAsistentesAsistieron: Integer;

    procedure RecibeParametros(lCodTaller: Code[20]; lCodExpositor: Code[20]; lSec: Integer; lTipoEvento: Code[10]; lNoSolicitud: Code[20]; lCodColegio: Code[20]; lCodPromotor: Code[20]; lFecha: Date; lTipoExp: Option Docente,Proveedor)
    begin
        gCodTaller := lCodTaller;
        gCodExpositor := lCodExpositor;
        gSec := lSec;
        gTipoEvento := lTipoEvento;
        gNoSolicitud := lNoSolicitud;
        gTipoExp := lTipoExp;

        CabPlanEvento.RESET;
        CabPlanEvento.SETRANGE("Tipo Evento", gTipoEvento);
        CabPlanEvento.SETRANGE("Cod. Taller - Evento", gCodTaller);
        CabPlanEvento.SETRANGE(Expositor, gCodExpositor);
        CabPlanEvento.SETRANGE("No. Solicitud", gNoSolicitud);
        /*
        IF NOT CabPlanEvento.FINDFIRST THEN
           BEGIN
            CLEAR(CabPlanEvento);
            CabPlanEvento.VALIDATE("Tipo Evento",gTipoEvento);
            CabPlanEvento.VALIDATE("Cod. Taller - Evento",gCodTaller);
            CabPlanEvento.VALIDATE("Tipo de Expositor",gTipoExp);
            CabPlanEvento.VALIDATE(Expositor,gCodExpositor);
            CabPlanEvento.VALIDATE("No. Solicitud",gNoSolicitud);
            CabPlanEvento.VALIDATE("Fecha Inicio",lFecha);
            IF lCodColegio <> '' THEN
               CabPlanEvento.VALIDATE("Cod. Colegio",lCodColegio);
            IF lCodPromotor <> '' THEN
               CabPlanEvento.VALIDATE("Cod. Promotor",lCodPromotor);
            CabPlanEvento.INSERT(TRUE);
            gSec       := 1;
            COMMIT;
           END
        ELSE
        */
        CabPlanEvento.FINDFIRST;
        gSec := CabPlanEvento.Secuencia;

    end;

    procedure RecibeProgEvento(lLinProg: Integer)
    var
        gProgEvento: Record 67015;
    begin

        gLinProg := lLinProg;
    end;
}

