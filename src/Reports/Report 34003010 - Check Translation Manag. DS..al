report 34003010 "Check Translation Manag. DS."
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Check Translation Manag. DS..rdl';
    Caption = 'Test Check Translation Management Functions';

    dataset
    {
        dataitem(PageLoop; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(TestLanguage; TestLanguage)
            {
                OptionCaption = 'ENU,ENC,FRC,ESM';
                OptionMembers = ENU,ENC,FRC,ESM;
            }
            column(TestCurrencyCode; TestCurrencyCode)
            {
            }
            column(TestDate; TestDate)
            {
            }
            column(CheckTransFunctionsCaption; CheckTranslationFunctionsCaptionLbl)
            {
            }
            column(TestDateCaption; TestDateCaptionLbl)
            {
            }
            column(TestLanguageCaption; TestLanguageCaptionLbl)
            {
            }
            column(TestCurrencyCodeCaption; TestCurrencyCodeCaptionLbl)
            {
            }
            column(DateToTestCaption; DateToTestCaptionLbl)
            {
            }
            dataitem(AmountTestLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(TestAmountText1; TestAmountText[1])
                {
                }
                column(TestAmountText2; TestAmountText[2])
                {
                }
                column(AmountInWordsCaption; AmountInWordsCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT FormatNoText(TestAmountText, TestAmount[Number], TestLanguageCode, TestCurrencyCode) THEN
                        TestAmountText[1] := 'ERROR:  ' + TestAmountText[1];
                end;

                trigger OnPreDataItem()
                begin
                    IF TestOption = TestOption::"Dates Only" THEN
                        CurrReport.BREAK;
                    SETRANGE(Number, 1, TestNumAmounts);
                end;
            }
            dataitem(DateTestLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(TestDateIndicator; TestDateIndicator)
                {
                }
                column(TestDateText; TestDateText)
                {
                }
                column(TestDateSeparatorFormatted; FORMAT(TestDateSeparator[Number]))
                {
                }
                column(TestDateIndicatorCaption; TestDateIndicatorCaptionLbl)
                {
                }
                column(TestDateTextCaption; TestDateTextCaptionLbl)
                {
                }
                column(DateSeparatorCaption; DateSeparatorCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TestDateText :=
                      FormatDate(TestDate, TestDateFormat[Number], TestDateSeparator[Number], TestLanguageCode, TestDateIndicator);
                end;

                trigger OnPreDataItem()
                begin
                    IF TestOption = TestOption::"Amounts Only" THEN
                        CurrReport.BREAK;
                    SETRANGE(Number, 1, TestNumDates);
                end;
            }
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
                    field(TestOption; TestOption)
                    {
                        Caption = 'Test Option';
                        OptionCaption = 'Both Amounts and Dates,Amounts Only,Dates Only';
                    }
                    field(TestLanguage; TestLanguage)
                    {
                        Caption = 'Test Language';
                        OptionCaption = 'ENU,ENC,FRC,ESM';
                    }
                    field(TestCurrencyCode; TestCurrencyCode)
                    {
                        Caption = 'Test Currency Code';
                        TableRelation = Currency;
                    }
                    field(TestDate; TestDate)
                    {
                        Caption = 'Date to Test';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            TestDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        MakeTestData;
        CASE TestLanguage OF
            TestLanguage::ENU:
                TestLanguageCode := 1033;
            TestLanguage::FRC:
                TestLanguageCode := 3084;
            TestLanguage::ESM:
                TestLanguageCode := 2058;
            TestLanguage::ENC:
                TestLanguageCode := 4105;
        END;
    end;

    var
        Currency: Record 4;
        GLSetup: Record 98;
        EnglishLanguageCode: Integer;
        FrenchLanguageCode: Integer;
        SpanishLanguageCode: Integer;
        CAEnglishLanguageCode: Integer;
        LanguageCode: Integer;
        CurrencyCode: Code[10];
        OnesText: array[30] of Text[30];
        TensText: array[10] of Text[30];
        HundredsText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        HundredText: Text[30];
        AndText: Text[30];
        ZeroText: Text[30];
        CentsText: Text[30];
        OneMillionText: Text[30];
        Text000: Label 'Zero';
        Text001: Label 'One';
        Text002: Label 'Two';
        Text003: Label 'Three';
        Text004: Label 'Four';
        Text005: Label 'Five';
        Text006: Label 'Six';
        Text007: Label 'Seven';
        Text008: Label 'Eight';
        Text009: Label 'Nine';
        Text010: Label 'Ten';
        Text011: Label 'Eleven';
        Text012: Label 'Twelve';
        Text013: Label 'Thirteen';
        Text014: Label 'Fourteen';
        Text015: Label 'Fifteen';
        Text016: Label 'Sixteen';
        Text017: Label 'Seventeen';
        Text018: Label 'Eighteen';
        Text019: Label 'Nineteen';
        Text020: Label 'Twenty';
        Text021: Label 'Thirty';
        Text022: Label 'Forty';
        Text023: Label 'Fifty';
        Text024: Label 'Sixty';
        Text025: Label 'Seventy';
        Text026: Label 'Eighty';
        Text027: Label 'Ninety';
        Text028: Label 'Hundred';
        Text029: Label 'and';
        Text031: Label 'Thousand';
        Text032: Label 'Million';
        Text033: Label 'Billion';
        Text035: Label '/100';
        Text036: Label 'One Million';
        Text041: Label 'Twenty One';
        Text042: Label 'Twenty Two';
        Text043: Label 'Twenty Three';
        Text044: Label 'Twenty Four';
        Text045: Label 'Twenty Five';
        Text046: Label 'Twenty Six';
        Text047: Label 'Twenty Seven';
        Text048: Label 'Twenty Eight';
        Text049: Label 'Twenty Nine';
        Text051: Label 'One Hundred';
        Text052: Label 'Two Hundred';
        Text053: Label 'Three Hundred';
        Text054: Label 'Four Hundred';
        Text055: Label 'Five Hundred';
        Text056: Label 'Six Hundred';
        Text057: Label 'Seven Hundred';
        Text058: Label 'Eight Hundred';
        Text059: Label 'Nine Hundred';
        Text100: Label 'Language Code %1 is not implemented.';
        Text101: Label '%1 results in a written number that is too long.';
        Text102: Label '%1 is too large to convert to text.';
        Text103: Label '%1 language is not enabled.';
        Text104: Label '****';
        Text107: Label 'MM DD YYYY';
        Text108: Label 'DD MM YYYY';
        Text109: Label 'YYYY MM DD';
        TestLanguage: Option ENU,ENC,FRC,ESM;
        TestOption: Option "Both Amounts and Dates","Amounts Only","Dates Only";
        TestCurrencyCode: Code[10];
        TestLanguageCode: Integer;
        TestAmount: array[50] of Decimal;
        TestDateFormat: array[20] of Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        TestDateSeparator: array[20] of Option " ","-",".","/";
        TestAmountText: array[2] of Text[80];
        TestDateText: Text[30];
        TestDateIndicator: Text[30];
        TestNumAmounts: Integer;
        TestNumDates: Integer;
        TestDate: Date;
        Text110: Label 'US dollars';
        Text111: Label 'Mexican pesos';
        Text112: Label 'Canadian dollars';
        CheckTranslationFunctionsCaptionLbl: Label 'Test of Check Translation Functions';
        TestDateCaptionLbl: Label 'Test Date';
        TestLanguageCaptionLbl: Label 'Test Language';
        TestCurrencyCodeCaptionLbl: Label 'Test Currency Code';
        DateToTestCaptionLbl: Label 'Date to Test';
        AmountInWordsCaptionLbl: Label 'Amount In Words';
        TestDateIndicatorCaptionLbl: Label 'Check Date Indicator';
        TestDateTextCaptionLbl: Label 'Check Date';
        DateSeparatorCaptionLbl: Label 'Check Date Separator';
        txt001: Label 'CON';

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; NewLanguageCode: Integer; NewCurrencyCode: Code[10]) Result: Boolean
    begin
        SetObjectLanguage(NewLanguageCode);

        InitTextVariable;
        GLSetup.GET;
        GLSetup.TESTFIELD("LCY Code");
        CurrencyCode := NewCurrencyCode;
        IF CurrencyCode = '' THEN BEGIN
            Currency.INIT;
            Currency.Code := GLSetup."LCY Code";
            CASE GLSetup."LCY Code" OF
                'USD':
                    Currency.Description := Text110;
                'MXP':
                    Currency.Description := Text111;
                'CAD':
                    Currency.Description := Text112;
            END;
        END ELSE
            IF NOT Currency.GET(CurrencyCode) THEN
                CLEAR(Currency);
        CLEAR(NoText);

        IF No < 1000000000000.0 THEN
            CASE LanguageCode OF
                EnglishLanguageCode, CAEnglishLanguageCode:
                    Result := FormatNoTextENU(NoText, No);
                SpanishLanguageCode:
                    Result := FormatNoTextESM(NoText, No);
                FrenchLanguageCode:
                    Result := FormatNoTextFRC(NoText, No);
                ELSE BEGIN
                    NoText[1] := STRSUBSTNO(Text100, LanguageCode);
                    Result := FALSE;
                END;
            END
        ELSE BEGIN
            NoText[1] := STRSUBSTNO(Text102, No);
            Result := FALSE;
        END;
    end;

    local procedure SetObjectLanguage(NewLanguageCode: Integer)
    var
        WindowsLang: Record 2000000045;
    begin
        EnglishLanguageCode := 1033;
        FrenchLanguageCode := 3084;
        SpanishLanguageCode := 2058;
        CAEnglishLanguageCode := 4105;

        WindowsLang.GET(NewLanguageCode);
        IF NOT WindowsLang."Globally Enabled" THEN
            ERROR(Text103, WindowsLang.Name);
        LanguageCode := NewLanguageCode;
        CurrReport.LANGUAGE(LanguageCode);
    end;

    local procedure InitTextVariable()
    begin
        OnesText[1] := Text001;
        OnesText[2] := Text002;
        OnesText[3] := Text003;
        OnesText[4] := Text004;
        OnesText[5] := Text005;
        OnesText[6] := Text006;
        OnesText[7] := Text007;
        OnesText[8] := Text008;
        OnesText[9] := Text009;
        OnesText[10] := Text010;
        OnesText[11] := Text011;
        OnesText[12] := Text012;
        OnesText[13] := Text013;
        OnesText[14] := Text014;
        OnesText[15] := Text015;
        OnesText[16] := Text016;
        OnesText[17] := Text017;
        OnesText[18] := Text018;
        OnesText[19] := Text019;
        OnesText[20] := Text020;
        OnesText[21] := Text041;
        OnesText[22] := Text042;
        OnesText[23] := Text043;
        OnesText[24] := Text044;
        OnesText[25] := Text045;
        OnesText[26] := Text046;
        OnesText[27] := Text047;
        OnesText[28] := Text048;
        OnesText[29] := Text049;

        TensText[1] := Text010;
        TensText[2] := Text020;
        TensText[3] := Text021;
        TensText[4] := Text022;
        TensText[5] := Text023;
        TensText[6] := Text024;
        TensText[7] := Text025;
        TensText[8] := Text026;
        TensText[9] := Text027;

        HundredsText[1] := Text051;
        HundredsText[2] := Text052;
        HundredsText[3] := Text053;
        HundredsText[4] := Text054;
        HundredsText[5] := Text055;
        HundredsText[6] := Text056;
        HundredsText[7] := Text057;
        HundredsText[8] := Text058;
        HundredsText[9] := Text059;

        ExponentText[1] := '';
        ExponentText[2] := Text031;
        ExponentText[3] := Text032;
        ExponentText[4] := Text033;

        HundredText := Text028;
        AndText := Text029;
        ZeroText := Text000;
        CentsText := Text035;
        OneMillionText := Text036;
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[40]; Divider: Text[1]): Boolean
    begin
        IF NoTextIndex > ARRAYLEN(NoText) THEN
            EXIT(FALSE);
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN BEGIN
                NoText[ARRAYLEN(NoText)] := STRSUBSTNO(Text101, AddText);
                EXIT(FALSE);
            END;
        END;

        CASE LanguageCode OF
            EnglishLanguageCode:
                IF NoText[NoTextIndex] = Text104 THEN
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + UPPERCASE(AddText), '<')
                ELSE
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + Divider + UPPERCASE(AddText), '<');
            SpanishLanguageCode:
                IF NoText[NoTextIndex] = Text104 THEN
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + UPPERCASE(AddText), '<')
                ELSE
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + Divider + UPPERCASE(AddText), '<');
            CAEnglishLanguageCode:
                IF NoText[NoTextIndex] = Text104 THEN
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + AddText, '<')
                ELSE
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + Divider + AddText, '<');
            FrenchLanguageCode:
                IF NoText[NoTextIndex] = Text104 THEN
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + AddText, '<')
                ELSE
                    NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + Divider + LOWERCASE(AddText), '<');
        END;

        EXIT(TRUE);
    end;

    procedure FormatDate(Date: Date; DateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD"; DateSeparator: Option " ","-",".","/"; NewLanguageCode: Integer; var DateIndicator: Text) ChequeDate: Text[30]
    begin
        SetObjectLanguage(NewLanguageCode);

        CASE DateFormat OF
            DateFormat::"MM DD YYYY":
                BEGIN
                    DateIndicator := Text107;
                    CASE DateSeparator OF
                        0:
                            ChequeDate := FORMAT(Date, 0, '<Month,2> <Day,2> <Year4>');
                        1:
                            ChequeDate := FORMAT(Date, 0, '<Month,2>-<Day,2>-<Year4>');
                        2:
                            ChequeDate := FORMAT(Date, 0, '<Month,2>.<Day,2>.<Year4>');
                        3:
                            ChequeDate := FORMAT(Date, 0, '<Month,2>/<Day,2>/<Year4>');
                    END;
                END;
            DateFormat::"DD MM YYYY":
                BEGIN
                    DateIndicator := Text108;
                    CASE DateSeparator OF
                        0:
                            ChequeDate := FORMAT(Date, 0, '<Day,2> <Month,2> <Year4>');
                        1:
                            ChequeDate := FORMAT(Date, 0, '<Day,2>-<Month,2>-<Year4>');
                        2:
                            ChequeDate := FORMAT(Date, 0, '<Day,2>.<Month,2>.<Year4>');
                        3:
                            ChequeDate := FORMAT(Date, 0, '<Day,2>/<Month,2>/<Year4>');
                    END;
                END;
            DateFormat::"YYYY MM DD":
                BEGIN
                    DateIndicator := Text109;
                    CASE DateSeparator OF
                        0:
                            ChequeDate := FORMAT(Date, 0, '<Year4> <Month,2> <Day,2>');
                        1:
                            ChequeDate := FORMAT(Date, 0, '<Year4>-<Month,2>-<Day,2>');
                        2:
                            ChequeDate := FORMAT(Date, 0, '<Year4>.<Month,2>.<Day,2>');
                        3:
                            ChequeDate := FORMAT(Date, 0, '<Year4>/<Month,2>/<Day,2>');
                    END;
                END;
            ELSE BEGIN
                DateIndicator := '';
                ChequeDate := FORMAT(Date, 0, 4);
            END;
        END;
    end;

    local procedure FormatNoTextENU(var NoText: array[2] of Text[80]; No: Decimal): Boolean
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        TxtNo: Text[30];
    begin
        NoTextIndex := 1;
        NoText[1] := Text104;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroText, ' ')
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds], ' ');
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundredText, ' ');
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens], ' ');
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones], ' ');
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent], ' ');
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        //001
        /*
        IF LanguageCode = CAEnglishLanguageCode THEN BEGIN
          AddToNoText(NoText,NoTextIndex,PrintExponent,Currency.Description,' ');
          AddToNoText(NoText,NoTextIndex,PrintExponent,AndText,' ');
          EXIT(AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + CentsText,' '));
        END;
        AddToNoText(NoText,NoTextIndex,PrintExponent,AndText,' ');
        AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + CentsText,' ');
        EXIT(AddToNoText(NoText,NoTextIndex,PrintExponent,Currency.Description,' '));
        */
        //001

        TxtNo := FORMAT(No, 0, '<Precision,2:2><Standard Format,0>');
        TxtNo := COPYSTR(TxtNo, STRPOS(TxtNo, '.') + 1, 2);

        IF LanguageCode = CAEnglishLanguageCode THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, txt001, ' ');//AMS
            AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
            EXIT(AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100) + CentsText, ' '));
        END;
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
        //GRN AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + CentsText,' ');
        AddToNoText(NoText, NoTextIndex, PrintExponent, TxtNo + CentsText, ' ');

        EXIT(AddToNoText(NoText, NoTextIndex, PrintExponent, txt001, ' '));//AMS

    end;

    local procedure FormatNoTextESM(var NoText: array[2] of Text[80]; No: Decimal): Boolean
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        TxtNo: Text[30];
    begin
        NoTextIndex := 1;
        NoText[1] := Text104;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroText, ' ')
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    IF (Hundreds = 1) AND (Tens = 0) AND (Ones = 0) THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, HundredText, ' ')
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, HundredsText[Hundreds], ' ');
                END;
                CASE Tens OF
                    0:
                        IF (Hundreds = 0) AND (Ones = 1) AND (Exponent > 1) THEN
                            PrintExponent := TRUE
                        ELSE
                            IF Ones > 0 THEN
                                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                    1, 2:
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones], ' ');
                    ELSE BEGIN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens], ' ');
                        IF Ones <> 0 THEN BEGIN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                        END;
                    END;
                END;
                IF PrintExponent AND (Exponent > 1) THEN BEGIN
                    IF (Hundreds = 0) AND (Tens = 0) AND (Ones = 1) AND (Exponent = 3) THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OneMillionText, ' ')
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent], ' ');
                END;
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;


        //001
        //AddToNoText(NoText,NoTextIndex,PrintExponent,Currency.Description,' ');
        TxtNo := FORMAT(No, 0, '<Precision,2:2><Standard Format,0>');
        TxtNo := COPYSTR(TxtNo, STRPOS(TxtNo, '.') + 1, 2);

        AddToNoText(NoText, NoTextIndex, PrintExponent, txt001, ' ');
        //001



        //GRN EXIT(AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100,2) + CentsText,' '));
        EXIT(AddToNoText(NoText, NoTextIndex, PrintExponent, TxtNo + CentsText, ' '));
    end;

    local procedure FormatNoTextFRC(var NoText: array[2] of Text[80]; No: Decimal): Boolean
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        NoTextIndex := 1;
        NoText[1] := Text104;

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ZeroText, ' ')
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;

                IF Hundreds = 1 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, HundredText, ' ')
                ELSE
                    IF Hundreds > 1 THEN BEGIN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds], ' ');
                        IF (Tens * 10 + Ones) = 0 THEN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, HundredText + 's', ' ')
                        ELSE
                            AddToNoText(NoText, NoTextIndex, PrintExponent, HundredText, ' ');
                    END;

                FormatTensFRC(NoText, NoTextIndex, PrintExponent, Exponent, Hundreds, Tens, Ones);

                IF PrintExponent AND (Exponent > 1) THEN
                    IF ((Hundreds * 100 + Tens * 10 + Ones) > 1) AND (Exponent <> 2) THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent] + 's', ' ')
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent], ' ');

                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;


        //AddToNoText(NoText,NoTextIndex,PrintExponent,Currency.Description,' ');
        AddToNoText(NoText, NoTextIndex, PrintExponent, txt001, ' ');//AMS
        AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
        EXIT(AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100, 2) + CentsText, ' '));
    end;

    local procedure FormatTensFRC(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; Exponent: Integer; Hundreds: Integer; Tens: Integer; Ones: Integer)
    begin
        CASE Tens OF
            9:
                IF Ones = 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[9] + 's', ' ')
                ELSE BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[8], ' ');
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones + 10], '-');
                END;
            8:
                IF Ones = 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[8] + 's', ' ')
                ELSE BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[8], ' ');
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], '-');
                END;
            7:
                BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[6], ' ');
                    IF Ones = 1 THEN BEGIN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones + 10], ' ');
                    END ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones + 10], '-');
                END;
            2:
                BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[2], ' ');
                    IF Ones > 0 THEN BEGIN
                        IF Ones = 1 THEN BEGIN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                        END ELSE
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], '-');
                    END;
                END;
            1:
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones], ' ');
            0:
                BEGIN
                    IF Ones > 0 THEN
                        IF (Ones = 1) AND (Hundreds < 1) AND (Exponent = 2) THEN
                            PrintExponent := TRUE
                        ELSE
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                END;
            ELSE BEGIN
                AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens], ' ');
                IF Ones > 0 THEN BEGIN
                    IF Ones = 1 THEN BEGIN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, AndText, ' ');
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], ' ');
                    END ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones], '-');
                END;
            END;
        END;
    end;

    procedure MakeTestData()
    var
        i: Integer;
        j: Integer;
    begin
        TestAmount[1] := 293.38;
        TestAmount[2] := 80;
        TestAmount[3] := 100;
        TestAmount[4] := 99.45;
        TestAmount[5] := 1266;
        TestAmount[6] := 1399121.38;
        TestAmount[7] := 185.38;
        TestAmount[8] := 680.33;
        TestAmount[9] := 80.99;
        TestAmount[10] := 200.66;
        TestAmount[11] := 238.27;
        TestAmount[12] := 80765.56;
        TestAmount[13] := 1000.78;
        TestAmount[14] := 2980.32;
        TestAmount[15] := 1301476.89;
        TestAmount[16] := 2000000.38;
        TestAmount[17] := 345497.88;
        TestAmount[18] := 1000065;
        TestAmount[19] := 1500300999.38;
        TestAmount[20] := 3000000000.0;
        TestAmount[21] := 1001.99;
        TestAmount[22] := 88;
        TestAmount[23] := 121;
        TestAmount[24] := 331;
        TestAmount[25] := 3341;
        TestAmount[26] := 1051;
        TestAmount[27] := 1000061;
        TestAmount[28] := 81;
        TestAmount[29] := 11;
        TestAmount[30] := 71;
        TestAmount[31] := 91;
        TestAmount[32] := 0;
        TestAmount[33] := 1;
        TestAmount[34] := 0.99;
        TestAmount[35] := 1.23;
        TestAmount[36] := 12.34;
        TestAmount[37] := 123.45;
        TestAmount[38] := 1234.56;
        TestAmount[39] := 12345.67;
        TestAmount[40] := 123456.78;
        TestAmount[41] := 1234567.89;
        TestAmount[42] := 12345678.9;
        TestAmount[43] := 123456789.01;
        TestAmount[44] := 1234567890.12;
        TestAmount[45] := 987654321098.76;
        TestAmount[46] := 9999999999.0;
        TestAmount[47] := 1000;
        TestNumAmounts := 47;

        TestNumDates := 0;
        FOR i := 0 TO 3 DO
            FOR j := 0 TO 3 DO BEGIN
                TestNumDates := TestNumDates + 1;
                TestDateFormat[TestNumDates] := i;
                TestDateSeparator[TestNumDates] := j;
            END;
    end;
}

