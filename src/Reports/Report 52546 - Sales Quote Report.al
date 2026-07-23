report 52546 "Sales Quote Report"
{
    //  Proyecto: Implementacion Microsoft Dynamics Nav
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.        Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001  07-Diciembre-2022     LDP      SANTINAV-3495: Santillana Costa Rica - Ajustes en cotizaciones de ventas BC
    DefaultLayout = RDLC;
    RDLCLayout = './Sales Quote Report.rdlc';

    Caption = 'Sales - Quote';

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(CategoriaPedidoVenta; "Categoria Pedido Venta")
            {
            }
            column(CatPedVtaFiltrarCodComp; CategoriaPedidoVenta."Filtrar Cod. Compartir")
            {
            }
            column(TotalAmountExcVat; TotalAmount1)
            {
            }
            column(TotalAmountIncVat; TotalAmount2)
            {
            }
            column(VATAmount; VATAmount)
            {
            }
            dataitem("Sales Line"; 37)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE("Document Type" = CONST(Quote));
                dataitem(SalesLineComments; 44)
                {
                    DataItemLink = "No." = FIELD("Document No."),
                                   "Document Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Type" = CONST(Quote));
                    //TODO: no existe "Print On Quote" = CONST(True));

                    trigger OnAfterGetRecord()
                    begin
                        WITH TempSalesLine DO BEGIN
                            INIT;
                            "Document Type" := "Sales Header"."Document Type";
                            "Document No." := "Sales Header"."No.";
                            "Line No." := HighestLineNo + 10;
                            HighestLineNo := "Line No.";
                        END;
                        IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                            TempSalesLine.Description := Comment;
                            TempSalesLine."Description 2" := '';
                        END ELSE BEGIN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                            WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                                SpacePointer := SpacePointer - 1;
                            IF SpacePointer = 1 THEN
                                SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                            TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                            TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                        END;
                        TempSalesLine.INSERT;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TempSalesLine := "Sales Line";
                    TempSalesLine.INSERT;
                    HighestLineNo := "Line No.";

                    IF ("Sales Header"."Tax Area Code" <> '') AND NOT UseExternalTaxEngine THEN
                        //TODO: no existe SalesTaxCalc.AddSalesLine(TempSalesLine);
                        // 001-- Permite agrupar las lineas por tipo categoria pedido venta.
                        CategoriaPedidoVenta.GET("Sales Header"."Categoria Pedido Venta");
                    IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN BEGIN
                        //*****************************************
                        IF ConfSant.GET THEN;
                        CASE "Sales Line".Compartir OF
                            "Sales Line".Compartir::Libros:
                                BEGIN
                                    "No." := ConfSant."Codigo Libro";
                                    Description := 'LIBROS';
                                END;
                            "Sales Line".Compartir::Aulas:
                                BEGIN
                                    "No." := ConfSant."Codigo Aulas";
                                    Description := 'AULAS';
                                END;
                            "Sales Line".Compartir::Servicios:
                                BEGIN
                                    "No." := ConfSant."Codigo Servicio";
                                    Description := 'SERVICIO';
                                END;
                        END;
                        //*****************************************
                    END;//001++
                    //001  Permite agrupar las lineas por tipo categoria pedido venta.
                end;

                trigger OnPostDataItem()
                begin
                    IF "Sales Header"."Tax Area Code" <> '' THEN BEGIN
                        //TODO: Ver
                        /*
                        IF UseExternalTaxEngine THEN
                            SalesTaxCalc.CallExternalTaxEngineForSales("Sales Header", TRUE)
                        ELSE
                            SalesTaxCalc.EndSalesTaxCalculation(UseDate);
                        SalesTaxCalc.DistTaxOverSalesLines(TempSalesLine);
                        SalesTaxCalc.GetSummarizedSalesTaxTable(TempSalesTaxAmtLine);
                        BrkIdx := 0;
                        PrevPrintOrder := 0;
                        PrevTaxPercent := 0;
                        WITH TempSalesTaxAmtLine DO BEGIN
                            RESET;
                            SETCURRENTKEY("Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code");
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
                                            BreakdownLabel[BrkIdx] := STRSUBSTNO("Print Description", "Tax %");
                                    END;
                                    BreakdownAmt[BrkIdx] := BreakdownAmt[BrkIdx] + "Tax Amount";
                                UNTIL NEXT = 0;
                        END;*/
                        IF BrkIdx = 1 THEN BEGIN
                            CLEAR(BreakdownLabel);
                            CLEAR(BreakdownAmt);
                        END;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesLine.RESET;
                    TempSalesLine.DELETEALL;
                end;
            }
            dataitem("<Sales Comment Line>"; 44)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                    WHERE("Document Type" = CONST(Quote),
                                          //TODO: Campo no existe "Print On Quote"=CONST(True),
                                          "Document Line No." = CONST(0));

                trigger OnAfterGetRecord()
                begin
                    WITH TempSalesLine DO BEGIN
                        INIT;
                        "Document Type" := "Sales Header"."Document Type";
                        "Document No." := "Sales Header"."No.";
                        "Line No." := HighestLineNo + 1000;
                        HighestLineNo := "Line No.";
                    END;
                    IF STRLEN(Comment) <= MAXSTRLEN(TempSalesLine.Description) THEN BEGIN
                        TempSalesLine.Description := Comment;
                        TempSalesLine."Description 2" := '';
                    END ELSE BEGIN
                        SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        WHILE (SpacePointer > 1) AND (Comment[SpacePointer] <> ' ') DO
                            SpacePointer := SpacePointer - 1;
                        IF SpacePointer = 1 THEN
                            SpacePointer := MAXSTRLEN(TempSalesLine.Description) + 1;
                        TempSalesLine.Description := COPYSTR(Comment, 1, SpacePointer - 1);
                        TempSalesLine."Description 2" := COPYSTR(COPYSTR(Comment, SpacePointer + 1), 1, MAXSTRLEN(TempSalesLine."Description 2"));
                    END;
                    TempSalesLine.INSERT;
                end;

                trigger OnPreDataItem()
                begin
                    WITH TempSalesLine DO BEGIN
                        INIT;
                        "Document Type" := "Sales Header"."Document Type";
                        "Document No." := "Sales Header"."No.";
                        "Line No." := HighestLineNo + 1000;
                        HighestLineNo := "Line No.";
                    END;
                    TempSalesLine.INSERT;
                end;
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyAddress1; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress2; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress3; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress4; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress5; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress6; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress1; BillToAddress[1])
                    {
                    }
                    column(BillToAddress2; BillToAddress[2])
                    {
                    }
                    column(BillToAddress3; BillToAddress[3])
                    {
                    }
                    column(BillToAddress4; BillToAddress[4])
                    {
                    }
                    column(BillToAddress5; BillToAddress[5])
                    {
                    }
                    column(BillToAddress6; BillToAddress[6])
                    {
                    }
                    column(BillToAddress7; BillToAddress[7])
                    {
                    }
                    column(ShipToAddress1; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress2; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress3; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress4; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress5; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress6; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress7; ShipToAddress[7])
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(OrderDate_SalesHeader; "Sales Header"."Order Date")
                    {
                    }
                    column(CompanyAddress7; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress8; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress8; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress8; ShipToAddress[8])
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(TaxRegLabel; TaxRegLabel)
                    {
                    }
                    column(TaxRegNo; TaxRegNo)
                    {
                    }
                    column(PrintFooter; PrintFooter)
                    {
                    }
                    column(CopyNo; CopyNo)
                    {
                    }
                    //TODO: no existe column(CustTaxIdentificationType; FORMAT(Cust."Tax Identification Type"))
                    //{
                    //}
                    column(SellCaption; SellCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(CustomerIDCaption; CustomerIDCaptionLbl)
                    {
                    }
                    column(SalesPersonCaption; SalesPersonCaptionLbl)
                    {
                    }
                    column(ShipCaption; ShipCaptionLbl)
                    {
                    }
                    column(SalesQuoteCaption; SalesQuoteCaptionLbl)
                    {
                    }
                    column(SalesQuoteNumberCaption; SalesQuoteNumberCaptionLbl)
                    {
                    }
                    column(SalesQuoteDateCaption; SalesQuoteDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ShipViaCaption; ShipViaCaptionLbl)
                    {
                    }
                    column(TermsCaption; TermsCaptionLbl)
                    {
                    }
                    column(TaxIdentTypeCaption; TaxIdentTypeCaptionLbl)
                    {
                    }
                    dataitem(SalesLine; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(Number_IntegerLine; Number)
                        {
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesLineNo; TempSalesLine."No.")
                        {
                        }
                        column(TempSalesLineUOM; TempSalesLine."Unit of Measure")
                        {
                        }
                        column(TempSalesLineQuantity; TempSalesLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Cantidad_Linea; TempSalesLine.Quantity)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(UnitPriceExclIVA; TempSalesLine."Unit Price")
                        {
                        }
                        column(Quantity____Unit_Price_; TempSalesLine."Unit Price" * TempSalesLine.Quantity)
                        {
                        }
                        column(TempSalesLineDescription; TempSalesLine.Description)
                        {
                        }
                        column(LineDiscount; TempSalesLine."Line Discount %")
                        {
                        }
                        column(LineDiscountAmount; TempSalesLine."Line Discount Amount")
                        {
                        }
                        column(LineAmountXclIva; TempSalesLine."Line Amount")
                        {
                        }
                        column(TaxLiable; TaxLiable)
                        {
                        }
                        column(TempSalesLineLineAmtTaxLiable; TempSalesLine."Line Amount" - TaxLiable)
                        {
                        }
                        column(TempSalesLineInvDiscAmt; TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(TaxAmount; TaxAmount)
                        {
                        }
                        column(TempSalesLineLineAmtTaxAmtInvDiscAmt; TempSalesLine."Line Amount" + TaxAmount - TempSalesLine."Inv. Discount Amount")
                        {
                        }
                        column(AmountIncludingVAT; TempSalesLine."Amount Including VAT")
                        {
                        }
                        column(VatBaseAmount; TempSalesLine."VAT Base Amount")
                        {
                        }
                        column(Vat; TempSalesLine."VAT %")
                        {
                        }
                        column(BreakdownTitle; BreakdownTitle)
                        {
                        }
                        column(BreakdownLabel1; BreakdownLabel[1])
                        {
                        }
                        column(BreakdownLabel2; BreakdownLabel[2])
                        {
                        }
                        column(BreakdownAmt1; BreakdownAmt[1])
                        {
                        }
                        column(BreakdownAmt2; BreakdownAmt[2])
                        {
                        }
                        column(BreakdownLabel3; BreakdownLabel[3])
                        {
                        }
                        column(BreakdownAmt3; BreakdownAmt[3])
                        {
                        }
                        column(BreakdownAmt4; BreakdownAmt[4])
                        {
                        }
                        column(BreakdownLabel4; BreakdownLabel[4])
                        {
                        }
                        column(TotalTaxLabel; TotalTaxLabel)
                        {
                        }
                        column(ItemNoCaption; ItemNoCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(TotalPriceCaption; TotalPriceCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(InvoiceDiscountCaption; InvoiceDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; TempSalesLine.Amount)
                        {
                        }
                        column(DiscountCaption; DiscountCaption)
                        {
                        }
                        column(LineDiscountCaption; LineDiscountCaption)
                        {
                        }
                        column(LineDiscountAmountCaption; LineDiscountAmountCaption)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }
                        column(AmtSubjecttoSalesTaxCptn; AmtSubjecttoSalesTaxCptnLbl)
                        {
                        }
                        column(AmtExemptfromSalesTaxCptn; AmtExemptfromSalesTaxCptnLbl)
                        {
                        }
                        column(IvaTotal; IvaCpation)
                        {
                        }
                        column(AmountDecimalOnly; TempSalesLine."Amount Including VAT" - TempSalesLine."Line Amount")
                        {
                        }
                        column(Subtotal; TotalAmountExcVatCapt)
                        {
                        }
                        column(Importe_Total; TotalAmountIncVatCapt)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;

                            WITH TempSalesLine DO BEGIN
                                IF OnLineNumber = 1 THEN
                                    FIND('-')
                                ELSE
                                    NEXT;

                                IF Type = 0 THEN BEGIN
                                    "No." := '';
                                    "Unit of Measure" := '';
                                    "Line Amount" := 0;
                                    "Inv. Discount Amount" := 0;
                                    Quantity := 0;
                                END ELSE
                                    IF Type = Type::"G/L Account" THEN
                                        "No." := '';

                                IF "Tax Area Code" <> '' THEN
                                    TaxAmount := "Amount Including VAT" - Amount
                                ELSE
                                    TaxAmount := 0;
                                IF TaxAmount <> 0 THEN
                                    TaxLiable := Amount
                                ELSE
                                    TaxLiable := 0;

                                OnAfterCalculateSalesTax("Sales Header", TempSalesLine, TaxAmount, TaxLiable);

                                AmountExclInvDisc := "Line Amount";

                                IF Quantity = 0 THEN
                                    UnitPriceToPrint := 0 // so it won't print
                                ELSE
                                    UnitPriceToPrint := ROUND(AmountExclInvDisc / Quantity, 0.00001);

                                //001-- Permite agrupar las lineas por tipo categoria pedido venta.
                                CategoriaPedidoVenta.GET("Sales Header"."Categoria Pedido Venta");
                                IF CategoriaPedidoVenta."Filtrar Cod. Compartir" THEN BEGIN
                                    //*****************************************
                                    IF ConfSant.GET THEN;
                                    CASE Compartir OF
                                        Compartir::Libros:
                                            BEGIN
                                                "No." := ConfSant."Codigo Libro";
                                                Description := 'LIBROS';
                                            END;
                                        Compartir::Aulas:
                                            BEGIN
                                                "No." := ConfSant."Codigo Aulas";
                                                Description := 'AULAS';
                                            END;
                                        Compartir::Servicios:
                                            BEGIN
                                                "No." := ConfSant."Codigo Servicio";
                                                Description := 'SERVICIO';
                                            END;
                                    END
                                    //*****************************************
                                END;
                            END;
                            //001++

                            IF OnLineNumber = NumberOfLines THEN
                                PrintFooter := TRUE;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CLEAR(TaxLiable);
                            CLEAR(TaxAmount);
                            CLEAR(AmountExclInvDisc);

                            TempSalesLine.RESET;
                            NumberOfLines := TempSalesLine.COUNT;
                            SETRANGE(Number, 1, NumberOfLines);
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
                            SalesPrinted.RUN("Sales Header");
                        CurrReport.BREAK;
                    END;
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
                IF PrintCompany THEN
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddress.RespCenter(CompanyAddress, RespCenter);
                        CompanyInformation."Phone No." := RespCenter."Phone No.";
                        CompanyInformation."Fax No." := RespCenter."Fax No.";
                    END;

                //TODO: no existe CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatDocumentFields("Sales Header");

                IF NOT Cust.GET("Sell-to Customer No.") THEN
                    CLEAR(Cust);

                FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");
                FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;

                CLEAR(BreakdownTitle);
                CLEAR(BreakdownLabel);
                CLEAR(BreakdownAmt);
                TotalTaxLabel := Text008;
                TaxRegNo := '';
                TaxRegLabel := '';
                IF "Tax Area Code" <> '' THEN BEGIN
                    TaxArea.GET("Tax Area Code");
                    //TODO: Ver
                    /*
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
                    UseExternalTaxEngine := TaxArea."Use External Tax Engine";
                    SalesTaxCalc.StartSalesTaxCalculation;*/
                END;

                UseDate := WORKDATE;
                CalculateTotals();//001-- Para agregar los totales al footter del reporte.
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
                    field(NoCopies; NoCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Number of Copies';
                        ToolTip = 'Specifies the number of copies of each document (in addition to the original) that you want to print.';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Company Address';
                        ToolTip = 'Specifies if your company address is printed at the top of the sheet, because you do not use pre-printed paper. Leave this check box blank to omit your company''s address.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the related interactions with the involved contact person in the Interaction Log Entry table.';

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
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
            ArchiveDocumentEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument :=
              (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Question) OR
              (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always);
            //TODO: no existe LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        SalesSetup.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
        //001--
        CompanyInfo.CALCFIELDS(Picture);
        //001++
    end;

    trigger OnPreReport()
    begin
        IF PrintCompany THEN
            FormatAddress.Company(CompanyAddress, CompanyInformation)
        ELSE
            CLEAR(CompanyAddress);
    end;

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInformation: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        CompanyInfo3: Record 79;
        CompanyInfo: Record 79;
        SalesSetup: Record 311;
        TempSalesLine: Record 37 temporary;
        RespCenter: Record 5714;
        rLanguage: Record 8;
        //TODO: no existe TempSalesTaxAmtLine: Record 10011 temporary;
        TaxArea: Record 318;
        Cust: Record 18;
        SalesPrinted: Codeunit 313;
        FormatAddress: Codeunit 365;
        FormatDocument: Codeunit 368;
        SalesTaxCalc: Codeunit 398;
        ArchiveManagement: Codeunit 5063;
        SegManagement: Codeunit 5051;
        CompanyAddress: array[8] of Text[100];
        BillToAddress: array[8] of Text[100];
        ShipToAddress: array[8] of Text[100];
        CopyTxt: Text;
        SalespersonText: Text[50];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        TaxAmount: Decimal;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        Text000: Label 'COPY';
        TaxRegNo: Text;
        TaxRegLabel: Text;
        TotalTaxLabel: Text;
        BreakdownTitle: Text;
        BreakdownLabel: array[4] of Text;
        BreakdownAmt: array[4] of Decimal;
        BrkIdx: Integer;
        PrevPrintOrder: Integer;
        PrevTaxPercent: Decimal;
        UseDate: Date;
        Text003: Label 'Sales Tax Breakdown:';
        Text004: Label 'Other Taxes';
        Text005: Label 'Total Sales Tax:';
        Text006: Label 'Tax Breakdown:';
        Text007: Label 'Total Tax:';
        Text008: Label 'Tax:';
        UseExternalTaxEngine: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        SellCaptionLbl: Label 'Sell';
        ToCaptionLbl: Label 'To:';
        CustomerIDCaptionLbl: Label 'Customer ID';
        SalesPersonCaptionLbl: Label 'SalesPerson';
        ShipCaptionLbl: Label 'Ship';
        SalesQuoteCaptionLbl: Label 'Sales Quote';
        SalesQuoteNumberCaptionLbl: Label 'Sales Quote Number:';
        SalesQuoteDateCaptionLbl: Label 'Sales Quote Date:';
        PageCaptionLbl: Label 'Page:';
        ShipViaCaptionLbl: Label 'Ship Via';
        TermsCaptionLbl: Label 'Terms';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        ItemNoCaptionLbl: Label 'Item No.';
        UnitCaptionLbl: Label 'Unit';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        UnitPriceCaptionLbl: Label 'Unit Price';
        TotalPriceCaptionLbl: Label 'Total Price';
        SubtotalCaptionLbl: Label 'Subtotal:';
        InvoiceDiscountCaptionLbl: Label 'Invoice Discount:';
        TotalCaptionLbl: Label 'Total:';
        AmtSubjecttoSalesTaxCptnLbl: Label 'Amount Subject to Sales Tax';
        AmtExemptfromSalesTaxCptnLbl: Label 'Amount Exempt from Sales Tax';
        CategoriaPedidoVenta: Record 52503;
        AmountXclIva: Record 36;
        ConfSant: Record 56001;
        LineDiscountCaption: Label '%';
        LineDiscountAmountCaption: Label 'Amount';
        DiscountCaption: Label 'Discount';
        IvaCpation: Label 'IVA';
        AmountDecimalOnly: Decimal;
        PctDescuentoCot: Decimal;
        ImpDesPct: Decimal;
        GeneralLedgerSetUp: Record 98;
        TotalSalesLine: Record 37;
        TotalSalesLineLCY: Record 37;
        TempVATAmountLine: Record 290;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        AdjProfitLCY: Decimal;
        TotalAdjCostLCY: Decimal;
        AdjProfitPct: Decimal;
        CurrExchRate: Record 330;
        SalesPost: Codeunit 80;
        VATAmountText: Text[30];
        CreditLimitLCYExpendedPct: Decimal;
        TotalAmountExcVatCapt: Label 'Subtotal';
        TotalAmountIncVatCapt: Label 'Total';

    local procedure FormatDocumentFields(SalesHeader: Record 36)
    begin
        WITH SalesHeader DO BEGIN
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalespersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        END;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateSalesTax(var SalesHeaderParm: Record 36; var SalesLineParm: Record 37; var TaxAmount: Decimal; var TaxLiable: Decimal)
    begin
    end;

    local procedure CalculateTotals()
    var
        SalesLine: Record 37;
        TempSalesLine: Record 37 temporary;
    begin
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(SalesPost);

        SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
        CLEAR(SalesPost);
        SalesPost.SumSalesLinesTemp(
          "Sales Header", TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        AdjProfitLCY := TotalSalesLineLCY.Amount - TotalAdjCostLCY;
        IF TotalSalesLineLCY.Amount <> 0 THEN
            AdjProfitPct := ROUND(AdjProfitLCY / TotalSalesLineLCY.Amount * 100, 0.1);

        IF "Sales Header"."Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
        END;

        IF Cust.GET("Sales Header"."Bill-to Customer No.") THEN
            Cust.CALCFIELDS("Balance (LCY)")
        ELSE
            CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
            CreditLimitLCYExpendedPct := 0
        ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
                    CreditLimitLCYExpendedPct := 10000
                ELSE
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        SalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified, FALSE);

        OnAfterCalculateTotals("Sales Header", TotalSalesLine, TotalSalesLineLCY, TempVATAmountLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateTotals(var SalesHeader: Record 36; var TotalSalesLine: Record 37; var TotalSalesLineLCY: Record 37; var TempVATAmountLine: Record 290 temporary)
    begin
    end;
}

