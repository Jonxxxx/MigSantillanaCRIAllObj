report 67019 "Control tipo evento x colegio"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Control tipo evento x colegio.rdlc';

    dataset
    {
        dataitem(Eventos; 67015)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Fecha inscripcion");
            RequestFilterFields = "Cod. Colegio", "Fecha programacion", "Cod. Promotor", Expositor, "Tipo Evento";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Eventos__Cod__Colegio_; "Cod. Colegio")
            {
            }
            column(Eventos__Nombre_Colegio_; "Nombre Colegio")
            {
            }
            column(TraerDistrito; TraerDistrito)
            {
            }
            column(Eventos__Fecha_programacion_; "Fecha programacion")
            {
            }
            column(Eventos__Tipo_Evento_; "Tipo Evento")
            {
            }
            column(Eventos__Description_Taller_; "Description Taller")
            {
            }
            column(TraerNombreExpositor; TraerNombreExpositor)
            {
            }
            column(Eventos__Nombre_Promotor_; "Nombre Promotor")
            {
            }
            column(TraerHoras; TraerHoras)
            {
            }
            column(Eventos_Avisado; FormatCheckMark(Avisado))
            {
            }
            column(Eventos__Asistentes_esperados_; "Asistentes esperados")
            {
            }
            column(Eventos__Nro__De_asistentes_reales_; "Nro. De asistentes reales")
            {
            }
            column(Eventos_Secuencia; intSecuencia)
            {
            }
            column(TraerTieneEquipo; FormatCheckMark(TraerTieneEquipo))
            {
            }
            column(intTotalEsperados; intTotalEsperados)
            {
            }
            column(intTotalReal; intTotalReal)
            {
            }
            column(Programac__Talleres_y_EventosCaption; Programac__Talleres_y_EventosCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Eventos__Fecha_programacion_Caption; Eventos__Fecha_programacion_CaptionLbl)
            {
            }
            column(Eventos__Tipo_Evento_Caption; FIELDCAPTION("Tipo Evento"))
            {
            }
            column(Eventos__Description_Taller_Caption; Eventos__Description_Taller_CaptionLbl)
            {
            }
            column(TraerNombreExpositorCaption; TraerNombreExpositorCaptionLbl)
            {
            }
            column(Eventos__Nombre_Promotor_Caption; FIELDCAPTION("Nombre Promotor"))
            {
            }
            column(TraerHorasCaption; TraerHorasCaptionLbl)
            {
            }
            column(Avis_Caption; Avis_CaptionLbl)
            {
            }
            column(Espe_Caption; Espe_CaptionLbl)
            {
            }
            column(RealCaption; RealCaptionLbl)
            {
            }
            column(AsistentesCaption; AsistentesCaptionLbl)
            {
            }
            column(Equi_Caption; Equi_CaptionLbl)
            {
            }
            column(Eventos__Cod__Colegio_Caption; Eventos__Cod__Colegio_CaptionLbl)
            {
            }
            column(TOTAL_Caption; TOTAL_CaptionLbl)
            {
            }
            column(Eventos_Cod__Taller___Evento; "Cod. Taller - Evento")
            {
            }
            column(Eventos_Tipo_de_Expositor; "Tipo de Expositor")
            {
            }
            column(Eventos_Expositor; Expositor)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF "Cod. Colegio" <> codColegio THEN BEGIN
                    CLEAR(intTotalEsperados);
                    CLEAR(intTotalReal);
                    CLEAR(intSecuencia);
                    codColegio := "Cod. Colegio";
                END;

                intTotalEsperados += Eventos."Asistentes esperados";
                intTotalReal += Eventos."Nro. De asistentes reales";

                intSecuencia += 1;
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
        codColegio: Code[20];
        intTotalEsperados: Integer;
        intTotalReal: Integer;
        intSecuencia: Integer;
        Programac__Talleres_y_EventosCaptionLbl: Label 'Control tipo evento';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        Eventos__Fecha_programacion_CaptionLbl: Label 'Fecha';
        Eventos__Description_Taller_CaptionLbl: Label 'Descripción evento';
        TraerNombreExpositorCaptionLbl: Label 'Nombre Expositor';
        TraerHorasCaptionLbl: Label 'Starting date';
        Avis_CaptionLbl: Label 'Avis.';
        Espe_CaptionLbl: Label 'Espe.';
        RealCaptionLbl: Label 'Real';
        AsistentesCaptionLbl: Label 'Asistentes';
        Equi_CaptionLbl: Label 'Equi.';
        Eventos__Cod__Colegio_CaptionLbl: Label 'Colegio:';
        TOTAL_CaptionLbl: Label 'TOTAL:';

    procedure TraerNombreExpositor(): Text[100]
    var
        recDocente: Record 67001;
        recVendor: Record 23;
    begin
        CASE Eventos."Tipo de Expositor" OF
            Eventos."Tipo de Expositor"::Docente:
                BEGIN
                    IF recDocente.GET(Eventos.Expositor) THEN
                        EXIT(recDocente."Full Name");
                END;
            Eventos."Tipo de Expositor"::Proveedor:
                BEGIN
                    IF recVendor.GET(Eventos.Expositor) THEN
                        EXIT(recVendor.Name);
                END;
        END;
    end;

    procedure TraerHoras(): Text[60]
    begin
        EXIT(FORMAT(Eventos."Hora de Inicio", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>') + ' A ' +
             FORMAT(Eventos."Hora Final", 0, '<Hours24,2><Filler Character,0>:<Minutes,2>'));
    end;

    procedure TraerDistrito(): Text[30]
    var
        recColegio: Record 5050;
    begin
        IF recColegio.GET(Eventos."Cod. Colegio") THEN
            EXIT(recColegio.Distritos);
    end;

    procedure TraerTieneEquipo(): Boolean
    var
        recEquipo: Record 67059;
    begin
        recEquipo.RESET;
        recEquipo.SETRANGE("Cod. Taller - Evento", Eventos."Cod. Taller - Evento");
        recEquipo.SETRANGE("Tipo Evento", Eventos."Tipo Evento");
        recEquipo.SETRANGE(Secuencia, Eventos.Secuencia);
        EXIT(recEquipo.FINDFIRST);
    end;

    procedure FormatCheckMark(blnPrmEntrada: Boolean): Text[2]
    begin
        IF blnPrmEntrada THEN
            EXIT('ü');
    end;
}

