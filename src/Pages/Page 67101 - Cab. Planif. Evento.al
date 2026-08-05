page 67101 "Cab. Planif. Evento"
{
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 67051;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cod. Taller-Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Editable = false;
                }
                field(Expositor; Rec.Expositor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositor';
                    Editable = false;
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                }
                field("Description Tipo evento"; Rec."Description Tipo evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Tipo evento';
                    Editable = false;
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                    Editable = false;
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                }
                field("Total registrados"; Rec."Total registrados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total registrados';
                    Editable = false;
                    Visible = false;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
            }
            part(SubFormPTyE; 55482)
            {
                SubPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                              "Tipo Evento" = FIELD("Tipo Evento"),
                              "Tipo de Expositor" = FIELD("Tipo de Expositor"),
                              "Expositor" = FIELD("Expositor"),
                              "Secuencia" = FIELD("Secuencia");
                SubPageView = SORTING("Cod. Taller - Evento", "Tipo Evento", "Tipo de Expositor", Expositor);
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
                    ApplicationArea = All;
                    Caption = 'Create Schedule';
                    ToolTip = 'Create Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProgTyE: Record 55482;
                        Seq: Integer;
                        IndSkip: Boolean;
                    begin
                        Evento.GET("Tipo Evento", "Cod. Taller - Evento");
                        Evento.TESTFIELD("Horas programadas");

                        TESTFIELD("Numero de sesiones");

                        Fecha.RESET;
                        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Date);
                        Fecha.SETRANGE("Period Start", "Fecha Inicio", CALCDATE('+50D', "Fecha Inicio"));
                        //Fecha.SETRANGE("Period end",calcdate('+50D',"Fecha Inicio"));
                        Fecha.FINDSET;
                        REPEAT
                            IndSkip := FALSE;
                            CLEAR(ProgTyE);
                            ProgTyE.VALIDATE("Cod. Taller - Evento", "Cod. Taller - Evento");
                            ProgTyE.VALIDATE("Tipo Evento", "Tipo Evento");
                            ProgTyE.VALIDATE("Tipo de Expositor", "Tipo de Expositor");
                            ProgTyE.VALIDATE(Expositor, Expositor);
                            ProgTyE."Asistentes esperados" := "Asistentes esperados";
                            ProgTyE.Secuencia := Secuencia;
                            IF (Fecha."Period No." = 7) AND (Domingos) THEN
                                ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                            ELSE
                                IF (Fecha."Period No." = 6) AND (Sabados) THEN
                                    ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                ELSE
                                    IF (Fecha."Period No." = 5) AND (Viernes) THEN
                                        ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                    ELSE
                                        IF (Fecha."Period No." = 4) AND (Jueves) THEN
                                            ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                        ELSE
                                            IF (Fecha."Period No." = 3) AND (Miercoles) THEN
                                                ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                            ELSE
                                                IF (Fecha."Period No." = 2) AND (Martes) THEN
                                                    ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                                ELSE
                                                    IF (Fecha."Period No." = 1) AND (Lunes) THEN
                                                        ProgTyE.VALIDATE("Fecha programacion", Fecha."Period Start")
                                                    ELSE
                                                        IndSkip := TRUE;

                            ProgTyE.VALIDATE("Fecha de realizacion", ProgTyE."Fecha programacion");
                            ProgTyE."Horas dictadas" := Evento."Horas programadas";

                            IF NOT IndSkip THEN BEGIN
                                ProgTyE.INSERT(TRUE);
                                Seq += 1;
                            END;
                        UNTIL (Fecha.NEXT = 0) OR (Seq >= "Numero de sesiones");
                    end;
                }
                action(Materiales)
                {
                    ApplicationArea = All;
                    Caption = 'Materiales';
                    ToolTip = 'Materiales';
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        MatTyE: Record 55481;
                        MatTyE2: Record 55481;
                        PgMatTyE: Page 55481;
                    begin
                        MatTyE.RESET;
                        MatTyE.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                        MatTyE.SETRANGE("Tipo Evento", "Tipo Evento");
                        MatTyE.SETRANGE(Expositor, Expositor);
                        MatTyE.SETRANGE(Secuencia, Secuencia);
                        IF NOT MatTyE.FINDFIRST THEN BEGIN
                            MatTyE2.RESET;
                            MatTyE2.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                            MatTyE2.SETRANGE("Tipo Evento", "Tipo Evento");
                            MatTyE2.SETRANGE(Secuencia, 0);
                            IF MatTyE2.FINDSET THEN
                                REPEAT
                                    CLEAR(MatTyE);
                                    MatTyE.TRANSFERFIELDS(MatTyE2);
                                    MatTyE.Expositor := Expositor;
                                    MatTyE."Tipo de Expositor" := "Tipo de Expositor";
                                    MatTyE.Secuencia := Secuencia;
                                    MatTyE.INSERT(TRUE);
                                UNTIL MatTyE2.NEXT = 0;
                            COMMIT;
                        END;

                        CLEAR(MatTyE);
                        MatTyE.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
                        MatTyE.SETRANGE("Tipo Evento", "Tipo Evento");
                        MatTyE.SETRANGE(Expositor, Expositor);
                        MatTyE.SETRANGE("Tipo de Expositor", "Tipo de Expositor");
                        MatTyE.SETRANGE(Secuencia, Secuencia);

                        PgMatTyE.SETTABLEVIEW(MatTyE);
                        PgMatTyE.RUNMODAL;
                        CLEAR(PgMatTyE);
                    end;
                }
                action(Asistentes)
                {
                    ApplicationArea = All;
                    Caption = 'Asistentes';
                    ToolTip = 'Asistentes';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55483;
                    RunPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                  "Tipo Evento" = FIELD("Tipo Evento"),
                                  "Secuencia" = FIELD("Secuencia"),
                                  "Cod. Expositor" = FIELD("Expositor");
                    Visible = false;
                }
                action("Distribution per Cost Centre")
                {
                    ApplicationArea = All;
                    Caption = 'Distribution per Cost Centre';
                    ToolTip = 'Distribution per Cost Centre';
                    Image = GLAccountBalance;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        GpoNegDistrib: Page 67094;
                    begin

                        TESTFIELD("Cod. Taller - Evento");
                        TESTFIELD("Tipo Evento");
                        TESTFIELD(Expositor);
                        TESTFIELD(Secuencia);

                        GpoNegDistrib.RecibeParametros('', '', "Cod. Taller - Evento", "Tipo Evento", Expositor, Secuencia, FALSE, TRUE, '');
                        GpoNegDistrib.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        Fecha: Record 2000000007;
        Evento: Record 55478;
}

