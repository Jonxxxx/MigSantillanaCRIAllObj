report 34002522 "DsPOS - Factura Venta GT ON"
{
    // #22712  10/06/2015  MOI   Cuando se reimprima una factura no se tiene que actualizar el NCF.
    //                           Eliminacion de codigo muerto
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/DsPOS - Factura Venta GT ON.rdl';

    Caption = 'Sales - Invoice';
    Permissions = TableData 112 = rm,
                  TableData 7190 = rimd,
                  TableData 34003012 = ri;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; 112)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_DocumentCaption_CopyText_; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__Giro_No__; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_; FORMAT("Sales Header"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(Sales_Invoice_Header___VAT_Registration_No__; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_; FORMAT("Sales Header"."Due Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPerson_Name; "Sales Header"."Salesperson Code" + '  -  ' + SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Invoice_Header___No__; "Sales Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Sales_Invoice_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(FORMAT__Sales_Invoice_Header___Document_Date__0_4_; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(Sales_Invoice_Header___Prices_Including_VAT_; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVAT_YesNo; FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(FORMAT_Cust__Tax_Identification_Type__; FORMAT(Cust."Tax Identification Type"))
                    {
                    }
                    column(Cobrador_Name; "Sales Header"."Collector Code" + '  -  ' + Cobrador)
                    {
                    }
                    column(cobradorText; CobradorText)
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(SIH_NCF; "Sales Header"."No. Comprobante Fiscal")
                    {
                    }
                    column(Sales_Invoice_Header___Cod__Cupon_; "Sales Header"."Cod. Cupon")
                    {
                    }
                    column(LabelCupon; LabelCupon)
                    {
                    }
                    column(Description_Text_No_to_Letter; DescriptionLine[1] + '  ' + CurrName)
                    {
                    }
                    column(Description_Total_Books; STRSUBSTNO(Text012, FORMAT(TotQty)))
                    {
                    }
                    column(Comp_Info_Tax_E; CompanyInfo."Tax Exemption No.")
                    {
                    }
                    column(Sales_Invoice_Line__Amount_Including_VAT_2; "Sales Header"."Amount Including VAT")
                    {
                        AutoFormatExpression = "Sales Line".GetCurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalInclVATText2; TotalInclVATText)
                    {
                    }
                    column(Currency_Exch; VALExchRate)
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__; "Sales Header"."Order No.")
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_Caption; Sales_Invoice_Header___Due_Date_CaptionLbl)
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_Caption; Sales_Invoice_Header___Posting_Date_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Prices_Including_VAT_Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(Tax_Ident__TypeCaption; Tax_Ident__TypeCaptionLbl)
                    {
                    }
                    column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                    {
                    }
                    column(SIH_NCF_Caption; SIH_NCF_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Sales Line"; 113)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Sales_Invoice_Line_Description2_Control65; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity2; Quantity)
                        {
                        }
                        column(Sales_Invoice_Total2_; AmtIVA)
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Unit_Price2_; ROUND("Unit Price", GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Discount2___; "Line Discount %")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount2__Control70; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Discount2_; "Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(SalesLineType2; FORMAT("Sales Line".Type))
                        {
                        }
                        column(Sales_Invoice_Line__No__; "No.")
                        {
                        }
                        column(Sales_Invoice_Line_Description_Control65; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Invoice_Total_; AmtIVA)
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Unit_Price_; ROUND("Unit Price", GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control70; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Discount_; "Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(SalesLineType; FORMAT("Sales Line".Type))
                        {
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Line_No__; "Sales Line"."Line No.")
                        {
                        }
                        column(FOB_Caption; 'Total FOB')
                        {
                        }
                        column(Total_FOB; TotalFOB)
                        {
                            AutoFormatExpression = "Sales Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate;

                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            IF Type = Type::Item THEN BEGIN
                                TotQty += Quantity;
                                TotalFOB += "Amount Including VAT";
                            END;

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;

                            IF ISSERVICETIER THEN BEGIN
                                TotalSubTotal += "Line Amount";
                                TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                                TotalAmount += Amount;
                                TotalAmountVAT += "Amount Including VAT" - Amount;
                                TotalAmountInclVAT += "Amount Including VAT";
                                TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            END;

                            IF Quantity <> 0 THEN //GRN Para poner el precio con IVA
                                IF NOT "Sales Header"."Prices Including VAT" THEN BEGIN
                                    "Unit Price" := ROUND(("Unit Price" * (1 + "VAT %" / 100)), GLSetup."Unit-Amount Rounding Precision");
                                    "Line Discount Amount" := ROUND("Unit Price" * Quantity * "Line Discount %" / 100, GLSetup."Amount Rounding Precision");
                                    AmtIVA := ROUND("Unit Price" * Quantity, GLSetup."Amount Rounding Precision");
                                END;

                            AmtIVA := ROUND("Unit Price" * Quantity, GLSetup."Amount Rounding Precision");
                            "Line Discount Amount" := ROUND("Unit Price" * Quantity * "Line Discount %" / 100, GLSetup."Amount Rounding Precision");
                        end;

                        trigger OnPreDataItem()
                        begin
                            TotQty := 0;
                            TotalFOB := 0;
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        IF ISSERVICETIER THEN
                            OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    IF ISSERVICETIER THEN BEGIN
                        TotalSubTotal := 0;
                        TotalInvoiceDiscountAmount := 0;
                        TotalAmount := 0;
                        TotalAmountVAT := 0;
                        TotalAmountInclVAT := 0;
                        TotalPaymentDiscountOnVAT := 0;
                    END
                end;

                trigger OnPreDataItem()
                begin
                    //GRN Es por el numerador de seris NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    NoOfLoops := ABS(NoOfCopies) + NoSerie."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    IF ISSERVICETIER THEN
                        OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //GRN Para calcular la tasa de cambio
                IF "Currency Code" <> '' THEN BEGIN
                    CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                    CalculatedExchRate := ROUND(1 / "Sales Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                    VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                END;

                VatBussPG.GET("VAT Bus. Posting Group");//GRN Para GUA

                //AMS - Cod. Cup´Š¢n
                IF "Sales Header"."Cod. Cupon" <> '' THEN
                    LabelCupon := Text014
                ELSE
                    LabelCupon := '';
                //AMS - Cod. Cup´Š¢n


                CurrReport.LANGUAGE := LanguageCU.GetLanguageID("Language Code");

                NoSerie.GET("No. Serie NCF Facturas");
                NoSerie.TESTFIELD("Invoice Copies");
                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Collector Code" = '' THEN BEGIN //GRN Se adiciona dato del cobrador
                    SalesPurchPerson.INIT;
                    CobradorText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Collector Code");
                    CobradorText := Text011;
                    Cobrador := SalesPurchPerson.Name;
                END;

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;

                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    //GRN  VATNoText := FIELDCAPTION("VAT Registration No.");
                    VATNoText := 'NIT';
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                    CurrName := Text013;
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                    Currency.GET("Currency Code");
                    CurrName := Currency.Description;
                END;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Header");
                IF NOT Cust.GET("Bill-to Customer No.") THEN
                    CLEAR(Cust);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;
                //fes mig FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                //GRN Para tener el monto de la factura
                CALCFIELDS("Amount Including VAT");
                ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        ToolTip = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = All;
                        Caption = 'Log Interaction';
                        ToolTip = 'Log Interaction';
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
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
    end;

    var
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record 98;
        ShipmentMethod: Record 10;
        PaymentTerms: Record 3;
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        SalesSetup: Record 311;
        Cust: Record 18;
        VATAmountLine: Record 290 temporary;
        RespCenter: Record 5714;
        LanguageCU: Codeunit Language;
        CurrExchRate: Record 330;
        SalesInvCountPrinted: Codeunit 315;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record 7190 temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        Item: Record 27;
        [InDataSet]
        LogInteractionEnable: Boolean;
        Text011: Label 'Collector';
        "*** DSLocGT1.01 ***": Integer;
        NoSerie: Record 308;
        "*** Santillana ***": Integer;
        VatBussPG: Record 323;
        Cobrador: Text[30];
        CobradorText: Text[30];
        ChkTransMgt: Report 10400;
        DescriptionLine: array[2] of Text[250];
        Text012: Label 'Total books %1';
        Text013: Label 'QUETZALES';
        CurrName: Text[30];
        Currency: Record 4;
        TotQty: Decimal;
        TotalFOB: Decimal;
        AmtIVA: Decimal;
        LabelCupon: Text[30];
        Text014: Label 'No. Cup´Š¢n';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        Sales_Invoice_Header___Due_Date_CaptionLbl: Label 'Due Date';
        Invoice_No_CaptionLbl: Label 'Invoice No.';
        Sales_Invoice_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        Tax_Ident__TypeCaptionLbl: Label 'Tax Ident. Type';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        SIH_NCF_CaptionLbl: Label 'FDN No.';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(Enum::"Interaction Log Entry Document Type"::"Sales Inv.") <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record 110;
        SalesShipmentBuffer2: Record 7190 temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Header"."Order No." = '' THEN
            EXIT("Sales Header"."Posting Date");

        CASE "Sales Line".Type OF
            "Sales Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Line");
            "Sales Line".Type::"G/L Account", "Sales Line".Type::Resource,
          "Sales Line".Type::"Charge (Item)", "Sales Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Line");
            "Sales Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record 113)
    var
        ValueEntry: Record 5802;
        ItemLedgerEntry: Record 32;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record 113)
    var
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine2: Record 113;
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF "Sales Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN BEGIN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                    END;
                END;
            UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record 111)
    var
        SalesInvoiceLine: Record 113;
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record 113; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT;
            NextEntryNo := NextEntryNo + 1
        END;
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Sales Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        EXIT(Text004);
    end;
}

