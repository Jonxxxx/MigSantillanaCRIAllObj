report 34002513 "DsPOS - NC Venta PY ON"
{
    // 001 #2193     03/03/14     La variable Tel ha cambiado de Code20 a Text30
    // 
    // #5811   PLB   04/11/2014   "Nuevo NCF" en opciones. Si se especifica, el doc. tiene NCF y se ha impreso anteriormente,
    //                            le asigna el nuevo NCF y actualiza los datos
    // 
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - NC Venta PY ON.rdlc';

    Caption = 'Sales Credit Memo';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            CalcFields = "Amount Including VAT", Amount;
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';
            column(ImporteFinal; "Amount Including VAT")
            {
            }
            column(TotalIva; "Amount Including VAT" - Amount)
            {
            }
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; 115)
            {
                DataItemLink = Document No.=FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                dataitem("Sales Comment Line"; 44)
                {
                    DataItemLink = No.=FIELD("Document No."),
                                   Document Line No.=FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type","No.","Document Line No.","Line No.")
                                        WHERE("Document Type"=CONST(Posted Credit Memo),
                                              Print On Credit Memo=CONST(true));

                    trigger OnAfterGetRecord()
                    begin
                        WITH TempSalesCrMemoLine DO BEGIN
                          INIT;
                          "Document No." := "Sales Cr.Memo Header"."No.";
                          "Line No." := HighestLineNo + 10;
                          HighestLineNo := "Line No.";
                        END;
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesCrMemoLine.Description) THEN BEGIN
                          TempSalesCrMemoLine.Description := Comment;
                          TempSalesCrMemoLine."Description 2" := '';
                        END ELSE BEGIN
                          SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                          WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                          IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesCrMemoLine.Description) + 1;
                          TempSalesCrMemoLine.Description := COPYSTR(Comment,1,SpacePointer - 1);
                          TempSalesCrMemoLine."Description 2" :=
                            COPYSTR(COPYSTR(Comment,SpacePointer + 1),1,MAXSTRLEN(TempSalesCrMemoLine."Description 2"));
                        END;
                        TempSalesCrMemoLine.INSERT;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine := "Sales Cr.Memo Line";
                    TempSalesCrMemoLine.INSERT;
                    HighestLineNo := "Line No.";
                    
                    //IVA
                    Columna1IVA := 0;
                    Columna2Iva := 0;
                    ColumnaExe := 0;
                    Columna1IVABase := 0;
                    Columna2IvaBase := 0;
                    ColumnaExeBase  := 0;
                    
                    ConfSant.GET;
                    //CPMCR-CEC+
                    /*
                    ConfSant.TESTFIELD("% IVA Venta 1");
                    ConfSant.TESTFIELD("% IVA Venta 2");
                    */
                    //CPMCR-CEC-
                    IF ("Amount Including VAT" - Amount) <> 0 THEN
                      BEGIN
                        VatPostSet.RESET;
                        VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                        //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 1");      //CPMCR-CEC+-
                        IF VatPostSet.FINDFIRST  THEN
                          BEGIN
                            Columna1IVA := "Amount Including VAT" - Amount;
                            Columna1IVABase := Amount;
                          END;
                        VatPostSet.RESET;
                        VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                        //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 2");      //CPMCR-CEC+-
                        IF VatPostSet.FINDFIRST  THEN
                          BEGIN
                            Columna2Iva := "Amount Including VAT" - Amount;
                            Columna2IvaBase := Amount;
                          END;
                      END
                    ELSE
                      BEGIN
                        ColumnaExe := "Amount Including VAT";
                        ColumnaExeBase := Amount;
                        ColumnaExe := "Amount Including VAT";
                        ColumnaExeBase := Amount;
                      END;
                    //IVA

                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.RESET;
                    TempSalesCrMemoLine.DELETEALL;
                end;
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(CopyTxt;CopyTxt)
                    {
                    }
                    column(CurrReport_PAGENO;CurrReport.PAGENO)
                    {
                    }
                    column(TaxRegLabel;TaxRegLabel)
                    {
                    }
                    column(TaxRegNo;TaxRegNo)
                    {
                    }
                    column(PrintFooter;PrintFooter)
                    {
                    }
                    column(CopyNo;CopyNo)
                    {
                    }
                    column(Serie_Factura_________No__Comprobante_Fiscal_;'D.: ' + "Sales Cr.Memo Header"."No. Comprobante Fiscal")
                    {
                        Description = '"Serie Factura" + ''-''+"No. Comprobante Fiscal"';
                    }
                    column(Sales_Invoice_Header__Posting_Date_;FORMAT("Sales Cr.Memo Header"."Document Date"))
                    {
                    }
                    column(RUC;"Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Phone_No;CompanyInformation."Phone No.")
                    {
                    }
                    column(Sales_Invoice_Header__Bill_to_Customer_No__;"Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Establecimiento;"Sales Cr.Memo Header"."Ship-to Code" + ' - ' + "Sales Cr.Memo Header"."Ship-to Name")
                    {
                    }
                    column(SCMH_Ship_To_Address;"Sales Cr.Memo Header"."Ship-to Address")
                    {
                    }
                    column(Bodega;'Bod.: ' + "Sales Cr.Memo Header"."Location Code")
                    {
                        Description = '"Serie Factura" + ''-''+"No. Comprobante Fiscal"';
                    }
                    column(FechaRegistro;FORMAT("Sales Cr.Memo Header"."Posting Date"))
                    {
                    }
                    column(FacturaANombre;"Sales Cr.Memo Header"."Bill-to Name")
                    {
                    }
                    column(FacturaRelacionada;NoFactAplicada)
                    {
                    }
                    column(DiaFact;Dia)
                    {
                    }
                    column(MesFact;Mes)
                    {
                    }
                    column(anoFact;ano)
                    {
                    }
                    column(Telefono;Tel)
                    {
                    }
                    column(DescriptionLine_1_____________CurrName;DescriptionLine[1] + ' ** ')
                    {
                    }
                    column(Page_Caption;Page_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    dataitem(SalesCrMemoLine; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(STRSUBSTNO_Text001_CurrReport_PAGENO___1_;STRSUBSTNO(Text001,CurrReport.PAGENO - 1))
                        {
                        }
                        column(AmountExclInvDisc;AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine__No__;TempSalesCrMemoLine."No.")
                        {
                        }
                        column(Line_Disc_Pct;TempSalesCrMemoLine."Line Discount %")
                        {
                        }
                        column(TempSalesCrMemoLine_Quantity;TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(UnitPrice;TempSalesCrMemoLine."Unit Price")
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(AmountExclInvDisc_Control53;AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine_Description_________TempSalesCrMemoLine__Description_2_;COPYSTR(TempSalesCrMemoLine.Description,1,22))
                        {
                        }
                        column(ImporteBruto;TempSalesCrMemoLine."Amount Including VAT" + TempSalesCrMemoLine."Line Discount Amount")
                        {
                            DecimalPlaces = 2:5;
                        }
                        column(ImporteDescuento;TempSalesCrMemoLine."Line Discount Amount")
                        {
                        }
                        column(ColumnaExenta;ColumnaExe)
                        {
                        }
                        column(ColumnaIva1;Columna1IVA)
                        {
                        }
                        column(ColumnaIva2;Columna2Iva)
                        {
                        }
                        column(ColumnaIva2Base;Columna2IvaBase)
                        {
                        }
                        column(ColumnaIva1Base;Columna1IVABase)
                        {
                        }
                        column(ColumnaExentaBase;ColumnaExeBase)
                        {
                        }
                        column(TaxLiable;TaxLiable)
                        {
                        }
                        column(TempSalesCrMemoLine_Amount___TaxLiable;TempSalesCrMemoLine.Amount - TaxLiable)
                        {
                        }
                        column(AmountExclInvDisc_Control79;AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine_Amount___AmountExclInvDisc;TempSalesCrMemoLine.Amount - AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT____TempSalesCrMemoLine_Amount;TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT_;TempSalesCrMemoLine."Amount Including VAT")
                        {
                        }
                        column(BreakdownTitle;BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel_1_;BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel_2_;BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt_1_;BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt_2_;BreakdownAmt[2])
                        {
                        }
                        column(BreakdownAmt_3_;BreakdownAmt[3])
                        {
                        }
                        column(BreakdownLabel_3_;BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt_4_;BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel_4_;BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel;TotalTaxLabel)
                        {
                        }
                        column(Item_No_Caption;Item_No_CaptionLbl)
                        {
                        }
                        column(Desc_Pct;Desc_PctLbl)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption;QuantityCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption;Unit_PriceCaptionLbl)
                        {
                        }
                        column(Total_PriceCaption;Total_PriceCaptionLbl)
                        {
                        }
                        column(Subtotal_Caption;Subtotal_CaptionLbl)
                        {
                        }
                        column(Invoice_Discount_Caption;Invoice_Discount_CaptionLbl)
                        {
                        }
                        column(Total_Caption;Total_CaptionLbl)
                        {
                        }
                        column(Amount_Subject_to_Sales_TaxCaption;Amount_Subject_to_Sales_TaxCaptionLbl)
                        {
                        }
                        column(Amount_Exempt_from_Sales_TaxCaption;Amount_Exempt_from_Sales_TaxCaptionLbl)
                        {
                        }
                        column(SalesCrMemoLine_Number;Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            WITH TempSalesCrMemoLine DO BEGIN
                              IF OnLineNumber = 1 THEN
                                FIND('-')
                              ELSE
                                NEXT;
                            
                              IF Type = 0 THEN BEGIN
                                "No." := '';
                                "Unit of Measure" := '';
                                Amount := 0;
                                "Amount Including VAT" := 0;
                                "Inv. Discount Amount" := 0;
                                Quantity := 0;
                              END ELSE IF Type = Type::"G/L Account" THEN
                                "No." := '';
                            
                              IF Amount <> "Amount Including VAT" THEN BEGIN
                                TaxFlag := TRUE;
                                TaxLiable := Amount;
                              END ELSE BEGIN
                                TaxFlag := FALSE;
                                  TaxLiable := 0;
                              END;
                            
                              AmountExclInvDisc := Amount + "Inv. Discount Amount";
                            
                            ConfSant.GET;
                            //CPMCR-CEC+
                            /*
                            ConfSant.TESTFIELD("% IVA Venta 1");
                            ConfSant.TESTFIELD("% IVA Venta 2");
                            */
                            //CPMCR-CEC-
                            IF ("Amount Including VAT" - Amount) <> 0 THEN
                              BEGIN
                                VatPostSet.RESET;
                                VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                                //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 1");   //CPMCR-CEC+-
                                IF VatPostSet.FINDFIRST  THEN
                                  BEGIN
                                    Columna1IVA := "Amount Including VAT" - Amount;
                                    Columna1IVABase := Amount;
                                  END;
                                VatPostSet.RESET;
                                VatPostSet.SETRANGE("VAT Prod. Posting Group","VAT Prod. Posting Group");
                                //VatPostSet.SETRANGE("VAT %",ConfSant."% IVA Venta 2");   //CPMCR-CEC+-
                                IF VatPostSet.FINDFIRST  THEN
                                  BEGIN
                                    Columna2Iva := "Amount Including VAT" - Amount;
                                    Columna2IvaBase := Amount;
                                  END;
                              END
                            ELSE
                              BEGIN
                                ColumnaExe := "Amount Including VAT";
                                ColumnaExeBase := Amount;
                                ColumnaExe := "Amount Including VAT";
                                ColumnaExeBase := Amount;
                              END;
                            //IVA
                            
                            
                              IF Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                              ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);
                            END;
                            
                            IF ISSERVICETIER THEN BEGIN
                              IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            END;

                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(TaxLiable,AmountExclInvDisc,TempSalesCrMemoLine.Amount,TempSalesCrMemoLine."Amount Including VAT",
                                                    TempSalesCrMemoLine."Unit Price",TempSalesCrMemoLine."Line Discount Amount",     //DYN.
                                                    TempSalesCrMemoLine.Quantity);  //DYN.

                            NumberOfLines := TempSalesCrMemoLine.COUNT;
                            SETRANGE(Number,1,NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PAGENO := 1;

                    IF CopyNo = NoLoops THEN BEGIN
                      IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoPrinted.RUN("Sales Cr.Memo Header");
                      CurrReport.BREAK;
                    END ELSE
                      CopyNo := CopyNo + 1;
                    IF CopyNo = 1 THEN // Original
                      CLEAR(CopyTxt)
                    ELSE
                      CopyTxt := Text000;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                      NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // DYN: ---------------------------- Codigo Dynasoft ------------------------------------------------
                
                Comentario := '';
                iBruto := 0;
                ImporteCargos := 0;
                ImporteSinCargos := 0;
                DescuentoCargos := 0;
                CantUnidades := 0;
                igv := 0;
                
                //Factura Aplicada
                SIH.RESET;
                SIH.SETCURRENTKEY("No. Comprobante Fiscal");
                SIH.SETRANGE("No. Comprobante Fiscal","No. Comprobante Fiscal Rel.");
                SIH.SETRANGE("Bill-to Customer No.","Bill-to Customer No.");
                IF SIH.FINDFIRST THEN
                  BEGIN
                    //NoFactAplicada := SIH."Punto de Emision Factura" + '-'+SIH."Establecimiento Factura"+'-'+SIH."No. Comprobante Fiscal";    //CPMCR-CEC+-
                    Dia := DATE2DMY(SIH."Posting Date",1);
                    Mes := DATE2DMY(SIH."Posting Date",2);
                    ano := DATE2DMY(SIH."Posting Date",3);
                  END
                ELSE
                  NoFactAplicada := '';
                //Factura Aplicada
                
                
                Cliente.GET("Sell-to Customer No.");
                Tel := Cliente."Phone No.";
                
                
                IF Loc.GET("Location Code") THEN;
                
                IF "Currency Code" <> '' THEN
                  BEGIN
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                    CodDivLocal := "Currency Code";
                  END
                ELSE
                  BEGIN
                    CurrName := GLSetUp."Nombre Divisa Local";
                    CodDivLocal := GLSetUp."LCY Code";
                  END;
                
                IF Vendedor_Comprador.GET("Salesperson Code") THEN
                 VendorName := Vendedor_Comprador.Name;
                
                IF PT.GET("Payment Terms Code") THEN
                  CondicionPago := PT.Description;
                
                SCL.SETRANGE("Document Type",SCL."Document Type"::"Posted Credit Memo");
                SCL.SETRANGE("No.","No.");
                
                IF SCL.FINDFIRST THEN
                  Comentario := SCL.Comment;
                
                
                CALCFIELDS(Amount,"Amount Including VAT");
                
                IF "Amount Including VAT" - Amount <> 0 THEN
                  txtIva := txt004
                ELSE
                  txtIva := '';
                
                ChkTransMgt.FormatNoText(DescriptionLine,"Amount Including VAT",2058,"Currency Code");
                
                TotFactura := "Amount Including VAT";
                
                //Datos para Historico de RTC
                SIL.RESET;
                SIL.SETRANGE("Document No.","No.");
                SIL.SETFILTER(Type,'<>%1',SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                  REPEAT
                    ImporteSinCargos += SIL.Amount + SIL."Line Discount Amount";
                    Descuento += SIL."Line Discount Amount";
                    CantUnidades += SIL.Quantity;
                    igv += SIL."Amount Including VAT" - SIL.Amount;
                  UNTIL SIL.NEXT = 0;
                
                SIL.RESET;
                SIL.SETRANGE("Document No.","No.");
                SIL.SETRANGE(SIL.Type,SIL.Type::"Charge (Item)");
                IF SIL.FINDSET THEN
                  REPEAT
                    ImporteCargos += SIL.Amount + SIL."Line Discount Amount";
                    DescuentoCargos += SIL."Line Discount Amount";
                    igv += SIL."Amount Including VAT" - SIL.Amount;
                  UNTIL SIL.NEXT = 0;
                
                
                IF Cust.GET("Sell-to Customer No.") THEN
                  Nombre := UPPERCASE(Cust.Name);
                
                IF PostCodes.GET(Cust."Post Code",Cust.City) THEN
                  BEGIN
                    Provincia := PostCodes.County;
                    Departamento := PostCodes.Colonia;
                  END;
                PuntoLlegada := "Bill-to Address" + ', '+"Bill-to City"+ ', '+Provincia+ ', '+Departamento;
                /*
                //GRN Para anular el ncf actual y generar uno nuevo - Error de impresion -
                ConfSant.GET;
                //IF ConfSant."Anula NCF al Reimprimir" THEN
                  BEGIN
                    IF ("No. Printed" > 0) AND (NOT CurrReport.PREVIEW) AND
                       (NOT Correction) THEN //GRN Para anular el ncf actual y generar uno nuevo
                      BEGIN
                        NCFAnulados."No. documento"          := "No.";
                        NCFAnulados."No. Serie NCF Facturas" := "No. Serie NCF Abonos";
                        NCFAnulados."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                        NCFAnulados."Fecha anulacion"        := TODAY;
                //        NCFAnulados.Serie                    := "Serie Factura";
                        NCFAnulados.INSERT;
                //        NCFAnulados."Tipo Documento"         := NCFAnulados."Tipo Documento"::"3";
                        "No. Comprobante Fiscal" := NoSeriesMgt.GetNextNo("No. Serie NCF Abonos",TODAY,TRUE);
                        MODIFY;
                
                        CLE.SETCURRENTKEY("Document No.","Document Type","Customer No.");
                        CLE.SETRANGE("Document No.","No.");
                        CLE.SETRANGE("Document Type",CLE."Document Type"::"Credit Memo");
                        CLE.SETRANGE("Customer No.","Sell-to Customer No.");
                        CLE.FINDFIRST;
                        CLE."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                        CLE.MODIFY;
                      END;
                  END;
                */
                
                //-#5811
                IF ("No. Comprobante Fiscal" <> '') AND (NuevoNCF <> '') AND ("No. Printed" > 0) AND (NOT CurrReport.PREVIEW) THEN BEGIN
                  //CPMCR-CEC+
                  /*
                  cPY.ActualizarCompFiscal("No. Comprobante Fiscal", NuevoNCF,
                    NCFAnulados."Tipo Documento"::"3",
                    "No.", "No. Serie NCF Abonos", "No. Autorizacion Comprobante", "Punto de Emision Factura", "Establecimiento Factura");
                  */
                  //CPMCR-CEC-
                  "No. Comprobante Fiscal" := NuevoNCF;
                  MODIFY;
                
                  NuevoNCF := INCSTR(NuevoNCF);
                END;
                //+#5811
                
                // DYN: ---------------------------- Codigo Dynasoft ------------------------------------------------
                
                // DYN: ---------------------------- Codigo Standard ------------------------------------------------
                IF PrintCompany THEN BEGIN
                  IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddress.RespCenter(CompanyAddress,RespCenter);
                    CompanyInformation."Phone No." := RespCenter."Phone No.";
                    CompanyInformation."Fax No." := RespCenter."Fax No.";
                  END;
                END;
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                
                IF "Salesperson Code" = '' THEN
                  CLEAR(SalesPurchPerson)
                ELSE
                  SalesPurchPerson.GET("Salesperson Code");
                
                IF "Bill-to Customer No." = '' THEN BEGIN
                  "Bill-to Name" := Text009;
                  "Ship-to Name" := Text009;
                END;
                
                FormatAddress.SalesCrMemoBillTo(BillToAddress,"Sales Cr.Memo Header");
                //fes mig FormatAddress.SalesCrMemoShipTo(ShipToAddress,"Sales Cr.Memo Header");
                
                IF LogInteraction THEN
                  IF NOT CurrReport.PREVIEW THEN
                    SegManagement.LogDocument(
                      6,"No.",0,0,DATABASE::Customer,"Sell-to Customer No.","Salesperson Code",
                      "Campaign No.","Posting Description",'');
                
                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                  TaxArea.GET("Tax Area Code");
                  CASE TaxArea."Country/Region" OF
                    TaxArea."Country/Region"::US:
                      TotalTaxLabel := Text005;
                    TaxArea."Country/Region"::CA:
                      BEGIN
                        TotalTaxLabel := Text007;
                        TaxRegNo := CompanyInformation."VAT Registration No.";
                        TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
                      END;
                  END;
                  SalesTaxCalc.StartSalesTaxCalculation;
                  IF TaxArea."Use External Tax Engine" THEN
                    SalesTaxCalc.CallExternalTaxEngineForDoc(DATABASE::"Sales Cr.Memo Header",0,"No.")
                  ELSE BEGIN
                    SalesTaxCalc.AddSalesCrMemoLines("No.");
                    SalesTaxCalc.EndSalesTaxCalculation("Posting Date");
                  END;
                  SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                  BrkIdx := 0;
                  PrevPrintOrder := 0;
                  PrevTaxPercent := 0;
                  WITH TempSalesTaxAmtLine DO BEGIN
                    RESET;
                    SETCURRENTKEY("Print Order","Tax Area Code for Key","Tax Jurisdiction Code");
                    IF FIND('-') THEN
                      REPEAT
                        IF ("Print Order" = 0) OR
                           ("Print Order" <> PrevPrintOrder) OR
                           ("Tax %" <> PrevTaxPercent)
                        THEN BEGIN
                          BrkIdx := BrkIdx + 1;
                          IF BrkIdx > 1 THEN BEGIN
                            IF TaxArea."Country/Region" = TaxArea."Country/Region"::CA THEN
                              BreakdownTitle := Text006
                            ELSE
                              BreakdownTitle := Text003;
                          END;
                          IF BrkIdx > ARRAYLEN(BreakdownAmt) THEN BEGIN
                            BrkIdx := BrkIdx - 1;
                            BreakdownLabel[BrkIdx] := Text004;
                          END ELSE
                            BreakdownLabel[BrkIdx] := STRSUBSTNO("Print Description","Tax %");
                        END;
                        BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                      UNTIL NEXT = 0;
                  END;
                  IF BrkIdx = 1 THEN BEGIN
                    CLEAR(BreakdownLabel);
                    CLEAR(BreakdownAmt);
                  END;
                END;
                // DYN: ---------------------------- Codigo Standard ------------------------------------------------

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
                group(Options)
                {
                    Caption = 'Options';
                    field("Nuevo NCF";NuevoNCF)
                    {
                        ToolTip = 'Si pone el nuevo NCF, a los documentos con NCF reimpresos se les asignar´Š¢ el nuevo nomero (si se reimprime m´Š¢s de un documento, se incrementar´Š¢ autom´Š¢ticamente la numeracion)';
                    }
                    field(NoCopies;NoCopies)
                    {
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompany;PrintCompany)
                    {
                        Caption = 'Print Company Address';
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        // DYN: ---------------------------- Codigo Standard ------------------------------------------------
        
        CompanyInformation.GET;
        SalesSetup.GET;
        
        /*
        CASE SalesSetup."Logo Position on Documents" OF
          SalesSetup."Logo Position on Documents"::"No Logo":;
          SalesSetup."Logo Position on Documents"::Left:
            BEGIN
              CompanyInformation.CALCFIELDS(Picture);
            END;
          SalesSetup."Logo Position on Documents"::Center:
            BEGIN
              CompanyInfo1.GET;
              CompanyInfo1.CALCFIELDS(Picture);
            END;
          SalesSetup."Logo Position on Documents"::Right:
            BEGIN
              CompanyInfo2.GET;
              CompanyInfo2.CALCFIELDS(Picture);
            END;
        END;
        
        IF PrintCompany THEN
          FormatAddress.Company(CompanyAddress,CompanyInformation)
        ELSE
          CLEAR(CompanyAddress);
        */
        // DYN: ---------------------------- Codigo Standard ------------------------------------------------
        
        // DYN: ---------------------------- Codigo Dynasoft ------------------------------------------------
        
        GLSetUp.GET;
        GLSetUp.TESTFIELD("LCY Code");
        GLSetUp.TESTFIELD("Nombre Divisa Local");
        
        CompanyInformation.CALCFIELDS(Picture);
        rPais.SETRANGE(Code,CompanyInformation."Country/Region Code");
        rPais.FINDFIRST;
        vPais := CompanyInformation.City +  ', ' + CompanyInformation.Name + ' ' + CompanyInformation."Post Code";

    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record 13;
        CompanyInformation: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        SalesSetup: Record 311;
        TempSalesCrMemoLine: Record 115 temporary;
        RespCenter: Record 5714;
        Language: Record 8;
        TempSalesTaxAmtLine: Record 10011 temporary;
        TaxArea: Record 318;
        CompanyAddress: array [8] of Text[50];
        BillToAddress: array [8] of Text[50];
        ShipToAddress: array [8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesCrMemoPrinted: Codeunit 316;
        FormatAddress: Codeunit 365;
        SalesTaxCalc: Codeunit 398;
        SegManagement: Codeunit 5051;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        Text001: Label 'Transferred from page %1';
        Text002: Label 'Transferred to page %1';
        TaxRegNo: Text[30];
        TaxRegLabel: Text[30];
        TotalTaxLabel: Text[30];
        BreakdownTitle: Text[30];
        BreakdownLabel: array [4] of Text[30];
        BreakdownAmt: array [4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        Text009: Label 'VOID CREDIT MEMO';
        [InDataSet]
        LogInteractionEnable: Boolean;
        "//DYN ---------------------": Integer;
        Cliente: Record 18;
        Loc: Record 14;
        Currency: Record 4;
        GLSetUp: Record 98;
        Vendedor_Comprador: Record 13;
        PT: Record 3;
        SCL: Record 44;
        ChkTransMgt: Report 10400;
                         SIL: Record 115;
                         PostedDocDim: Integer;
                         DimVal: Record 349;
                         Cust: Record 18;
                         PostCodes: Record 225;
                         ConfSant: Record 56001;
                         NCFAnulados: Record 34003012;
                         CLE: Record 21;
                         rPais: Record 9;
                         NoSeriesMgt: Codeunit 396;
                         Comentario: Text[1024];
                         iBruto: Decimal;
                         ImporteCargos: Decimal;
                         ImporteSinCargos: Decimal;
                         DescuentoCargos: Decimal;
                         CantUnidades: Decimal;
                         igv: Decimal;
                         CurrName: Text[30];
                         CodDivLocal: Code[20];
                         VendorName: Text[50];
                         CondicionPago: Text[100];
                         txtIva: Text[30];
                         DescriptionLine: array [2] of Text[250];
                         TotFactura: Decimal;
                         Descuento: Decimal;
                         TipoCliente: Text[100];
                         TipoVenta: Text[100];
                         Nombre: Text[250];
                         Provincia: Text[150];
                         Departamento: Text[150];
                         PuntoLlegada: Text[500];
                         vPais: Text[50];
                         txt004: Label '(*) IVA';
        VatPostSet: Record 325;
        VatProdPostGrp: Record 324;
        Columna1IVA: Decimal;
        Columna2Iva: Decimal;
        ColumnaExe: Decimal;
        Columna1IVABase: Decimal;
        Columna2IvaBase: Decimal;
        ColumnaExeBase: Decimal;
        SIH: Record 112;
        NoFactAplicada: Code[50];
        Dia: Integer;
        Mes: Integer;
        ano: Integer;
        Tel: Text[30];
        Page_CaptionLbl: Label 'Page:';
        Item_No_CaptionLbl: Label 'Item No.';
        Desc_PctLbl: Label 'Disc. %';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Total_PriceCaptionLbl: Label 'Total Price';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Invoice_Discount_CaptionLbl: Label 'Invoice Discount:';
        Total_CaptionLbl: Label 'Total:';
        Amount_Subject_to_Sales_TaxCaptionLbl: Label 'Amount Subject to Sales Tax';
        Amount_Exempt_from_Sales_TaxCaptionLbl: Label 'Amount Exempt from Sales Tax';
        NuevoNCF: Code[19];
}

