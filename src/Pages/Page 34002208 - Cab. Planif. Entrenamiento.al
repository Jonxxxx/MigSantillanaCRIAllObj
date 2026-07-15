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
                field("No. entrenamiento"; "No. entrenamiento")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit() THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                }
                field("Titulo entrenamiento"; "Titulo entrenamiento")
                {
                }
                field("Tipo de Instructor"; "Tipo de Instructor")
                {
                }
                field("Cod. Instructor"; "Cod. Instructor")
                {
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                }
                field("Horas entrenamiento"; "Horas entrenamiento")
                {
                }
                field("Hora Final"; "Hora Final")
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Total registrados"; "Total registrados")
                {
                }
                field("Asistentes reales"; "Asistentes reales")
                {
                }
                field("Area Curricular"; "Area Curricular")
                {
                }
                field(Sala; Sala)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field(Estado; Estado)
                {
                    Editable = false;
                }
                group(Schedule)
                {
                    Caption = 'Schedule';
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
                }
            }
            part(PartPage; 34002232)
            {
                SubPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                              "Tipo entrenamiento" = FIELD("Tipo entrenamiento");
            }
            group(GeneralGroup)
            {
                field("Importe Gastos Entrenador"; "Importe Gastos Entrenador")
                {
                }
                field("Importe Gastos Impresion"; "Importe Gastos Impresion")
                {
                }
                field("Importe Atenciones"; "Importe Atenciones")
                {
                }
                field("Otros Importes"; "Otros Importes")
                {
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

