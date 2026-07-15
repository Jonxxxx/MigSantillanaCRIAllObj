page 34002243 "Registro Asistencia Entrenamie"
{
    Caption = 'Training Attendance Registration';
    PageType = List;
    SourceTable = 34002204;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Instructor"; "Cod. Instructor")
                {
                    Editable = false;
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                    Editable = false;
                }
                field("No. entrenamiento"; "No. entrenamiento")
                {
                    Editable = false;
                }
                field("Titulo entrenamiento"; "Titulo entrenamiento")
                {
                    Editable = false;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                    Editable = false;
                }
                field(Disponible; Disponible)
                {
                    Editable = false;
                }
                field(Sala; Sala)
                {
                    Editable = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                    Editable = false;
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                    Editable = false;
                }
                field(Lunes; Lunes)
                {
                    Editable = false;
                }
                field(Martes; Martes)
                {
                    Editable = false;
                }
                field(Miercoles; Miercoles)
                {
                    Editable = false;
                }
                field(Jueves; Jueves)
                {
                    Editable = false;
                }
                field(Viernes; Viernes)
                {
                    Editable = false;
                }
                field(Sabados; Sabados)
                {
                    Editable = false;
                }
                field(Domingos; Domingos)
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(ContultaAsist; 34002244)
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
                    Caption = 'Register Assistants';
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

