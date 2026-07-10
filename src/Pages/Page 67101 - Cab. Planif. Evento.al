page 67101 "Cab. Planif. Evento"
{
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
                field("Numero de sesiones"; "Numero de sesiones")
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field(Lunes; Lunes)
                {
                }
                field(Martes; Martes)
                {
                }
                field(Miercoles; Miercoles)
                {
                }
                field(Jueves; Jueves)
                {
                }
                field(Viernes; Viernes)
                {
                }
                field(Sabados; Sabados)
                {
                }
                field(Domingos; Domingos)
                {
                }
                field("Total registrados"; "Total registrados")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Estado; Estado)
                {
                }
            }
            part(SubFormPTyE; 67015)
            {
                SubPageLink = Cod. Taller - Evento=FIELD(Cod. Taller - Evento),
                              Tipo Evento=FIELD(Tipo Evento),
                              Tipo de Expositor=FIELD(Tipo de Expositor),
                              Expositor=FIELD(Expositor),
                              Secuencia=FIELD(Secuencia);
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
                action("Create Schedule")
                {
                    Caption = 'Create Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProgTyE Record: 67015;
                        Seq: Integer;
                        IndSkip: Boolean;
                    begin
                        Evento.GET("Tipo Evento","Cod. Taller - Evento");
                        Evento.TESTFIELD("Horas programadas");

                        TESTFIELD("Numero de sesiones");

                        Fecha.RESET;
                        Fecha.SETRANGE("Period Type",Fecha."Period Type"::Date);
                        Fecha.SETRANGE("Period Start","Fecha Inicio",CALCDATE('+50D',"Fecha Inicio"));
                        //Fecha.SETRANGE("Period end",calcdate('+50D',"Fecha Inicio"));
                        Fecha.FINDSET;
                        REPEAT
                         IndSkip := FALSE;
                         CLEAR(ProgTyE);
                         ProgTyE.VALIDATE("Cod. Taller - Evento","Cod. Taller - Evento");
                         ProgTyE.VALIDATE("Tipo Evento","Tipo Evento");
                         ProgTyE.VALIDATE("Tipo de Expositor","Tipo de Expositor");
                         ProgTyE.VALIDATE(Expositor,Expositor);
                         ProgTyE."Asistentes esperados" := "Asistentes esperados";
                         ProgTyE.Secuencia := Secuencia;
                         IF (Fecha."Period No." = 7) AND (Domingos) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 6) AND (Sabados) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 5) AND (Viernes) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 4) AND (Jueves) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 3) AND (Miercoles) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 2) AND (Martes) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                         IF (Fecha."Period No." = 1) AND (Lunes) THEN
                            ProgTyE.VALIDATE("Fecha programacion",Fecha."Period Start")
                         ELSE
                           IndSkip := TRUE;

                         ProgTyE.VALIDATE("Fecha de realizacion",ProgTyE."Fecha programacion");
                         ProgTyE."Horas dictadas" := Evento."Horas programadas";

                         IF NOT IndSkip THEN
                            BEGIN
                             ProgTyE.INSERT(TRUE);
                             Seq += 1;
                            END;
                        UNTIL (Fecha.NEXT = 0) OR (Seq >= "Numero de sesiones");
                    end;
                }
                action(Materiales)
                {
                    Caption = 'Materiales';
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MatTyE Record: 67014;
                        MatTyE2Record 67014;
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
                                MatTyE.Expositor :=  Expositor;
                                MatTyE."Tipo de Expositor" :=  "Tipo de Expositor";
                                MatTyE.Secuencia := Secuencia;
                                MatTyE.INSERT(TRUE);
                               UNTIL MatTyE2.NEXT = 0;
                            COMMIT;
                           END;

                        CLEAR(MatTyE);
                        MatTyE.SETRANGE("Cod. Taller - Evento","Cod. Taller - Evento");
                        MatTyE.SETRANGE("Tipo Evento","Tipo Evento");
                        MatTyE.SETRANGE(Expositor,Expositor);
                        MatTyE.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
                        MatTyE.SETRANGE(Secuencia,Secuencia);

                        PgMatTyE.SETTABLEVIEW(MatTyE);
                        PgMatTyE.RUNMODAL;
                        CLEAR(PgMatTyE);
                    end;
                }
                action(Asistentes)
                {
                    Caption = 'Asistentes';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67016;
                                    RunPageLink = Cod. Taller - Evento=FIELD(Cod. Taller - Evento),
                                  Tipo Evento=FIELD(Tipo Evento),
                                  Secuencia=FIELD(Secuencia),
                                  Cod. Expositor=FIELD(Expositor);
                    Visible = false;
                }
                action("Distribution per Cost Centre")
                {
                    Caption = 'Distribution per Cost Centre';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page67094;
                    begin

                        TESTFIELD("Cod. Taller - Evento");
                        TESTFIELD("Tipo Evento");
                        TESTFIELD(Expositor);
                        TESTFIELD(Secuencia);

                        GpoNegDistrib.RecibeParametros('','',"Cod. Taller - Evento","Tipo Evento",Expositor,Secuencia,FALSE,TRUE,'');
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        Fecha Record: 2000000007;
        Evento Record: 67011;
}

