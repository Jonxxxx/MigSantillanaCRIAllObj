report 67013 "Resumen colegios adoptados"
{
    // Falta calcujlo de colegios adoptados , no adoptados e indecisos. Ademas del nº de ejemplares.
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Resumen colegios adoptados.rdlc';


    dataset
    {
        dataitem(CategoriasPromotor; 67036)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Categoria colegio")
                                WHERE("Cod. Promotor" = FILTER(<> ''));
            RequestFilterFields = "Cod. Promotor", "Categoria colegio";
            RequestFilterHeading = 'Resumen de colegios adoptados por categoria';
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(intColegios; intColegios)
            {
            }
            column(CategoriasPromotor__Categoria_colegio_; "Categoria colegio")
            {
            }
            column(TraerNombrePromotor; TraerNombrePromotor)
            {
            }
            column(CategoriasPromotor__Cod__Promotor_; "Cod. Promotor")
            {
            }
            column(intNoAdoptados; intNoAdoptados)
            {
            }
            column(intAdoptados; intAdoptados)
            {
            }
            column(intFaltanDecidir; intFaltanDecidir)
            {
            }
            column(intEjemplares; intEjemplares)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Resumen_de_colegios_adoptados_por_categoriaCaption"; Resumen_de_colegios_adoptados_por_categoriaCaptionLbl)
            {
            }
            column(intColegiosCaption; intColegiosCaptionLbl)
            {
            }
            column(CategoriasPromotor__Categoria_colegio_Caption; CategoriasPromotor__Categoria_colegio_CaptionLbl)
            {
            }
            column(TraerNombrePromotorCaption; TraerNombrePromotorCaptionLbl)
            {
            }
            column(CategoriasPromotor__Cod__Promotor_Caption; FIELDCAPTION("Cod. Promotor"))
            {
            }
            column(No_adoptadosCaption; No_adoptadosCaptionLbl)
            {
            }
            column(AdoptadosCaption; AdoptadosCaptionLbl)
            {
            }
            column(Faltan_decidirCaption; Faltan_decidirCaptionLbl)
            {
            }
            column(EjemplaresCaption; EjemplaresCaptionLbl)
            {
            }
            column(CategoriasPromotor_Cod__Colegio; "Cod. Colegio")
            {
            }
            column(CategoriasPromotor_Cod__Nivel; "Cod. Nivel")
            {
            }
            column(CategoriasPromotor_Turno; Turno)
            {
            }
            column(CategoriasPromotor_Ruta; Ruta)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(intAdoptados);
                CLEAR(intNoAdoptados);
                CLEAR(intFaltanDecidir);
                CLEAR(intEjemplares);
                CLEAR(intColegios);

                FILTERGROUP(2);
                SETRANGE("Cod. Promotor", "Cod. Promotor");
                SETRANGE("Categoria colegio", "Categoria colegio");
                FINDLAST;
                SETRANGE("Cod. Promotor");
                SETRANGE("Categoria colegio");

                recTmpColegio.DELETEALL;

                recNivelCol.RESET;
                recNivelCol.SETCURRENTKEY("Cod. Promotor", "Categoria colegio");
                recNivelCol.SETRANGE("Cod. Promotor", CategoriasPromotor."Cod. Promotor");
                recNivelCol.SETRANGE("Categoria colegio", CategoriasPromotor."Categoria colegio");
                IF recNivelCol.FINDSET THEN
                    REPEAT
                        recNivelCol.SETRANGE("Cod. Colegio", recNivelCol."Cod. Colegio");
                        recNivelCol.FINDLAST;
                        recNivelCol.SETRANGE("Cod. Colegio");

                        intColegios += 1;

                        //Colegios NO adoptados
                        recAdopcion.RESET;
                        recAdopcion.SETCURRENTKEY("Cod. Colegio", "Cod. Nivel");
                        recAdopcion.SETRANGE("Cod. Colegio", recNivelCol."Cod. Colegio");
                        recAdopcion.SETRANGE("Cod. Nivel", recNivelCol."Cod. Nivel");
                        recAdopcion.SETRANGE("Cod. Promotor", recNivelCol."Cod. Promotor");
                        IF NOT recAdopcion.FINDFIRST THEN
                            intNoAdoptados += 1
                        ELSE BEGIN
                            //Colegios adoptados
                            recAdopcion.RESET;
                            recAdopcion.SETCURRENTKEY("Cod. Colegio", "Cod. Nivel");
                            recAdopcion.SETRANGE("Cod. Colegio", recNivelCol."Cod. Colegio");
                            recAdopcion.SETRANGE("Cod. Nivel", recNivelCol."Cod. Nivel");
                            recAdopcion.SETRANGE("Cod. Promotor", recNivelCol."Cod. Promotor");
                            recAdopcion.SETFILTER(Adopcion, '%1|%2', recAdopcion.Adopcion::Conquista, recAdopcion.Adopcion::Mantener);
                            IF recAdopcion.FINDSET THEN BEGIN
                                intAdoptados += 1;
                                REPEAT
                                    intEjemplares += recAdopcion."Adopcion Real"
                                UNTIL recAdopcion.NEXT = 0;
                            END
                            ELSE BEGIN
                                recAdopcion.SETRANGE(Adopcion, recAdopcion.Adopcion::Perdida);  //Colegios NO adoptados
                                IF recAdopcion.FINDFIRST THEN
                                    intNoAdoptados += 1
                                ELSE BEGIN
                                    recAdopcion.SETRANGE(Adopcion, recAdopcion.Adopcion::" ");    //Colegios sin decidir
                                    IF recAdopcion.FINDFIRST THEN
                                        intFaltanDecidir += 1
                                END;
                            END;
                        END;

                    UNTIL recNivelCol.NEXT = 0;
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
        Text001: Label 'Cargando datos';
        Text002: Label '##############################1\\';
        Text003: Label '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2';
        recNivelCol: Record 67036;
        recTmpColegio: Record 5050 temporary;
        recAdopcion: Record 67053;
        intColegios: Integer;
        intNoAdoptados: Integer;
        intAdoptados: Integer;
        intFaltanDecidir: Integer;
        intEjemplares: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        "Resumen_de_colegios_adoptados_por_categoriaCaptionLbl": Label 'Resumen de colegios adoptados por categoria';
        intColegiosCaptionLbl: Label 'Total colegios';
        CategoriasPromotor__Categoria_colegio_CaptionLbl: Label 'Categoria';
        TraerNombrePromotorCaptionLbl: Label 'Nombre promotor';
        No_adoptadosCaptionLbl: Label 'No adoptados';
        AdoptadosCaptionLbl: Label 'Adoptados';
        Faltan_decidirCaptionLbl: Label 'Faltan decidir';
        EjemplaresCaptionLbl: Label 'Ejemplares';

    procedure TraerNombrePromotor(): Text[50]
    var
        recPromotor: Record 13;
    begin
        IF recPromotor.GET(CategoriasPromotor."Cod. Promotor") THEN
            EXIT(recPromotor.Name);
    end;
}

