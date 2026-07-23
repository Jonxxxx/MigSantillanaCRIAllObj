report 67011 "Alcance presupuesto promotor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Alcance presupuesto promotor.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Presupuesto; 67027)
        {
            DataItemTableView = SORTING("Cod. Promotor", "Cod. Producto")
                                WHERE("Cod. Promotor" = FILTER(<> ''));
            RequestFilterFields = "Cod. Promotor", "Cod. Producto";
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
            column(Presupuesto__Cod__Promotor_; "Cod. Promotor")
            {
            }
            column(Presupuesto__Nombre_Promotor_; "Nombre Promotor")
            {
            }
            column(codNivel; codNivel)
            {
            }
            column(texDescLinNeg; texDescLinNeg)
            {
            }
            column(decMontoPres; decMontoPres)
            {
                DecimalPlaces = 0 : 2;
            }
            column(decMontoAlcance; decMontoAlcance)
            {
                DecimalPlaces = 0 : 2;
            }
            column(decCdadMant; decCdadMant)
            {
                DecimalPlaces = 0 : 2;
            }
            column(decCdadConquista; decCdadConquista)
            {
                DecimalPlaces = 0 : 2;
            }
            column(decCdadPres; Quantity)
            {
                DecimalPlaces = 0 : 2;
            }
            column(texDescFamilia; texDescFamilia)
            {
            }
            column(texDescSubFamilia; texDescSubFamilia)
            {
            }
            column(texDescEdicionCol; texDescEdicionCol)
            {
            }
            column(decCdadPerdidas; decCdadPerdidas)
            {
                DecimalPlaces = 0 : 2;
            }
            column(Presupuesto__Item_Description_; "Item Description")
            {
            }
            column(Presupuesto__Cod__Producto_; "Cod. Producto")
            {
            }
            column(Adoption_StatisticCaption; Adoption_StatisticCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(codNivelCaption; codNivelCaptionLbl)
            {
            }
            column(codFamiliaCaption; codFamiliaCaptionLbl)
            {
            }
            column(codSubFamiliaCaption; codSubFamiliaCaptionLbl)
            {
            }
            column(codEdicionColCaption; codEdicionColCaptionLbl)
            {
            }
            column(codLinNegCaption; codLinNegCaptionLbl)
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
            column("DescripcionCaption"; DescripcionCaptionLbl)
            {
            }
            column(Presupuesto__Cod__Producto_Caption; FIELDCAPTION("Cod. Producto"))
            {
            }
            column(PromotorCaption; PromotorCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(codLinNeg);
                CLEAR(texDescLinNeg);
                CLEAR(codFamilia);
                CLEAR(texDescFamilia);
                CLEAR(codSubFamilia);
                CLEAR(texDescSubFamilia);
                CLEAR(codEdicionCol);
                CLEAR(texDescEdicionCol);
                CLEAR(codNivel);
                CLEAR(texDescNivel);
                CLEAR(decMontoPres);
                CLEAR(decMontoAlcance);
                CLEAR(decCdadMant);
                CLEAR(decCdadConquista);
                CLEAR(decCdadPerdidas);
                CLEAR(decPrecio);

                recAdopciones.RESET;
                recAdopciones.SETRANGE("Cod. Promotor", "Cod. Promotor");
                recAdopciones.SETRANGE("Cod. Producto", "Cod. Producto");
                IF recAdopciones.FINDSET THEN BEGIN

                    codLinNeg := recAdopciones."Linea de negocio";
                    texDescLinNeg := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Lin. Negocio", codLinNeg);

                    codFamilia := recAdopciones.Familia;
                    texDescFamilia := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Familia", codFamilia);

                    codSubFamilia := recAdopciones."Sub Familia";
                    texDescSubFamilia := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Sub Familia", codSubFamilia);

                    codEdicionCol := recAdopciones.Serie;
                    texDescEdicionCol := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Serie", codEdicionCol);

                    codNivel := recAdopciones."Cod. Nivel";
                    IF recNivel.GET(codNivel) THEN
                        texDescNivel := recNivel.Descripcion;

                    REPEAT
                        CASE recAdopciones.Adopcion OF
                            recAdopciones.Adopcion::Conquista:
                                decCdadConquista += recAdopciones."Adopcion Real";
                            recAdopciones.Adopcion::Mantener:
                                decCdadMant += recAdopciones."Adopcion Real";
                            recAdopciones.Adopcion::Perdida:
                                decCdadPerdidas += recAdopciones."Adopcion Real";
                        END;
                    UNTIL recAdopciones.NEXT = 0;

                END;

                decPrecio := CalcularPrecio("Cod. Producto");
                decMontoPres := decPrecio * Quantity;
                decMontoAlcance := decPrecio * (decCdadConquista + decCdadMant);
            end;

            trigger OnPreDataItem()
            begin
                recCfgAPS.GET;
                recCfgAPS.TESTFIELD("Cod. Dimension Lin. Negocio");
                recCfgAPS.TESTFIELD("Cod. Dimension Familia");
                recCfgAPS.TESTFIELD("Cod. Dimension Sub Familia");
                recCfgAPS.TESTFIELD("Cod. Dimension Serie");
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
        recCfgAPS: Record 67000;
        recAdopciones: Record 67053;
        recNivel: Record 67022;
        codLinNeg: Code[20];
        texDescLinNeg: Text[100];
        codFamilia: Code[20];
        texDescFamilia: Text[100];
        codSubFamilia: Code[20];
        texDescSubFamilia: Text[100];
        codEdicionCol: Code[20];
        texDescEdicionCol: Text[100];
        codNivel: Code[20];
        texDescNivel: Text[100];
        decMontoPres: Decimal;
        decMontoAlcance: Decimal;
        decCdadMant: Decimal;
        decCdadConquista: Decimal;
        decCdadPerdidas: Decimal;
        decPrecio: Decimal;
        Adoption_StatisticCaptionLbl: Label 'Alcance de presupuesto';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        codNivelCaptionLbl: Label 'Nivel';
        codFamiliaCaptionLbl: Label 'Familia';
        codSubFamiliaCaptionLbl: Label 'Subfamilia';
        codEdicionColCaptionLbl: Label 'Edicion coleccion';
        codLinNegCaptionLbl: Label 'Linea de negocio';
        decCdadPresCaptionLbl: Label 'Cdad. presup.';
        decMontoPresCaptionLbl: Label 'Monto presup.';
        decMontoAlcanceCaptionLbl: Label 'Monto alcance';
        decCdadMantCaptionLbl: Label 'Cdad. mante.';
        decCdadConquistaCaptionLbl: Label 'Cdad. Conquis.';
        decCdadPerdidasCaptionLbl: Label 'Cdad perdidas';
        "DescripcionCaptionLbl": Label 'Descripcion';
        PromotorCaptionLbl: Label 'Promotor:';

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
}

