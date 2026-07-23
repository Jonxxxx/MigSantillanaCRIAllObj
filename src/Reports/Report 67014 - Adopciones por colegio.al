report 67014 "Adopciones por colegio"
{
    // Falta como obtener precio.
    DefaultLayout = RDLC;
    RDLCLayout = './Adopciones por colegio.rdlc';


    dataset
    {
        dataitem(Adopciones; 67053)
        {
            DataItemTableView = SORTING("Cod. Colegio", "Cod. Promotor", "Cod. Producto");
            RequestFilterFields = "Cod. Colegio", "Cod. Promotor";
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
            column(Adopciones__Cod__Colegio_; "Cod. Colegio")
            {
            }
            column(Adopciones__Nombre_Colegio_; "Nombre Colegio")
            {
                AutoCalcField = true;
            }
            column(Presupuesto__Nombre_Promotor_; "Nombre Promotor")
            {
            }
            column(Presupuesto__Cod__Promotor_; "Cod. Promotor")
            {
            }
            column(texDescLinNeg; texDescLinNeg)
            {
            }
            column(decPrecio; decPrecio)
            {
                DecimalPlaces = 0 : 2;
            }
            column(codMarca; Adopcion)
            {
                DecimalPlaces = 0 : 2;
            }
            column(intCdadAlumnos; "Cantidad Alumnos")
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
            column(Adopciones__Descripcion_producto_; "Descripcion producto")
            {
                AutoCalcField = true;
            }
            column(Presupuesto__Cod__Producto_; "Cod. Producto")
            {
            }
            column(Adopciones__Cod__Nivel_; "Cod. Nivel")
            {
            }
            column(decCdadPres; "Cod. Grado")
            {
                DecimalPlaces = 0 : 2;
            }
            column(codCategoria; codCategoria)
            {
            }
            column(Adopciones_por_colegioCaption; Adopciones_por_colegioCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
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
            column(decMontoPresCaption; decMontoPresCaptionLbl)
            {
            }
            column(decMontoAlcanceCaption; decMontoAlcanceCaptionLbl)
            {
            }
            column(decCdadMantCaption; decCdadMantCaptionLbl)
            {
            }
            column("DescripciónCaption"; DescripciónCaptionLbl)
            {
            }
            column(Presupuesto__Cod__Producto_Caption; FIELDCAPTION("Cod. Producto"))
            {
            }
            column(codNivelCaption; codNivelCaptionLbl)
            {
            }
            column(decCdadPresCaption; FIELDCAPTION("Cod. Grado"))
            {
            }
            column(Categ_Caption; Categ_CaptionLbl)
            {
            }
            column(Colegio_Caption; Colegio_CaptionLbl)
            {
            }
            column(PromotorCaption; PromotorCaptionLbl)
            {
            }
            column(Adopciones_Grupo_de_Negocio; "Grupo de Negocio")
            {
            }
            column(Adopciones_Cod__Turno; "Cod. Turno")
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
                CLEAR(texDescNivel);
                CLEAR(decPrecio);
                CLEAR(intCdadAlumnos);

                codCategoria := TraerCategoria("Cod. Colegio", "Cod. Nivel");

                texDescLinNeg := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Lin. Negocio", "Linea de negocio");
                texDescFamilia := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Familia", Familia);
                texDescSubFamilia := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Sub Familia", "Sub Familia");
                texDescEdicionCol := TraerDescripcionDimension(recCfgAPS."Cod. Dimension Serie", Serie);

                decPrecio := CalcularPrecio("Cod. Producto");

                IF Adopcion = Adopcion::Perdida THEN
                    "Cantidad Alumnos" := -"Cantidad Alumnos"
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
        _recNivel: Record 67022;
        codLinNeg: Code[20];
        texDescLinNeg: Text[100];
        codFamilia: Code[20];
        texDescFamilia: Text[100];
        codSubFamilia: Code[20];
        texDescSubFamilia: Text[100];
        codEdicionCol: Code[20];
        texDescEdicionCol: Text[100];
        texDescNivel: Text[100];
        decPrecio: Decimal;
        intCdadAlumnos: Integer;
        codCategoria: Code[10];
        Adopciones_por_colegioCaptionLbl: Label 'Adopciones por colegio';
        CurrReport_PAGENOCaptionLbl: Label 'Pág.';
        codFamiliaCaptionLbl: Label 'Familia';
        codSubFamiliaCaptionLbl: Label 'Subfamilia';
        codEdicionColCaptionLbl: Label 'Edición colección';
        codLinNegCaptionLbl: Label 'Línea de negocio';
        decMontoPresCaptionLbl: Label 'Precio';
        decMontoAlcanceCaptionLbl: Label 'Marca';
        decCdadMantCaptionLbl: Label 'Cantidad alumnos';
        "DescripciónCaptionLbl": Label 'Descripción';
        codNivelCaptionLbl: Label 'Nivel';
        Categ_CaptionLbl: Label 'Categ.';
        Colegio_CaptionLbl: Label 'Colegio:';
        PromotorCaptionLbl: Label 'Promotor:';

    procedure CalcularPrecio(codPrmProd: Code[20]): Decimal
    var
        recProducto: Record 27;
    begin
        IF recProducto.GET(codPrmProd) THEN
            EXIT(recProducto."Unit Price");
        //De momento devuelvo el precio del a ficha a falta de saber como obteener el precio que quieren
    end;

    procedure TraerDescripcionDimension(codPrmDim: Code[20]; codPrmValor: Code[20]): Text[100]
    var
        recDimVal: Record 349;
    begin
        IF recDimVal.GET(codPrmDim, codPrmValor) THEN
            EXIT(recDimVal.Name);
    end;

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
}

