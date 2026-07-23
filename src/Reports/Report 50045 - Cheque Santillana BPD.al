report 50045 "Cheque Santillana BPD"
{
    // Proyecto: Microsoft Dynamics Business Central
    // ------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------
    // No.      Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // MIGDO    06-enero-2022   FES           Comentado por error compilacion. Migracion Santillana Dominicana
    DefaultLayout = RDLC;
    RDLCLayout = './Cheque Santillana BPD.rdlc';

    Caption = 'Check';
    //TODO: revisar propiedad PDFFontEmbedding = true;
    Permissions = TableData 270 = m;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(VoidGenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                CheckManagement.VoidCheck(VoidGenJnlLine);
            end;

            trigger OnPreDataItem()
            begin
                IF CurrReport.PREVIEW THEN
                    ERROR(Text000);

                IF UseCheckNo = '' THEN
                    ERROR(Text001);

                IF INCSTR(UseCheckNo) = '' THEN
                    ERROR(USText004);

                IF TestPrint THEN
                    CurrReport.BREAK;

                IF NOT ReprintChecks THEN
                    CurrReport.BREAK;

                IF (GETFILTER("Line No.") <> '') OR (GETFILTER("Document No.") <> '') THEN
                    ERROR(
                      Text002, FIELDCAPTION("Line No."), FIELDCAPTION("Document No."));
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", TRUE);
            end;
        }
        dataitem(TestGenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.");

            trigger OnAfterGetRecord()
            begin
                IF Amount = 0 THEN
                    CurrReport.SKIP;

                TextDiaCheque := FORMAT("Posting Date", 0, ('<day,2>'));
                TextMesCheque := FORMAT("Posting Date", 0, ('<month Text>'));
                TextAnoCheque := FORMAT("Posting Date", 0, ('<year4>'));

                //--AMS Descripcion y beneficiario--//
                Descr := GenJnlLine.Description;
                //Benef := GenJnlLine.Beneficiario;

                rBanco.GET("Bal. Account No.");
                NombreBanco := UPPERCASE(rBanco.Name);
                DireccionBanco := rBanco.Address + ' ' + rBanco."Address 2";
                CiudadBanco := rBanco.County;
                CuentaBanco := rBanco."Bank Account No.";




                TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                IF "Bal. Account No." <> BankAcc2."No." THEN
                    CurrReport.SKIP;
                //TODO: Ver
                /*
                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            IF BankAcc2."Check Date Format" = BankAcc2."Check Date Format"::" " THEN
                                ERROR(USText006, BankAcc2.FIELDCAPTION("Check Date Format"), BankAcc2.TABLECAPTION, BankAcc2."No.");
                            IF BankAcc2."Bank Communication" = BankAcc2."Bank Communication"::"S Spanish" THEN
                                ERROR(USText007, BankAcc2.FIELDCAPTION("Bank Communication"), BankAcc2.TABLECAPTION, BankAcc2."No.");
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            Cust.GET("Account No.");
                            IF Cust."Check Date Format" = Cust."Check Date Format"::" " THEN
                                ERROR(USText006, Cust.FIELDCAPTION("Check Date Format"), Cust.TABLECAPTION, "Account No.");
                            IF Cust."Bank Communication" = Cust."Bank Communication"::"S Spanish" THEN
                                ERROR(USText007, Cust.FIELDCAPTION("Bank Communication"), Cust.TABLECAPTION, "Account No.");
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            //AMS
                            //Vend.GET("Account No.");
                            //IF Vend."Check Date Format" = Vend."Check Date Format"::" " THEN
                            //  ERROR(USText006,Vend.FIELDCAPTION("Check Date Format"),Vend.TABLECAPTION,"Account No.");
                            //IF Vend."Bank Communication" = Vend."Bank Communication"::"S Spanish" THEN
                            //  ERROR(USText007,Vend.FIELDCAPTION("Bank Communication"),Vend.TABLECAPTION,"Account No.");                                
                        END;
                    "Account Type"::"Bank Account":
                        BEGIN
                            BankAcc.GET("Account No.");
                            IF BankAcc."Check Date Format" = BankAcc."Check Date Format"::" " THEN
                                ERROR(USText006, BankAcc.FIELDCAPTION("Check Date Format"), BankAcc.TABLECAPTION, "Account No.");
                            IF BankAcc."Bank Communication" = BankAcc."Bank Communication"::"S Spanish" THEN
                                ERROR(USText007, BankAcc.FIELDCAPTION("Bank Communication"), BankAcc.TABLECAPTION, "Account No.");
                        END;
                END;
                */
            end;

            trigger OnPreDataItem()
            begin
                IF ISSERVICETIER THEN BEGIN
                    IF TestPrint THEN BEGIN
                        CompanyInfo.GET;
                        BankAcc2.GET(BankAcc2."No.");
                        BankCurrencyCode := BankAcc2."Currency Code";
                    END;
                END;

                IF TestPrint THEN
                    CurrReport.BREAK;
                CompanyInfo.GET;
                BankAcc2.GET(BankAcc2."No.");
                BankCurrencyCode := BankAcc2."Currency Code";

                //IF BankAcc2."Country/Region Code" <> CompanyInfo."Canada Country/Region Code" THEN   //MIGDO
                IF BankAcc2."Country/Region Code" <> 'CA' THEN
                    CurrReport.BREAK;
                BankAcc2.TESTFIELD(Blocked, FALSE);
                COPY(VoidGenJnlLine);
                BankAcc2.GET(BankAcc2."No.");
                BankAcc2.TESTFIELD(Blocked, FALSE);
                SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                SETRANGE("Check Printed", FALSE);
            end;
        }
        dataitem(GenJnlLine; 81)
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            column(GenJnlLine_Journal_Template_Name; "Journal Template Name")
            {
            }
            column(GenJnlLine_Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(GenJnlLine_Line_No_; "Line No.")
            {
            }
            dataitem(CheckPages; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PrintSettledLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 30;

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT TestPrint THEN BEGIN
                            IF FoundLast THEN BEGIN
                                IF RemainingAmount <> 0 THEN BEGIN
                                    DocType := Text015;
                                    DocNo := '';
                                    ExtDocNo := '';
                                    LineAmount := RemainingAmount;
                                    LineAmount2 := RemainingAmount;
                                    CurrentLineAmount := LineAmount2;
                                    LineDiscount := 0;
                                    RemainingAmount := 0;
                                    PostingDesc := CheckToAddr[1];

                                END ELSE
                                    CurrReport.BREAK;
                            END ELSE BEGIN
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustLedgEntry.RESET;
                                                        CustLedgEntry.SETCURRENTKEY("Document No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendLedgEntry.RESET;
                                                        VendLedgEntry.SETCURRENTKEY("Document No.");
                                                        VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                        VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                        VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                            FoundLast := TRUE;
                                        END;
                                    ApplyMethod::OneLineID:
                                        BEGIN
                                            CASE BalancingType OF
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                        FoundLast := (CustLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        FoundLast := TRUE;//AMS
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            CustLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT CustLedgEntry.FIND('-');
                                                            FoundLast := TRUE;//AMS
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                        FoundLast := (VendLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                        FoundLast := TRUE;//AMS
                                                        IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                            VendLedgEntry.SETRANGE(Positive, FALSE);
                                                            FoundLast := NOT VendLedgEntry.FIND('-');
                                                            FoundLast := TRUE;//AMS
                                                            FoundNegative := TRUE;
                                                        END;
                                                    END;
                                            END;
                                            RemainingAmount := RemainingAmount - LineAmount2;
                                            CurrentLineAmount := LineAmount2;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        BEGIN
                                            CurrentLineAmount := GenJnlLine2.Amount;
                                            LineAmount2 := CurrentLineAmount;
                                            IF GenJnlLine2."Applies-to ID" <> '' THEN
                                                ERROR(
                                                  Text016 +
                                                  Text017);
                                            GenJnlLine2.TESTFIELD("Check Printed", FALSE);
                                            GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");

                                            IF GenJnlLine2."Applies-to Doc. No." = '' THEN BEGIN
                                                DocType := Text015;
                                                DocNo := '';
                                                ExtDocNo := '';
                                                LineAmount := CurrentLineAmount;
                                                LineDiscount := 0;
                                                PostingDesc := GenJnlLine2.Description;
                                            END ELSE BEGIN
                                                CASE BalancingType OF
                                                    BalancingType::"G/L Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                            PostingDesc := GenJnlLine2.Description;

                                                        END;
                                                    BalancingType::Customer:
                                                        BEGIN
                                                            CustLedgEntry.RESET;
                                                            CustLedgEntry.SETCURRENTKEY("Document No.");
                                                            CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                            CustLedgEntry.FIND('-');
                                                            CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::Vendor:
                                                        BEGIN
                                                            VendLedgEntry.RESET;
                                                            VendLedgEntry.SETCURRENTKEY("Document No.");
                                                            VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                            VendLedgEntry.FIND('-');
                                                            VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                            LineAmount := CurrentLineAmount;
                                                        END;
                                                    BalancingType::"Bank Account":
                                                        BEGIN
                                                            DocType := FORMAT(GenJnlLine2."Document Type");
                                                            DocNo := GenJnlLine2."Document No.";
                                                            ExtDocNo := GenJnlLine2."External Document No.";
                                                            LineAmount := CurrentLineAmount;
                                                            LineDiscount := 0;
                                                            PostingDesc := GenJnlLine2.Description;

                                                        END;
                                                END;
                                            END;
                                            FoundLast := GenJnlLine2.NEXT = 0;
                                            FoundLast := TRUE;//AMS
                                        END;
                                END;
                            END;

                            TotalLineAmount := TotalLineAmount + CurrentLineAmount;
                            TotalLineDiscount := TotalLineDiscount + LineDiscount;
                        END ELSE BEGIN
                            IF FoundLast THEN
                                CurrReport.BREAK;
                            FoundLast := TRUE;
                            DocType := Text018;
                            DocNo := Text010;
                            ExtDocNo := Text010;
                            LineAmount := 0;
                            LineDiscount := 0;
                            PostingDesc := '';

                        END;

                        IF ISSERVICETIER THEN BEGIN
                            IF DocNo = '' THEN
                                CurrencyCode2 := GenJnlLine."Currency Code";
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT TestPrint THEN
                            IF FirstPage THEN BEGIN
                                FoundLast := TRUE;
                                CASE ApplyMethod OF
                                    ApplyMethod::OneLineOneEntry:
                                        // AMS FoundLast := FALSE;
                                        FoundLast := TRUE;//AMS
                                    ApplyMethod::OneLineID:
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustLedgEntry.RESET;
                                                    CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.SETRANGE(Open, TRUE);
                                                    CustLedgEntry.SETRANGE(Positive, TRUE);
                                                    CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT CustLedgEntry.FIND('-');
                                                    FoundLast := TRUE;//AMS
                                                    IF FoundLast THEN BEGIN
                                                        CustLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT CustLedgEntry.FIND('-');
                                                        FoundLast := TRUE;//AMS
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendLedgEntry.RESET;
                                                    VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.SETRANGE(Open, TRUE);
                                                    VendLedgEntry.SETRANGE(Positive, TRUE);
                                                    VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                    FoundLast := NOT VendLedgEntry.FIND('-');
                                                    FoundLast := TRUE;//AMS
                                                    IF FoundLast THEN BEGIN
                                                        VendLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT VendLedgEntry.FIND('-');
                                                        FoundLast := TRUE;//AMS
                                                        FoundNegative := TRUE;
                                                    END ELSE
                                                        FoundNegative := FALSE;
                                                END;
                                        END;
                                    ApplyMethod::MoreLinesOneEntry:
                                        //FoundLast := FALSE;
                                        FoundLast := TRUE;//AMS
                                END;
                            END
                            ELSE
                                //FoundLast := FALSE;
                                FoundLast := TRUE;//AMS
                        IF ISSERVICETIER THEN BEGIN
                            IF DocNo = '' THEN
                                CurrencyCode2 := GenJnlLine."Currency Code";


                            IF GenJnlLine."Currency Code" <> '' THEN
                                NetAmount := STRSUBSTNO(Text063, GenJnlLine."Currency Code")
                            ELSE BEGIN
                                GLSetup.GET;
                                NetAmount := STRSUBSTNO(Text063, GLSetup."LCY Code");
                            END;

                            PageNo := PageNo + 1;
                        END;
                    end;
                }
                dataitem(PrintCheck; 2000000026)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(UseCheckNo; UseCheckNo)
                    {
                    }
                    column(CheckToAddr_1_; CheckToAddr[1])
                    {
                    }
                    column(Monto; Monto)
                    {
                    }
                    column(COPYSTR_DescriptionLine_1__5_STRLEN_DescriptionLine_1___; COPYSTR(DescriptionLine[1], 5, STRLEN(DescriptionLine[1])))
                    {
                    }
                    column(Monto_Control1000000033; Monto)
                    {
                    }
                    column(ABS_wMonto_1__; ABS(wMonto[1]))
                    {
                    }
                    column(txtReferencia_1_; txtReferencia[1])
                    {
                    }
                    column(txtReferencia_2_; txtReferencia[2])
                    {
                    }
                    column(txtReferencia_3_; txtReferencia[3])
                    {
                    }
                    column(txtReferencia_4_; txtReferencia[4])
                    {
                    }
                    column(txtReferencia_5_; txtReferencia[5])
                    {
                    }
                    column(Fecha1; txtFecha[1])
                    {
                    }
                    column(txtFecha_2_; txtFecha[2])
                    {
                    }
                    column(txtFecha_3_; txtFecha[3])
                    {
                    }
                    column(txtFecha_4_; txtFecha[4])
                    {
                    }
                    column(txtFecha_5_; txtFecha[5])
                    {
                    }
                    column(ABS_wMonto_2__; ABS(wMonto[2]))
                    {
                    }
                    column(ABS_wMonto_3__; ABS(wMonto[3]))
                    {
                    }
                    column(ABS_wMonto_4__; ABS(wMonto[4]))
                    {
                    }
                    column(ABS_wMonto_5__; ABS(wMonto[5]))
                    {
                    }
                    column(CtaBanco; CtaBanco)
                    {
                    }
                    column(ABS_wMonto_5___Control1000000056; ABS(wMonto[5]))
                    {
                    }
                    column(ABS_wMonto_4___Control1000000057; ABS(wMonto[4]))
                    {
                    }
                    column(ABS_wMonto_3___Control1000000058; ABS(wMonto[3]))
                    {
                    }
                    column(ABS_wMonto_2___Control1000000059; ABS(wMonto[2]))
                    {
                    }
                    column(ABS_wMonto_1___Control1000000060; ABS(wMonto[1]))
                    {
                    }
                    column(CodCuentaFactura_1_; CodCuentaFactura[1])
                    {
                    }
                    column(CodCuentaFactura_2_; CodCuentaFactura[2])
                    {
                    }
                    column(CodCuentaFactura_3_; CodCuentaFactura[3])
                    {
                    }
                    column(CodCuentaFactura_4_; CodCuentaFactura[4])
                    {
                    }
                    column(CodCuentaFactura_5_; CodCuentaFactura[5])
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____day_2_____1_1_; COPYSTR(FORMAT(Fecha, 0, ('<day,2>')), 1, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____day_2_____2_1_; COPYSTR(FORMAT(Fecha, 0, ('<day,2>')), 2, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____MONTH_2_____1_1_; COPYSTR(FORMAT(Fecha, 0, ('<MONTH,2>')), 1, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____MONTH_2_____2_1_; COPYSTR(FORMAT(Fecha, 0, ('<MONTH,2>')), 2, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____yEAR4_____1_1_; COPYSTR(FORMAT(Fecha, 0, ('<yEAR4>')), 1, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____yEAR4_____2_1_; COPYSTR(FORMAT(Fecha, 0, ('<yEAR4>')), 2, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____yEAR4_____3_1_; COPYSTR(FORMAT(Fecha, 0, ('<yEAR4>')), 3, 1))
                    {
                    }
                    column(COPYSTR_FORMAT_Fecha_0____yEAR4_____4_1_; COPYSTR(FORMAT(Fecha, 0, ('<yEAR4>')), 4, 1))
                    {
                    }
                    column(TextAnoCheque; TextAnoCheque)
                    {
                    }
                    column(TextMesCheque; TextMesCheque)
                    {
                    }
                    column(TextDiaCheque; TextDiaCheque)
                    {
                    }
                    column(Cheque_No_Caption; Cheque_No_CaptionLbl)
                    {
                    }
                    column(ReferenciaCaption; ReferenciaCaptionLbl)
                    {
                    }
                    column(FechaCaption; FechaCaptionLbl)
                    {
                    }
                    column(CuentaCaption; CuentaCaptionLbl)
                    {
                    }
                    column(MontoCaption; MontoCaptionLbl)
                    {
                    }
                    column(Desc_AdjCaption; Desc_AdjCaptionLbl)
                    {
                    }
                    column(Monto_NetoCaption; Monto_NetoCaptionLbl)
                    {
                    }
                    column(Cta__Caption; Cta__CaptionLbl)
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(PrintCheck_Number; Number)
                    {
                    }
                    column(Descripcion; UPPERCASE(Descr))
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        Decimals: Decimal;
                    begin
                        IF NOT TestPrint THEN BEGIN
                            WITH GenJnlLine DO BEGIN
                                CheckLedgEntry.INIT;
                                CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                                CheckLedgEntry."Posting Date" := "Posting Date";
                                CheckLedgEntry."Document Type" := "Document Type";
                                CheckLedgEntry."Document No." := UseCheckNo;
                                CheckLedgEntry.Description := CheckToAddr[1];
                                CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
                                CheckLedgEntry."Bal. Account Type" := BalancingType;
                                CheckLedgEntry."Bal. Account No." := BalancingNo;

                                // Grabar el beneficiario en movimiento de cheque
                                CheckLedgEntry.Beneficiario := Beneficiario;

                                IF FoundLast THEN BEGIN
                                    IF TotalLineAmount < 0 THEN
                                        ERROR(
                                          Text020,
                                          UseCheckNo, TotalLineAmount);
                                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Printed;
                                    CheckLedgEntry.Amount := TotalLineAmount;
                                END ELSE BEGIN
                                    CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::Voided;
                                    CheckLedgEntry.Amount := 0;
                                END;
                                CheckLedgEntry."Check Date" := "Posting Date";
                                CheckLedgEntry."Check No." := UseCheckNo;
                                //CheckManagement.InsertCheck(CheckLedgEntry);  //MIGDO
                                CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);  //MIGDO

                                IF FoundLast THEN BEGIN
                                    IF BankAcc2."Currency Code" <> '' THEN
                                        Currency.GET(BankAcc2."Currency Code")
                                    ELSE
                                        Currency.InitRoundingPrecision;
                                    Decimals := CheckLedgEntry.Amount - ROUND(CheckLedgEntry.Amount, 1, '<');
                                    IF STRLEN(FORMAT(Decimals)) < STRLEN(FORMAT(Currency."Amount Rounding Precision")) THEN
                                        IF Decimals = 0 THEN
                                            CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0) +
                                              COPYSTR(FORMAT(0.01), 2, 1) +
                                              PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - 2, '0')
                                        ELSE
                                            CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0) +
                                              PADSTR('', STRLEN(FORMAT(Currency."Amount Rounding Precision")) - STRLEN(FORMAT(Decimals)), '0')
                                    ELSE
                                        CheckAmountText := FORMAT(CheckLedgEntry.Amount, 0, 0);


                                    IF CheckLanguage = 3084 THEN BEGIN   // French
                                        DollarSignBefore := '';
                                        DollarSignAfter := Currency.Symbol;
                                    END ELSE BEGIN
                                        DollarSignBefore := Currency.Symbol;
                                        DollarSignAfter := ' ';
                                    END;
                                    //TODO: Ver IF NOT ChkTransMgt.FormatNoText(DescriptionLine, CheckLedgEntry.Amount, CheckLanguage, BankAcc2."Currency Code") THEN
                                    ERROR(DescriptionLine[1]);
                                    VoidText := '';
                                END ELSE BEGIN
                                    CLEAR(CheckAmountText);
                                    CLEAR(DescriptionLine);
                                    DescriptionLine[1] := Text021;
                                    DescriptionLine[2] := DescriptionLine[1];
                                    VoidText := Text022;
                                END;
                            END;
                        END ELSE BEGIN
                            WITH GenJnlLine DO BEGIN
                                CheckLedgEntry.INIT;
                                CheckLedgEntry."Bank Account No." := BankAcc2."No.";
                                CheckLedgEntry."Posting Date" := "Posting Date";
                                CheckLedgEntry."Document No." := UseCheckNo;
                                CheckLedgEntry.Description := Text023;
                                CheckLedgEntry."Bank Payment Type" := "Bank Payment Type"::"Computer Check";
                                CheckLedgEntry."Entry Status" := CheckLedgEntry."Entry Status"::"Test Print";
                                CheckLedgEntry."Check Date" := "Posting Date";
                                CheckLedgEntry."Check No." := UseCheckNo;
                                //CheckManagement.InsertCheck(CheckLedgEntry);  //MIGDO
                                CheckManagement.InsertCheck(CheckLedgEntry, RECORDID);  //MIGDO

                                CheckAmountText := Text024;
                                DescriptionLine[1] := Text025;
                                DescriptionLine[2] := DescriptionLine[1];
                                VoidText := Text022;
                            END;
                        END;

                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := FALSE;

                        IF ISSERVICETIER THEN BEGIN
                            CLEAR(PrnChkCompanyAddr);
                            CLEAR(PrnChkCheckToAddr);
                            CLEAR(PrnChkCheckNoText);
                            CLEAR(PrnChkCheckDateText);
                            CLEAR(PrnChkDescriptionLine);
                            CLEAR(PrnChkVoidText);
                            CLEAR(PrnChkDateIndicator);
                            CLEAR(PrnChkCurrencyCode);
                            CLEAR(PrnChkCheckAmountText);
                            COPYARRAY(PrnChkCompanyAddr[CheckStyle], CompanyAddr, 1);
                            COPYARRAY(PrnChkCheckToAddr[CheckStyle], CheckToAddr, 1);
                            PrnChkCheckNoText[CheckStyle] := CheckNoText;
                            PrnChkCheckDateText[CheckStyle] := CheckDateText;
                            COPYARRAY(PrnChkDescriptionLine[CheckStyle], DescriptionLine, 1);
                            PrnChkVoidText[CheckStyle] := VoidText;
                            PrnChkDateIndicator[CheckStyle] := DateIndicator;
                            PrnChkCurrencyCode[CheckStyle] := BankAcc2."Currency Code";
                            StartingLen := STRLEN(CheckAmountText);
                            IF CheckStyle = CheckStyle::US THEN
                                ControlLen := 27
                            ELSE
                                ControlLen := 29;
                            CheckAmountText := CheckAmountText + DollarSignBefore + DollarSignAfter;
                            Index := 0;
                            IF CheckAmountText = Text024 THEN BEGIN
                                IF STRLEN(CheckAmountText) < (ControlLen - 12) THEN BEGIN
                                    REPEAT
                                        Index := Index + 1;
                                        CheckAmountText := INSSTR(CheckAmountText, '*', STRLEN(CheckAmountText) + 1);
                                    UNTIL (Index = ControlLen) OR (STRLEN(CheckAmountText) >= (ControlLen - 12))
                                END;
                            END ELSE BEGIN
                                IF STRLEN(CheckAmountText) < (ControlLen - 11) THEN BEGIN
                                    REPEAT
                                        Index := Index + 1;
                                        CheckAmountText := INSSTR(CheckAmountText, '*', STRLEN(CheckAmountText) + 1);
                                    UNTIL (Index = ControlLen) OR (STRLEN(CheckAmountText) >= (ControlLen - 11))
                                END;
                            END;
                            //  ParagraphHandling.PadStrProportional(
                            //    CheckAmountText + DollarSignBefore + DollarSignAfter,ControlLen,10,'*');
                            CheckAmountText :=
                              DELSTR(CheckAmountText, StartingLen + 1, STRLEN(DollarSignBefore + DollarSignAfter));
                            NewLen := STRLEN(CheckAmountText);
                            IF NewLen <> StartingLen THEN
                                CheckAmountText :=
                                  COPYSTR(CheckAmountText, StartingLen + 1) +
                                  COPYSTR(CheckAmountText, 1, StartingLen);
                            PrnChkCheckAmountText[CheckStyle] :=
                              DollarSignBefore + CheckAmountText + DollarSignAfter;

                            CheckStyleIndex := CheckStyle;
                        END;


                        //Footer

                        CLEAR(PrnChkCompanyAddr);
                        CLEAR(PrnChkCheckToAddr);
                        CLEAR(PrnChkCheckNoText);
                        CLEAR(PrnChkCheckDateText);
                        CLEAR(PrnChkDescriptionLine);
                        CLEAR(PrnChkVoidText);
                        CLEAR(PrnChkDateIndicator);
                        CLEAR(PrnChkCurrencyCode);
                        CLEAR(PrnChkCheckAmountText);
                        COPYARRAY(PrnChkCompanyAddr[CheckStyle], CompanyAddr, 1);
                        COPYARRAY(PrnChkCheckToAddr[CheckStyle], CheckToAddr, 1);
                        PrnChkCheckNoText[CheckStyle] := CheckNoText;
                        PrnChkCheckDateText[CheckStyle] := CheckDateText;
                        COPYARRAY(PrnChkDescriptionLine[CheckStyle], DescriptionLine, 1);
                        PrnChkVoidText[CheckStyle] := VoidText;
                        PrnChkDateIndicator[CheckStyle] := DateIndicator;
                        PrnChkCurrencyCode[CheckStyle] := BankAcc2."Currency Code";
                        StartingLen := STRLEN(CheckAmountText);
                        IF CheckStyle = CheckStyle::US THEN
                            ControlLen := 27
                        ELSE
                            ControlLen := 29;
                        //TODO: Ver CheckAmountText := ParagraphHandling.PadStrProportional(CheckAmountText + DollarSignBefore + DollarSignAfter, ControlLen, 10, '*');
                        CheckAmountText :=
                          DELSTR(CheckAmountText, StartingLen + 1, STRLEN(DollarSignBefore + DollarSignAfter));
                        NewLen := STRLEN(CheckAmountText);
                        IF NewLen <> StartingLen THEN
                            CheckAmountText :=
                              COPYSTR(CheckAmountText, StartingLen + 1) +
                              COPYSTR(CheckAmountText, 1, StartingLen);
                        PrnChkCheckAmountText[CheckStyle] :=
                          DollarSignBefore + CheckAmountText + DollarSignAfter;
                        CheckStyleIndex := CheckStyle;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF FoundLast THEN
                        CurrReport.BREAK;

                    UseCheckNo := INCSTR(UseCheckNo);
                    IF NOT TestPrint THEN
                        CheckNoText := UseCheckNo
                    ELSE
                        CheckNoText := Text011;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT TestPrint THEN BEGIN
                        IF UseCheckNo <> GenJnlLine."Document No." THEN BEGIN
                            GenJnlLine3.RESET;
                            GenJnlLine3.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3.SETRANGE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3.SETRANGE("Document No.", UseCheckNo);
                            IF GenJnlLine3.FIND('-') THEN
                                GenJnlLine3.FIELDERROR("Document No.", STRSUBSTNO(Text013, UseCheckNo));
                        END;

                        IF ApplyMethod <> ApplyMethod::MoreLinesOneEntry THEN BEGIN
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.TESTFIELD("Posting No. Series", '');
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3.MODIFY;
                        END ELSE BEGIN
                            "TotalLineAmount$" := 0;
                            IF GenJnlLine2.FIND('-') THEN BEGIN
                                HighestLineNo := GenJnlLine2."Line No.";
                                REPEAT
                                    IF GenJnlLine2."Line No." > HighestLineNo THEN
                                        HighestLineNo := GenJnlLine2."Line No.";
                                    GenJnlLine3 := GenJnlLine2;
                                    GenJnlLine3.TESTFIELD("Posting No. Series", '');
                                    GenJnlLine3."Bal. Account No." := '';
                                    GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::" ";
                                    GenJnlLine3."Document No." := UseCheckNo;
                                    GenJnlLine3."Check Printed" := TRUE;
                                    GenJnlLine3.VALIDATE(Amount);
                                    "TotalLineAmount$" := "TotalLineAmount$" + GenJnlLine3."Amount (LCY)";
                                    GenJnlLine3.MODIFY;
                                UNTIL GenJnlLine2.NEXT = 0;
                            END;

                            GenJnlLine3.RESET;
                            GenJnlLine3 := GenJnlLine;
                            GenJnlLine3.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlLine3.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                            GenJnlLine3."Line No." := HighestLineNo;
                            IF GenJnlLine3.NEXT = 0 THEN
                                GenJnlLine3."Line No." := HighestLineNo + 10000
                            ELSE BEGIN
                                WHILE GenJnlLine3."Line No." = HighestLineNo + 1 DO BEGIN
                                    HighestLineNo := GenJnlLine3."Line No.";
                                    IF GenJnlLine3.NEXT = 0 THEN
                                        GenJnlLine3."Line No." := HighestLineNo + 20000;
                                END;
                                GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
                            END;
                            GenJnlLine3.INIT;
                            GenJnlLine3.VALIDATE("Posting Date", GenJnlLine."Posting Date");
                            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
                            GenJnlLine3."Document No." := UseCheckNo;
                            GenJnlLine3."Account Type" := GenJnlLine3."Account Type"::"Bank Account";
                            GenJnlLine3.VALIDATE("Account No.", BankAcc2."No.");
                            IF BalancingType <> BalancingType::"G/L Account" THEN
                                GenJnlLine3.Description := STRSUBSTNO(Text014, SELECTSTR(BalancingType + 1, Text062), BalancingNo);
                            GenJnlLine3.VALIDATE(Amount, -TotalLineAmount);
                            IF TotalLineAmount <> "TotalLineAmount$" THEN
                                GenJnlLine3.VALIDATE("Amount (LCY)", -"TotalLineAmount$");
                            GenJnlLine3."Bank Payment Type" := GenJnlLine3."Bank Payment Type"::"Computer Check";
                            GenJnlLine3."Check Printed" := TRUE;
                            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
                            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
                            GenJnlLine3."Allow Zero-Amount Posting" := TRUE;
                            GenJnlLine3.INSERT;
                        END;
                    END;

                    BankAcc2."Last Check No." := UseCheckNo;
                    BankAcc2.MODIFY;
                    IF CommitEachCheck THEN BEGIN
                        COMMIT;
                        CLEAR(CheckManagement);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    FirstPage := TRUE;
                    FoundLast := FALSE;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //--AMS Descripcion y beneficiario--//
                Descr := GenJnlLine.Description;


                //AMS-Para la descripcion del documento a liquidar
                i := 0;
                wMontoTotal := 0;
                CLEAR(CodCuentaFactura);
                CLEAR(txtReferencia);
                CLEAR(wMonto);
                CLEAR(txtFecha);

                rVendorLedgerEntry.RESET;
                rVendorLedgerEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                //rVendorLedgerEntry.SETRANGE("Document Type",rVendorLedgerEntry."Document Type"::Invoice);
                rVendorLedgerEntry.SETRANGE("Vendor No.", GenJnlLine."Account No.");
                rVendorLedgerEntry.SETFILTER("Amount to Apply", '<>%1', 0);
                IF rVendorLedgerEntry.FINDSET(FALSE, FALSE) THEN BEGIN
                    IF rVendorLedgerEntry."Applies-to ID" <> '' THEN
                        REPEAT
                            i += 1;
                            txtReferencia[i] := rVendorLedgerEntry."External Document No.";
                            txtFecha[i] := rVendorLedgerEntry."Posting Date";
                            wMonto[i] := rVendorLedgerEntry."Amount to Apply";
                            wMontoTotal += rVendorLedgerEntry."Amount to Apply";

                            //Se busca la primera cuenta de la factura
                            rPurchInvLine.RESET;
                            rPurchInvLine.SETRANGE("Document No.", rVendorLedgerEntry."Document No.");
                            rPurchInvLine.SETRANGE(rPurchInvLine.Type, 1);
                            IF rPurchInvLine.FINDLAST THEN
                                CodCuentaFactura[i] := rPurchInvLine."No.";

                        UNTIL (rVendorLedgerEntry.NEXT = 0) OR (i = 5);
                END;

                IF rCuentaBanco.GET(GenJnlLine."Bal. Account No.") THEN BEGIN
                    CtaBanco := '';
                    GrupoContBanco.GET(rCuentaBanco."Bank Acc. Posting Group");
                    //TODO: Ver CtaBanco := GrupoContBanco."G/L Bank Account No.";
                END;

                TextDiaCheque := FORMAT("Posting Date", 0, ('<day,2>'));
                TextMesCheque := FORMAT("Posting Date", 0, ('<month Text>'));
                TextAnoCheque := FORMAT("Posting Date", 0, ('<year4>'));

                rBanco.GET("Bal. Account No.");
                NombreBanco := UPPERCASE(rBanco.Name);
                DireccionBanco := rBanco.Address + ' ' + rBanco."Address 2";
                CiudadBanco := rBanco.County;
                CuentaBanco := rBanco."Bank Account No.";

                IF NOT GrupoContBanco.GET(rBanco."Bank Acc. Posting Group") THEN
                    ERROR(Error002 + rBanco.FIELDCAPTION(rBanco."Bank Acc. Posting Group"));
                //TODO: Ver CtaCredito := GrupoContBanco."G/L Bank Account No.";
                Monto := Amount;

                CreditAmount := GenJnlLine."Credit Amount";
                DebitAmount := GenJnlLine."Debit Amount";
                Fecha := GenJnlLine."Posting Date";

                CASE "Account Type" OF
                    "Account Type"::Customer:
                        BEGIN
                            Cliente.GET("Account No.");
                            GrupoContableCliente.GET(Cliente."Customer Posting Group");
                            Cuenta := GrupoContableCliente."Receivables Account";
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            Proveedor.GET("Account No.");
                            GrupoContableProveedor.GET(Proveedor."Vendor Posting Group");
                            Cuenta := GrupoContableProveedor."Payables Account";
                            CheckToAddr[1] := GenJnlLine.Beneficiario;
                        END;
                    "Account Type"::"G/L Account":
                        BEGIN
                            Cuenta := "Account No.";
                            //--AMS Beneficiario--//
                            CheckToAddr[1] := GenJnlLine.Beneficiario;
                            //CheckToAddr[1] := GenJnlLine.Description;
                        END;

                    "Account Type"::"Bank Account":


                        BEGIN
                            IF BankAcc.GET("Account No.") THEN
                                GrupoContBanco.GET(BankAcc."Bank Acc. Posting Group");
                            //TODO: Ver Cuenta := GrupoContBanco."G/L Bank Account No.";
                            CheckToAddr[1] := GenJnlLine.Beneficiario;
                        END;

                    "Account Type"::"Fixed Asset":
                        ERROR(Error001);
                END;

                Catalogo.GET(Cuenta);
                DescripcionCuenta := Catalogo.Name;




                IF OneCheckPrVendor AND (GenJnlLine."Currency Code" <> '') AND
                   (GenJnlLine."Currency Code" <> Currency.Code)
                THEN BEGIN
                    Currency.GET(GenJnlLine."Currency Code");
                    Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                    Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                END;

                IF NOT TestPrint THEN BEGIN
                    IF Amount = 0 THEN
                        CurrReport.SKIP;

                    TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                    IF "Bal. Account No." <> BankAcc2."No." THEN
                        CurrReport.SKIP;

                    IF ("Account No." <> '') AND ("Bal. Account No." <> '') THEN BEGIN
                        BalancingType := "Account Type";
                        BalancingNo := "Account No.";
                        RemainingAmount := Amount;
                        IF OneCheckPrVendor THEN BEGIN
                            ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                            GenJnlLine2.RESET;
                            GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                            GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                            GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                            GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                            GenJnlLine2.SETRANGE("Document No.", "Document No.");
                            GenJnlLine2.SETRANGE("Account Type", "Account Type");
                            GenJnlLine2.SETRANGE("Account No.", "Account No.");
                            GenJnlLine2.SETRANGE("Bal. Account Type", "Bal. Account Type");
                            GenJnlLine2.SETRANGE("Bal. Account No.", "Bal. Account No.");
                            GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                            GenJnlLine2.FIND('-');
                            RemainingAmount := 0;
                        END ELSE
                            IF "Applies-to Doc. No." <> '' THEN
                                ApplyMethod := ApplyMethod::OneLineOneEntry
                            ELSE
                                IF "Applies-to ID" <> '' THEN
                                    ApplyMethod := ApplyMethod::OneLineID
                                ELSE
                                    ApplyMethod := ApplyMethod::Payment;
                    END ELSE
                        IF "Account No." = '' THEN
                            FIELDERROR("Account No.", Text004)
                        ELSE
                            FIELDERROR("Bal. Account No.", Text004);

                    CLEAR(CheckToAddr);
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CASE BalancingType OF
                        BalancingType::"G/L Account":
                            BEGIN
                                //AMS CheckToAddr[1] := GenJnlLine.Description;
                                CheckToAddr[1] := GenJnlLine.Beneficiario;
                                //TODO: Ver 
                                /*
                                SetCheckPrintParams(
                                  BankAcc2."Check Date Format",
                                  BankAcc2."Check Date Separator",
                                  BankAcc2."Country/Region Code",
                                  BankAcc2."Bank Communication");*/
                            END;
                        BalancingType::Customer:
                            BEGIN
                                Cust.GET(BalancingNo);
                                IF Cust.Blocked = Cust.Blocked::All THEN
                                    ERROR(Text064, Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, Cust."No.");
                                Cust.Contact := '';
                                FormatAddr.Customer(CheckToAddr, Cust);
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Cust."Salesperson Code" <> '' THEN BEGIN
                                    ContactText := Text006;
                                    SalesPurchPerson.GET(Cust."Salesperson Code");
                                END;
                                //TODO: Ver 
                                /*
                                SetCheckPrintParams(
                                  Cust."Check Date Format",
                                  Cust."Check Date Separator",
                                  BankAcc2."Country/Region Code",
                                  Cust."Bank Communication");*/
                            END;
                        BalancingType::Vendor:
                            BEGIN
                                Vend.GET(BalancingNo);
                                IF Vend.Blocked IN [Vend.Blocked::All, Vend.Blocked::Payment] THEN
                                    ERROR(Text064, Vend.FIELDCAPTION(Blocked), Vend.Blocked, Vend.TABLECAPTION, Vend."No.");
                                Vend.Contact := '';
                                // AMS FormatAddr.Vendor(CheckToAddr,Vend);
                                CheckToAddr[1] := GenJnlLine.Beneficiario;
                                IF BankAcc2."Currency Code" <> "Currency Code" THEN
                                    ERROR(Text005);
                                IF Vend."Purchaser Code" <> '' THEN BEGIN
                                    ContactText := Text007;
                                    SalesPurchPerson.GET(Vend."Purchaser Code");
                                END;
                                //TODO: Ver 
                                /*
                                SetCheckPrintParams(
                                  Vend."Check Date Format",
                                  Vend."Check Date Separator",
                                  BankAcc2."Country/Region Code",
                                  Vend."Bank Communication");*/
                            END;
                        BalancingType::"Bank Account":
                            BEGIN
                                BankAcc.GET(BalancingNo);
                                BankAcc.TESTFIELD(Blocked, FALSE);
                                BankAcc.Contact := '';

                                // FormatAddr.BankAcc(CheckToAddr,BankAcc);
                                CheckToAddr[1] := GenJnlLine.Beneficiario;


                                IF BankAcc2."Currency Code" <> BankAcc."Currency Code" THEN
                                    ERROR(Text008);
                                IF BankAcc."Our Contact Code" <> '' THEN BEGIN
                                    ContactText := Text009;
                                    SalesPurchPerson.GET(BankAcc."Our Contact Code");
                                END;
                                //TODO: Ver 
                                /*
                                SetCheckPrintParams(
                                  BankAcc."Check Date Format",
                                  BankAcc."Check Date Separator",
                                  BankAcc2."Country/Region Code",
                                  BankAcc."Bank Communication");*/
                            END;
                    END;

                    //TODO: Ver CheckDateText := ChkTransMgt.FormatDate("Posting Date", CheckDateFormat, DateSeparator, CheckLanguage, DateIndicator);
                END ELSE BEGIN
                    IF ChecksPrinted > 0 THEN
                        CurrReport.BREAK;
                    //TODO: Ver 
                    /*
                        SetCheckPrintParams(
                        BankAcc2."Check Date Format",
                        BankAcc2."Check Date Separator",
                        BankAcc2."Country/Region Code",
                        BankAcc2."Bank Communication");*/
                    BalancingType := BalancingType::Vendor;
                    BalancingNo := Text010;
                    CLEAR(CheckToAddr);
                    FOR i := 1 TO 5 DO
                        CheckToAddr[i] := Text003;
                    ContactText := '';
                    CLEAR(SalesPurchPerson);
                    CheckNoText := Text011;
                    IF CheckStyle = CheckStyle::CA THEN
                        CheckDateText := DateIndicator
                    ELSE
                        CheckDateText := Text010;
                END;

                //AMS
                txtMonto := '***' + FORMAT(Monto);
            end;

            trigger OnPreDataItem()
            begin
                GenJnlLine.COPY(VoidGenJnlLine);
                CompanyInfo.GET;
                IF NOT TestPrint THEN BEGIN
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    BankAcc2.GET(BankAcc2."No.");
                    BankAcc2.TESTFIELD(Blocked, FALSE);
                    COPY(VoidGenJnlLine);
                    SETRANGE("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    SETRANGE("Check Printed", FALSE);
                END ELSE BEGIN
                    CLEAR(CompanyAddr);
                    FOR i := 1 TO 5 DO
                        CompanyAddr[i] := Text003;
                END;
                ChecksPrinted := 0;

                SETRANGE("Account Type", GenJnlLine."Account Type"::"Fixed Asset");
                IF FIND('-') THEN
                    GenJnlLine.FIELDERROR("Account Type");
                SETRANGE("Account Type");
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
                    field("No."; BankAcc2."No.")
                    {
                        Caption = 'Bank Account';
                        TableRelation = "Bank Account";

                        trigger OnValidate()
                        begin
                            IF BankAcc2."No." <> '' THEN BEGIN
                                BankAcc2.GET(BankAcc2."No.");
                                BankAcc2.TESTFIELD("Last Check No.");
                                UseCheckNo := BankAcc2."Last Check No.";
                            END;
                        end;
                    }
                    field(UseCheckNo; UseCheckNo)
                    {
                        Caption = 'Last Check No.';
                    }
                    field(OneCheckPrVendor; OneCheckPrVendor)
                    {
                        Caption = 'One Check per Vendor per Document No.';
                        MultiLine = true;
                    }
                    field(ReprintChecks; ReprintChecks)
                    {
                        Caption = 'Reprint Checks';
                    }
                    field(TestPrint; TestPrint)
                    {
                        Caption = 'Test Print';
                    }
                    field(PreprintedStub; PreprintedStub)
                    {
                        Caption = 'Preprinted Stub';
                    }
                    field(CommitEachCheck; CommitEachCheck)
                    {
                        Caption = 'Commit Each Check';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF BankAcc2."No." <> '' THEN BEGIN
                IF BankAcc2.GET(BankAcc2."No.") THEN
                    UseCheckNo := BankAcc2."Last Check No."
                ELSE BEGIN
                    BankAcc2."No." := '';
                    UseCheckNo := '';
                END;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GenJnlTemplate.GET(VoidGenJnlLine.GETFILTER("Journal Template Name"));
        IF NOT GenJnlTemplate."Force Doc. Balance" THEN
            IF NOT CONFIRM(USText001, TRUE) THEN
                ERROR(USText002);

        IF ISSERVICETIER THEN BEGIN
            PageNo := 0;
        END;
    end;

    var
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        CompanyInfo: Record 79;
        SalesPurchPerson: Record 13;
        GenJnlLine2: Record 81;
        GenJnlLine3: Record 81;
        Cust: Record 18;
        CustLedgEntry: Record 21;
        Vend: Record 23;
        VendLedgEntry: Record 25;
        BankAcc: Record 270;
        BankAcc2: Record 270;
        CheckLedgEntry: Record 272;
        Currency: Record 4;
        GenJnlTemplate: Record 80;
        WindowsLang: Record 2000000045;
        FormatAddr: Codeunit 365;
        CheckManagement: Codeunit 367;
        //TODO: Ver ParagraphHandling: Codeunit 10025;
        //TODO: Ver ChkTransMgt: Report 10400;
        CompanyAddr: array[8] of Text[100];
        CheckToAddr: array[8] of Text[220];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        ContactText: Text[60];
        CheckNoText: Text[60];
        CheckDateText: Text[60];
        CheckAmountText: Text[60];
        DescriptionLine: array[2] of Text[250];
        DocType: Text[60];
        DocNo: Text[60];
        ExtDocNo: Text[60];
        VoidText: Text[60];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        "TotalLineAmount$": Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        UseCheckNo: Code[20];
        FoundLast: Boolean;
        ReprintChecks: Boolean;
        TestPrint: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        CommitEachCheck: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        PreprintedStub: Boolean;
        _TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[60];
        CurrencyExchangeRate: Record 330;
        LineAmount2: Decimal;
        Text063: Label 'Net Amount %1';
        GLSetup: Record 98;
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        USText001: Label 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.  Do you want to continue anyway?';
        USText002: Label 'Process cancelled at user request.';
        USText003: Label '%1 must not be %2 on %3 %4.';
        USText004: Label 'Last Check No. must include at least one digit, so that it can be incremented.';
        USText005: Label '%1 language is not enabled. %2 is set up for checks in %1.';
        DateIndicator: Text[10];
        CheckDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD";
        CheckStyle: Option ,US,CA;
        CheckLanguage: Integer;
        DateSeparator: Option " ","-",".","/";
        DollarSignBefore: Code[5];
        DollarSignAfter: Code[5];
        PrnChkCompanyAddr: array[2, 8] of Text[100];
        PrnChkCheckToAddr: array[2, 8] of Text[220];
        PrnChkCheckNoText: array[2] of Text[60];
        PrnChkCheckDateText: array[2] of Text[60];
        PrnChkCheckAmountText: array[2] of Text[60];
        PrnChkDescriptionLine: array[2, 2] of Text[250];
        PrnChkVoidText: array[2] of Text[60];
        PrnChkDateIndicator: array[2] of Text[10];
        PrnChkCurrencyCode: array[2] of Code[10];
        USText006: Label 'You cannot use the <blank> %1 option with a Canadian style check. Please check %2 %3.';
        USText007: Label 'You cannot use the Spanish %1 option with a Canadian style check. Please check %2 %3.';
        PostingDesc: Text[220];
        CompanyAddresses: array[6] of Text[60];
        CheckStyleIndex: Integer;
        BankCurrencyCode: Text[60];
        StartingLen: Integer;
        ControlLen: Integer;
        Index: Integer;
        NewLen: Integer;
        PageNo: Integer;
        Descr: Text[250];
        Benef: Text[250];
        TextDiaCheque: Text[60];
        TextMesCheque: Text[60];
        TextAnoCheque: Text[60];
        LongitudString: Integer;
        PosicionInicial: Integer;
        Monto: Decimal;
        CodDiv: Code[20];
        DescriLinea: array[2] of Text[250];
        Fecha: Date;
        rBanco: Record 270;
        Cliente: Record 18;
        GrupoContableCliente: Record 92;
        Proveedor: Record 23;
        GrupoContableProveedor: Record 93;
        Catalogo: Record 15;
        GrupoContBanco: Record 277;
        DescripcionCuenta: Text[250];
        CtaCredito: Text[20];
        CtaDebito: Text[20];
        CreditAmount: Decimal;
        DebitAmount: Decimal;
        Cuenta: Text[60];
        NombreBanco: Text[250];
        ImporteT: Decimal;
        DireccionBanco: Text[250];
        CiudadBanco: Text[50];
        CuentaBanco: Text[60];
        NoCheque: Text[60];
        Error002: Label 'No existe';
        Error001: Label 'Cannot make a check of a fixed asset';
        rVendorLedgerEntry: Record 25;
        txtReferencia: array[5] of Text[60];
        txtFecha: array[5] of Date;
        wMonto: array[5] of Decimal;
        wMontoTotal: Decimal;
        CtaBanco: Text[100];
        rCuentaBanco: Record 270;
        txtMonto: Text[100];
        rPurchInvLine: Record 123;
        CodCuentaFactura: array[5] of Text[100];
        Cheque_No_CaptionLbl: Label 'Cheque No.';
        ReferenciaCaptionLbl: Label 'Referencia';
        FechaCaptionLbl: Label 'Fecha';
        CuentaCaptionLbl: Label 'Cuenta';
        MontoCaptionLbl: Label 'Monto';
        Desc_AdjCaptionLbl: Label 'Desc/Adj';
        Monto_NetoCaptionLbl: Label 'Monto Neto';
        Cta__CaptionLbl: Label 'Cta.:';
        TotalCaptionLbl: Label 'Total';
        EmptyStringCaptionLbl: Label '***';
        NofactVendedor: array[6] of Code[20];
        PIH: Record 122;

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record 21; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF CustLedgEntry2."Document Type" <> CustLedgEntry2."Document Type"::" " THEN
                IF GenJnlLine3.FIND('-') THEN
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text030,
                        CustLedgEntry2."Document Type", CustLedgEntry2."Document No.",
                        CustLedgEntry2."Customer No."));
        END;

        DocType := FORMAT(CustLedgEntry2."Document Type");
        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Document Date";
        PostingDesc := CustLedgEntry2.Description;
        CurrencyCode2 := CustLedgEntry2."Currency Code";
        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount := -(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible" -
          CustLedgEntry2."Accepted Payment Tolerance");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((((CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Invoice) AND
              (LineAmount2 >= RemainingAmount2)) OR
             ((CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::"Credit Memo") AND
              (LineAmount2 <= RemainingAmount2)) AND
            (GenJnlLine."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) OR
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance")
        THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
               ROUND(
                -(ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                  CustLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
            THEN
                LineAmount2 :=
                  ROUND(
                    -(ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Remaining Amount")), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record 25; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
            IF VendLedgEntry2."Document Type" <> VendLedgEntry2."Document Type"::" " THEN
                IF GenJnlLine3.FIND('-') THEN
                    GenJnlLine3.FIELDERROR(
                      "Applies-to Doc. No.",
                      STRSUBSTNO(
                        Text031,
                        VendLedgEntry2."Document Type", VendLedgEntry2."Document No.",
                        VendLedgEntry2."Vendor No."));
        END;

        DocType := FORMAT(VendLedgEntry2."Document Type");
        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocNo := ExtDocNo;
        DocDate := VendLedgEntry2."Document Date";

        PostingDesc := VendLedgEntry2.Description;

        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CALCFIELDS("Remaining Amount");
        LineAmount := -(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" -
          VendLedgEntry2."Accepted Payment Tolerance");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((((VendLedgEntry2."Document Type" = VendLedgEntry2."Document Type"::Invoice) AND
              (LineAmount2 <= RemainingAmount2)) OR
             ((VendLedgEntry2."Document Type" = VendLedgEntry2."Document Type"::"Credit Memo") AND
              (LineAmount2 >= RemainingAmount2))) AND
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) OR
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
                ROUND(
                 -(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   VendLedgEntry2."Amount to Apply")), Currency."Amount Rounding Precision")
             THEN BEGIN
                LineAmount2 :=
                  ROUND(
                    -(ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      VendLedgEntry2."Amount to Apply")), Currency."Amount Rounding Precision");
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    procedure InitializeRequest(BankAcc: Code[20]; LastCheckNo: Code[20]; NewOneCheckPrVend: Boolean; NewReprintChecks: Boolean; NewTestPrint: Boolean; NewPreprintedStub: Boolean)
    begin
        IF BankAcc <> '' THEN
            IF BankAcc2.GET(BankAcc) THEN BEGIN
                UseCheckNo := LastCheckNo;
                OneCheckPrVendor := NewOneCheckPrVend;
                ReprintChecks := NewReprintChecks;
                TestPrint := NewTestPrint;
                PreprintedStub := NewPreprintedStub;
            END;
    end;

    procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
        ELSE IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
            Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
        ELSE
            Amount2 := Amount;
    end;

    local procedure SetCheckPrintParams(NewDateFormat: Option " ","MM DD YYYY","DD MM YYYY","YYYY MM DD"; NewDateSeparator: Option " ","-",".","/"; NewCountryCode: Code[10]; NewCheckLanguage: Option "E English","F French","S Spanish")
    begin
        CheckDateFormat := NewDateFormat;
        DateSeparator := NewDateSeparator;
        CASE NewCheckLanguage OF
            NewCheckLanguage::"E English":
                CheckLanguage := 4105;
            NewCheckLanguage::"F French":
                CheckLanguage := 3084;
            NewCheckLanguage::"S Spanish":
                CheckLanguage := 2058;
            ELSE
                CheckLanguage := 1033;
        END;
        CASE NewCountryCode OF
            //CompanyInfo."US Country/Region Code":  //MIGDO
            'US':  //MIGDO
                BEGIN
                    CheckStyle := CheckStyle::US;
                    IF CheckLanguage = 4105 THEN
                        CheckLanguage := 1033;
                END;
            //CompanyInfo."Canada Country/Region Code":  //MIGDO
            'CA':
                BEGIN
                    CheckStyle := CheckStyle::CA;
                    IF CheckLanguage = 1033 THEN
                        CheckLanguage := 4105;
                END;
            //CompanyInfo."Mexico Country/Region Code":  //MIGDO
            'MX':
                CheckStyle := CheckStyle::US;
            ELSE
                CheckStyle := CheckStyle::US;
        END;
        IF CheckLanguage <> WindowsLang."Language ID" THEN
            WindowsLang.GET(CheckLanguage);
        IF NOT WindowsLang."Globally Enabled" THEN BEGIN
            IF CheckLanguage = 4105 THEN
                CheckLanguage := 1033
            ELSE
                ERROR(USText005, WindowsLang.Name, CheckToAddr[1]);
        END;
    end;
}

