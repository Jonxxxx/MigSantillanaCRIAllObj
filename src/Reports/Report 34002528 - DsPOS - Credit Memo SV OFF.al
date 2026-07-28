report 34002528 "DsPOS - Credit Memo SV OFF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Credit Memo SV OFF.rdlc';
    Caption = 'DsPOS - Credit Memo SV OFF';
    Permissions = TableData 21 = rm,
                  TableData 114 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';
            column(SIH_Posting_Date__; SIH."Posting Date")
            {
            }
            column(Sales_Cr_Memo_Header___No__; "No. Comprobante Fiscal Rel.")
            {
            }
            column(Sales_CR_Memo_Header___Bill_to_Customer_No__; "VAT Registration No.")
            {
            }
            column(FORMAT__Sales_Cr_Memo_Header___Document_Date__0_4_; FORMAT("Sales Header"."Document Date", 0, 4))
            {
            }
            column(CustAddr_1_; BillToAddress[1])
            {
            }
            column(CustAddr_4_; "Bill-to Address")
            {
            }
            column(CustAddr_5_; "Bill-to City")
            {
            }
            column(CustAddr_6_; Cust.GIRO)
            {
            }
            column(CompanyInfo1_Picture; CompanyInfo1.Picture)
            {
            }
            column(Description_Text_No_to_Letter; DescriptionLine[1])
            {
            }
            column(Description_Total_Books; txtTotalItems)
            {
            }
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            column(blnMostrarFOB; blnMostrarFOB)
            {
            }
            column(Cod_Terminos_Pago_; Customer."Payment Terms Code")
            {
            }
            column(NRC_; Customer.NRC)
            {
            }
            column(Giro_; Customer.GIRO)
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem("Sales Line"; 37)
                    {
                        DataItemLink = Document No.=FIELD("No."),
                                       "Document Type"=FIELD("Document Type");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.","Line No.")
                                            WHERE(Type=FILTER(<>' '));
                        column(FiltroLineas;texFiltroLineas)
                        {
                        }
                        column(Sales_Line_Description2_Control65;Description)
                        {
                        }
                        column(Temp_Line__No__;"No.")
                        {
                        }
                        column(Sales_Line_Description_Control65;Description)
                        {
                        }
                        column(Sales_Line_Quantity;Quantity)
                        {
                            DecimalPlaces = 0:2;
                        }
                        column(Sales_Line_Unit_Price;ROUND(UnitPriceToPrint,GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatType = 2;
                        }
                        column(FOB_Caption;'Total FOB')
                        {
                        }
                        column(Total_FOB;TotalFOB)
                        {
                            AutoFormatType = 1;
                        }
                        column(AmountExclInvDisc;AmountExclInvDisc)
                        {
                        }
                        column(AmtGravado;AmtGravado)
                        {
                        }
                        column(AmtExento;AmtExento)
                        {
                        }
                        column(AmtIVA;AmtIVA)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT____TempSalesCrMemoLine_Amount;"Amount Including VAT" - Amount)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_VAT_;"Amount Including VAT")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

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

                            //GRN Para segregar el importe exento y gravado
                            IF "VAT %" <> 0 THEN
                               AmtGravado := "Amount Including VAT"
                            ELSE
                               AmtExento  := "Amount Including VAT";

                            AmtIVA := "Amount Including VAT" - Amount;

                            IF Quantity = 0 THEN
                              UnitPriceToPrint := 0  // so it won't print
                            ELSE
                              UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity,0.00001);

                            IF (UnitPriceToPrint <> 0) AND ("VAT %" <> 0) AND ( NOT "Sales Header"."Prices Including VAT") THEN
                               UnitPriceToPrint := ROUND(UnitPriceToPrint * (1 + "VAT %"/100),GLSetup."Amount Rounding Precision");

                            //GRN Para imprimir con el redondeo exigido por Guatemala
                            IF Quantity <> 0 THEN //GRN Para poner el precio con IVA
                               IF NOT "Sales Header"."Prices Including VAT" THEN
                                  BEGIN
                                   "Unit Price"     := ROUND(("Unit Price"  * (1 + "VAT %"/100)),GLSetup."Unit-Amount Rounding Precision");
                                   UnitPriceToPrint := "Unit Price";
                                   "Line Discount Amount" := ROUND("Unit Price" * Quantity * "Line Discount %" /100,GLSetup."Amount Rounding Precision");
                              //GRN     AmtIVA := ROUND("Unit Price" * Quantity,GLSetup."Amount Rounding Precision");
                                  END;


                            IF Type = Type::Item THEN
                               BEGIN
                                TotQty   += Quantity;
                                TotalFOB += "Amount Including VAT";
                               END;

                            texFiltroLineas := 'LINEAS';

                            IF (Type <> Type::Item) THEN
                              "No." := '';

                            IF (Type = Type::"Charge (Item)") OR
                               ("Amount Including VAT" = 0) THEN
                              texFiltroLineas := '';


                            IF blnPrimeraVez THEN BEGIN
                              DescriptionLine[1] += ' ' + CurrName;
                              blnPrimeraVez := FALSE;
                            END;

                            txtTotalItems := STRSUBSTNO(Text012,FORMAT(TotQty));
                            IF (TotalDto <> 0) THEN
                              txtTotalItems := txtTotalItems + ', ' + STRSUBSTNO(Text014,FORMAT(TotalDto,0,'<Integer thousand><Decimals,3>'));
                        end;
                    }
                    dataitem(CML; 37)
                    {
                        DataItemLink = Document No.=FIELD("No."),
                                       "Document Type"=FIELD("Document Type");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.",Type,"No.")
                                            WHERE(Type=CONST("Charge (Item)"));
                        column(FiltroCargos;'CARGOS')
                        {
                        }
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
                //+#22839
                Customer.GET("Bill-to Customer No.");
                //-#22839


                //GRN Configuraciones para controlar la cantidad de lineas por documento
                ConfSantillana.GET();
                ConfSantillana.TESTFIELD(Country);
                ConfigLinRep.GET(ConfSantillana.Country,52003);
                ConfigLinRep.TESTFIELD("Maximun line number");

                AmtIVA     := 0;
                AmtGravado := 0;
                AmtExento := 0;
                blnPrimeraVez := TRUE;

                "Sales Line".SETRANGE("Document No.","No.");
                "Sales Line".SETRANGE(Type,"Sales Line".Type::Item);
                "Sales Line".SETFILTER(Quantity,'<>0');
                IF "Sales Line".COUNT > ConfigLinRep."Maximun line number" THEN
                  ERROR(Text016);

                GLSetup.GET(); //GRN
                IF PrintCompany THEN BEGIN
                  IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddress.RespCenter(CompanyAddress,RespCenter);
                    CompanyInformation."Phone No." := RespCenter."Phone No.";
                    CompanyInformation."Fax No." := RespCenter."Fax No.";
                  END;
                END;
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                Cust.GET("Sell-to Customer No.");
                IF "Salesperson Code" = '' THEN
                  CLEAR(SalesPurchPerson)
                ELSE
                  SalesPurchPerson.GET("Salesperson Code");

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

                IF "Bill-to Customer No." = '' THEN BEGIN
                  "Bill-to Name" := Text009;
                  "Ship-to Name" := Text009;
                END;

                FormatAddress.SalesHeaderBillTo(BillToAddress,"Sales Header");
                //fes mig FormatAddress.SalesHeaderShipTo(ShipToAddress,"Sales Header");

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
                  CurrName         := Text013;
                END ELSE BEGIN
                  Currency.GET("Currency Code");
                  CurrName         := Currency.Description;
                END;

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
                //GRN Para tener el monto de la factura
                CALCFIELDS("Amount Including VAT");
                ChkTransMgt.FormatNoText(DescriptionLine,"Amount Including VAT",2058,"Currency Code");

                //GRN Se busca el documento de factura
                IF "Applies-to Doc. No." <> '' THEN
                   SIH.GET("Applies-to Doc. No.");

                blnMostrarFOB := ("Currency Code" <> '') AND (VatBussPG."Cliente de Exportacion");
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
        Text013: Label 'DOLARES';
        "*** DSLocGT1.01 ***": Integer;
        NoSerie: Record 308;
        "*** Santillana ***": Integer;
        ConfSantillana: Record 56001;
        ConfigLinRep: Record 56002;
        SIH: Record 112;
        VatBussPG: Record 323;
        ChkTransMgt: Report 10400;
                         Cust: Record 18;
                         DescriptionLine: array [2] of Text[250];
                         NoSeriesMgt: Codeunit 396;
                         NCFAnulados: Record 34003012;
                         CLE: Record 21;
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
                         AmtGravado: Decimal;
                         AmtExento: Decimal;
                         TotalDto: Decimal;
                         Dto: Decimal;
                         Text014: Label 'Total discount:  %1';
        Text015: Label ', Discount: %1%';
        txtTotalItems: Text[150];
        Text016: Label 'The number of product lines exceeds the limit for reporting';
        texFiltroLineas: Text;
        blnMostrarFOB: Boolean;
        blnPrimeraVez: Boolean;
        Customer: Record 18;
}

