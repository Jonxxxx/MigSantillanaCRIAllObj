report 67015 "Colegios planificados"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Colegios planificados.rdlc';

    dataset
    {
        dataitem(Planificacion; 67038)
        {
            CalcFields = "Nombre Promotor";
            DataItemTableView = SORTING(Delegacion, Nivel, "Cod. Promotor", Ano, Semana, "Fecha Visita")
                                WHERE("Fecha Visita" = FILTER(<> ''));
            RequestFilterFields = Delegacion, Nivel, "Cod. Promotor", "Fecha Visita";
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
            column(Delegacion__________TraerNombreDelegacion; Delegacion + ' -  ' + TraerNombreDelegacion)
            {
            }
            column(Nivel_______texDescNivel; Nivel + ' - ' + texDescNivel)
            {
            }
            column(Cod__Promotor__________Nombre_Promotor_; "Cod. Promotor" + ' -  ' + "Nombre Promotor")
            {
            }
            column(Planificacion_Semana; Semana)
            {
            }
            column(Planificacion_Ano; Ano)
            {
            }
            column(TraerDiasSemana; TraerDiasSemana)
            {
            }
            column(Planificacion__Fecha_Visita_; "Fecha Visita")
            {
            }
            column(Planificacion__Nombre_Colegio_; "Nombre Colegio")
            {
            }
            column(texDistrito; texDistrito)
            {
            }
            column(codCategoria; codCategoria)
            {
            }
            column(Planificacion__Descripcion_Objetivo_; "Descripcion Objetivo")
            {
            }
            column(Planificacion__Cod__Colegio_; "Cod. Colegio")
            {
            }
            column("Planificacion_de_visitasCaption"; Planificacion_de_visitasCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Planificacion__Cod__Colegio_Caption; FIELDCAPTION("Cod. Colegio"))
            {
            }
            column(Planificacion__Nombre_Colegio_Caption; FIELDCAPTION("Nombre Colegio"))
            {
            }
            column(texDistritoCaption; texDistritoCaptionLbl)
            {
            }
            column(codCategoriaCaption; codCategoriaCaptionLbl)
            {
            }
            column(Planificacion__Descripcion_Objetivo_Caption; Planificacion__Descripcion_Objetivo_CaptionLbl)
            {
            }
            column("Delegacion_Caption"; Delegacion_CaptionLbl)
            {
            }
            column(Nivel_Caption; Nivel_CaptionLbl)
            {
            }
            column(Promotor_Caption; Promotor_CaptionLbl)
            {
            }
            column(Semana_Caption; Semana_CaptionLbl)
            {
            }
            column("Año_Caption"; Año_CaptionLbl)
            {
            }
            column(Planificacion_Cod__Promotor; "Cod. Promotor")
            {
            }
            column(Planificacion_Delegacion; Delegacion)
            {
            }
            column(Planificacion_Nivel; Nivel)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(texDistrito);
                CLEAR(texDescNivel);

                IF recColegio.GET("Cod. Colegio") THEN
                    texDistrito := recColegio.Distritos;

                IF recNivel.GET(Nivel) THEN
                    texDescNivel := recNivel.Descripcion;

                codCategoria := TraerCategoria("Cod. Colegio", Nivel);
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
        recColegio: Record 5050;
        recNivel: Record 67022;
        texDistrito: Text[100];
        codCategoria: Code[20];
        Text001: Label 'Del %1 al %2';
        texDescNivel: Text[100];
        "Planificacion_de_visitasCaptionLbl": Label 'Planificacion de visitas';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        texDistritoCaptionLbl: Label 'Distrito';
        codCategoriaCaptionLbl: Label 'Categoria';
        Planificacion__Descripcion_Objetivo_CaptionLbl: Label 'Objetivo';
        "Delegacion_CaptionLbl": Label 'Delegacion:';
        Nivel_CaptionLbl: Label 'Nivel:';
        Promotor_CaptionLbl: Label 'Promotor:';
        Semana_CaptionLbl: Label 'Semana:';
        "Año_CaptionLbl": Label 'Año:';

    procedure TraerCategoria(codPrmColegio: Code[20]; codPrmNivel: Code[20]): Code[10]
    var
        recNivel: Record 67036;
    begin
        recNivel.RESET;
        recNivel.SETRANGE("Cod. Colegio", codPrmColegio);
        recNivel.SETRANGE("Cod. Nivel", codPrmNivel);
        IF recNivel.FINDFIRST THEN
            EXIT(recNivel."Categoria colegio");
    end;

    procedure TraerDiasSemana(): Text[100]
    var
        recFechas: Record 2000000007;
    begin
        recFechas.RESET;
        recFechas.SETRANGE("Period Type", recFechas."Period Type"::Week);
        recFechas.SETFILTER("Period Start", '<=%1', Planificacion."Fecha Visita");
        recFechas.SETFILTER("Period End", '>=%1', Planificacion."Fecha Visita");
        recFechas.SETRANGE("Period No.", Planificacion.Semana);
        IF recFechas.FINDFIRST THEN
            EXIT(STRSUBSTNO(Text001, FORMAT(recFechas."Period Start", 0, '<Day>/<Month>/<Year4>'),
                                     FORMAT(NORMALDATE(recFechas."Period End"), 0, '<Day>/<Month>/<Year4>')));
    end;

    procedure TraerNombreDelegacion(): Text[50]
    var
        recCfg: Record 67000;
        recDimValue: Record 349;
    begin
        recCfg.GET;
        recCfg.TESTFIELD("Cod. Dimension Delegacion");

        IF recDimValue.GET(recCfg."Cod. Dimension Delegacion", Planificacion.Delegacion) THEN
            EXIT(recDimValue.Name);
    end;
}

