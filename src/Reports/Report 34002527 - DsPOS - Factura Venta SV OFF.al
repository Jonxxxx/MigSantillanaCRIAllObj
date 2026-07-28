report 34002527 "DsPOS - Factura Venta SV OFF"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DsPOS - Factura Venta SV OFF.rdlc';
    Caption = 'Sales - Invoice';
    Permissions = TableData 21 = rm,
                  TableData 112 = rm,
                  TableData 7190 = rm,
                  TableData 34003012 = rim;

    dataset
    {
        dataitem("Sales Invoice Header"; 36)
        {
            CalcFields = "Amount Including VAT", Amount;
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(Sales_Invoice_Header_Posting_No_; "Sales Invoice Header"."Posting No.")
            {
            }
            column(Sales_Invoice_Header_VentaANombre; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(Sales_Invoice_Header_VentaADireccion; "Sales Invoice Header"."Bill-to Address")
            {
            }
            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Sales_Invoice_Header___VAT_Registration_No__; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(SalesPurchPerson_Name; COPYSTR("Sales Invoice Header"."Salesperson Code" + '  -  ' + SalesPurchPerson.Name, 1, 16))
                    {
                    }
                    column(FORMAT__Sales_Invoice_Header___Document_Date__0_4_; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>') + '/' + FORMAT("Sales Invoice Header"."Posting Date", 0, '<Month Text>') + '/' + FORMAT("Sales Invoice Header"."Posting Date", 0, '<Year4>'))
                    {
                    }
                    column(Sales_Invoice_Header___Order_No__; "Sales Invoice Header"."No.")
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(Bill_to_Customer; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(STRSUBSTNO_Text014_TotalDto_; STRSUBSTNO(Text014, TotalDto))
                    {
                    }
                    column(Description_Text_No_to_Letter; DescriptionLine[1])
                    {
                    }
                    column(Fecha_Vencimiento___; 'Fecha Vencimiento :')
                    {
                    }
                    column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(txtTotalItems; txtTotalItems)
                    {
                    }
                    dataitem("Sales Invoice Line"; 37)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       Document No.=FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(FiltroLineas; texFiltroLineas)
                        {
                        }
                        column(Sales_Invoice_Line_Description2_Control65; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity2; Quantity)
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price2_; ROUND("Unit Price", GLSetup."Amount Rounding Precision"))
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Discount2_; "Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(SalesLineType2; FORMAT("Sales Invoice Line".Type))
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
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 2;
                            DecimalPlaces = 2 : 5;
                        }
                        column(Sales_Invoice_Line__Line_Discount_; "Line Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(SalesLineType; FORMAT("Sales Invoice Line".Type))
                        {
                        }
                        column(FOB_Caption; 'Total FOB')
                        {
                        }
                        column(Total_FOB; TotalFOB)
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(blnMostrarFOB; blnMostrarFOB)
                        {
                        }
                        column(AmtExento; AmtExento)
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(AmtGravado; AmtGravado)
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        dataitem("Sales Shipment Buffer"; 2000000026)
                        {
                            DataItemTableView = SORTING(Number);

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;

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

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                            IF Quantity <> 0 THEN //GRN Para poner el precio con IVA
                                IF NOT "Sales Invoice Header"."Prices Including VAT" THEN BEGIN
                                    "Unit Price" := ROUND(("Unit Price" * (1 + "VAT %" / 100)), GLSetup."Unit-Amount Rounding Precision");
                                    "Line Discount Amount" := ROUND("Unit Price" * Quantity * "Line Discount %" / 100, GLSetup."Amount Rounding Precision");
                                    AmtIVA := ROUND("Unit Price" * Quantity, GLSetup."Amount Rounding Precision");
                                    TotalDto += "Line Discount Amount";
                                    Dto := "Line Discount %";
                                END;

                            IF "VAT %" <> 0 THEN
                                AmtGravado := "Amount Including VAT"
                            ELSE
                                AmtExento := "Amount Including VAT";

                            texFiltroLineas := 'LINEAS';

                            IF (Type = Type::"G/L Account") OR (Type = Type::Resource) OR (Type = Type::"Fixed Asset") THEN
                                "No." := '';

                            IF (Type = Type::"Charge (Item)") THEN
                                texFiltroLineas := '';

                            IF Type = Type::Item THEN BEGIN
                                TotQty += Quantity;
                                TotalFOB += "Amount Including VAT";
                            END;

                            DescriptionLine[1] += ' ' + CurrName;
                            txtTotalItems := STRSUBSTNO(Text012, FORMAT(TotQty));
                            IF (Dto <> 0) OR (TotalDto <> 0) THEN BEGIN
                                DescriptionLine[1] := DescriptionLine[1] + STRSUBSTNO(Text015, FORMAT(Dto), 0, '<Decimalplaces,2:2>');
                                txtTotalItems := txtTotalItems + ', ' + STRSUBSTNO(Text014, FORMAT(TotalDto, 0, '<Integer thousand><Decimals,3>'));
                            END;
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
                            //CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount");
                            //CurrReport.CREATETOTALS(AmtExento,AmtGravado);
                        end;
                    }
                    dataitem(SIL; 37)
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       Document No.=FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                            WHERE(Type = CONST("Charge (Item)"));
                        column(FiltroCargos; 'CARGOS')
                        {
                        }
                        column(IC_No_; "No.")
                        {
                        }
                        column(IC_Amt; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SIL_Document_No_; "Document No.")
                        {
                        }
                        column(SIL_Line_No_; "Line No.")
                        {
                        }
                        column(SIL_Type; Type)
                        {
                        }
                    }
                    dataitem(VATCounter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLine.GetTotalVATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; 2000000026)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Invoice Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
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
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //GRN Es por el numerador de seris NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    //NoOfLoops := ABS(NoOfCopies) + NoSerie."Invoice Copies" + 1;
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
                //GRN Configuraciones para controlar la cantidad de lineas por documento
                ConfSantillana.GET();
                ConfSantillana.TESTFIELD(Country);
                ConfigLinRep.GET(ConfSantillana.Country, 52000);
                ConfigLinRep.TESTFIELD("Maximun line number");

                AmtExento := 0;
                AmtGravado := 0;

                "Sales Invoice Line".SETRANGE("Document No.", "No.");
                "Sales Invoice Line".SETRANGE(Type, "Sales Invoice Line".Type::Item);
                "Sales Invoice Line".SETFILTER(Quantity, '<>0');
                IF "Sales Invoice Line".COUNT > ConfigLinRep."Maximun line number" THEN
                    ERROR(Text016);

                //GRN Para calcular la tasa de cambio
                IF "Currency Code" <> '' THEN BEGIN
                    CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                    CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                    VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                END;

                VatBussPG.GET("VAT Bus. Posting Group");//GRN Para GUA

                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                /*
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                END;
                */

                NoSerie.GET("No. Serie NCF Facturas");

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

                //FormatAddr.SalesHeaderBillTo(CustAddr,"Sales Invoice Header");

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
                //fes mig FormatAddr.SalesHeaderShipTo(ShipToAddr,"Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;

                //GRN Para tener el monto de la factura
                CALCFIELDS("Amount Including VAT");
                ChkTransMgt.FormatNoText(DescriptionLine, "Amount Including VAT", 2058, "Currency Code");

                IF ("No. Printed" > 0) AND (NOT CurrReport.PREVIEW) THEN //GRN Para anular el ncf actual y generar uno nuevo - Error de impresion -
                   BEGIN
                    NCFAnulados."No. documento" := "No.";
                    NCFAnulados."No. Serie NCF Facturas" := "No. Serie NCF Facturas";
                    NCFAnulados."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                    NCFAnulados."Fecha anulacion" := TODAY;
                    NCFAnulados.INSERT;
                    "No. Comprobante Fiscal" := NoSeriesMgt.GetNextNo("No. Serie NCF Facturas", TODAY, TRUE);
                    MODIFY;

                    CLE.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                    CLE.SETRANGE("Document No.", "No.");
                    CLE.SETRANGE("Document Type", CLE."Document Type"::Invoice);
                    CLE.SETRANGE("Customer No.", "Sell-to Customer No.");
                    CLE.FINDFIRST;
                    CLE."No. Comprobante Fiscal" := "No. Comprobante Fiscal";
                    CLE.MODIFY;
                END;

                blnMostrarFOB := ("Sales Invoice Header"."Currency Code" <> '') AND (VatBussPG."Cliente de Exportacion");

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
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
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

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
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
        SalesSetup: Record 311;
        Cust: Record 18;
        VATAmountLine: Record 290 temporary;
        RespCenter: Record 5714;
        Language: Record 8;
        CurrExchRate: Record 330;
        SalesInvCountPrinted: Codeunit 315;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
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
        ConfSantillana: Record 56001;
        ConfigLinRep: Record 56002;
        VatBussPG: Record 323;
        Cobrador: Text[30];
        CobradorText: Text[30];
        ChkTransMgt: Report "Check Translation Management";
        DescriptionLine: array[2] of Text[250];
        Text012: Label 'Total books %1';
        NoSeriesMgt: Codeunit 396;
        NCFAnulados: Record 34003012;
        Text013: Label 'DOLLARS';
        CLE: Record 21;
        CurrName: Text[30];
        Currency: Record 4;
        TotQty: Decimal;
        TotalFOB: Decimal;
        AmtIVA: Decimal;
        AmtGravado: Decimal;
        AmtExento: Decimal;
        Text014: Label 'Total discount:  %1';
        Text015: Label ', Discount: %1%';
        TotalDto: Decimal;
        Dto: Decimal;
        txtTotalItems: Text[150];
        Text016: Label 'The number of product lines exceeds the limit for reporting';
        blnMostrarFOB: Boolean;
        texFiltroLineas: Text;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
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
}

