report 34002524 "DsPOS - Credit Memo GT ON"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Credit Memo GT ON.rdlc';
    Caption = 'Sales Credit Memo';
    Permissions = TableData 21 = rm,
                  TableData 114 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            CalcFields = Amount, "Invoice Discount Amount";
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            column(Sales_Cr_Memo_Header_Amount_; "Sales Cr.Memo Header".Amount)
            {
            }
            column(Sales_Cr_Memo_Header_InvoiceDiscountAmount_; "Sales Cr.Memo Header"."Invoice Discount Amount")
            {
            }
            dataitem("Sales Cr.Memo Line"; 115)
            {
                DataItemLink = Document No.=FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Type = FILTER(<> ' '));
                dataitem(SalesLineComments; 44)
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
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.RESET;
                    TempSalesCrMemoLine.DELETEALL;
                end;
            }
            dataitem("Sales Comment Line"; 44)
            {
                DataItemLink = No.=FIELD("No.");
                DataItemTableView = SORTING("Document Type","No.","Document Line No.","Line No.")
                                    WHERE("Document Type"=CONST(Posted Credit Memo),
                                          Print On Credit Memo=CONST(true),
                                          Document Line No.=CONST(0));

                trigger OnAfterGetRecord()
                begin
                    //GRN Comentario += ' ' + Comment; //GRN Para el pie de pagina en las Notas de Credito
                    WITH TempSalesCrMemoLine DO BEGIN
                      INIT;
                      "Document No." := "Sales Cr.Memo Header"."No.";
                      "Line No." := HighestLineNo + 1000;
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

                trigger OnPreDataItem()
                begin
                    WITH TempSalesCrMemoLine DO BEGIN
                      INIT;
                      "Document No." := "Sales Cr.Memo Header"."No.";
                      "Line No." := HighestLineNo + 1000;
                      HighestLineNo := "Line No.";
                    END;
                    TempSalesCrMemoLine.INSERT;
                end;
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number=CONST(1));
                    column(CompanyInfo2_Picture;CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture;CompanyInfo1.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__;STRSUBSTNO(Text005,FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(CustAddr_1_;BillToAddress[1])
                    {
                    }
                    column(CustAddr_2_;BillToAddress[2])
                    {
                    }
                    column(CustAddr_3_;BillToAddress[3])
                    {
                    }
                    column(CustAddr_4_;BillToAddress[4])
                    {
                    }
                    column(CustAddr_5_;BillToAddress[5])
                    {
                    }
                    column(CustAddr_6_;BillToAddress[6])
                    {
                    }
                    column(Sales_CR_Memo_Header___Bill_to_Customer_No__;"Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Posting_Date_;FORMAT("Sales Cr.Memo Header"."Posting Date"))
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__;"Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(CustAddr_7_;BillToAddress[7])
                    {
                    }
                    column(CustAddr_8_;BillToAddress[8])
                    {
                    }
                    column(FORMAT__Sales_Cr_Memo_Header___Document_Date__0_4_;FORMAT("Sales Cr.Memo Header"."Document Date",0,4))
                    {
                    }
                    column(PageCaption;STRSUBSTNO(Text005,''))
                    {
                    }
                    column(SIH_NCF;"Sales Cr.Memo Header"."No. Comprobante Fiscal")
                    {
                    }
                    column(TaxRegNo;TaxRegNo)
                    {
                    }
                    column(TaxRegLabel;TaxRegLabel)
                    {
                    }
                    column(SalesPurchPerson_Name;"Sales Cr.Memo Header"."Salesperson Code" + '  -  ' + NombreVendedor)
                    {
                    }
                    column(Cobrador_Name;"Sales Cr.Memo Header"."Collector Code" + '  -  ' + Cobrador)
                    {
                    }
                    column(cobradorText;CobradorText)
                    {
                    }
                    column(CopyNo;CopyNo)
                    {
                    }
                    column(TempSalesCrMemoLine__Amount_Including_VAT_;TempSalesCrMemoLine."Amount Including VAT")
                    {
                        AutoFormatType = 1;
                    }
                    column(Comp_Info_Tax_E;Comentario)
                    {
                    }
                    column(Currency_Exch;VALExchRate)
                    {
                    }
                    column(Description_Text_No_to_Letter;DescriptionLine[1] + '  ' + CurrName)
                    {
                    }
                    column(AmountExclInvDisc_Control79;TempSalesCrMemoLine."Amount Including VAT" + TempSalesCrMemoLine."Line Discount Amount")
                    {
                    }
                    column(TempSalesCrMemoLine_Amount___AmountExclInvDisc;TempSalesCrMemoLine."Line Discount Amount")
                    {
                    }
                    column(TempSalesCrMemoLine__Amount_Including_VAT_2;TempSalesCrMemoLine."Amount Including VAT")
                    {
                    }
                    column(Invoice_No_Caption;Invoice_No_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_Caption;Sales_Invoice_Header___Posting_Date_CaptionLbl)
                    {
                    }
                    column(SIH_NCF_Caption;SIH_NCF_CaptionLbl)
                    {
                    }
                    column(SalesPersonCaption;SalesPersonCaptionLbl)
                    {
                    }
                    column(Total_Caption;Total_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number;Number)
                    {
                    }
                    dataitem(SalesCrMemoLine; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Sales_Line_Description2_Control65;TempSalesCrMemoLine.Description)
                        {
                        }
                        column(Sales_Line_Quantity2;TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0:2;
                        }
                        column(Sales_Invoice_Total2_;ROUND(TempSalesCrMemoLine.Quantity * UnitPriceToPrint,GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Unit_Price2_;ROUND(UnitPriceToPrint,GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount2___;TempSalesCrMemoLine."Line Discount %")
                        {
                            DecimalPlaces = 0:2;
                        }
                        column(Sales_Line__Line_Amount2__Control70;TempSalesCrMemoLine."Amount Including VAT")
                        {
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Line_Discount2_;TempSalesCrMemoLine."Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Temp_Line__No__;TempSalesCrMemoLine."No.")
                        {
                        }
                        column(Sales_Line_Description_Control65;TempSalesCrMemoLine.Description)
                        {
                        }
                        column(Sales_Line_Quantity;TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0:2;
                        }
                        column(Sales_Invoice_Total_;ROUND(TempSalesCrMemoLine.Quantity * UnitPriceToPrint,GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Unit_Price_;ROUND(UnitPriceToPrint,GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Line_Discount___;TempSalesCrMemoLine."Line Discount %")
                        {
                            DecimalPlaces = 0:2;
                        }
                        column(Sales_Line__Line_Amount__Control70;TempSalesCrMemoLine."Amount Including VAT")
                        {
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__Line_Discount_;TempSalesCrMemoLine."Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Cr_Memo_Line___Line_No__;TempSalesCrMemoLine."Line No.")
                        {
                        }
                        column(FOB_Caption;'Total FOB')
                        {
                        }
                        column(Total_FOB;TotalFOB)
                        {
                            AutoFormatType = 1;
                        }
                        column(SalesCrMemoLine_Number;Number)
                        {
                        }
                        column(Description_Total_Books;STRSUBSTNO(Text012,FORMAT(TempSalesCrMemoLine.Quantity)))
                        {
                        }
                        column(TempSalesCrMemoLine_Amount_;TempSalesCrMemoLine.Amount)
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

                              IF Type = Type::Item THEN BEGIN
                                TotQty   += Quantity;
                                TotalFOB += "Amount Including VAT";
                              END;


                              IF Quantity = 0 THEN
                                UnitPriceToPrint := 0  // so it won't print
                              ELSE
                                UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);

                              IF (UnitPriceToPrint <> 0) AND ("VAT %" <> 0) AND ( NOT "Sales Cr.Memo Header"."Prices Including VAT") THEN
                                 UnitPriceToPrint := ROUND(UnitPriceToPrint * (1 + "VAT %"/100),GLSetup."Amount Rounding Precision")
                              ELSE
                              IF "Sales Cr.Memo Header"."Prices Including VAT" THEN
                                 UnitPriceToPrint := "Unit Price";

                              //GRN Para imprimir con el redondeo exigido por Guatemala
                              IF Quantity <> 0 THEN //GRN Para poner el precio con IVA
                                 IF NOT "Sales Cr.Memo Header"."Prices Including VAT" THEN
                                    BEGIN
                                     "Unit Price"     := ROUND(("Unit Price"  * (1 + "VAT %"/100)),GLSetup."Unit-Amount Rounding Precision");
                                     UnitPriceToPrint := "Unit Price";
                                     "Line Discount Amount" := ROUND("Unit Price" * Quantity * "Line Discount %" /100,GLSetup."Amount Rounding Precision");
                            //GRN         AmtIVA := ROUND("Unit Price" * Quantity,GLSetup."Amount Rounding Precision");
                                    END;
                            END;

                            IF ISSERVICETIER THEN BEGIN
                              IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(TaxLiable,AmountExclInvDisc,TempSalesCrMemoLine.Amount,TempSalesCrMemoLine."Amount Including VAT",
                                                    TempSalesCrMemoLine.Quantity,TempSalesCrMemoLine."Line Discount Amount");
                            NumberOfLines := TempSalesCrMemoLine.COUNT;
                            SETRANGE(Number,1,NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := FALSE;
                        end;
                    }
                    dataitem(CML; 115)
                    {
                        DataItemLink = Document No.=FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.",Type,"No.")
                                            WHERE(Type=CONST("Charge (Item)"));
                        column(IC_No_;"No.")
                        {
                        }
                        column(IC_Amt;"Amount Including VAT")
                        {
                            AutoFormatType = 1;
                        }
                        column(CML_Document_No_;"Document No.")
                        {
                        }
                        column(CML_Line_No_;"Line No.")
                        {
                        }
                        column(CML_Type;Type)
                        {
                        }
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
                    //GRN Es por el numerador de seris NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    NoLoops := 1+ ABS(NoCopies) + NoSerie."Invoice Copies";

                    //GRN NoLoops := 1 + ABS(NoCopies);
                    IF NoLoops <= 0 THEN
                      NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLSetup.GET(); //GRN
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
                
                NoSerie.GET("No. Serie NCF Abonos");
                NoSerie.TESTFIELD("Invoice Copies");
                
                VatBussPG.GET("VAT Bus. Posting Group");//GRN Para GUA
                
                IF "Collector Code" = '' THEN BEGIN //GRN Se adiciona dato del cobrador
                  SalesPurchPerson.INIT;
                  CobradorText := '';
                  Cobrador := '';
                END ELSE BEGIN
                  SalesPurchPerson.GET("Collector Code");
                  CobradorText := Text011;
                  Cobrador        := SalesPurchPerson.Name;
                END;
                
                IF rSalesperson.GET("Salesperson Code") THEN
                  NombreVendedor := rSalesperson.Name
                ELSE
                  NombreVendedor := '';
                
                
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
                //GRN        TaxRegLabel := CompanyInformation.FIELDCAPTION("VAT Registration No.");
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
                
                //GRN  VATNoText := FIELDCAPTION("VAT Registration No.");
                  TaxRegLabel := 'NIT';
                  TaxRegNo := "VAT Registration No.";
                
                IF "Currency Code" = '' THEN BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                 // TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                //  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                //  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                  CurrName         := Text013;
                END ELSE BEGIN
                //  TotalText := STRSUBSTNO(Text001,"Currency Code");
                //  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                //  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                  Currency.GET("Currency Code");
                  CurrName         := Currency.Description;
                END;
                
                
                //AMS
                /* A partir de la Factura electronica no se pueden correr los folios ya generados
                IF ("No. Printed" > 0) AND (NOT CurrReport.PREVIEW) THEN //GRN Para anular el ncf actual y generar uno nuevo - Error de impresion -
                   BEGIN
                    NCFAnulados."No. documento"          := "No.";
                    NCFAnulados."No. Serie NCF Facturas" := "No. Serie NCF Abonos";
                    NCFAnulados."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                    NCFAnulados."Fecha anulacion"        := TODAY;
                    NCFAnulados.INSERT;
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
                */
                //GRN Para tener el monto de la factura
                CALCFIELDS("Amount Including VAT");
                ChkTransMgt.FormatNoText(DescriptionLine,"Amount Including VAT",2058,"Currency Code");
                
                Comentario += ' ' + "Posting Description"; //GRN Para el pie de pagina en las Notas de Credito

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
        CompanyInformation.GET;
        SalesSetup.GET;

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
        Text011: Label 'Collector';
        Text012: Label 'Total books %1';
        Text013: Label 'QUETZALES';
        Text014: Label 'Affect to Invoice No.';
        "*** DSLocGT1.01 ***": Integer;
        NoSerie: Record 308;
        "*** Santillana ***": Integer;
        VatBussPG: Record 323;
        ChkTransMgt: Report "Check Translation Management";
                         DescriptionLine: array [2] of Text[250];
                         NoSeriesMgt: Codeunit 396;
                         NCFAnulados: Record 34003012;
                         CurrName: Text[30];
                         Currency: Record 4;
                         TotQty: Decimal;
                         TotalFOB: Decimal;
                         GLSetup: Record 98;
                         Comentario: Text[150];
                         VALExchRate: Text[50];
                         Cobrador: Text[30];
                         CobradorText: Text[30];
                         AmtIVA: Decimal;
                         rSalesperson: Record 13;
                         NombreVendedor: Text[100];
                         CLE: Record 21;
                         Invoice_No_CaptionLbl: Label 'Invoice No.';
        Sales_Invoice_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        SIH_NCF_CaptionLbl: Label 'FDN No.';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        Total_CaptionLbl: Label 'Total:';
}

