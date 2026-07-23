report 56125 "Agin Accounts Payable (CxP)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Agin Accounts Payable (CxP).rdlc';
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Aged Accounts Payable';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; 23)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Vendor Posting Group", "Payment Terms Code", "Purchaser Code";
            column(Aged_Accounts_Payable_; 'Aged Accounts Payable')
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(TIME; TIME)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(DateTitle; DateTitle)
            {
            }
            column(Document_Number_is______Vendor_Ledger_Entry__FIELDCAPTION__External_Document_No___; 'Document Number is ' + "Vendor Ledger Entry".FIELDCAPTION("External Document No."))
            {
            }
            column(Vendor_TABLECAPTION__________FilterString; Vendor.TABLECAPTION + ': ' + FilterString)
            {
            }
            column(ColumnHeadHead; ColumnHeadHead)
            {
            }
            column(ColumnHead_1_; ColumnHead[1])
            {
            }
            column(ColumnHead_2_; ColumnHead[2])
            {
            }
            column(ColumnHead_3_; ColumnHead[3])
            {
            }
            column(ColumnHead_4_; ColumnHead[4])
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(PrintDetail; PrintDetail)
            {
            }
            column(PrintAmountsInLocal; PrintAmountsInLocal)
            {
            }
            column(ShowAllForOverdue; ShowAllForOverdue)
            {
            }
            column(UseExternalDocNo; UseExternalDocNo)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(ColumnHeadHead_Control21; ColumnHeadHead)
            {
            }
            column(ShortDateTitle; ShortDateTitle)
            {
            }
            column(ColumnHead_1__Control26; ColumnHead[1])
            {
            }
            column(ColumnHead_2__Control27; ColumnHead[2])
            {
            }
            column(ColumnHead_3__Control28; ColumnHead[3])
            {
            }
            column(ColumnHead_4__Control29; ColumnHead[4])
            {
            }
            column(Dim; DimDepto)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(Vendor_Contact; Contact)
            {
            }
            column(BlockedDescription; BlockedDescription)
            {
            }
            column(TotalBalanceDue__; -"TotalBalanceDue$")
            {
            }
            column(BalanceDue___1_; -"BalanceDue$"[1])
            {
            }
            column(BalanceDue___2_; -"BalanceDue$"[2])
            {
            }
            column(BalanceDue___3_; -"BalanceDue$"[3])
            {
            }
            column(BalanceDue___4_; -"BalanceDue$"[4])
            {
            }
            column(PercentString_1_; PercentString[1])
            {
            }
            column(PercentString_2_; PercentString[2])
            {
            }
            column(PercentString_3_; PercentString[3])
            {
            }
            column(PercentString_4_; PercentString[4])
            {
            }
            column(TotalBalanceDue___Control91; -"TotalBalanceDue$")
            {
            }
            column(BalanceDue___1__Control92; -"BalanceDue$"[1])
            {
            }
            column(BalanceDue___2__Control93; -"BalanceDue$"[2])
            {
            }
            column(BalanceDue___3__Control94; -"BalanceDue$"[3])
            {
            }
            column(PercentString_1__Control95; PercentString[1])
            {
            }
            column(PercentString_2__Control96; PercentString[2])
            {
            }
            column(PercentString_3__Control97; PercentString[3])
            {
            }
            column(BalanceDue___4__Control98; -"BalanceDue$"[4])
            {
            }
            column(PercentString_4__Control99; PercentString[4])
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Aged_byCaption; Aged_byCaptionLbl)
            {
            }
            column(Control11Caption; CAPTIONCLASSTRANSLATE('101,1,' + Text021))
            {
            }
            column(Vendor__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(AmountDueToPrint_Control74Caption; AmountDueToPrint_Control74CaptionLbl)
            {
            }
            column(Vendor__No__Caption_Control22; FIELDCAPTION("No."))
            {
            }
            column(Vendor_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(DocNoCaption; DocNoCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(AmountDueToPrint_Control63Caption; AmountDueToPrint_Control63CaptionLbl)
            {
            }
            column(DocumentCaption; DocumentCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry___Currency_Code_Caption; Vendor_Ledger_Entry___Currency_Code_CaptionLbl)
            {
            }
            column(Expense; ExpenseLbl)
            {
            }
            column(Phone_Caption; Phone_CaptionLbl)
            {
            }
            column(Contact_Caption; Contact_CaptionLbl)
            {
            }
            column(Control1020000Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionCode("Currency Code")))
            {
            }
            column(Control47Caption; CAPTIONCLASSTRANSLATE('101,0,' + Text022))
            {
            }
            column(Control48Caption; CAPTIONCLASSTRANSLATE('101,0,' + Text022))
            {
            }
            dataitem("Vendor Ledger Entry"; 25)
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");

                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date");

                trigger OnAfterGetRecord()
                begin
                    SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    CALCFIELDS("Remaining Amount");

                    CLEAR(RazonGasto);
                    PIL.RESET;
                    PIL.SETRANGE("Document No.", "Document No.");
                    PIL.SETRANGE(Type, PIL.Type::"G/L Account");
                    IF PIL.FINDSET THEN
                        REPEAT
                            IF (STRLEN(RazonGasto) + STRLEN(PIL.Description)) < 1024 THEN
                                RazonGasto += PIL.Description + ', ';
                        // IF PDD.GET(123,PIL."Document No.",PIL."Line No.",DimDepto) THEN
                        //   DimDeptoPRT := PDD."Dimension Value Code";
                        UNTIL PIL.NEXT = 0;

                    IF "Remaining Amount" <> 0 THEN
                        InsertTemp("Vendor Ledger Entry");
                    CurrReport.SKIP;    //  this fools the system into thinking that no details "printed"...yet
                end;

                trigger OnPreDataItem()
                begin
                    // Find ledger entries which are posted before the date of the aging.
                    SETRANGE("Posting Date", 0D, PeriodEndingDate[1]);

                    IF (ShowOnlyOverDueBy <> '') AND NOT (ShowAllForOverdue) THEN
                        SETRANGE("Due Date", 0D, CalculatedDate);
                end;
            }
            dataitem(Totals; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(AmountDueToPrint; -AmountDueToPrint)
                {
                }
                column(AmountDue_1_; -AmountDue[1])
                {
                }
                column(AmountDue_2_; -AmountDue[2])
                {
                }
                column(AmountDue_3_; -AmountDue[3])
                {
                }
                column(AmountDue_4_; -AmountDue[4])
                {
                }
                column(AgingDate; AgingDate)
                {
                }
                column(Vendor_Ledger_Entry__Description; "Vendor Ledger Entry".Description)
                {
                }
                column(Vendor_Ledger_Entry___Document_Type_; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocNo; DocNo)
                {
                }
                column(AmountDueToPrint_Control63; -AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control64; -AmountDue[1])
                {
                }
                column(AmountDue_2__Control65; -AmountDue[2])
                {
                }
                column(AmountDue_3__Control66; -AmountDue[3])
                {
                }
                column(AmountDue_4__Control67; -AmountDue[4])
                {
                }
                column(Vendor_Ledger_Entry___Currency_Code_; "Vendor Ledger Entry"."Currency Code")
                {
                }
                column(RazonGasto; RazonGasto)
                {
                }
                column(AmountDueToPrint_Control68; -AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control69; -AmountDue[1])
                {
                }
                column(AmountDue_2__Control70; -AmountDue[2])
                {
                }
                column(AmountDue_3__Control71; -AmountDue[3])
                {
                }
                column(AmountDue_4__Control72; -AmountDue[4])
                {
                }
                column(AmountDueToPrint_Control74; -AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control75; -AmountDue[1])
                {
                }
                column(AmountDue_2__Control76; -AmountDue[2])
                {
                }
                column(AmountDue_3__Control77; -AmountDue[3])
                {
                }
                column(AmountDue_4__Control78; -AmountDue[4])
                {
                }
                column(PercentString_1__Control5; PercentString[1])
                {
                }
                column(PercentString_2__Control6; PercentString[2])
                {
                }
                column(PercentString_3__Control7; PercentString[3])
                {
                }
                column(PercentString_4__Control8; PercentString[4])
                {
                }
                column(Vendor__No___Control80; Vendor."No.")
                {
                }
                column(AmountDueToPrint_Control81; -AmountDueToPrint)
                {
                }
                column(AmountDue_1__Control82; -AmountDue[1])
                {
                }
                column(AmountDue_2__Control83; -AmountDue[2])
                {
                }
                column(AmountDue_3__Control84; -AmountDue[3])
                {
                }
                column(AmountDue_4__Control85; -AmountDue[4])
                {
                }
                column(PercentString_1__Control87; PercentString[1])
                {
                }
                column(PercentString_2__Control88; PercentString[2])
                {
                }
                column(PercentString_3__Control89; PercentString[3])
                {
                }
                column(PercentString_4__Control90; PercentString[4])
                {
                }
                column(Balance_ForwardCaption; Balance_ForwardCaptionLbl)
                {
                }
                column(Balance_to_Carry_ForwardCaption; Balance_to_Carry_ForwardCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption; Total_Amount_DueCaptionLbl)
                {
                }
                column(Total_Amount_DueCaption_Control86; Total_Amount_DueCaption_Control86Lbl)
                {
                }
                column(Control1020001Caption; CAPTIONCLASSTRANSLATE(GetCurrencyCaptionCode(Vendor."Currency Code")))
                {
                }
                column(Totals_Number; Number)
                {
                }
                dataitem("Purch. Inv. Line"; 123)
                {
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(Posted_Document_Dimension__Dimension_Value_Code_; DimSetEntry."Dimension Value Code")
                    {
                    }
                    column(Importe; Importe)
                    {
                    }
                    column(Posted_Document_Dimension_Table_ID; 123)
                    {
                    }
                    column(Posted_Document_Dimension_Document_No_; "Document No.")
                    {
                    }
                    column(Posted_Document_Dimension_Line_No_; "Line No.")
                    {
                    }
                    column(Posted_Document_Dimension_Dimension_Code; DimDepto)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //+MIGRACION 2013
                        //+#139
                        //CLEAR(PIL);
                        //IF PIL.GET("Document No.","Line No.") THEN
                        //  Importe += PIL."Amount Including VAT"
                        //-#139
                        DimSetEntry.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                        DimSetEntry.SETRANGE("Dimension Code", DimDepto);
                        IF NOT DimSetEntry.FINDFIRST THEN
                            CurrReport.SKIP;
                        Importe := "Amount Including VAT";
                        //-MIGRACION 2013
                    end;

                    trigger OnPreDataItem()
                    begin

                        //+MIGRACION 2013
                        //SETRANGE("Table ID",123);
                        //SETRANGE("Document No.","Vendor Ledger Entry"."Document No.");
                        //SETFILTER("Line No.",'<>%1',0);
                        //SETRANGE("Dimension Code",DimDepto);
                        "Purch. Inv. Line".SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                        //-MIGRACION 2013
                        Importe := 0; //+#139
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF ISSERVICETIER THEN
                        CalcPercents(AmountDueToPrint, AmountDue);

                    IF Number = 1 THEN
                        TempVendLedgEntry.FIND('-')
                    ELSE
                        TempVendLedgEntry.NEXT;
                    TempVendLedgEntry.SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    TempVendLedgEntry.CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");
                    IF TempVendLedgEntry."Remaining Amount" = 0 THEN
                        CurrReport.SKIP;
                    IF TempVendLedgEntry."Currency Code" <> '' THEN
                        TempVendLedgEntry."Remaining Amt. (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToFCY(
                              PeriodEndingDate[1],
                              TempVendLedgEntry."Currency Code",
                              '',
                              TempVendLedgEntry."Remaining Amount"));
                    IF PrintAmountsInLocal THEN BEGIN
                        TempVendLedgEntry."Remaining Amount" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToFCY(
                              PeriodEndingDate[1],
                              TempVendLedgEntry."Currency Code",
                              Vendor."Currency Code",
                              TempVendLedgEntry."Remaining Amount"),
                            Currency."Amount Rounding Precision");
                        AmountDueToPrint := TempVendLedgEntry."Remaining Amount";
                    END ELSE
                        AmountDueToPrint := TempVendLedgEntry."Remaining Amt. (LCY)";

                    CASE AgingMethod OF
                        AgingMethod::"Due Date":
                            AgingDate := TempVendLedgEntry."Due Date";
                        AgingMethod::"Trans Date":
                            AgingDate := TempVendLedgEntry."Posting Date";
                        AgingMethod::"Document Date":
                            AgingDate := TempVendLedgEntry."Document Date";
                    END;
                    j := 0;
                    WHILE AgingDate < PeriodEndingDate[j + 1] DO
                        j := j + 1;
                    IF j = 0 THEN
                        j := 1;

                    AmountDue[j] := AmountDueToPrint;
                    "BalanceDue$"[j] := "BalanceDue$"[j] + TempVendLedgEntry."Remaining Amt. (LCY)";

                    IF ISSERVICETIER THEN BEGIN
                        "TotalBalanceDue$" := 0;
                        VendTotAmountDue[j] := VendTotAmountDue[j] + AmountDueToPrint;
                        VendTotAmountDueToPrint := VendTotAmountDueToPrint + AmountDueToPrint;

                        FOR j := 1 TO 4 DO
                            "TotalBalanceDue$" := "TotalBalanceDue$" + "BalanceDue$"[j];
                        CalcPercents("TotalBalanceDue$", "BalanceDue$");
                    END;


                    "Vendor Ledger Entry" := TempVendLedgEntry;
                    IF UseExternalDocNo THEN
                        DocNo := "Vendor Ledger Entry"."External Document No."
                    ELSE
                        DocNo := "Vendor Ledger Entry"."Document No.";

                    // Do NOT use the following fields in the sections:
                    //   "Applied-To Doc. Type"
                    //   "Applied-To Doc. No."
                    //   Open
                    //   "Paym. Disc. Taken"
                    //   "Closed by Entry No."
                    //   "Closed at Date"
                    //   "Closed by Amount"

                    IF PrintDetail AND PrintToExcel THEN
                        MakeExcelDataBody;
                end;

                trigger OnPostDataItem()
                begin
                    IF TempVendLedgEntry.COUNT > 0 THEN BEGIN
                        IF ISSERVICETIER THEN BEGIN
                            FOR j := 1 TO 4 DO
                                AmountDue[j] := VendTotAmountDue[j];
                            AmountDueToPrint := VendTotAmountDueToPrint;
                        END;
                        IF NOT PrintDetail AND PrintToExcel THEN
                            MakeExcelDataBody;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //TODO: Revisar metodo CurrReport.CREATETOTALS(AmountDueToPrint, AmountDue);
                    SETRANGE(Number, 1, TempVendLedgEntry.COUNT);
                    TempVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                    IF ISSERVICETIER THEN BEGIN
                        CLEAR("BalanceDue$");
                        CLEAR(VendTotAmountDue);
                        VendTotAmountDueToPrint := 0;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                VendLedgEntry: Record 25;
            begin
                IF PrintAmountsInLocal THEN BEGIN
                    GetCurrencyRecord(Currency, "Currency Code");
                    CurrencyFactor := CurrExchRate.ExchangeRate(PeriodEndingDate[1], "Currency Code");
                END;

                IF Blocked <> Blocked::" " THEN
                    BlockedDescription := STRSUBSTNO(Text003, Blocked)
                ELSE
                    BlockedDescription := '';

                TempVendLedgEntry.DELETEALL;

                IF ShowOnlyOverDueBy <> '' THEN
                    CalculatedDate := CALCDATE('-' + ShowOnlyOverDueBy, PeriodEndingDate[1]);

                IF ShowAllForOverdue AND (ShowOnlyOverDueBy <> '') THEN BEGIN
                    VendLedgEntry.SETRANGE("Vendor No.", "No.");
                    VendLedgEntry.SETRANGE(Open, TRUE);
                    VendLedgEntry.SETRANGE("Due Date", 0D, CalculatedDate);
                    IF NOT (VendLedgEntry.FINDSET) THEN CurrReport.SKIP;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR("BalanceDue$");
                IF PeriodEndingDate[1] = 0D THEN
                    PeriodEndingDate[1] := WORKDATE;

                IF PrintDetail THEN BEGIN
                    SubTitle := Text004;
                END ELSE BEGIN
                    SubTitle := Text005;
                END;
                SubTitle := SubTitle + Text006 + ' ' + FORMAT(PeriodEndingDate[1], 0, 4) + ')';

                IF AgingMethod = AgingMethod::"Due Date" THEN BEGIN
                    DateTitle := Text007;
                    ShortDateTitle := Text008;
                    ColumnHead[2] := Text009 + ' '
                                     + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                     + ' ' + Text010;
                    ColumnHeadHead := ' ' + Text011 + ' ';
                END ELSE IF AgingMethod = AgingMethod::"Trans Date" THEN BEGIN
                    DateTitle := Text012;
                    ShortDateTitle := Text013;
                    ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                                     + ' - '
                                     + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                     + ' ' + Text010;
                    ColumnHeadHead := ' ' + Text014 + ' ';
                END ELSE BEGIN
                    DateTitle := Text015;
                    ShortDateTitle := Text016;
                    ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                                     + ' - '
                                     + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                     + ' ' + Text010;
                    ColumnHeadHead := ' ' + Text017 + ' ';
                END;

                ColumnHead[1] := Text018;
                ColumnHead[3] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3] + 1)
                                 + ' - '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                                 + ' ' + Text010;
                ColumnHead[4] := 'Over '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                                 + ' ' + Text010;

                IF PrintToExcel THEN
                    MakeExcelInfo;
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
                    field(PeriodEndingDate1; PeriodEndingDate[1])
                    {
                        Caption = 'Aged as of';

                        trigger OnValidate()
                        begin
                            PeriodEndingDate1OnAfterValida;
                        end;
                    }
                    field(AgingMethod; AgingMethod)
                    {
                        Caption = 'Aging Method';
                        OptionCaption = 'Due Date,Trans Date,Document Date';
                    }
                    field(PeriodCalculation; PeriodCalculation)
                    {
                        Caption = 'Length of Aging Periods';

                        trigger OnValidate()
                        begin
                            IF PeriodCalculation = '' THEN
                                ERROR('You must enter a period calculation in the '
                                      + 'Length of Aging Periods field');
                        end;
                    }
                    field(ShowOnlyOverDueBy; ShowOnlyOverDueBy)
                    {
                        Caption = 'Show If Overdue By';
                        DateFormula = true;

                        trigger OnValidate()
                        begin
                            IF AgingMethod <> AgingMethod::"Due Date" THEN
                                ERROR(Text120);
                            IF ShowOnlyOverDueBy = '' THEN ShowAllForOverdue := FALSE;
                        end;
                    }
                    field(DimDepto; DimDepto)
                    {
                        Caption = 'Dimension';
                        TableRelation = Dimension;
                    }
                    field(ShowAllForOverdue; ShowAllForOverdue)
                    {
                        Caption = 'Show All for Overdue By Vendor';

                        trigger OnValidate()
                        begin
                            IF AgingMethod <> AgingMethod::"Due Date" THEN
                                ERROR(Text120);
                            IF ShowAllForOverdue AND (ShowOnlyOverDueBy = '') THEN
                                ERROR(Text119);
                        end;
                    }
                    field(PrintAmountsInLocal; PrintAmountsInLocal)
                    {
                        Caption = 'Print Amounts in Vendor''s Currency';
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            IF ShowAllForOverdue AND (ShowOnlyOverDueBy = '') THEN
                                ERROR(Text119);
                        end;
                    }
                    field(PrintDetail; PrintDetail)
                    {
                        Caption = 'Print Detail';
                    }
                    field(UseExternalDocNo; UseExternalDocNo)
                    {
                        Caption = 'Use External Doc. No.';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodEndingDate[1] = 0D THEN BEGIN
                PeriodEndingDate[1] := WORKDATE;
                PeriodCalculation := Text023;
            END;
        end;
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
        IF AgingMethod = AgingMethod::"Due Date" THEN BEGIN
            PeriodEndingDate[2] := PeriodEndingDate[1];
            FOR j := 3 TO 4 DO
                PeriodEndingDate[j] := CALCDATE('-(' + PeriodCalculation + ')', PeriodEndingDate[j - 1]);
        END ELSE BEGIN
            FOR j := 2 TO 4 DO
                PeriodEndingDate[j] := CALCDATE('-(' + PeriodCalculation + ')', PeriodEndingDate[j - 1]);
        END;
        PeriodEndingDate[5] := 0D;
        CompanyInformation.GET;
        GLSetup.GET;
        FilterString := Vendor.GETFILTERS;

        IF DimDepto = '' THEN
            ERROR(Error001);
    end;

    var
        CompanyInformation: Record 79;
        TempVendLedgEntry: Record 25 temporary;
        Currency: Record 4;
        CurrExchRate: Record 330;
        GLSetup: Record 98;
        ExcelBuf: Record 370 temporary;
        PIL: Record 123;
        PIH: Record 122;
        PeriodCalculation: Code[20];
        ShowOnlyOverDueBy: Code[10];
        AgingMethod: Option "Due Date","Trans Date","Document Date";
        PrintAmountsInLocal: Boolean;
        PrintDetail: Boolean;
        PrintToExcel: Boolean;
        AmountDue: array[4] of Decimal;
        "BalanceDue$": array[4] of Decimal;
        ClosingAmount: Decimal;
        ColumnHead: array[4] of Text[20];
        ColumnHeadHead: Text[59];
        PercentString: array[4] of Text[10];
        Percent: Decimal;
        "TotalBalanceDue$": Decimal;
        AmountDueToPrint: Decimal;
        BlockedDescription: Text[80];
        j: Integer;
        CurrencyFactor: Decimal;
        FilterString: Text[250];
        SubTitle: Text[88];
        DateTitle: Text[20];
        ShortDateTitle: Text[20];
        PeriodEndingDate: array[5] of Date;
        AgingDate: Date;
        UseExternalDocNo: Boolean;
        DocNo: Code[20];
        Text001: Label 'Amounts are in %1';
        Text002: Label 'US Dollars';
        Text003: Label '*** This vendor is blocked for %1 processing ***';
        Text004: Label '(Detail';
        Text005: Label '(Summary';
        Text006: Label ', aged as of';
        Text007: Label 'due date.';
        Text008: Label 'Due Date';
        Text009: Label 'Up To';
        Text010: Label 'Days';
        Text011: Label 'Aged Overdue Amounts';
        Text012: Label 'transaction date.';
        Text013: Label 'Trx Date';
        Text014: Label 'Aged Vendor Balances';
        Text015: Label 'document date.';
        Text016: Label 'Doc Date';
        Text017: Label 'Aged Vendor Balances';
        Text018: Label 'Current';
        Text021: Label 'Amounts are in the vendor''s local currency (report totals are in %1).';
        Text022: Label 'Report Total Amount Due (%1)';
        Text023: Label '30D';
        Text101: Label 'Data';
        Text102: Label 'Aged Accounts Payable';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Vendor Filters';
        Text109: Label 'Aged by';
        Text110: Label 'Amounts are';
        Text111: Label 'In our Functional Currency';
        Text112: Label 'As indicated in Data';
        Text113: Label 'Aged as of';
        Text114: Label 'Aging Date (%1)';
        Text115: Label 'Balance Due';
        Text116: Label 'Document Currency';
        Text117: Label 'Vendor Currency';
        ByVendor: Boolean;
        ShowAllForOverdue: Boolean;
        Text119: Label 'Show Only Overdue By Needs a Valid Date Formula';
        CalculatedDate: Date;
        Text120: Label 'This option is only allowed for method Due Date';
        VendTotAmountDue: array[4] of Decimal;
        VendTotAmountDueToPrint: Decimal;
        RazonGasto: Text[1024];
        DimDepto: Code[20];
        DimDeptoPRT: Code[20];
        Importe: Decimal;
        Error001: Label 'Dimension must be selected in the Option Tab';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Aged_byCaptionLbl: Label 'Aged by';
        NameCaptionLbl: Label 'Name';
        AmountDueToPrint_Control74CaptionLbl: Label 'Balance Due';
        DocNoCaptionLbl: Label 'Number';
        DescriptionCaptionLbl: Label 'Description';
        TypeCaptionLbl: Label 'Type';
        AmountDueToPrint_Control63CaptionLbl: Label 'Balance Due';
        DocumentCaptionLbl: Label 'Document';
        Vendor_Ledger_Entry___Currency_Code_CaptionLbl: Label 'Doc. Curr.';
        ExpenseLbl: Label 'Reason / Account Expense';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Contact:';
        Balance_ForwardCaptionLbl: Label 'Balance Forward';
        Balance_to_Carry_ForwardCaptionLbl: Label 'Balance to Carry Forward';
        Total_Amount_DueCaptionLbl: Label 'Total Amount Due';
        Total_Amount_DueCaption_Control86Lbl: Label 'Total Amount Due';
        DimSetEntry: Record 480;

    local procedure InsertTemp(var VendLedgEntry: Record 25)
    begin
        WITH TempVendLedgEntry DO BEGIN
            IF GET(VendLedgEntry."Entry No.") THEN
                EXIT;
            TempVendLedgEntry := VendLedgEntry;
            CASE AgingMethod OF
                AgingMethod::"Due Date":
                    "Posting Date" := "Due Date";
                AgingMethod::"Document Date":
                    "Posting Date" := "Document Date";
            END;
            INSERT;
        END;
    end;

    procedure CalcPercents(Total: Decimal; Amounts: array[4] of Decimal)
    var
        i: Integer;
        j: Integer;
    begin
        CLEAR(PercentString);
        IF Total <> 0 THEN
            FOR i := 1 TO 4 DO BEGIN
                Percent := Amounts[i] / Total * 100.0;
                IF STRLEN(FORMAT(ROUND(Percent))) + 4 > MAXSTRLEN(PercentString[1]) THEN
                    PercentString[i] := PADSTR(PercentString[i], MAXSTRLEN(PercentString[i]), '*')
                ELSE BEGIN
                    PercentString[i] := FORMAT(ROUND(Percent));
                    j := STRPOS(PercentString[i], '.');
                    IF j = 0 THEN
                        PercentString[i] := PercentString[i] + '.00'
                    ELSE IF j = STRLEN(PercentString[i]) - 1 THEN
                        PercentString[i] := PercentString[i] + '0';
                    PercentString[i] := PercentString[i] + '%';
                END;
            END;
    end;

    local procedure GetCurrencyRecord(var Currency: Record 4; CurrencyCode: Code[10])
    begin
        IF CurrencyCode = '' THEN BEGIN
            CLEAR(Currency);
            Currency.Description := GLSetup."LCY Code";
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        END ELSE
            IF Currency.Code <> CurrencyCode THEN
                Currency.GET(CurrencyCode);
    end;

    local procedure GetCurrencyCaptionCode(CurrencyCode: Code[10]): Text[80]
    begin
        IF PrintAmountsInLocal THEN BEGIN
            IF CurrencyCode = '' THEN
                EXIT('101,1,' + Text001)
            ELSE BEGIN
                GetCurrencyRecord(Currency, CurrencyCode);
                EXIT('101,4,' + STRSUBSTNO(Text001, Currency.Description));
            END;
        END ELSE
            EXIT('');
    end;

    local procedure MakeExcelInfo()
    begin
        /*//fes mig
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Aged Accounts Payable",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TIME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text108),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FilterString,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text109),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(DateTitle,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text113),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(PeriodEndingDate[1],FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text110),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF PrintAmountsInLocal THEN
          ExcelBuf.AddInfoColumn(FORMAT(Text112),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddInfoColumn(FORMAT(Text111),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
        */

    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Vendor Ledger Entry".FIELDCAPTION("Vendor No."), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Vendor.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(STRSUBSTNO(Text114, ShortDateTitle), FALSE, '', TRUE, FALSE, TRUE, '@', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Vendor Ledger Entry".FIELDCAPTION(Description), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Vendor Ledger Entry".FIELDCAPTION("Document Type"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Vendor Ledger Entry".FIELDCAPTION("Document No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(FORMAT(Text115), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[1], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(ColumnHead[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        IF PrintAmountsInLocal THEN BEGIN
            IF PrintDetail THEN
                ExcelBuf.AddColumn(FORMAT(Text116), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text)
            ELSE
                ExcelBuf.AddColumn(FORMAT(Text117), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        END;
    end;

    local procedure MakeExcelDataBody()
    var
        CurrencyCodeToPrint: Code[20];
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Vendor."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Vendor.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF PrintDetail THEN BEGIN
            ExcelBuf.AddColumn(AgingDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Vendor Ledger Entry".Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FORMAT("Vendor Ledger Entry"."Document Type"), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(DocNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        END;
        ExcelBuf.AddColumn(-AmountDueToPrint, FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-AmountDue[1], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-AmountDue[2], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-AmountDue[3], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(-AmountDue[4], FALSE, '', FALSE, FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Text);
        IF PrintAmountsInLocal THEN BEGIN
            IF PrintDetail THEN
                CurrencyCodeToPrint := "Vendor Ledger Entry"."Currency Code"
            ELSE
                CurrencyCodeToPrint := Vendor."Currency Code";
            IF CurrencyCodeToPrint = '' THEN
                CurrencyCodeToPrint := GLSetup."LCY Code";
            ExcelBuf.AddColumn(CurrencyCodeToPrint, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        END;
    end;

    local procedure CreateExcelbook()
    begin
        //fes mig ExcelBuf.CreateBookAndOpenExcel(Text101,Text102,COMPANYNAME,USERID);
        ERROR('');
    end;

    local procedure PeriodEndingDate1OnAfterValida()
    begin
        IF PeriodEndingDate[1] = 0D THEN
            PeriodEndingDate[1] := WORKDATE;
    end;
}