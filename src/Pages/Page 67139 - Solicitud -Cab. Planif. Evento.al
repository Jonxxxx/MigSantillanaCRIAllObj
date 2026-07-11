page 67139 "Solicitud -Cab. Planif. Evento"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = Table67051;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                }
                field(Expositor; Expositor)
                {
                    Editable = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                    Editable = false;
                }
                field("Description Taller"; "Description Taller")
                {
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                    Editable = false;
                }
                field(Estado; Estado)
                {
                    Editable = false;
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                    Editable = false;
                    StyleExpr = TRUE;
                }
            }
            part(SubFormPTyE; 67015)
            {
                SubPageLink = Cod. Taller - Evento=FIELD("Cod. Taller - Evento"),
                              Tipo Evento=FIELD("Tipo Evento"),
                              Tipo de Expositor=FIELD("Tipo de Expositor"),
                              Expositor=FIELD("Expositor"),
                              Secuencia=FIELD("Secuencia");
                SubPageView = SORTING(Cod. Taller - Evento,Tipo Evento,Tipo de Expositor,Expositor);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000038>")
            {
                Caption = '&Event';
                action("<Action1000000039>")
                {
                    Caption = 'Materiales';
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MatTyE: Record 67014;
                        MatTyE2Record: Record 67014;
                        PgMatTyE: Page67014;
                    begin
                        MatTyE.RESET;
                        MatTyE.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
                        MatTyE.SETRANGE("Tipo Evento","Tipo Evento");
                        MatTyE.SETRANGE(Expositor,Expositor);
                        MatTyE.SETRANGE(Secuencia,Secuencia);
                        IF NOT MatTyE.FINDFIRST THEN
                           BEGIN
                            MatTyE2.RESET;
                            MatTyE2.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
                            MatTyE2.SETRANGE("Tipo Evento","Tipo Evento");
                            MatTyE2.SETRANGE(Secuencia,0);
                            IF MatTyE2.FINDSET THEN
                               REPEAT
                                CLEAR(MatTyE);
                                MatTyE.TRANSFERFIELDS(MatTyE2);
                                MatTyE.Expositor  := Expositor;
                                MatTyE."Tipo de Expositor"  :=  "Tipo de Expositor";
                                MatTyE.Secuencia := Secuencia;
                                MatTyE.INSERT(TRUE);
                               UNTIL MatTyE2.NEXT = 0;
                            COMMIT;
                           END;

                        CLEAR(MatTyE);
                        MatTyE.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
                        MatTyE.SETRANGE("Tipo Evento","Tipo Evento");
                        MatTyE.SETRANGE(Secuencia,Secuencia);
                        MatTyE.SETRANGE(Expositor,Expositor);
                        MatTyE.SETRANGE("Tipo de Expositor", "Tipo de Expositor");

                        PgMatTyE.SETTABLEVIEW(MatTyE);
                        PgMatTyE.RUNMODAL;
                        CLEAR(PgMatTyE);
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        rProg: Record 67015;
        rSol: Record 67055;
    begin
        /*
        IF "No. Solicitud" <> '' THEN BEGIN
          rSol.GET("No. Solicitud");
          rSol."Asistentes Reales" := 0;
          rProg.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
          rProg.SETRANGE("Tipo Evento","Tipo Evento");
          rProg.SETRANGE("Tipo de Expositor","Tipo de Expositor");
          rProg.SETRANGE(rProg.Expositor,Expositor);
          rProg.SETRANGE(Secuencia, Secuencia);
          IF rProg.FINDFIRST THEN BEGIN
             REPEAT
               rSol."Asistentes Reales" := rSol."Asistentes Reales" + rProg."Nro. De asistentes reales";
             UNTIL rProg.NEXT=0;
             rSol.MODIFY;
          END;
        END;
        */

    end;

    var
        Fecha: Record 2000000007;
        Evento: Record 67011;
}

