page 34002208 "Cab. Planif. Entrenamiento"
{
    Caption = 'Training schedule page';
    PageType = Card;
    SourceTable = 34002204;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                }
                field("Titulo entrenamiento"; Rec."Titulo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo entrenamiento';
                }
                field("Tipo de Instructor"; Rec."Tipo de Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Instructor';
                }
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                }
                field("Nombre Instructor"; Rec."Nombre Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Instructor';
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field("Hora de Inicio"; Rec."Hora de Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora de Inicio';
                }
                field("Horas entrenamiento"; Rec."Horas entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas entrenamiento';
                }
                field("Hora Final"; Rec."Hora Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Final';
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                }
                field("Total registrados"; Rec."Total registrados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total registrados';
                }
                field("Asistentes reales"; Rec."Asistentes reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes reales';
                }
                field("Area Curricular"; Rec."Area Curricular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Curricular';
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Editable = false;
                }
                group(Schedule)
                {
                    Caption = 'Schedule';
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
                }
            }
            part(PartPage; 34002232)
            {
                SubPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                              "Tipo entrenamiento" = FIELD("Tipo entrenamiento");
            }
            group(GeneralGroup)
            {
                field("Importe Gastos Entrenador"; Rec."Importe Gastos Entrenador")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gastos Entrenador';
                }
                field("Importe Gastos Impresion"; Rec."Importe Gastos Impresion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gastos Impresion';
                }
                field("Importe Atenciones"; Rec."Importe Atenciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Atenciones';
                }
                field("Otros Importes"; Rec."Otros Importes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Otros Importes';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000038>")
            {
                Caption = 'Training';
                Image = DateRange;
                action(Agenda)
                {
                    Caption = 'Create Schedule';
                    Image = CalendarChanged;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        LPEntrenamientos: Record 34002205;
                        Fecha: Record 2000000007;
                        Seq: Integer;
                        IndSkip: Boolean;
                    begin
                        Entrenamientos.GET("No. entrenamiento");
                        Entrenamientos.TESTFIELD("Hora de Inicio");
                        Entrenamientos.TESTFIELD("Hora Final");
                        TESTFIELD("Numero de sesiones");
                        IF (NOT Domingos) AND (NOT Lunes) AND (NOT Martes) AND (NOT Miercoles) AND (NOT Jueves) AND
                           (NOT Viernes) AND (NOT Sabados) THEN
                            ERROR(Err001);

                        Fecha.RESET;
                        Fecha.SETRANGE("Period Type", Fecha."Period Type"::Date);
                        Fecha.SETRANGE("Period Start", "Fecha Inicio", CALCDATE('+50D', "Fecha Inicio"));
                        Fecha.FINDSET;
                        REPEAT
                            IndSkip := FALSE;
                            CLEAR(LPEntrenamientos);
                            LPEntrenamientos."No. entrenamiento" := "No. entrenamiento";
                            LPEntrenamientos.VALIDATE("Tipo entrenamiento", "Tipo entrenamiento");
                            // LPEntrenamientos.VALIDATE("Cod. entrenamiento","Cod. entrenamiento");
                            LPEntrenamientos.VALIDATE("Tipo de Instructor", "Tipo de Instructor");
                            LPEntrenamientos.VALIDATE("Cod. Instructor", "Cod. Instructor");
                            LPEntrenamientos.VALIDATE("Hora de Inicio", "Hora de Inicio");
                            LPEntrenamientos.VALIDATE("Hora Final", "Hora Final");
                            // LPEntrenamientos."Asistentes esperados" := "Asistentes esperados";
                            //LPEntrenamientos.Secuencia := Secuencia;
                            IF (Fecha."Period No." = 7) AND (Domingos) THEN
                                LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                            ELSE
                                IF (Fecha."Period No." = 6) AND (Sabados) THEN
                                    LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                ELSE
                                    IF (Fecha."Period No." = 5) AND (Viernes) THEN
                                        LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                    ELSE
                                        IF (Fecha."Period No." = 4) AND (Jueves) THEN
                                            LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                        ELSE
                                            IF (Fecha."Period No." = 3) AND (Miercoles) THEN
                                                LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                            ELSE
                                                IF (Fecha."Period No." = 2) AND (Martes) THEN
                                                    LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                                ELSE
                                                    IF (Fecha."Period No." = 1) AND (Lunes) THEN
                                                        LPEntrenamientos.VALIDATE("Fecha programacion", Fecha."Period Start")
                                                    ELSE
                                                        IndSkip := TRUE;

                            //LPEntrenamientos.VALIDATE("Fecha de realizacion",LPEntrenamientos."Fecha programacion");

                            IF NOT IndSkip THEN BEGIN
                                LPEntrenamientos.INSERT(TRUE);
                                Seq += 1;
                            END;
                        UNTIL (Fecha.NEXT = 0) OR (Seq >= "Numero de sesiones");
                    end;
                }
            }
        }
    }

    var
        Entrenamientos: Record 34002204;
        Err001: Label 'Please select at least one day on which it will be taught';
}

