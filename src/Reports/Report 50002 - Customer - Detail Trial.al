report 50002 "Customer - Detail Trial"
{
    // #4148  PLB  25/09/2014  Se han añadido varios datos al cliente:
    //                         - Nombre institución (Name 2)
    //                         - Dirección
    //                         - Vendedor
    //                         - Contacto
    //  Proyecto: Implementacion Microsoft Dynamic
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.           Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  001           13/03/2023      LDP      SANTINAV-4805: Ajuste reporte Cliente - Movimiento
    //  002           10/04/2025      LDP      SANTINAV-7904: Error en estados de cuenta ã Información incompleta y saldo incorrecto, no visible para busquedas.
    DefaultLayout = RDLC;
    RDLCLayout = './Customer - Detail Trial.rdlc';

    Caption = 'Customer - Detail Trial Bal.';

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Date Filter";
            column(TodayFormatted; FORMAT(TODAY))
            {
            }
            column(PeriodCustDatetFilter; STRSUBSTNO(Text000, CustDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(CustFilterCaption; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(RemainingAmtCaption; RemainingAmtCaption)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Name_Cust; Name)
            {
            }
            column(PhoneNo_Cust; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(Email_2; Customer."E-Mail 2")
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceLCY; StartBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(StartBalAdjLCY; StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceLCY; CustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(CustLedgerEntryAmtLCY; "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(StartBalanceLCYAdjLCY; StartBalanceLCY + StartBalAdjLCY)
            {
                AutoFormatType = 1;
            }
            column(StrtBalLCYCustLedgEntryAmt; StartBalanceLCY + "Cust. Ledger Entry"."Amount (LCY)" + Correction + ApplicationRounding)
            {
                AutoFormatType = 1;
            }
            column(CustDetailTrialBalCaption; CustDetailTrialBalCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllAmtsLCYCaption; AllAmtsLCYCaptionLbl)
            {
            }
            column(RepInclCustsBalCptn; RepInclCustsBalCptnLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(BalanceLCYCaption; BalanceLCYCaptionLbl)
            {
            }
            column(AdjOpeningBalCaption; AdjOpeningBalCaptionLbl)
            {
            }
            column(BeforePeriodCaption; BeforePeriodCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(OpeningBalCaption; OpeningBalCaptionLbl)
            {
            }
            column(Institucion; "Name 2")
            {
            }
            column(Direccion; Address + ' ' + City)
            {
            }
            column(DireccionLbl; DireccionLbl)
            {
            }
            column(VendedorLbl; VendedorLbl)
            {
            }
            column(CodVendedor; GetSalesPersonName())
            {
            }
            column(Contacto; Contact)
            {
                IncludeCaption = true;
            }
            dataitem("Cust. Ledger Entry"; 21)
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               Posting Date=FIELD("Date Filter"),
                               Global Dimension 2 Code=FIELD("Global Dimension 2 Filter"),
                               Global Dimension 1 Code=FIELD("Global Dimension 1 Filter"),
                               Date Filter=FIELD("Date Filter");
                DataItemTableView = SORTING("Customer No.","Posting Date");
                column(PostDate_CustLedgEntry;FORMAT("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry;"Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry;"Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry;Description)
                {
                    IncludeCaption = true;
                }
                column(CustAmount;CustAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustRemainAmount;CustRemainAmount)
                {
                    AutoFormatExpression = CustCurrencyCode;
                    AutoFormatType = 1;
                }
                column(CustEntryDueDate;FORMAT(CustEntryDueDate))
                {
                }
                column(EntryNo_CustLedgEntry;"Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CustCurrencyCode;CustCurrencyCode)
                {
                }
                column(CustBalanceLCY1;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                dataitem("Detailed Cust. Ledg. Entry";379)
                {
                    DataItemLink = "Cust. Ledger Entry No."=FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.",Entry Type,Posting Date)
                                        WHERE("Entry Type"=FILTER(Appln. Rounding|Correction of Remaining Amount));
                    column(EntryType_DtldCustLedgEntry;FORMAT("Entry Type"))
                    {
                    }
                    column(Correction;Correction)
                    {
                        AutoFormatType = 1;
                    }
                    column(CustBalanceLCY2;CustBalanceLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(ApplicationRounding;ApplicationRounding)
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CASE "Entry Type" OF
                          "Entry Type"::"Appln. Rounding":
                            ApplicationRounding := ApplicationRounding + "Amount (LCY)";
                          "Entry Type"::"Correction of Remaining Amount":
                            Correction := Correction + "Amount (LCY)";
                        END;
                        CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETFILTER("Posting Date",CustDateFilter);
                        Correction := 0;
                        ApplicationRounding := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //if "Document Type" > 0 then
                    //error('%1',"Document Type");
                    
                    //001+
                    /*
                    IF "Currency Code" <> '' THEN
                     CALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt. (LCY)")
                     ELSE
                      CALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt ");
                    */
                    //001-
                    CALCFIELDS(Amount,"Remaining Amount","Amount (LCY)","Remaining Amt. (LCY)");
                    
                    CustLedgEntryExists := TRUE;
                    IF PrintAmountsInLCY THEN BEGIN
                      CustAmount := "Amount (LCY)";
                      CustRemainAmount := "Remaining Amt. (LCY)";
                      CustCurrencyCode := '';
                      CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";//001+- Si es filtro moneda local.
                    END ELSE BEGIN
                      //001+
                      IF ("Currency Code") <> '' THEN BEGIN
                       CustAmount := Amount;
                       CustRemainAmount := "Remaining Amount";
                       CustBalanceLCY := CustBalanceLCY + Amount
                       END ELSE BEGIN
                         CustAmount := "Amount (LCY)";
                         CustRemainAmount := "Remaining Amt. (LCY)";
                         CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                         END;
                      //001-
                    
                      //CustAmount := Amount;//001+-Original
                      //CustRemainAmount := "Remaining Amount";//001+-Original
                      CustCurrencyCode := "Currency Code";
                    END;
                    
                    //001+
                    /*
                    IF ("Currency Code") <> '' THEN
                     CustBalanceLCY := CustBalanceLCY + "Amount"
                     ELSE
                      CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";
                    */
                    //001-
                    //CustBalanceLCY := CustBalanceLCY + "Amount (LCY)";//001+- Original
                    IF ("Document Type" = "Document Type"::Payment) OR ("Document Type" = "Document Type"::Refund) THEN
                      CustEntryDueDate := 0D
                    ELSE
                      CustEntryDueDate := "Due Date";

                end;

                trigger OnPreDataItem()
                begin
                    CustLedgEntryExists := FALSE;
                    IF "Currency Code" <> '' THEN
                     CurrReport.CREATETOTALS(CustAmount,Amount)//001+
                     ELSE
                      CurrReport.CREATETOTALS(CustAmount,"Amount (LCY)");//001+

                    //CurrReport.CREATETOTALS(CustAmount,"Amount (LCY)");//001+
                end;
            }
            dataitem("Integer";2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(Name1_Cust;Customer.Name)
                {
                }
                column(CustBalanceLCY4;CustBalanceLCY)
                {
                    AutoFormatType = 1;
                }
                column(StartBalanceLCY2;StartBalanceLCY)
                {
                }
                column(StartBalAdjLCY2;StartBalAdjLCY)
                {
                }
                column(CustBalStBalStBalAdjLCY;CustBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
                {
                    AutoFormatType = 1;
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT CustLedgEntryExists AND ((StartBalanceLCY = 0) OR ExcludeBalanceOnly) THEN BEGIN
                      StartBalanceLCY := 0;
                      CurrReport.SKIP;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF PrintOnlyOnePerPage THEN
                  PageGroupNo := PageGroupNo + 1;

                StartBalanceLCY := 0;
                StartBalAdjLCY := 0;
                IF CustDateFilter <> '' THEN BEGIN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,GETRANGEMIN("Date Filter") - 1);
                    CALCFIELDS("Net Change (LCY)");
                    StartBalanceLCY := "Net Change (LCY)";
                  END;
                  SETFILTER("Date Filter",CustDateFilter);
                  CALCFIELDS("Net Change (LCY)");
                  //001+
                  IF ("Currency Code") <> '' THEN
                   StartBalAdjLCY := "Net Change (LCY)"
                  ELSE
                   StartBalAdjLCY := "Net Change";
                  //001-
                  //StartBalAdjLCY := "Net Change (LCY)";//001-
                  CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
                  CustLedgEntry.SETRANGE("Customer No.","No.");
                  CustLedgEntry.SETFILTER("Posting Date",CustDateFilter);
                  IF CustLedgEntry.FIND('-') THEN
                    REPEAT
                      CustLedgEntry.SETFILTER("Date Filter",CustDateFilter);
                      //001+
                      IF ("Currency Code") <> '' THEN BEGIN
                      CustLedgEntry.CALCFIELDS(Amount);//001+-
                      StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry.Amount;
                       END ELSE BEGIN
                         CustLedgEntry.CALCFIELDS("Amount (LCY)");//001+-
                         StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";
                        END;
                      //001-
                      //CustLedgEntry.CALCFIELDS("Amount (LCY)");//001+-
                      //StartBalAdjLCY := StartBalAdjLCY - CustLedgEntry."Amount (LCY)";//
                      "Detailed Cust. Ledg. Entry".SETCURRENTKEY("Cust. Ledger Entry No.","Entry Type","Posting Date");
                      "Detailed Cust. Ledg. Entry".SETRANGE("Cust. Ledger Entry No.",CustLedgEntry."Entry No.");
                      "Detailed Cust. Ledg. Entry".SETFILTER("Entry Type",'%1|%2',
                        "Detailed Cust. Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
                        "Detailed Cust. Ledg. Entry"."Entry Type"::"Appln. Rounding");
                      "Detailed Cust. Ledg. Entry".SETFILTER("Posting Date",CustDateFilter);
                      IF "Detailed Cust. Ledg. Entry".FIND('-') THEN
                        REPEAT
                          //001+
                          IF ("Currency Code") <> '' THEN
                            StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry".Amount
                           ELSE
                            StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)"
                          //001-
                          //StartBalAdjLCY := StartBalAdjLCY - "Detailed Cust. Ledg. Entry"."Amount (LCY)";//001+-
                        UNTIL "Detailed Cust. Ledg. Entry".NEXT = 0;
                      "Detailed Cust. Ledg. Entry".RESET;
                    UNTIL CustLedgEntry.NEXT = 0;
                END;
                CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalanceLCY = 0);
                CustBalanceLCY := StartBalanceLCY + StartBalAdjLCY
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
                CurrReport.CREATETOTALS("Cust. Ledger Entry"."Amount (LCY)",StartBalanceLCY,StartBalAdjLCY,Correction,ApplicationRounding);
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
                    field(ShowAmountsInLCY;PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in $';
                    }
                    field(NewPageperCustomer;PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                    }
                    field(ExcludeCustHaveaBalanceOnly;ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
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

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
        WITH "Cust. Ledger Entry" DO
          IF PrintAmountsInLCY THEN BEGIN
            AmountCaption := FIELDCAPTION("Amount (LCY)");
            RemainingAmtCaption := FIELDCAPTION("Remaining Amt. (LCY)");
          END ELSE BEGIN
            AmountCaption := FIELDCAPTION(Amount);
            RemainingAmtCaption := FIELDCAPTION("Remaining Amount");
          END;
    end;

    var
        Text000: Label 'Period: %1';
        CustLedgEntry: Record 21;
        SalesPerson: Record 13;
        PrintAmountsInLCY: Boolean;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        CustFilter: Text;
        CustDateFilter: Text[30];
        AmountCaption: Text[80];
        RemainingAmtCaption: Text[30];
        CustAmount: Decimal;
        CustRemainAmount: Decimal;
        CustBalanceLCY: Decimal;
        CustCurrencyCode: Code[10];
        CustEntryDueDate: Date;
        StartBalanceLCY: Decimal;
        StartBalAdjLCY: Decimal;
        Correction: Decimal;
        ApplicationRounding: Decimal;
        CustLedgEntryExists: Boolean;
        PageGroupNo: Integer;
        CustDetailTrialBalCaptionLbl: Label 'Customer - Detail Trial Bal.';
        PageNoCaptionLbl: Label 'Page';
        AllAmtsLCYCaptionLbl: Label 'All amounts are in $';
        RepInclCustsBalCptnLbl: Label 'This report also includes customers that only have balances.';
        PostingDateCaptionLbl: Label 'Posting Date';
        DueDateCaptionLbl: Label 'Due Date';
        BalanceLCYCaptionLbl: Label 'Balance ($)';
        AdjOpeningBalCaptionLbl: Label 'Adj. of Opening Balance';
        BeforePeriodCaptionLbl: Label 'Total ($) Before Period';
        TotalCaptionLbl: Label 'Total ($)';
        OpeningBalCaptionLbl: Label 'Total Adj. of Opening Balance';
        DireccionLbl: Label 'Address';
        VendedorLbl: Label 'Sales person';
        Lang: Record 8;

    procedure InitializeRequest(ShowAmountInLCY: Boolean;SetPrintOnlyOnePerPage: Boolean;SetExcludeBalanceOnly: Boolean)
    begin
        PrintOnlyOnePerPage := SetPrintOnlyOnePerPage;
        PrintAmountsInLCY := ShowAmountInLCY;
        ExcludeBalanceOnly := SetExcludeBalanceOnly;
    end;

    procedure GetSalesPersonName(): Text[100]
    begin
        IF SalesPerson.GET(Customer."Salesperson Code") THEN
          EXIT('(' + SalesPerson.Code + ') ' + SalesPerson.Name);
        EXIT('');
    end;
}

