report 56138 "Estadisticas de Vtas."
{
    // 
    //  WHERE("Item Ledger Entry Type"=FILTER(Sale),Invoiced Quantity=FILTER(<>0))
    // 
    // #2297  CAT 03/04/2014  Añadido campo "Cód. categoría producto" y "Nº Devolucion" para filtro de los usuarios.
    //                        Nota migracion: no existe el campo "Cód. categoría producto"
    // 
    // #6280  PLB 19/11/2014  Guardaba todos los datos como texto en el Excel... ahora guardará la fecha como fecha y las cantidades
    //                        e importes como números.
    //                        Algunos ajustes en el código
    //        PLB 06/07/2016  Faltaba el MakeExcelDataBody3 para guardar como números en el Excel.
    // 
    // #34579 FAA 28/10/2015  Se crea función ya que el reporte muestra datos erroneos.
    //        PLB 05/07/2015  Si se genera excel, no generar dataset para imprimir, y así poder sacar un año entero
    //                        No generar el total por dimension si es detallado
    // 
    // #37692 MOI 30/11/2015  Se modifica la formula para obtener el valor de la venta neta.
    //                        La formula es: Venta neta:=Importe Venta bruta - Importe Devolucion bruta + Importe Descuento. (Ver Excel WI)
    // 
    // 010 #56268 RRT 01.09.2016: Corrección en la versión para Excel, para la columna "Vta. Liquida"
    // 011 #56799 RRT 15.09.2016: Que se pueda invocar como SAVEASEXCEL. Añadir las columnas de código y descripción del vendedor.
    // 012 #57840 RRT 13.10.2016: Mostrar el "grupo contable negocio" y la linea de negocio en el formato EXCEL. Poder filtrar por estos campos.
    // 013 #58537 RRT 19.10.2016: Mostrar la descripción del producto en la versión Excel.
    // 014 #62474 JMB 23.01.2011: Añadir la descripcíon del cliente justo despues del código (en el layout RDLC).
    // 015 #188565 YFC 1/15/2019: Adicionar 3 campos a reporte de Estadísticas de Vtas. (EXCEL)
    // #230560, RRT, 09.07.2019 : Si el nombre del colegio queda sin valor, asignar el relacionado con la factura o NCR registrada.
    // 
    // 
    // Proyecto: Microsoft Dynamics Business Central
    // ------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma           Descripción
    // ------------------------------------------------------------------------
    // 016     07-02-2020      FES             SANTINAV-1017: Adicionar importe impuesto incluido venta
    // 017     02-MAR-2021     FES             SANTINAV-2210: Adicionar Codigo Colegio y Tipo Colegio para los Clientes Tipo Mostrador
    // 018     13-ENE-2022     FES             SANTINAV-2871. Adicionar el campo Categoria Pedido Venta.
    // 019     13-Enero-2022   FES             SANTINAV-2916. Permitir seleccionar rango en filtro producto.
    // 020     12-07-2023      LDP             SANTINAV-4746: crear filtro en Estadisticas de Vtas. (EXCEL)
    // 021     18-09-2025      LDP             SANTINAV-8394: Crear campo ŽCanal de Venta en cabecera de pedidos y agregarlo al reporte de estadísticas
    DefaultLayout = RDLC;
    RDLCLayout = './Estadisticas de Vtas..rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Value Entry"; 5802)
        {
            DataItemTableView = SORTING("Gen. Bus. Posting Group", "Global Dimension 1 Code")
                                ORDER(Ascending)
                                WHERE("Item Ledger Entry Type" = FILTER(Sale),
                                      Invoiced Quantity=FILTER(<>0));
            RequestFilterFields = "Item No.","Source No.","Global Dimension 2 Code","Posting Date","Document Type","Gen. Bus. Posting Group","Global Dimension 1 Code";
            column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(USERID;USERID)
            {
            }
            column(Filtros;Filtros)
            {
            }
            column(Detallado_;Detallado)
            {
            }
            column(Value_Entry__Gen__Bus__Posting_Group_;"Gen. Bus. Posting Group")
            {
            }
            column(Dim1;Dim1)
            {
            }
            column(Value_Entry__Source_No__;"Source No.")
            {
            }
            column(Value_Entry__Source_Name__;Nombre)
            {
            }
            column(NombreColegio;NombreColegio)
            {
            }
            column(TipoColegio;TipoColegio)
            {
            }
            column(DimensionRegComp;DimensionRegComp)
            {
            }
            column(Dim2;Dim2)
            {
            }
            column(Value_Entry__Item_No__;"Item No.")
            {
            }
            column(Value_Entry__Document_No__;"Document No.")
            {
            }
            column(Categoria_Pedido;CategoriaPedido)
            {
            }
            column(CategoriaPedidoCaption_lbl;CategoriaPedidoCaption)
            {
            }
            column(Value_Entry__Posting_Date_;"Posting Date")
            {
            }
            column(CtdDevol;CtdDevol)
            {
            }
            column(ImpVtaBta;ImpVtaBta)
            {
            }
            column(ImpDevol;ImpDevol)
            {
            }
            column(CtdVtaBta___CtdDevol;CtdVtaBta - CtdDevol)
            {
            }
            column(ImpVtaBta___ImpDevol;ImpVtaBta - ImpDevol)
            {
            }
            column(Value_Entry__Discount_Amount_;DiscountAmount)
            {
            }
            column(ImpVtaBta___ImpDevol___ABS__Discount_Amount__;(ImpVtaBta - ImpDevol)+DiscountAmount)
            {
            }
            column(V1__Cost_Amount__Actual__;CostAmount)
            {
            }
            column(CtdVtaBta;CtdVtaBta)
            {
            }
            column(TotalFor___Dim1;TotalFor + Dim1)
            {
            }
            column(CtdVtaBta_Control1000000063;CtdVtaBtaDimTot)
            {
            }
            column(CtdDevol_Control1000000064;CtdDevolDimTot)
            {
            }
            column(ImpVtaBta_Control1000000065;ImpVtaBtaDimTot)
            {
            }
            column(ImpDevol_Control1000000066;ImpDevolDimTot)
            {
            }
            column(CtdVtaBta___CtdDevol_Control1000000067;CtdVtaBtaDimTot - CtdDevolDimTot)
            {
            }
            column(ImpVtaBta___ImpDevol_Control1000000068;ImpVtaBtaDimTot - ImpDevolDimTot)
            {
            }
            column(Value_Entry__Discount_Amount__Control1000000069;DiscountAmountDimTot)
            {
            }
            column(ImpVtaBta___ImpDevol___ABS__Discount_Amount___Control1000000070;(ImpVtaBtaDimTot - ImpDevolDimTot) -ABS(DiscountAmountDimTot))
            {
            }
            column(V1__Cost_Amount__Actual___Control1000000071;CostAmountDimTot)
            {
            }
            column(TotalFor____Gen__Bus__Posting_Group_;TotalFor + "Gen. Bus. Posting Group")
            {
            }
            column(CtdVtaBta_Control1000000081;CtdVtaBtaGenTot)
            {
            }
            column(CtdDevol_Control1000000082;CtdDevolGenTot)
            {
            }
            column(ImpVtaBta_Control1000000083;ImpVtaBtaGenTot)
            {
            }
            column(ImpDevol_Control1000000084;ImpDevolGenTot)
            {
            }
            column(CtdVtaBta___CtdDevol_Control1000000085;CtdVtaBtaGenTot - CtdDevolGenTot)
            {
            }
            column(ImpVtaBta___ImpDevol_Control1000000086;ImpVtaBtaGenTot - ImpDevolGenTot)
            {
            }
            column(Value_Entry__Discount_Amount__Control1000000087;DiscountAmountGenTot)
            {
            }
            column(ImpVtaBta___ImpDevol___ABS__Discount_Amount___Control1000000088;(ImpVtaBtaGenTot - ImpDevolGenTot) -ABS(DiscountAmountGenTot))
            {
            }
            column(V1__Cost_Amount__Actual___Control1000000089;CostAmountGenTot)
            {
            }
            column(CtdVtaBta_Control1000000011;CtdVtaBtaGranTot)
            {
            }
            column(CtdDevol_Control1000000012;CtdDevolGranTot)
            {
            }
            column(ImpVtaBta_Control1000000019;ImpVtaBtaGranTot)
            {
            }
            column(ImpDevol_Control1000000020;ImpDevolGranTot)
            {
            }
            column(CtdVtaBta___CtdDevol_Control1000000021;CtdVtaBtaGranTot - CtdDevolGranTot)
            {
            }
            column(ImpVtaBta___ImpDevol_Control1000000022;ImpVtaBtaGranTot - ImpDevolGranTot)
            {
            }
            column(Value_Entry__Discount_Amount__Control1000000025;DiscountAmountGranTot)
            {
            }
            column(ImpVtaBta___ImpDevol___ABS__Discount_Amount___Control1000000026;(ImpVtaBtaGranTot - ImpDevolGranTot) -ABS(DiscountAmountGranTot))
            {
            }
            column(V1__Cost_Amount__Actual___Control1000000027;CostAmountGranTot)
            {
            }
            column(Value_EntryCaption;Value_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column("Cód__ClienteCaption";Cód__ClienteCaptionLbl)
            {
            }
            column(Tipor_ClienteCaption;Tipor_ClienteCaptionLbl)
            {
            }
            column(Value_Entry__Item_No__Caption;FIELDCAPTION("Item No."))
            {
            }
            column(Cant__Ventas_BrutasCaption;Cant__Ventas_BrutasCaptionLbl)
            {
            }
            column("Vta__LíquidaCaption";Vta__LíquidaCaptionLbl)
            {
            }
            column(Value_Entry__Discount_Amount_Caption;Value_Entry__Discount_Amount_CaptionLbl)
            {
            }
            column(Value_Entry__Document_No__Caption;FIELDCAPTION("Document No."))
            {
            }
            column(Value_Entry__Posting_Date_Caption;FIELDCAPTION("Posting Date"))
            {
            }
            column(Cant__Devol__BrutaCaption;Cant__Devol__BrutaCaptionLbl)
            {
            }
            column(Imp__Ventas_BrutasCaption;Imp__Ventas_BrutasCaptionLbl)
            {
            }
            column(Imp__Devol__BrutasCaption;Imp__Devol__BrutasCaptionLbl)
            {
            }
            column(Cant__Ventas_NetasCaption;Cant__Ventas_NetasCaptionLbl)
            {
            }
            column(Imp__Vtas__NetasCaption;Imp__Vtas__NetasCaptionLbl)
            {
            }
            column(Costo_de_Vta_Caption;Costo_de_Vta_CaptionLbl)
            {
            }
            column(Value_Entry__Gen__Bus__Posting_Group_Caption;FIELDCAPTION("Gen. Bus. Posting Group"))
            {
            }
            column(Dim1Caption;Dim1CaptionLbl)
            {
            }
            column(TotalesCaption;TotalesCaptionLbl)
            {
            }
            column(Value_Entry_Entry_No_;"Entry No.")
            {
            }
            column(Value_Entry_Global_Dimension_1_Code;"Global Dimension 1 Code")
            {
            }
            column(wSalidaExcel;wSalidaExcel)
            {
            }
            column(Cod_Vendedor;"Salespers./Purch. Code")
            {
            }
            column(wNombreVendedor;wNombreVendedor)
            {
            }
            column(wVEFiltros;wVEFiltros)
            {
            }
            column(GenBusPostingGroup_ValueEntry;"Value Entry"."Gen. Bus. Posting Group")
            {
            }
            column(GlobalDimension1Code_ValueEntry;"Value Entry"."Global Dimension 1 Code")
            {
            }
            column(DescProducto;Desc)
            {
            }
            column(Importe_Impuesto_Incluido_Caption;ImporteImpInc_Lbl)
            {
            }
            column(Importe_Impuesto_Incluido;ImpVatInc)
            {
            }
            column(Impote_Impuesto_Incluido_Nota_Credito_Caption;ImporteImpIncCR_Lbl)
            {
            }
            column(Impote_Impuesto_Incluido_Nota_Credito;ImpVatIncCR)
            {
            }
            column(Cod_Colegio_;CodColegio)
            {
            }
            column(Cod_Colegio_Caption;CodColegio_Caption)
            {
            }
            column(Canalventa;Canalventa)
            {
            }
            column(Canalventa_Lbl;Canalventa_Lbl)
            {
            }
            dataitem("Sales Invoice Header";112)
            {
                DataItemLink = "No."=FIELD("Document No.");
                RequestFilterFields = "Categoria Pedido Venta";
            }

            trigger OnAfterGetRecord()
            var
                lrVendedor: Record 13;
                lrSIH: Record 112;
                lrSCMH: Record 114;
                lrContact: Record 5050;
                lrSIL: Record 113;
                lrSCML: Record 115;
            begin
                CtdVtaBta := 0; ImpVtaBta := 0;  CtdDevol:= 0; ImpDevol := 0; CostAmount := 0; DiscountAmount := 0;
                //016+
                ImpVatInc := 0; ImpVatIncCR := 0;
                //016-
                
                //+011
                wNombreVendedor := '';
                IF "Salespers./Purch. Code" <> '' THEN
                  IF lrVendedor.GET("Salespers./Purch. Code") THEN
                    wNombreVendedor := lrVendedor.Name;
                //-011
                
                //+013
                Desc := '';
                //-013
                
                IF FirstTime THEN
                  GroupHeader2;
                
                //total por dimension
                IF (DimAnt <> "Global Dimension 1 Code") THEN BEGIN
                  Borrardim;
                  DimAnt := "Global Dimension 1 Code";
                
                  //+011
                  wWindow.UPDATE(2,DimAnt);
                  //-011
                
                END;
                
                // Totales  por grupo negocio
                IF (GenAnt <> "Gen. Bus. Posting Group") THEN BEGIN
                  Borrargen;
                  GenAnt := "Gen. Bus. Posting Group";
                  //+011
                  wWindow.UPDATE(1,GenAnt);
                  //-011
                
                END;
                
                //CostAmount := "Cost Amount (Actual)";
                CostAmount := TotalMovimientosProductos("Item Ledger Entry No."); //#34579
                DiscountAmount := "Discount Amount";
                
                IF "Invoiced Quantity" < 0 THEN BEGIN
                  //-#6280
                  //CtdVtaBta := ABS("Invoiced Quantity");
                  //ImpVtaBta := ABS("Sales Amount (Actual)") + ABS("Discount Amount");
                  CtdVtaBta := -"Invoiced Quantity";
                  ImpVtaBta := "Sales Amount (Actual)" - "Discount Amount";
                
                  //016++
                  lrSIL.RESET;        //Venta
                  lrSIL.SETRANGE("Document No.","Document No.");
                  lrSIL.SETRANGE("Line No.","Document Line No.");
                  IF lrSIL.FINDSET THEN
                    REPEAT
                      ImpVatInc := lrSIL."Amount Including VAT";
                    UNTIL lrSIL.NEXT= 0;
                  //016-
                  //+#6280
                END
                ELSE BEGIN
                  //-#6280
                  //CtdDevol := ABS("Invoiced Quantity");
                  //ImpDevol := ABS("Sales Amount (Actual)") + ABS("Discount Amount");
                  CtdDevol := "Invoiced Quantity";
                  ImpDevol := -"Sales Amount (Actual)" + "Discount Amount";
                  //+#6280
                
                  //016++
                  lrSCML.RESET;       //Nota Credito
                  lrSCML.SETRANGE("Document No.","Document No.");
                  lrSCML.SETRANGE("Line No.","Document Line No.");
                  IF lrSCML.FINDSET THEN
                    REPEAT
                      ImpVatIncCR := lrSCML."Amount Including VAT";
                    UNTIL lrSCML.NEXT = 0;
                  //016-
                END;
                
                //GLS.GET; //-#6280
                IF DV.GET(GLS."Global Dimension 1 Code","Global Dimension 1 Code") THEN
                  Dim1 := DV.Name
                ELSE
                  Dim1 := "Global Dimension 1 Code";
                
                //017+
                /*
                 // ++ #188565
                  IF Cust.GET("Source No.") THEN BEGIN
                    IF (Cust."Cod. Colegio" <> '') AND (Cust."Tipos de colegios" <> '')  THEN
                      BEGIN
                        IF  Contact.GET(Cust."Cod. Colegio") THEN
                          NombreColegio := Contact.Name;
                        TipoColegio := Cust."Tipos de colegios";
                      END
                    ELSE
                      BEGIN
                        NombreColegio := '';
                        TipoColegio :=  '';
                      END
                  END
                  ELSE BEGIN
                    NombreColegio := '';
                    TipoColegio :=  '';
                  END;
                
                  DefaultDimension.RESET;
                  DefaultDimension.SETCURRENTKEY("Table ID","No.","Dimension Code");
                  DefaultDimension.SETRANGE("Table ID",18);
                  DefaultDimension.SETRANGE("No.","Source No.");
                  DefaultDimension.SETRANGE("Dimension Code",'REGULAR/COMPARTIR');
                  IF DefaultDimension.FINDFIRST THEN
                    DimensionRegComp := DefaultDimension."Dimension Value Code"
                  ELSE
                    DimensionRegComp := '';
                
                // -- #188565
                  IF Cust.GET("Source No.") THEN BEGIN
                    IF  Contact.GET(Cust."Cod. Colegio") THEN
                      NombreColegio := Contact.Name;
                    TipoColegio := Cust."Tipos de colegios";
                  */
                  //017 - ORIGINAL-
                
                  //017+  MODIFICADO+
                  NombreColegio := '';
                  TipoColegio :=  '';
                  DimensionRegComp := '';
                  CodColegio := '';
                
                  IF Cust.GET("Source No.") THEN
                    BEGIN
                      IF Contact.GET(Cust."Cod. Colegio") THEN
                        BEGIN
                          NombreColegio := Contact.Name;
                          CodColegio := Contact."No.";
                          IF Contact."Tipo de colegio" <> '' THEN
                            TipoColegio := Contact."Tipo de colegio"
                          ELSE
                            IF Cust."Tipos de colegios" <> '' THEN
                              TipoColegio := Cust."Tipos de colegios";
                        END;
                
                      DefaultDimension.RESET;
                      DefaultDimension.SETCURRENTKEY("Table ID","No.","Dimension Code");
                      DefaultDimension.SETRANGE("Table ID",18);
                      DefaultDimension.SETRANGE("No.","Source No.");
                      DefaultDimension.SETRANGE("Dimension Code",'REGULAR/COMPARTIR');
                      IF DefaultDimension.FINDFIRST THEN
                        DimensionRegComp := DefaultDimension."Dimension Value Code";
                    END;
                  //017-  MODIFICADO-
                
                //+#230560
                //... Las ventas que provienen de POS, llevan el nombre del colegio.
                //... Creo que si no es detallado, no se visualiza el nombre del colegio.
                IF Detallado AND (NombreColegio = '') THEN BEGIN
                  CASE "Document Type" OF
                    "Document Type"::"Sales Invoice":
                      IF lrSIH.GET("Document No.") THEN
                        IF lrSIH."Nombre Colegio" <> '' THEN
                          BEGIN //017+-
                            NombreColegio := lrSIH."Nombre Colegio";
                            //017+
                            IF lrSIH."Cod. Colegio" <> '' THEN
                              BEGIN
                                CodColegio := lrSIH."Cod. Colegio";
                                IF lrContact.GET(CodColegio) THEN
                                  IF lrContact."Tipo de colegio" <> '' THEN
                                    TipoColegio := lrContact."Tipo de colegio";
                              END;
                          END
                            //017-
                        ELSE BEGIN
                          IF lrSIH."Cod. Colegio" <> '' THEN BEGIN
                            NombreColegio := lrSIH."Cod. Colegio";
                            IF lrContact.GET(lrSIH."Cod. Colegio") THEN
                              IF lrContact.Name <> '' THEN
                                BEGIN //017+-
                                  NombreColegio := lrContact.Name;
                                  //017+
                                  CodColegio := lrContact."No.";
                                  IF lrContact."Tipo de colegio" <> '' THEN
                                    TipoColegio := lrContact."Tipo de colegio";
                                END;
                                //017-
                          END;
                        END;
                    "Document Type"::"Sales Credit Memo":
                      IF lrSCMH.GET("Document No.") THEN
                        IF lrSCMH."Nombre Colegio" <> '' THEN
                          BEGIN //017+-
                            NombreColegio := lrSCMH."Nombre Colegio";
                            //017+
                            IF lrSCMH."Cod. Colegio" <> '' THEN
                              BEGIN
                                CodColegio := lrSCMH."Cod. Colegio";
                                IF lrContact.GET(CodColegio) THEN
                                  IF lrContact."Tipo de colegio" <> '' THEN
                                    TipoColegio := lrContact."Tipo de colegio";
                              END;
                            END
                            //017-
                        ELSE BEGIN
                          IF lrSCMH."Cod. Colegio" <> '' THEN BEGIN
                            NombreColegio := lrSCMH."Cod. Colegio";
                            IF lrContact.GET(lrSCMH."Cod. Colegio") THEN
                              IF lrContact.Name <> '' THEN
                                BEGIN   //017+-
                                  NombreColegio := lrContact.Name;
                                  //017+
                                  CodColegio := lrContact."No.";
                                  IF lrContact."Tipo de colegio" <> '' THEN
                                    TipoColegio := lrContact."Tipo de colegio";
                                END;
                                //017-
                          END;
                        END;
                
                  END;
                END;
                //-#230560
                
                IF Detallado THEN
                 BEGIN
                  //GLS.GET; //+#6280
                  IF DV.GET(GLS."Global Dimension 2 Code","Global Dimension 2 Code") THEN
                    Dim2 := DV.Name
                  ELSE
                    Dim2 := "Global Dimension 2 Code";
                
                  IF Cust.GET("Source No.") THEN
                    Nombre := Cust.Name
                  ELSE
                    Nombre := '';
                
                //020+
                IF wCategoriaPedido = '' THEN//020+
                  //018+
                  CASE "Document Type" OF
                    "Document Type"::"Sales Invoice":
                      IF lrSIH.GET("Document No.") THEN
                        CategoriaPedido := lrSIH."Categoria Pedido Venta";
                
                    "Document Type"::"Sales Credit Memo":
                      IF lrSCMH.GET("Document No.") THEN
                        CategoriaPedido := lrSCMH."Categoria Pedido Venta";
                  END;
                  //018-
                
                IF wCategoriaPedido <> '' THEN//020+
                  CASE "Document Type" OF
                    "Document Type"::"Sales Invoice":
                    BEGIN
                      //IF lrSIH.GET("Document No.") THEN //020+
                        //020+
                        lrSIH.SETRANGE("No.","Document No.");
                        IF wCategoriaPedido <> '' THEN
                          lrSIH.SETRANGE("Categoria Pedido Venta",wCategoriaPedido);//LDP+-
                          IF NOT lrSIH.FINDFIRST THEN
                            CurrReport.SKIP
                           ELSE
                            CategoriaPedido := lrSIH."Categoria Pedido Venta";
                      END;
                    "Document Type"::"Sales Credit Memo":
                     BEGIN
                      //IF lrSCMH.GET("Document No.") THEN //020+
                        //020+
                        lrSCMH.SETRANGE("No.","Document No.");
                        IF wCategoriaPedido <> '' THEN
                         lrSCMH.SETRANGE("Categoria Pedido Venta",wCategoriaPedido);
                          IF NOT lrSCMH.FINDFIRST THEN
                            CurrReport.SKIP
                           ELSE
                            CategoriaPedido := lrSCMH."Categoria Pedido Venta";
                     END
                  END;
                //020-
                
                //021+
                CLEAR(Canalventa);
                IF wCanalVenta = '' THEN
                  //018+
                  CASE "Document Type" OF
                    "Document Type"::"Sales Invoice":
                      IF lrSIH.GET("Document No.") THEN
                        Canalventa := Funcionesvarias.BuscaDimension(lrSIH."No.");
                
                    "Document Type"::"Sales Credit Memo":
                      IF lrSCMH.GET("Document No.") THEN
                        Canalventa := Funcionesvarias.BuscaDimension(lrSCMH."No.");
                  END;
                
                CLEAR(Canalventa);
                IF wCanalVenta <> '' THEN BEGIN
                  CASE "Document Type" OF
                    "Document Type"::"Sales Invoice":
                    BEGIN
                        lrSIH.SETRANGE("No.","Document No.");
                        //IF wCanalVenta <> '' THEN
                          Canalventa := Funcionesvarias.BuscaDimension(lrSIH."No.");
                          IF Canalventa <> wCanalVenta THEN
                            CurrReport.SKIP;
                           //ELSE
                            //Canalventa := Funcionesvarias.BuscaDimension("Document No.");
                      END;
                    "Document Type"::"Sales Credit Memo":
                     BEGIN
                      //IF lrSCMH.GET("Document No.") THEN //020+
                        //020+
                        lrSCMH.SETRANGE("No.","Document No.");
                        //IF wCanalVenta <> '' THEN
                          Canalventa := Funcionesvarias.BuscaDimension(lrSCMH."No.");
                          IF Canalventa <> wCanalVenta THEN
                            CurrReport.SKIP;
                     END
                  END;
                END;
                //021-
                
                  IF Item.GET("Item No.") THEN
                    Desc := Item.Description
                  ELSE
                    Desc := '';
                
                  IF recVendedores.GET("Salespers./Purch. Code") THEN
                    texNombVendedor := recVendedores.Name
                  ELSE
                    texNombVendedor := '';
                
                  IF PrintToExcel THEN
                    MakeExcelDataBody;
                END;
                
                Acumular;
                
                //021+
                //CLEAR(Canalventa);
                Canalventa := Funcionesvarias.BuscaDimension("Value Entry"."Document No.");
                ExcelBuf.AddColumn(Canalventa,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);//021+-
                //021-
                
                //+#34579
                IF PrintToExcel THEN
                  CurrReport.SKIP;
                //-#34579

            end;

            trigger OnPostDataItem()
            begin

                IF PrintToExcel THEN BEGIN
                  GroupHeader1;
                  MakeExcelDataBody2;
                  MakeExcelDataBody3;
                  MakeExcelFooter;
                END;

                //+011
                wWindow.CLOSE;
                //-011
            end;

            trigger OnPreDataItem()
            var
                rSCMH: Record 114;
                lText001: Label 'El Nº Devolución introducido no pertenece a nínguna Nota de crédito registrada';
                lrSIH: Record 112;
                lrSCMH: Record 114;
            begin
                //+#2297
                IF codNumDev <> '' THEN BEGIN
                  rSCMH.SETRANGE("Return Order No.", codNumDev);
                  IF rSCMH.FINDFIRST THEN BEGIN
                    SETRANGE("Document Type", "Document Type"::"Sales Credit Memo");
                    SETRANGE("Document No.", rSCMH."No.");
                  END
                  ELSE
                    ERROR(lText001);
                END;
                //-#2297
                
                FirstTime := TRUE;
                
                //+012
                IF wGCN <> '' THEN
                  SETRANGE("Gen. Bus. Posting Group",wGCN);
                
                IF wLineaNegocio <> '' THEN
                  SETRANGE("Global Dimension 1 Code",wLineaNegocio);
                //-012
                
                
                //+011
                //... Establecer los filtros, considerando que este reporte puede ser invocado desde otro objeto.
                IF (wFechaIni <> 0D) AND (wFechaFin <> 0D) THEN
                  SETRANGE("Posting Date",wFechaIni,wFechaFin);
                
                IF wCliente <> '' THEN BEGIN
                  SETRANGE("Source Type","Source Type"::Customer);
                  SETRANGE("Source No.",wCliente);
                END;
                
                //019+
                //IF wProducto <> '' THEN
                  //SETRANGE("Item No.",wProducto);
                IF (wProducto <> '') OR (wProducto2 <>'') THEN
                  SETRANGE("Item No.",wProducto,wProducto2);
                //019-
                
                IF wTipoCliente <> '' THEN
                  SETRANGE("Global Dimension 2 Code",wTipoCliente);
                
                //020+
                //IF wCategoriaPedido <> '' THEN
                  //SETRANGE(CategoriaPedido,wCategoriaPedido);
                //020-
                
                //020+
                /*
                IF wCategoriaPedido <> '' THEN
                  BEGIN
                    lrSIH.SETRANGE("Categoria Pedido Venta",wCategoriaPedido);//LDP+-
                    IF lrSIH.FINDFIRST THEN
                     SETRANGE("Document No.",lrSIH."No.");
                
                    //IF lrSIH.FINDFIRST THEN;
                    lrSCMH.SETRANGE("Categoria Pedido Venta",wCategoriaPedido);//LDP+-
                     IF lrSCMH.FINDFIRST THEN
                       SETRANGE("Document No.",lrSCMH."No.");
                  END;
                  */
                //020-
                
                wSalidaExcel := wSalidaExcelExt  OR PrintToExcel;
                //-011
                
                IF PrintToExcel THEN
                  MakeExcelDataHeader;
                
                //+011
                wWindow.OPEN(Text100);
                //-011

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(PrintToExcel;PrintToExcel)
                    {
                        Caption = 'Export to excel';
                    }
                    field(Detallado;Detallado)
                    {
                        Caption = 'Detallado';
                    }
                    field(codNumDev;codNumDev)
                    {
                        Caption = 'Nº Devolución';
                        Visible = true;
                    }
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
        IF PrintToExcel THEN
          CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        GLS.GET; //+#6280
        CI.GET;
        Filtros := "Value Entry".GETFILTERS;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Detallado: Boolean;
        Nombre: Text[150];
        Cust: Record 18;
        Desc: Text[150];
        Item: Record 27;
        CtdVtaBta: Decimal;
        CtdDevol: Decimal;
        ImpVtaBta: Decimal;
        ImpDevol: Decimal;
        CostAmount: Decimal;
        DiscountAmount: Decimal;
        ExcelBuf: Record 370 temporary;
        PrintToExcel: Boolean;
        Text001: Label 'Data';
        Text000: Label 'Redeemed Cupon''s Report';
        CI: Record 79;
        GLS: Record 98;
        DV: Record 349;
        Dim2: Text[100];
        Dim1: Text[100];
        Filtros: Text[1024];
        texNombVendedor: Text[200];
        codNumDev: Code[20];
        recVendedores: Record 13;
        DimAnt: Code[20];
        GenAnt: Code[10];
        CtdVtaBtaGenTot: Decimal;
        CtdDevolGenTot: Decimal;
        ImpVtaBtaGenTot: Decimal;
        ImpDevolGenTot: Decimal;
        CostAmountGenTot: Decimal;
        DiscountAmountGenTot: Decimal;
        CtdVtaBtaDimTot: Decimal;
        CtdDevolDimTot: Decimal;
        ImpVtaBtaDimTot: Decimal;
        ImpDevolDimTot: Decimal;
        CostAmountDimTot: Decimal;
        DiscountAmountDimTot: Decimal;
        CtdVtaBtaGranTot: Decimal;
        CtdDevolGranTot: Decimal;
        ImpVtaBtaGranTot: Decimal;
        ImpDevolGranTot: Decimal;
        CostAmountGranTot: Decimal;
        DiscountAmountGranTot: Decimal;
        FirstTime: Boolean;
        lastgen: Code[10];
        Value_EntryCaptionLbl: Label 'Value Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Cód__ClienteCaptionLbl": Label 'Cód. Cliente';
        Tipor_ClienteCaptionLbl: Label 'Tipor Cliente';
        Cant__Ventas_BrutasCaptionLbl: Label 'Cant. Ventas Brutas';
        "Vta__LíquidaCaptionLbl": Label 'Vta. Líquida';
        Value_Entry__Discount_Amount_CaptionLbl: Label 'Importe Descuento';
        Cant__Devol__BrutaCaptionLbl: Label 'Cant. Devol. Bruta';
        Imp__Ventas_BrutasCaptionLbl: Label 'Imp. Ventas Brutas';
        Imp__Devol__BrutasCaptionLbl: Label 'Imp. Devol. Brutas';
        Cant__Ventas_NetasCaptionLbl: Label 'Cant. Ventas Netas';
        Imp__Vtas__NetasCaptionLbl: Label 'Imp. Vtas. Netas';
        Costo_de_Vta_CaptionLbl: Label 'Costo de Vta.';
        Dim1CaptionLbl: Label 'Línea de negocio :';
        TotalesCaptionLbl: Label 'Totales';
        wFechaIni: Date;
        wFechaFin: Date;
        wSalidaExcelExt: Boolean;
        wSalidaExcel: Boolean;
        wNombreVendedor: Text[100];
        wTipoCliente: Code[20];
        wCliente: Code[20];
        wProducto: Code[20];
        wProducto2: Code[20];
        wTipoDocumento: Option " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";
        rVE: Record 5802;
        wVEFiltros: Text[1024];
        wWindow: Dialog;
        Text100: Label 'Grupo contable negocio ##########1  Linea negocio ############2';
        wGCN: Code[20];
        wLineaNegocio: Code[20];
        NombreColegio: Text[150];
        TipoColegio: Code[20];
        DimensionRegComp: Code[20];
        DefaultDimension: Record 352;
        Contact: Record 5050;
        ImporteImpInc_Lbl: Label 'Importe Impuestos Incluidos';
        ImpVatInc: Decimal;
        ImporteVatIncGenTot: Decimal;
        ImporteVatIncGranTot: Decimal;
        ImpVatIncCR: Decimal;
        ImporteVatIncGenTotCR: Decimal;
        ImporteVatIncGranTotCR: Decimal;
        ImporteImpIncCR_Lbl: Label 'Importe Imp. Inc. Nota Crédito';
        CodColegio: Code[20];
        CodColegio_Caption: Label 'School Code';
        NombreArchivo: Text;
        RutaArchivo: Text;
        CategoriaPedido: Code[20];
        CategoriaPedidoCaption: Label 'Order Category';
        wCategoriaPedido: Code[20];
        Funcionesvarias: Codeunit 50001;
        Canalventa: Code[20];
        Canalventa_Lbl: Label 'Canal de Venta';
        wCanalVenta: Code[20];

    local procedure CreateExcelbook()
    var
        TextL006: Label 'EstadisticasVentas';
        lRuta: Text[1024];
        lFile: Text[100];
        lFile0: Text[100];
        lrMySession: Record 2000000110;
    begin
        /*
        lRuta := 'C:\Libros Excel\';
        
        lFile:='';
        IF lrMySession.FINDFIRST THEN
          lFile := FORMAT(lrMySession."Session ID");
        lFile := lFile + TextL006;
        */
        //ExcelBuf.CreateBookAndOpenExcel(lRuta+lFile+'.xlsx',Text001,Text000,COMPANYNAME,USERID);
        ExcelBuf.CreateBookAndOpenExcel('',Text001,Text000,COMPANYNAME,USERID);
        ERROR('');

    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Filtros,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(CI.Name + ' RUC '+CI."VAT Registration No.",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('MOVIMIENTO VALOR',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;

        ExcelBuf.AddColumn('No. Documento',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Categoría Pedido',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text); //018+-
        ExcelBuf.AddColumn('Fecha Registro',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cod. Cliente',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Tipo Cliente',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('No. Producto',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+013
        IF Detallado THEN
          ExcelBuf.AddColumn('Descripcion Producto',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //-013

        ExcelBuf.AddColumn('Cant. Vtas. Brutas',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Imp. Vta. Bruta',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cant. Devol. Brutas',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Imp. Devol. Bruta',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Cant. Vta. Neta',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Imp. Vta. Neta',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Imp. Dto.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vta. Liquida',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Costo Vta.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //016
        ExcelBuf.AddColumn('Importe Impuesto Incluido',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //016
        ExcelBuf.AddColumn('Grpo. Contable Neg.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Desc. Producto',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Nombre Cliente',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+011
        IF Detallado THEN BEGIN  //+013
          ExcelBuf.AddColumn('Cód. Vendedor',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Nombre Vendedor',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        //-011

        //+012
        IF Detallado THEN BEGIN  //+013
          ExcelBuf.AddColumn('Grupo contable negocio',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn('Linea de negocio',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        //-012

        // ++ #188565
        //SANTINAV-2210
        ExcelBuf.AddColumn('Código Colegio ',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //SANTINAV-2210
        ExcelBuf.AddColumn('Nombre Colegio',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Tipos de colegios',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Dimensión REGULAR/COMPARTIR',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Canal de Venta',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);//021+- - //SANTINAV-8394
        // -- #188565
    end;

    local procedure MakeExcelDataBody()
    begin

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Value Entry"."Document No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn("Value Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text); //-#6280
        ExcelBuf.AddColumn(CategoriaPedido,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);  //018+-
        ExcelBuf.AddColumn("Value Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date); //+#6280
        ExcelBuf.AddColumn("Value Entry"."Source No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //GLS.GET; //-#6280
        IF DV.GET(GLS."Global Dimension 2 Code","Value Entry"."Global Dimension 2 Code") THEN
          ExcelBuf.AddColumn(DV.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn("Value Entry"."Global Dimension 2 Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        ExcelBuf.AddColumn("Value Entry"."Item No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+013
        IF Detallado THEN
          ExcelBuf.AddColumn(Desc,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //-013

        //+#6280
        //ExcelBuf.AddColumn(CtdVtaBta,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBta,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdVtaBta - CtdDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBta - ImpDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn("Value Entry"."Discount Amount",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn((ImpVtaBta - ImpDevol) -ABS("Value Entry"."Discount Amount"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(-1*"Value Entry"."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CtdVtaBta,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBta,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdVtaBta - CtdDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBta - ImpDevol,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn("Value Entry"."Discount Amount",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //#37692:Inicio
        //ExcelBuf.AddColumn((ImpVtaBta - ImpDevol) -ABS("Value Entry"."Discount Amount"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn((ImpVtaBta - ImpDevol)+("Value Entry"."Discount Amount"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //#37692:Fin
        //+#34579
        //ExcelBuf.AddColumn(-1*"Value Entry"."Cost Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(-1* CostAmount,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-#34579
        //-#6280

        ExcelBuf.AddColumn("Value Entry"."Gen. Bus. Posting Group",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Desc,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Nombre,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+011
        IF Detallado THEN BEGIN  //+013
          ExcelBuf.AddColumn("Value Entry"."Salespers./Purch. Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(wNombreVendedor,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        //-011

        //+012
        IF Detallado THEN BEGIN  //+013
          ExcelBuf.AddColumn("Value Entry"."Gen. Bus. Posting Group",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn("Value Entry"."Global Dimension 1 Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
        //-012

        // ++ #188565
        //SANTINAV-2210
          ExcelBuf.AddColumn(CodColegio,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //SANTINAV-2210
          ExcelBuf.AddColumn(NombreColegio,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(TipoColegio,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(DimensionRegComp,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        // -- #188565
          //021+
          CLEAR(Canalventa);
          Canalventa := Funcionesvarias.BuscaDimension("Value Entry"."Document No.");
          ExcelBuf.AddColumn(Canalventa,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);//021+-
          //021-
    end;

    local procedure MakeExcelFooter()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TOTALES ',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+#6280
        //ExcelBuf.AddColumn(CtdVtaBtaGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdVtaBtaGranTot - CtdDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaGranTot - ImpDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(DiscountAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn((ImpVtaBtaGranTot - ImpDevolGranTot) -ABS(DiscountAmountGranTot),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(-1*CostAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CtdVtaBtaGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //016++
        ExcelBuf.AddColumn(ImporteVatIncGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImporteVatIncGranTotCR,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //016-
        ExcelBuf.AddColumn(CtdDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdVtaBtaGranTot - CtdDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaGranTot - ImpDevolGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(DiscountAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);

        //+010
        //ExcelBuf.AddColumn((ImpVtaBtaGranTot - ImpDevolGranTot) -ABS(DiscountAmountGranTot),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn((ImpVtaBtaGranTot - ImpDevolGranTot) + DiscountAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-010

        //+#34579
        //ExcelBuf.AddColumn(-1*CostAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CostAmountGranTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-#34579
        //-#6280
    end;

    procedure GroupHeader1()
    begin

        IF Detallado THEN
          EXIT;

        IF Dim1 = '' THEN
          EXIT;

        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Línea de Negocio',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Dim1,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
    end;

    procedure GroupHeader2()
    begin

        IF ((GenAnt = "Value Entry"."Gen. Bus. Posting Group") AND (NOT FirstTime)) OR
           ((lastgen = "Value Entry"."Gen. Bus. Posting Group") AND (lastgen <>'')) THEN
          EXIT;


        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Grupo Cont. Negocio',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("Value Entry"."Gen. Bus. Posting Group",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        FirstTime  := FALSE;
        lastgen    := "Value Entry"."Gen. Bus. Posting Group";
    end;

    local procedure MakeExcelDataBody2()
    begin
        //+#34579
        IF Detallado THEN
          EXIT;
        //-#34579

        IF (CtdVtaBtaDimTot = 0) AND (ImpVtaBtaDimTot = 0) AND (CtdDevolDimTot =0) AND (ImpDevolDimTot=0) THEN
          EXIT;

        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+#6280
        //ExcelBuf.AddColumn(CtdVtaBtaDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdVtaBtaDimTot - CtdDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaDimTot - ImpDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(DiscountAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn((ImpVtaBtaDimTot - ImpDevolDimTot) -ABS(DiscountAmountDimTot),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(-1*CostAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CtdVtaBtaDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdVtaBtaDimTot - CtdDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaDimTot - ImpDevolDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(DiscountAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);

        //+010
        //ExcelBuf.AddColumn((ImpVtaBtaDimTot - ImpDevolDimTot) -ABS(DiscountAmountDimTot),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn((ImpVtaBtaDimTot - ImpDevolDimTot) + DiscountAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-010

        //+#34579
        //ExcelBuf.AddColumn(-1*CostAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CostAmountDimTot,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-#34579
        //-#6280
    end;

    local procedure MakeExcelDataBody3()
    begin

        IF (CtdVtaBtaGenTot=0) AND (ImpVtaBtaGenTot=0) AND (CtdDevolGenTot=0) AND (ImpDevolGenTot=0) THEN
          EXIT;

        ExcelBuf.NewRow;
        //ExcelBuf.AddColumn(TotalFor + "Value Entry"."Gen. Bus. Posting Group",FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalFor + GenAnt,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        //+#6280
        //ExcelBuf.AddColumn(CtdVtaBtaGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(CtdVtaBtaGenTot - CtdDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(ImpVtaBtaGenTot - ImpDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(DiscountAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn((ImpVtaBtaGenTot - ImpDevolGenTot) -ABS(DiscountAmountGenTot),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //ExcelBuf.AddColumn(-1*CostAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(CtdVtaBtaGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //016++
        ExcelBuf.AddColumn(ImporteVatIncGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImporteVatIncGenTotCR,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //016-
        ExcelBuf.AddColumn(CtdDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CtdVtaBtaGenTot - CtdDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(ImpVtaBtaGenTot - ImpDevolGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(DiscountAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);

        //+010
        //ExcelBuf.AddColumn((ImpVtaBtaGenTot - ImpDevolGenTot) -ABS(DiscountAmountGenTot),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn((ImpVtaBtaGenTot - ImpDevolGenTot) + DiscountAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-010

        //+#34579
        //ExcelBuf.AddColumn(-1*CostAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(CostAmountGenTot,FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        //-#34579
        //-#6280
    end;

    procedure Acumular()
    begin

        CtdVtaBtaGenTot +=  CtdVtaBta;
        CtdDevolGenTot  += CtdDevol;
        ImpVtaBtaGenTot += ImpVtaBta;
        //016++
        ImporteVatIncGenTot += ImpVatInc;
        ImporteVatIncGenTotCR += ImpVatIncCR;
        //016-
        ImpDevolGenTot   += ImpDevol;
        CostAmountGenTot += CostAmount;
        DiscountAmountGenTot += DiscountAmount;

        CtdVtaBtaDimTot +=  CtdVtaBta;
        CtdDevolDimTot  += CtdDevol;
        ImpVtaBtaDimTot += ImpVtaBta;
        ImpDevolDimTot   += ImpDevol;
        CostAmountDimTot += CostAmount;
        DiscountAmountDimTot += DiscountAmount;

        CtdVtaBtaGranTot +=  CtdVtaBta;
        CtdDevolGranTot  += CtdDevol;
        ImpVtaBtaGranTot += ImpVtaBta;
        //016++
        ImporteVatIncGranTot += ImpVatInc;
        ImporteVatIncGranTotCR += ImpVatIncCR;
        //016-
        ImpDevolGranTot   += ImpDevol;
        CostAmountGranTot += CostAmount;
        DiscountAmountGranTot += DiscountAmount;
    end;

    procedure Borrargen()
    begin

        IF PrintToExcel THEN
          MakeExcelDataBody3;

        CtdVtaBtaGenTot := 0;
        CtdDevolGenTot := 0;
        ImpVtaBtaGenTot := 0;
        //016++
        ImporteVatIncGenTot := 0;
        ImporteVatIncGenTotCR := 0;
        //016-

        ImpDevolGenTot := 0;
        CostAmountGenTot := 0;
        DiscountAmountGenTot := 0;

        IF PrintToExcel AND (NOT FirstTime)THEN
          GroupHeader2;

        FirstTime := FALSE;
    end;

    procedure Borrardim()
    begin

        IF PrintToExcel THEN BEGIN
          GroupHeader1;
          MakeExcelDataBody2;
        END;

        CtdVtaBtaDimTot := 0;
        CtdDevolDimTot := 0;
        ImpVtaBtaDimTot := 0;
        ImpDevolDimTot := 0;
        CostAmountDimTot := 0;
        DiscountAmountDimTot := 0;
    end;

    procedure TotalMovimientosProductos(intNoMovProducto: Integer): Decimal
    var
        recValueEntry: Record 5802;
    begin
        //#34579
        recValueEntry.RESET;
        recValueEntry.SETCURRENTKEY("Item Ledger Entry No.","Entry Type");
        recValueEntry.SETRANGE("Item Ledger Entry No.",intNoMovProducto);
        recValueEntry.CALCSUMS("Cost Amount (Actual)");
        EXIT(recValueEntry."Cost Amount (Actual)");
    end;

    procedure Parametros(pSalidaExcelExt: Boolean;pDetallado: Boolean;pFechaIni: Date;pFechaFin: Date;pCodNumDev: Code[20];pTipoCliente: Code[20];pCliente: Code[20];pProducto: Code[20];pProducto2: Code[20];pTipoDocumento: Option " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly";pGCN: Code[20];pLineaNegocio: Code[20];pCategoriaPedido: Code[250];pCanalVenta: Code[20])
    var
        lrSCMH: Record 114;
    begin
        //+011
        wSalidaExcelExt := pSalidaExcelExt;
        Detallado       := pDetallado;
        wFechaIni       := pFechaIni;
        wFechaFin       := pFechaFin;
        codNumDev       := pCodNumDev;
        wTipoCliente    := pTipoCliente;
        wCliente        := pCliente;
        wProducto       := pProducto;
        wProducto2      := pProducto2; //019+-
        wTipoDocumento  := pTipoDocumento;
        //+012
        wGCN            := pGCN;
        wLineaNegocio   := pLineaNegocio;
        //-012
        wCategoriaPedido:= pCategoriaPedido;//020+-

        wCanalVenta := pCanalVenta;//021+-

        rVE.RESET;

        IF codNumDev <> '' THEN BEGIN
          lrSCMH.SETRANGE("Return Order No.", codNumDev);
          IF lrSCMH.FINDFIRST THEN BEGIN
            rVE.SETRANGE("Document Type", "Value Entry"."Document Type"::"Sales Credit Memo");
            rVE.SETRANGE("Document No.", "Value Entry"."No.");
          END;
        END;

        IF (wFechaIni <> 0D) AND (wFechaFin <> 0D) THEN
          rVE.SETRANGE("Posting Date",wFechaIni,wFechaFin);

        IF wCliente <> '' THEN BEGIN
          rVE.SETRANGE("Source Type","Value Entry"."Source Type"::Customer);
          rVE.SETRANGE("Source No.",wCliente);
        END;

        //019+
        //IF wProducto <> '' THEN
          //rVE.SETRANGE("Item No.",wProducto);
        IF (wProducto <> '') OR (wProducto2 <>'') THEN
          rVE.SETRANGE("Item No.",wProducto,wProducto2);
        //019-

        IF wTipoCliente <> '' THEN
          rVE.SETRANGE("Global Dimension 2 Code",wTipoCliente);

        //+012
        IF wGCN <> '' THEN
          rVE.SETRANGE("Gen. Bus. Posting Group",wGCN);

        IF wLineaNegocio <> '' THEN
          rVE.SETRANGE("Global Dimension 1 Code",wLineaNegocio);
        //-012


        //
        //IF wCategoriaPedido <> '' THEN
          //rVE.SETRANGE()
        //
        wVEFiltros := rVE.GETFILTERS;
    end;
}

