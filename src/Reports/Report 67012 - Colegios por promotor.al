report 67012 "Colegios por promotor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Colegios por promotor.rdlc';

    dataset
    {
        dataitem(Adopciones; 67052)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Cod. Colegio");
            RequestFilterFields = "Cod. Promotor", "Cod. Colegio";
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
            column(codGrados_1_; codGrados[1])
            {
            }
            column(codGrados_2_; codGrados[2])
            {
            }
            column(codGrados_4_; codGrados[4])
            {
            }
            column(codGrados_3_; codGrados[3])
            {
            }
            column(codGrados_6_; codGrados[6])
            {
            }
            column(codGrados_5_; codGrados[5])
            {
            }
            column(codGrados_9_; codGrados[9])
            {
            }
            column(codGrados_8_; codGrados[8])
            {
            }
            column(codGrados_7_; codGrados[7])
            {
            }
            column(codGrados_10_; codGrados[10])
            {
            }
            column(codGrados_11_; codGrados[11])
            {
            }
            column(codGrados_12_; codGrados[12])
            {
            }
            column(codGrados_18_; codGrados[18])
            {
            }
            column(codGrados_17_; codGrados[17])
            {
            }
            column(codGrados_16_; codGrados[16])
            {
            }
            column(codGrados_15_; codGrados[15])
            {
            }
            column(codGrados_14_; codGrados[14])
            {
            }
            column(codGrados_13_; codGrados[13])
            {
            }
            column(codGrados_19_; codGrados[19])
            {
            }
            column(Adopciones__Cod__Promotor_; "Cod. Promotor")
            {
            }
            column(Adopciones__Nombre_Promotor_; "Nombre Promotor")
            {
            }
            column(texDistrito; texDistrito)
            {
            }
            column(decTotalGrado_1_; decTotalGrado[1])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_2_; decTotalGrado[2])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_3_; decTotalGrado[3])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_4_; decTotalGrado[4])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_5_; decTotalGrado[5])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_6_; decTotalGrado[6])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_7_; decTotalGrado[7])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_8_; decTotalGrado[8])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_9_; decTotalGrado[9])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_10_; decTotalGrado[10])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_11_; decTotalGrado[11])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_12_; decTotalGrado[12])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_18_; decTotalGrado[18])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_17_; decTotalGrado[17])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_16_; decTotalGrado[16])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_15_; decTotalGrado[15])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_14_; decTotalGrado[14])
            {
                DecimalPlaces = 0 : 2;
            }
            column(decTotalGrado_13_; decTotalGrado[13])
            {
                DecimalPlaces = 0 : 2;
            }
            column(codCategoria; codCategoria)
            {
            }
            column(decTotalGrado_19_; decTotalGrado[19])
            {
                DecimalPlaces = 0 : 2;
            }
            column(Adopciones__Cod__Colegio_; "Cod. Colegio")
            {
            }
            column(Adopciones__Nombre_Colegio_; "Nombre Colegio")
            {
            }
            column(Colegios_por_promotorCaption; Colegios_por_promotorCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(codCategoriaCaption; codCategoriaCaptionLbl)
            {
            }
            column(texDistritoCaption; texDistritoCaptionLbl)
            {
            }
            column(Adopciones__Cod__Colegio_Caption; Adopciones__Cod__Colegio_CaptionLbl)
            {
            }
            column(Adopciones__Nombre_Colegio_Caption; FIELDCAPTION("Nombre Colegio"))
            {
            }
            column(Adopciones__Cod__Promotor_Caption; Adopciones__Cod__Promotor_CaptionLbl)
            {
            }
            column(Adopciones_Turno; Turno)
            {
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(texDistrito);

                codCategoria := TraerCategoria("Cod. Colegio", "Cod. Nivel");
                IF recColegio.GET("Cod. Colegio") THEN
                    texDistrito := recColegio.Distritos;

                CargarTotalGrados;
            end;

            trigger OnPreDataItem()
            begin
                CargarGrados;
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
        codCategoria: Code[10];
        texDistrito: Text[30];
        codGrados: array[20] of Code[20];
        decTotalGrado: array[20] of Decimal;
        Colegios_por_promotorCaptionLbl: Label 'Colegios por promotor';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        codCategoriaCaptionLbl: Label 'Cat.';
        texDistritoCaptionLbl: Label 'Distrito';
        Adopciones__Cod__Colegio_CaptionLbl: Label 'Cód. Colegio';
        Adopciones__Cod__Promotor_CaptionLbl: Label 'Promotor:';

    procedure TraerCategoria(codPrmColegio: Code[20]; codPrmNivel: Code[20]): Code[10]
    var
        recNivel: Record 67036;
    begin
        recNivel.RESET;
        recNivel.SETRANGE("Cod. Colegio", codPrmColegio);
        //recNivel.SETRANGE("Cod. Promotor", codPrmProm);
        recNivel.SETRANGE("Cod. Nivel", codPrmNivel);
        IF recNivel.FINDFIRST THEN
            EXIT(recNivel."Categoria colegio");
    end;

    procedure CargarGrados()
    var
        recGrados: Record 67002;
        i: Integer;
    begin
        recGrados.RESET;
        recGrados.SETCURRENTKEY("Orden en informes");
        recGrados.SETFILTER("Orden en informes", '<>%1', 0);
        recGrados.SETRANGE("Tipo registro", recGrados."Tipo registro"::Grados);

        IF recGrados.FINDSET THEN
            REPEAT
                i += 1;
                codGrados[i] := recGrados.Codigo;
            UNTIL (recGrados.NEXT = 0) OR (i = ARRAYLEN(codGrados));
    end;

    procedure CargarTotalGrados()
    var
        recDetalle: Record 67053;
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(codGrados) DO BEGIN
            recDetalle.RESET;
            recDetalle.SETCURRENTKEY("Cod. Colegio", "Cod. Grado", "Cod. Promotor", Adopcion);
            recDetalle.SETRANGE("Cod. Colegio", Adopciones."Cod. Colegio");
            recDetalle.SETRANGE("Cod. Promotor", Adopciones."Cod. Promotor");
            recDetalle.SETRANGE("Cod. Grado", codGrados[i]);
            recDetalle.SETFILTER(Adopcion, '%1|%2', recDetalle.Adopcion::Conquista, recDetalle.Adopcion::Mantener);
            recDetalle.CALCSUMS("Adopcion Real");
            decTotalGrado[i] := recDetalle."Adopcion Real";
        END;
    end;
}

