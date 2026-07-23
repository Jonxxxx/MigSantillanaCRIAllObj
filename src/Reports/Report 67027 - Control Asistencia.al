report 67027 "Control Asistencia"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Control Asistencia.rdlc';

    dataset
    {
        dataitem("Cab. Planif. Evento"; 67051)
        {
            RequestFilterFields = "Cod. Taller - Evento", Expositor, Secuencia, "Tipo Evento";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Cab__Planif__Evento__Cod__Taller___Evento_; "Cod. Taller - Evento")
            {
            }
            column(Cab__Planif__Evento__Tipo_Evento_; "Tipo Evento")
            {
            }
            column(Cab__Planif__Evento_Expositor; Expositor)
            {
            }
            column(Cab__Planif__Evento_Secuencia; Secuencia)
            {
            }
            column(informeCaption; informeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cab__Planif__Evento__Cod__Taller___Evento_Caption; FIELDCAPTION("Cod. Taller - Evento"))
            {
            }
            column(Cab__Planif__Evento__Tipo_Evento_Caption; FIELDCAPTION("Tipo Evento"))
            {
            }
            column(Cab__Planif__Evento_ExpositorCaption; FIELDCAPTION(Expositor))
            {
            }
            column(Cab__Planif__Evento_SecuenciaCaption; FIELDCAPTION(Secuencia))
            {
            }
            dataitem("Programac. Talleres y Eventos"; 67015)
            {
                DataItemLink = Cod. Taller - Evento=FIELD(Cod. Taller - Evento),
                               Expositor=FIELD(Expositor),
                               Secuencia=FIELD(Secuencia);
                DataItemTableView = SORTING("Cod. Taller - Evento","Tipo Evento","Tipo de Expositor",Expositor,"Fecha programacion",Secuencia);
                column(Programac__Talleres_y_Eventos__Fecha_programacion_;"Fecha programacion")
                {
                }
                column(Programac__Talleres_y_Eventos__Asistentes_esperados_;"Asistentes esperados")
                {
                }
                column(Programac__Talleres_y_Eventos__Hora_de_Inicio_;"Hora de Inicio")
                {
                }
                column(Programac__Talleres_y_Eventos__Hora_Final_;"Hora Final")
                {
                }
                column(Programac__Talleres_y_Eventos__Fecha_programacion_Caption;FIELDCAPTION("Fecha programacion"))
                {
                }
                column(Programac__Talleres_y_Eventos__Asistentes_esperados_Caption;FIELDCAPTION("Asistentes esperados"))
                {
                }
                column(Programac__Talleres_y_Eventos__Hora_de_Inicio_Caption;FIELDCAPTION("Hora de Inicio"))
                {
                }
                column(Programac__Talleres_y_Eventos__Hora_Final_Caption;FIELDCAPTION("Hora Final"))
                {
                }
                column(Programac__Talleres_y_Eventos_Cod__Taller___Evento;"Cod. Taller - Evento")
                {
                }
                column(Programac__Talleres_y_Eventos_Tipo_Evento;"Tipo Evento")
                {
                }
                column(Programac__Talleres_y_Eventos_Tipo_de_Expositor;"Tipo de Expositor")
                {
                }
                column(Programac__Talleres_y_Eventos_Expositor;Expositor)
                {
                }
                column(Programac__Talleres_y_Eventos_Secuencia;Secuencia)
                {
                }
                dataitem("Asistentes Talleres y Eventos";67016)
                {
                    DataItemLink = Cod. Taller - Evento=FIELD(Cod. Taller - Evento),
                                   Cod. Expositor=FIELD(Expositor),
                                   Secuencia=FIELD(Secuencia),
                                   Fecha programacion=FIELD("Fecha programacion");
                    DataItemTableView = SORTING("No. Solicitud","Cod. Taller - Evento","Cod. Expositor",Secuencia,"Cod. Docente","Fecha programacion");
                    column(Asistentes_Talleres_y_Eventos_Confirmado;Confirmado)
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos__Cod__Docente_;"Cod. Docente")
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos__Nombre_Docente_;"Nombre Docente")
                    {
                    }
                    column(FORMAT_Confirmado_;FORMAT(Confirmado))
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_Asistio;Asistio)
                    {
                    }
                    column(FORMAT_Inscrito_;FORMAT(Inscrito))
                    {
                    }
                    column(num_;num)
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_ConfirmadoCaption;FIELDCAPTION(Confirmado))
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos__Cod__Docente_Caption;FIELDCAPTION("Cod. Docente"))
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos__Nombre_Docente_Caption;FIELDCAPTION("Nombre Docente"))
                    {
                    }
                    column(FORMAT_Confirmado_Caption;FORMAT_Confirmado_CaptionLbl)
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_AsistioCaption;FIELDCAPTION(Asistio))
                    {
                    }
                    column(FORMAT_Inscrito_Caption;FORMAT_Inscrito_CaptionLbl)
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_No__Solicitud;"No. Solicitud")
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_Cod__Taller___Evento;"Cod. Taller - Evento")
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_Cod__Expositor;"Cod. Expositor")
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_Secuencia;Secuencia)
                    {
                    }
                    column(Asistentes_Talleres_y_Eventos_Fecha_programacion;"Fecha programacion")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                         num += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(num);
                    end;
                }
            }

            trigger OnPreDataItem()
            begin
                IF "Cab. Planif. Evento".GETFILTER("Cab. Planif. Evento"."Cod. Taller - Evento") = '' THEN
                   ERROR(Error001, "Cab. Planif. Evento".FIELDCAPTION("Cab. Planif. Evento"."Cod. Taller - Evento"));
                IF "Cab. Planif. Evento".GETFILTER("Cab. Planif. Evento".Expositor) = '' THEN
                   ERROR(Error001, "Cab. Planif. Evento".FIELDCAPTION("Cab. Planif. Evento".Expositor));
                IF "Cab. Planif. Evento".GETFILTER("Cab. Planif. Evento".Secuencia) = '' THEN
                   ERROR(Error001, "Cab. Planif. Evento".FIELDCAPTION("Cab. Planif. Evento".Secuencia));
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        num: Integer;
        Error001: Label 'Se requiere introducir un valor de %1';
        informeCaptionLbl: Label 'Control Asistencia';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        FORMAT_Confirmado_CaptionLbl: Label 'Label1000000019';
        FORMAT_Inscrito_CaptionLbl: Label 'Label1000000029';
}

