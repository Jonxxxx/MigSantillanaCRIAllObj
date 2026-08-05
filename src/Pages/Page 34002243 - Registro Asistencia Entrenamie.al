page 55883 "Registro Asistencia Entrenamie"
{
    Caption = 'Training Attendance Registration';
    PageType = List;
    SourceTable = 55845;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                    Editable = false;
                }
                field("Nombre Instructor"; Rec."Nombre Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Instructor';
                    Editable = false;
                }
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                    Editable = false;
                }
                field("Titulo entrenamiento"; Rec."Titulo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo entrenamiento';
                    Editable = false;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                    Editable = false;
                }
                field(Disponible; Rec.Disponible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Disponible';
                    Editable = false;
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                    Editable = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                    Editable = false;
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                    Editable = false;
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                    Editable = false;
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                    Editable = false;
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                    Editable = false;
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                    Editable = false;
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                    Editable = false;
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                    Editable = false;
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(ContultaAsist; 55884)
            {
                Caption = 'Training Attendance Registration';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                              "Tipo entrenamiento" = FIELD("Tipo entrenamiento"),
                              "Cod. Instructor" = FIELD("Cod. Instructor");
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
                action("Register Assistants")
                {
                    ApplicationArea = All;
                    Caption = 'Register Assistants';
                    ToolTip = 'Register Assistants';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //CurrPage.ConsultaPLanTyE.FORM.AbrirPagAsistentes;
                        /*
                        rCabPlanif.RESET;
                        rCabPlanif.FILTERGROUP(2);
                        rCabPlanif.SETRANGE(rCabPlanif."Cod. Taller - Evento","Cod. Taller - Evento");
                        rCabPlanif.SETRANGE(rCabPlanif.Expositor, Expositor);
                        rCabPlanif.SETRANGE(rCabPlanif.Secuencia, Secuencia);
                        rCabPlanif.FILTERGROUP(0);
                        IF "No. Solicitud" <> '' THEN BEGIN
                          pProgColegio.SETTABLEVIEW(rCabPlanif);
                          pProgColegio.RUNMODAL;
                        END
                        ELSE BEGIN
                          pProgEditorial.SETTABLEVIEW(rCabPlanif);
                          pProgEditorial.RUNMODAL;
                        END;
                        */


                        //CurrPage.ConsultaPLanTyE.FORM.GETRECORD("ProgT&E");
                        //MESSAGE('%1',aa);

                    end;
                }
            }
        }
    }
}

