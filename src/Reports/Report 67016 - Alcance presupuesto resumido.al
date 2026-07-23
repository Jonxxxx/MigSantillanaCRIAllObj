report 67016 "Alcance presupuesto resumido"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Alcance presupuesto resumido.rdlc';

    dataset
    {
        dataitem(Presupuesto; 67060)
        {
            CalcFields = "Descripcion nivel";
            DataItemTableView = SORTING(Usuario, "Fecha hora", "Cod. Nivel", "Linea de negocio", Familia, "Sub Familia");
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
            column(Cod__Nivel_________Descripcion_nivel_; "Cod. Nivel" + ' - ' + "Descripcion nivel")
            {
            }
            column(TraerDescripcionSubFamilia; TraerDescripcionSubFamilia)
            {
            }
            column(Presupuesto__Sub_Familia_; "Sub Familia")
            {
            }
            column(TraerDescripcionFamilia; TraerDescripcionFamilia)
            {
            }
            column(Presupuesto_Familia; Familia)
            {
            }
            column(TraerDescripcionLinNeg; TraerDescripcionLinNeg)
            {
            }
            column(Presupuesto__Linea_de_negocio_; "Linea de negocio")
            {
            }
            column(Presupuesto__Cdad__presupuestada_; "Cdad. presupuestada")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Monto__presupuestado_; "Monto. presupuestado")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Cdad__alcance_; "Cdad. alcance")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Monto_alcance_; "Monto alcance")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Cdad__mnto__; "Cdad. mnto.")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Cdad__conquista_; "Cdad. conquista")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Cdad__perdida_; "Cdad. perdida")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Adoption_StatisticCaption; Adoption_StatisticCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Cod__familiaCaption"; Cod__familiaCaptionLbl)
            {
            }
            column("Cod__subfamiliaCaption"; Cod__subfamiliaCaptionLbl)
            {
            }
            column("Cod__linea_de_negocioCaption"; Cod__linea_de_negocioCaptionLbl)
            {
            }
            column(Cdad__alcanceCaption; Cdad__alcanceCaptionLbl)
            {
            }
            column(SubfamiliaCaption; SubfamiliaCaptionLbl)
            {
            }
            column(FamiliaCaption; FamiliaCaptionLbl)
            {
            }
            column("Linea_de_negocioCaption"; Linea_de_negocioCaptionLbl)
            {
            }
            column(decCdadPresCaption; decCdadPresCaptionLbl)
            {
            }
            column(decMontoPresCaption; decMontoPresCaptionLbl)
            {
            }
            column(decMontoAlcanceCaption; decMontoAlcanceCaptionLbl)
            {
            }
            column(decCdadMantCaption; decCdadMantCaptionLbl)
            {
            }
            column(decCdadConquistaCaption; decCdadConquistaCaptionLbl)
            {
            }
            column(decCdadPerdidasCaption; decCdadPerdidasCaptionLbl)
            {
            }
            column(Nivel_Caption; Nivel_CaptionLbl)
            {
            }
            column(Presupuesto_Usuario; Usuario)
            {
            }
            column(Presupuesto_Fecha_hora; "Fecha hora")
            {
            }
            column(Presupuesto_No__mov; "No. mov")
            {
            }
            column(Presupuesto_Cod__Nivel; "Cod. Nivel")
            {
            }

            trigger OnPreDataItem()
            begin
                SETRANGE(Usuario, USERID);
                SETRANGE("Fecha hora", dtImpresion);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Promotor; codPromotor)
                {
                    TableRelation = "Salesperson/Purchaser";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        recTemp.RESET;
        recTemp.SETRANGE(Usuario, USERID);
        recTemp.SETRANGE("Fecha hora", dtImpresion);
        recTemp.DELETEALL;
    end;

    trigger OnPreReport()
    begin
        dtImpresion := CURRENTDATETIME;
        CargarDatosTemp;
    end;

    var
        recTemp: Record 67060;
        dlgProgreso: Dialog;
        codPromotor: Code[20];
        dtImpresion: DateTime;
        decMontoPRes: Decimal;
        decMontoAlcance: Decimal;
        Text001: Label 'Cargando datos presupuestos';
        Text002: Label '##############################1\\';
        Text003: Label '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2';
        Text004: Label 'Cargando datos adopciones';
        Adoption_StatisticCaptionLbl: Label 'Alcance de presupuesto resumido';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        "Cod__familiaCaptionLbl": Label 'Cod. familia';
        "Cod__subfamiliaCaptionLbl": Label 'Cod. subfamilia';
        "Cod__linea_de_negocioCaptionLbl": Label 'Cod. linea de negocio';
        Cdad__alcanceCaptionLbl: Label 'Cdad. alcance';
        SubfamiliaCaptionLbl: Label 'Subfamilia';
        FamiliaCaptionLbl: Label 'Familia';
        "Linea_de_negocioCaptionLbl": Label 'Linea de negocio';
        decCdadPresCaptionLbl: Label 'Cdad. presup.';
        decMontoPresCaptionLbl: Label 'Monto presup.';
        decMontoAlcanceCaptionLbl: Label 'Monto alcance';
        decCdadMantCaptionLbl: Label 'Cdad. mante.';
        decCdadConquistaCaptionLbl: Label 'Cdad. Conquis.';
        decCdadPerdidasCaptionLbl: Label 'Cdad perdidas';
        Nivel_CaptionLbl: Label 'Nivel:';

    procedure CalcularPrecio(codPrmProd: Code[20]): Decimal
    var
        recProducto: Record 27;
        recTarifas: Record 7002;
    begin

        IF recProducto.GET(codPrmProd) THEN BEGIN
            recTarifas.RESET;
            recTarifas.SETRANGE("Item No.", codPrmProd);
            recTarifas.SETFILTER("Variant Code", '%1', '');
            recTarifas.SETFILTER("Ending Date", '%1|>=%2', 0D, WORKDATE);
            recTarifas.SETFILTER("Currency Code", '%1', '');
            recTarifas.SETFILTER("Unit of Measure Code", '%1|%2', recProducto."Sales Unit of Measure", '');
            recTarifas.SETRANGE("Starting Date", 0D, WORKDATE);
            recTarifas.SETRANGE("Sales Type", recTarifas."Sales Type"::"All Customers");
            IF recTarifas.FINDFIRST THEN
                EXIT(recTarifas."Unit Price")
            ELSE
                EXIT(recProducto."Unit Price");
        END;
    end;

    procedure TraerDescripcionDimension(codPrmDim: Code[20]; codPrmValor: Code[20]): Text[100]
    var
        recDimVal: Record 349;
    begin
        IF recDimVal.GET(codPrmDim, codPrmValor) THEN
            EXIT(recDimVal.Name);
    end;

    procedure CargarDatosTemp()
    var
        recTmpRep: Record 67060 temporary;
        recPpto: Record 67027;
        recAdopciones: Record 67053;
        recProducto: Record 27;
        codNivel: Code[20];
        codLinNeg: Code[20];
        codFamilia: Code[20];
        codSubFamilia: Code[20];
        decPrecio: Decimal;
        intProcesados: Integer;
        intTotal: Integer;
        intMov: Integer;
    begin

        dlgProgreso.OPEN(Text002 + Text003);

        recPpto.RESET;
        IF codPromotor <> '' THEN
            recPpto.SETRANGE("Cod. Promotor", codPromotor);
        IF recPpto.FINDSET THEN BEGIN
            dlgProgreso.UPDATE(1, Text001);
            intTotal := recPpto.COUNT;
            REPEAT
                IF recProducto.GET(recPpto."Cod. Producto") THEN BEGIN
                    codNivel := recProducto."Nivel Educativo APS";
                    codLinNeg := recProducto.GetLineaNegocio;
                    codFamilia := recProducto.GetFamilia;
                    codSubFamilia := recProducto.GetSubfamilia;
                    decPrecio := CalcularPrecio(recProducto."No.");

                    recTmpRep.RESET;
                    recTmpRep.SETCURRENTKEY(Usuario, "Fecha hora", "Cod. Nivel", "Linea de negocio", Familia, "Sub Familia");
                    recTmpRep.SETRANGE(Usuario, USERID);
                    recTmpRep.SETRANGE("Fecha hora", dtImpresion);
                    recTmpRep.SETRANGE("Cod. Nivel", codNivel);
                    recTmpRep.SETRANGE("Linea de negocio", codLinNeg);
                    recTmpRep.SETRANGE(Familia, codFamilia);
                    recTmpRep.SETRANGE("Sub Familia", codSubFamilia);
                    IF recTmpRep.FINDFIRST THEN BEGIN
                        recTmpRep."Cdad. presupuestada" += recPpto.Quantity;
                        recTmpRep."Monto. presupuestado" += (decPrecio * recPpto.Quantity);
                        recTmpRep.MODIFY;
                    END
                    ELSE BEGIN
                        intMov += 1;
                        recTmpRep.INIT;
                        recTmpRep."No. mov" := intMov;
                        recTmpRep."Cod. Nivel" := codNivel;
                        recTmpRep."Linea de negocio" := codLinNeg;
                        recTmpRep.Familia := codFamilia;
                        recTmpRep."Sub Familia" := codSubFamilia;
                        recTmpRep."Cdad. presupuestada" := recPpto.Quantity;
                        recTmpRep."Monto. presupuestado" := (decPrecio * recPpto.Quantity);
                        recTmpRep.Usuario := USERID;
                        recTmpRep."Fecha hora" := dtImpresion;
                        recTmpRep.INSERT;
                    END;
                END;

                intProcesados += 1;
                IF intProcesados MOD 100 = 0 THEN
                    dlgProgreso.UPDATE(2, ROUND(intProcesados / intTotal * 10000, 1));
            UNTIL recPpto.NEXT = 0;
        END;

        recAdopciones.RESET;
        IF codPromotor <> '' THEN
            recAdopciones.SETRANGE("Cod. Promotor", codPromotor);
        IF recAdopciones.FINDSET THEN BEGIN
            dlgProgreso.UPDATE(1, Text004);
            intTotal := recAdopciones.COUNT;
            intProcesados := 0;
            REPEAT

                IF recProducto.GET(recAdopciones."Cod. Producto") THEN BEGIN
                    codNivel := recProducto."Nivel Educativo APS";
                    codLinNeg := recProducto.GetLineaNegocio;
                    codFamilia := recProducto.GetFamilia;
                    codSubFamilia := recProducto.GetSubfamilia;
                    decPrecio := CalcularPrecio(recProducto."No.");

                    recTmpRep.RESET;
                    recTmpRep.SETCURRENTKEY(Usuario, "Fecha hora", "Cod. Nivel", "Linea de negocio", Familia, "Sub Familia");
                    recTmpRep.SETRANGE(Usuario, USERID);
                    recTmpRep.SETRANGE("Fecha hora", dtImpresion);
                    recTmpRep.SETRANGE("Cod. Nivel", codNivel);
                    recTmpRep.SETRANGE("Linea de negocio", codLinNeg);
                    recTmpRep.SETRANGE(Familia, codFamilia);
                    recTmpRep.SETRANGE("Sub Familia", codSubFamilia);
                    IF recTmpRep.FINDFIRST THEN BEGIN
                        CASE recAdopciones.Adopcion OF
                            recAdopciones.Adopcion::Conquista:
                                BEGIN
                                    recTmpRep."Cdad. conquista" += recAdopciones."Adopcion Real";
                                    recTmpRep."Cdad. alcance" += recAdopciones."Adopcion Real";
                                    recTmpRep."Monto alcance" += (recAdopciones."Adopcion Real" * decPrecio);
                                END;
                            recAdopciones.Adopcion::Mantener:
                                BEGIN
                                    recTmpRep."Cdad. mnto." += recAdopciones."Adopcion Real";
                                    recTmpRep."Cdad. alcance" += recAdopciones."Adopcion Real";
                                    recTmpRep."Monto alcance" += (recAdopciones."Adopcion Real" * decPrecio);
                                END;
                            recAdopciones.Adopcion::Perdida:
                                recTmpRep."Cdad. perdida" += recAdopciones."Adopcion Real";
                        END;
                        recTmpRep.MODIFY;
                    END
                    ELSE BEGIN
                        recTmpRep.INIT;
                        intMov += 1;
                        recTmpRep."No. mov" := intMov;
                        recTmpRep."Cod. Nivel" := codNivel;
                        recTmpRep."Linea de negocio" := codLinNeg;
                        recTmpRep.Familia := codFamilia;
                        recTmpRep."Sub Familia" := codSubFamilia;
                        CASE recAdopciones.Adopcion OF
                            recAdopciones.Adopcion::Conquista:
                                recTmpRep."Cdad. conquista" := recAdopciones."Adopcion Real";
                            recAdopciones.Adopcion::Mantener:
                                recTmpRep."Cdad. mnto." := recAdopciones."Adopcion Real";
                            recAdopciones.Adopcion::Perdida:
                                recTmpRep."Cdad. perdida" := recAdopciones."Adopcion Real";
                        END;
                        recTmpRep."Cdad. alcance" := recTmpRep."Cdad. conquista" + recTmpRep."Cdad. mnto.";
                        recTmpRep."Monto alcance" := recTmpRep."Cdad. alcance" * decPrecio;
                        recTmpRep.Usuario := USERID;
                        recTmpRep."Fecha hora" := dtImpresion;
                        recTmpRep.INSERT;
                    END;
                END;

                intProcesados += 1;
                IF intProcesados MOD 100 = 0 THEN
                    dlgProgreso.UPDATE(2, ROUND(intProcesados / intTotal * 10000, 1));
            UNTIL recAdopciones.NEXT = 0;
        END;
        dlgProgreso.CLOSE;


        //Cargo los datos primero en un record temporary = Yes por una cuestion de rendiemiento.
        recTmpRep.RESET;
        IF recTmpRep.FINDSET THEN
            REPEAT
                recTemp := recTmpRep;
                recTemp.INSERT;
            UNTIL recTmpRep.NEXT = 0;
    end;
}

