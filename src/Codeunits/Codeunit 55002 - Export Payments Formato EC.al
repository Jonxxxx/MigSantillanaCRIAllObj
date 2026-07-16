codeunit 55002 "Export Payments Formato EC"
{

    trigger OnRun()
    begin
    end;

    var
        Vendor: Record 23;
        BankAccount: Record 270;
        CompanyInformation: Record 79;
        VendorBankAccount: Record 288;
        CheckLedgerEntry: Record 272;
        CheckManagement: Codeunit 367;
        RBMgt: Codeunit 419;
        TotalFileDebit: Decimal;
        TotalFileCredit: Decimal;
        TotalBatchDebit: Decimal;
        TotalBatchCredit: Decimal;
        RecordLength: Integer;
        BlockingFactor: Integer;
        BlockCount: Integer;
        EntryAddendaCount: Integer;
        FileEntryAddendaCount: Integer;
        NoOfRec: Integer;
        PrnString: Text[422];
        ExportFile: File;
        Justification: Option Left,Right;
        BatchNo: Integer;
        BatchCount: Integer;
        EntryHash: Decimal;
        FileHashTotal: Decimal;
        BatchHashTotal: Decimal;
        AdendaSeqNo: Integer;
        FileName: Text[250];
        FileNameFound: Boolean;
        FileIsInProcess: Boolean;
        BatchIsInProcess: Boolean;
        FileIDModifier: Code[1];
        FileDate: Date;
        FileTime: Time;
        ModifierValues: array[26] of Code[1];
        PayeeAcctType: Integer;
        I: Integer;
        TraceNo: Integer;
        BatchDay: Integer;
        Text000: Label 'Cannot start new Export File while %1 is in process.';
        Text001: Label 'is not valid.';
        Text002: Label '%1 in %2 %3 is invalid.';
        Text003: Label 'File %1 already exists. Check the %2 in %3 %4.';
        Text004: Label 'Cannot start export batch until an export file is started.';
        Text005: Label 'Cannot start new export batch until previous batch is completed.';
        Text006: Label 'Cannot export details until an export file is started.';
        Text007: Label 'Cannot export details until an export batch is started.';
        Text008: Label 'Vendor No. %1 has no bank account setup for electronic payments.';
        Text009: Label 'Vendor No. %1 has more than one bank account setup for electronic payments.';
        Text010: Label 'Customer No. %1 has no bank account setup for electronic payments.';
        Text011: Label 'Customer No. %1 has more than one bank account setup for electronic payments.';
        Text012: Label 'Cannot end export batch until an export file is started.';
        Text013: Label 'Cannot end export batch until an export batch is started.';
        Text014: Label 'Cannot end export file until an export file is started.';
        Text015: Label 'Cannot end export file until export batch is ended.';
        Text016: Label 'File %1 does not exist.';
        Text017: Label 'Did the transmission work properly?';
        Text018: Label 'Either %1 or %2 must refer to either a %3 or a %4 for an electronic payment.';
        Text1020100: Label '%1 is blocked for %2 processing';
        Text019: Label 'You must now run the program that transmits the payments file to the bank. Transmit the file named %1 located at %2 to %3 (%4 %5 %6).  After the transmission is completed, you will be asked if it worked correctly.  Are you ready to transmit (answer No to cancel the transmission process)?';
        Text1480004: Label 'Bank Account number must be either the 18 character CLABE format for checking, or 16 characters for Debit Card.';
        SequenceNo: Integer;
        OpCode: Integer;
        ClientFile: Text[250];

    procedure StartExportFile(BankAccountNo: Code[20]; ReferenceCode: Code[10])
    var
        FileHeaderRec: Text[422];
        i: Integer;
    begin
        BuildIDModifier;
        IF FileIsInProcess THEN
            ERROR(Text000, FileName);

        CompanyInformation.GET;
        //TODO: Ver 
        /*
        CompanyInformation.TESTFIELD("Federal ID No.");

        WITH BankAccount DO BEGIN
            LOCKTABLE;
            GET(BankAccountNo);
            TESTFIELD("Export Format", "Export Format"::MX);
            TESTFIELD("Transit No.");
            TESTFIELD("E-Pay Export File Path");
            IF "E-Pay Export File Path"[STRLEN("E-Pay Export File Path")] <> '\' THEN
                ERROR(Text002,
                      FIELDCAPTION("E-Pay Export File Path"),
                      TABLECAPTION,
                      "No.");
            //TESTFIELD("Last E-Pay Export File Name");
            TESTFIELD("Bank Acc. Posting Group");
            TESTFIELD(Blocked, FALSE);

            FileName := ExportFileName();
            "Last E-Pay Export File Name" := FileName;
            IF ISSERVICETIER THEN
                FileName := RBMgt.ServerTempFileName('')
            ELSE
                FileName := "E-Pay Export File Path" + FileName;
            MODIFY;

            IF EXISTS(FileName) THEN
                ERROR(Text003,
                      FileName,
                      FIELDCAPTION("Last E-Pay Export File Name"),
                      TABLECAPTION,
                      "No.");
            ExportFile.TEXTMODE(TRUE);
            ExportFile.WRITEMODE(TRUE);
            IF NOT ISSERVICETIER THEN
                ExportFile.QUERYREPLACE(TRUE);
            ExportFile.CREATE(FileName);
            IF NOT ISSERVICETIER THEN
                ExportFile.OPEN(FileName);
                

        FileIsInProcess := TRUE;
        FileDate := TODAY;
        FileTime := TIME;
        NoOfRec := 0;
        FileHashTotal := 0;
        TotalFileDebit := 0;
        TotalFileCredit := 0;
        FileEntryAddendaCount := 0;
        BatchCount := 0;
        BlockingFactor := 10;
        RecordLength := 422;
        BatchNo := 0;

    END;*/
    end;

    procedure StartExportBatch(OperationCode: Integer; SourceCode: Code[10]; SettleDate: Date)
    var
        BatchHeaderRec: Text[422];
    begin
        IF NOT FileIsInProcess THEN
            ERROR(Text004);
        IF BatchIsInProcess THEN
            ERROR(Text005);

        BatchIsInProcess := TRUE;
        BatchNo := BatchNo + 1;
        BatchHashTotal := 0;
        TotalBatchDebit := 0;
        TotalBatchCredit := 0;
        EntryAddendaCount := 0;
        TraceNo := 0;
        SequenceNo := 1;
        BatchHeaderRec := '';
        OpCode := OperationCode;
        EVALUATE(BatchDay, FORMAT(TODAY, 2, '<Day>'));
        // Cecoban layout
        AddToPrnString(BatchHeaderRec, '1', 1, 2, Justification::Right, '0');                  // Record Type of Input "01" is Batch Header
        AddNumToPrnString(BatchHeaderRec, SequenceNo, 3, 7);                                          // Sequence Number
        AddNumToPrnString(BatchHeaderRec, OpCode, 10, 2);                                    // Operation Code
        AddToPrnString(BatchHeaderRec, BankAccount."Bank Account No.", 12, 3, Justification::Left, ' ');    // Bank 3 digit #
        AddToPrnString(BatchHeaderRec, 'E', 15, 1, Justification::Right, '');                    //  Export Type
        AddNumToPrnString(BatchHeaderRec, 2, 16, 1);                                          //  Service
        AddNumToPrnString(BatchHeaderRec, BatchDay, 17, 2);                                  //  Batch Number day of month part
        AddNumToPrnString(BatchHeaderRec, BatchNo, 19, 5);                                   //  Batch Number sequence part
        AddToPrnString(BatchHeaderRec, FORMAT(SettleDate, 0, '<Year,2><Month,2><Day,2>'), 24, 8, Justification::Right, '0');
        //  Date of Presentation  AAAAMMDD
        AddToPrnString(BatchHeaderRec, '01', 32, 2, Justification::Left, ' ');                    // Currency Code, 01 - MX peso 05 - USD
        AddNumToPrnString(BatchHeaderRec, 0, 34, 2);                                           // Rejection code
        AddNumToPrnString(BatchHeaderRec, 2, 36, 1);                                          // System
        AddToPrnString(BatchHeaderRec, '', 37, 41, Justification::Left, ' ');                     // future Cecoban use
        AddToPrnString(BatchHeaderRec, '', 78, 345, Justification::Left, ' ');                     // future Bank use
        ExportPrnString(BatchHeaderRec);
    end;

    procedure ExportElectronicPayment(GenJnlLine: Record 81; PaymentAmount: Decimal; SettleDate: Date): Code[30]
    var
        Vendor: Record 23;
        VendorBankAcct: Record 288;
        Customer: Record 18;
        CustBankAcct: Record 287;
        AcctType: Text[1];
        AcctNo: Code[20];
        AcctName: Text[30];
        BankAcctNo: Text[30];
        TransitNo: Text[20];
        RFCNo: Text[20];
        DetailRec: Text[422];
        DemandCredit: Boolean;
    begin
        /*GRN 11/03/2013
        IF NOT FileIsInProcess THEN
          ERROR(Text006);
        IF NOT BatchIsInProcess THEN
          ERROR(Text007);
        
        // NOTE:  If PaymentAmount is Positive, then we are Receiving money.
        //        If PaymentAmount is Negative, then we are Sending money.
        IF PaymentAmount = 0 THEN
          EXIT('');
        DemandCredit := (PaymentAmount < 0);
        PaymentAmount := ABS(PaymentAmount);
        
        WITH GenJnlLine DO BEGIN
          IF "Account Type" = "Account Type"::Vendor THEN BEGIN
            AcctType := 'V';
            AcctNo := "Account No.";
          END ELSE IF "Account Type" = "Account Type"::Customer THEN BEGIN
            AcctType := 'C';
            AcctNo := "Account No.";
          END ELSE IF "Bal. Account Type" = "Bal. Account Type"::Vendor THEN BEGIN
            AcctType := 'V';
            AcctNo := "Bal. Account No.";
          END ELSE IF "Bal. Account Type" = "Bal. Account Type"::Customer THEN BEGIN
            AcctType := 'C';
            AcctNo := "Bal. Account No.";
          END ELSE
            ERROR(Text018,
                  FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"),Vendor.TABLECAPTION,Customer.TABLECAPTION);
        
          IF AcctType = 'V' THEN BEGIN
            Vendor.GET(AcctNo);
            Vendor.TESTFIELD(Blocked,Vendor.Blocked::" ");
            AcctName := Vendor.Name;
            RFCNo := Vendor."VAT Registration No.";
        
            VendorBankAcct.SETRANGE("Vendor No.", AcctNo);
            VendorBankAcct.SETRANGE( "Use for Electronic Payments", TRUE);
            VendorBankAcct.FIND('-');
        
            IF VendorBankAcct.COUNT < 1 THEN
              ERROR(Text008, AcctNo);
            IF VendorBankAcct.COUNT > 1 THEN
              ERROR(Text009, AcctNo);
            IF NOT PayeeCheckDigit(VendorBankAcct."Transit No.") THEN
              VendorBankAcct.FIELDERROR("Transit No.",Text001 + ' ' + Text1480004);
        
            VendorBankAcct.TESTFIELD("Bank Account No.");
            TransitNo := VendorBankAcct."Transit No.";
            BankAcctNo := VendorBankAcct."Bank Account No.";
          END ELSE IF AcctType = 'C' THEN BEGIN
            Customer.GET(AcctNo);
              IF Customer.Blocked = Customer.Blocked::All THEN
              ERROR(
                STRSUBSTNO(
                  Text1020100,
                  "Account Type",Customer.Blocked));
            AcctName := Customer.Name;
            RFCNo := Customer."VAT Registration No.";
        
            CustBankAcct.SETRANGE("Customer No.", AcctNo);
            CustBankAcct.SETRANGE( "Use for Electronic Payments", TRUE);
            CustBankAcct.FIND('-');
        
            IF CustBankAcct.COUNT < 1 THEN
              ERROR(Text010, AcctNo);
              ERROR(Text011, AcctNo);
            IF NOT PayeeCheckDigit(CustBankAcct."Transit No.") THEN
              CustBankAcct.FIELDERROR("Transit No.",Text001 + ' ' + Text1480004);
            CustBankAcct.TESTFIELD("Bank Account No.");
            TransitNo := CustBankAcct."Transit No.";
            BankAcctNo := CustBankAcct."Bank Account No.";
          END;
        
          TraceNo := TraceNo + 1;
          SequenceNo := SequenceNo + 1;
          DetailRec := '';
          //  Cecoban Detail rec
          AddToPrnString(DetailRec,'2',1,2,Justification::Right,'0');                      // Record Type of Input "02" is Detail
          AddNumToPrnString(DetailRec,SequenceNo,3,7);                                     // Sequence Number
          AddNumToPrnString(DetailRec,OpCode,10,2);                                            // Operation Code
          AddToPrnString(DetailRec,'01',12,2,Justification::Left,' ');                    // Currency Code, 01 - MX peso 05 - USD
          AddToPrnString(DetailRec,FORMAT(FileDate,0,'<Year,4><Month,2><Day,2>'),14,8,Justification::Right,'0');
          //  Transfer Date AAAAMMDD
        
          AddToPrnString(DetailRec,BankAccount."Bank Account No.",22,3,Justification::Left,' ');                    // ODFI
          AddToPrnString(DetailRec,BankAcctNo,25,3,Justification::Left,' ');                // RDFI
          AddAmtToPrnString(DetailRec,PaymentAmount,28,15);                                           // Operation Fee
          AddToPrnString(DetailRec,' ',43,16,Justification::Left,' ');                    // Future use
          AddNumToPrnString(DetailRec,OpCode,59,2);                                        // Operation Type
          AddToPrnString(DetailRec,FORMAT(SettleDate,0,'<Year,2><Month,2><Day,2>'),61,8,Justification::Right,'0');
        //  Date Entered AAAAMMDD
          AddNumToPrnString(DetailRec,1,69,2);                    // '?????' Originator Account Type
          AddToPrnString(DetailRec,BankAccount."Transit No.",71,20,Justification::Left,'');          // Originator Account No.
          AddToPrnString(DetailRec,AcctName,91,40,Justification::Left,'');                    // Originator Account Name
          AddToPrnString(DetailRec,'',131,18,Justification::Left,'');                   // Originator RFC/CURP
          AddNumToPrnString(DetailRec,PayeeAcctType,149,2);                    // Payee Account Type
          AddToPrnString(DetailRec,TransitNo,151,20,Justification::Left,'');              // Payee Account No.
          AddToPrnString(DetailRec,AcctName,171,40,Justification::Left,'');                    // Payee Account Name
          AddToPrnString(DetailRec,RFCNo,211,18,Justification::Left,'');                   // Payee RFC/CURP
          AddToPrnString(DetailRec,'',229,40,Justification::Left,'');                   // Transmitter Service Reference
          AddToPrnString(DetailRec,'',269,40,Justification::Left,'');                   // Service Owner
          AddAmtToPrnString(DetailRec,0,309,15);                                            // Operation Tax Cost
          AddNumToPrnString(DetailRec,0,324,7);                                       // Originator Numeric reference
          AddToPrnString(DetailRec,'',331,40,Justification::Left,'');                   // Originator alpha reference
          AddToPrnString(DetailRec,GenerateTraceNoCode(TraceNo),371,30,Justification::Left,'');                   // Tracking code
          AddNumToPrnString(DetailRec,0,401,2);                                            // Return Reason
          AddToPrnString(DetailRec,FORMAT(TODAY,0,'<Year><Month,2><Day,2>'),403,8,Justification::Left,' ');   // Initial Presentation Date
          AddToPrnString(DetailRec,'',411,12,Justification::Left,' ');                   // future use
          //AddAmtToPrnString(DetailRec,0,423,7);                                         // for untimely returns
          //AddNumToPrnString(DetailRec,0,430,3);                                         // delayed days for untimely returns
          //AddAmtToPrnString(DetailRec,0,433,15);                                         // for untimely returns
        
          ExportPrnString(DetailRec);
          EntryAddendaCount := EntryAddendaCount + 1;
          IF DemandCredit THEN
            TotalBatchCredit := TotalBatchCredit + PaymentAmount
          ELSE
            TotalBatchDebit := TotalBatchDebit + PaymentAmount;
          IncrementHashTotal(BatchHashTotal,MakeHash(COPYSTR(TransitNo,1,8)));
        END;
        */
        EXIT(GenerateFullTraceNoCode(TraceNo));

    end;

    procedure EndExportBatch()
    var
        BatchControlRec: Text[422];
    begin
        IF NOT FileIsInProcess THEN
            ERROR(Text012);
        IF NOT BatchIsInProcess THEN
            ERROR(Text013);

        BatchIsInProcess := FALSE;
        BatchControlRec := '';
        SequenceNo := SequenceNo + 1;
        //cecoban batch summary
        AddNumToPrnString(BatchControlRec, 9, 1, 2);                  // Record Type
        AddNumToPrnString(BatchControlRec, SequenceNo, 3, 7);                  // sequence number
        AddNumToPrnString(BatchControlRec, OpCode, 10, 2);                  // op code
        AddNumToPrnString(BatchControlRec, BatchDay, 12, 2);                  //  Batch Number day of month part
        AddNumToPrnString(BatchControlRec, BatchNo, 14, 5);                  // batch number sequence part
        AddNumToPrnString(BatchControlRec, (SequenceNo - 2), 19, 7);          // operation number
        AddAmtToPrnString(BatchControlRec, BatchHashTotal, 26, 18);                  // TCO
        AddToPrnString(BatchControlRec, ' ', 44, 40, Justification::Left, ' ');            // future use
        AddToPrnString(BatchControlRec, ' ', 84, 339, Justification::Left, ' ');            // future use
        ExportPrnString(BatchControlRec);

        BatchCount := BatchCount + 1;
        IncrementHashTotal(FileHashTotal, BatchHashTotal);
        TotalFileDebit := TotalFileDebit + TotalBatchDebit;
        TotalFileCredit := TotalFileCredit + TotalBatchCredit;
        FileEntryAddendaCount := FileEntryAddendaCount + EntryAddendaCount;
    end;

    procedure EndExportFile(): Boolean
    var
        FileControlRec: Text[422];
    begin
        IF NOT FileIsInProcess THEN
            ERROR(Text014);
        IF BatchIsInProcess THEN
            ERROR(Text015);

        FileIsInProcess := FALSE;
        //TODO: Ver 
        /*
        ExportFile.CLOSE;
        IF ISSERVICETIER THEN BEGIN
            ClientFile := BankAccount."E-Pay Export File Path" + BankAccount."Last E-Pay Export File Name";
            IF NOT DOWNLOAD(FileName, '', '', '', ClientFile) THEN BEGIN
                ERASE(FileName);
                EXIT(FALSE);
            END;
            ERASE(FileName);
        END;
        */
        EXIT(TRUE);
    end;

    local procedure GenerateFullTraceNoCode(TraceNo: Integer): Code[30]
    var
        TraceCode: Text[250];
    begin
        TraceCode := '';
        AddToPrnString(TraceCode, FORMAT(FileDate, 0, '<Year,2><Month,2><Day,2>'), 1, 6, Justification::Left, ' ');
        //TODO: Ver AddToPrnString(TraceCode, BankAccount."Last ACH File ID Modifier", 7, 1, Justification::Right, '0');
        AddNumToPrnString(TraceCode, BatchNo, 8, 7);
        AddToPrnString(TraceCode, GenerateTraceNoCode(TraceNo), 15, 15, Justification::Left, ' ');
        EXIT(TraceCode);
    end;

    local procedure GenerateTraceNoCode(TraceNo: Integer): Code[15]
    var
        TraceCode: Text[250];
    begin
        TraceCode := '';
        AddToPrnString(TraceCode, BankAccount."Transit No.", 1, 8, Justification::Left, ' ');
        AddNumToPrnString(TraceCode, TraceNo, 9, 7);
        EXIT(TraceCode);
    end;

    local procedure AddNumToPrnString(var PrnString: Text[422]; Number: Integer; StartPos: Integer; Length: Integer)
    var
        TmpString: Text[422];
        I: Integer;
    begin
        TmpString := DELCHR(FORMAT(Number), '=', '.,-');
        AddToPrnString(PrnString, TmpString, StartPos, Length, Justification::Right, '0');
    end;

    local procedure AddAmtToPrnString(var PrnString: Text[422]; Amount: Decimal; StartPos: Integer; Length: Integer)
    var
        TmpString: Text[422];
        I: Integer;
    begin
        TmpString := FORMAT(Amount);
        I := STRPOS(TmpString, '.');
        CASE TRUE OF
            I = 0:
                TmpString := TmpString + '.00';
            I = STRLEN(TmpString) - 1:
                TmpString := TmpString + '0';
        END;
        TmpString := DELCHR(TmpString, '=', '.,-');
        AddToPrnString(PrnString, TmpString, StartPos, Length, Justification::Right, '0');
    end;

    local procedure AddToPrnString(var PrnString: Text[422]; SubString: Text[345]; StartPos: Integer; Length: Integer; Justification: Option Left,Right; Filler: Text[1])
    var
        TmpString: Text[422];
        I: Integer;
        SubStrLen: Integer;
    begin
        SubString := UPPERCASE(DELCHR(SubString, '<>', ' '));
        SubStrLen := STRLEN(SubString);

        IF SubStrLen > Length THEN BEGIN
            SubString := COPYSTR(SubString, 1, Length);
            SubStrLen := Length;
        END;

        IF Justification = Justification::Right THEN
            FOR I := 1 TO (Length - SubStrLen) DO
                SubString := Filler + SubString
        ELSE
            FOR I := SubStrLen + 1 TO Length DO
                SubString := SubString + Filler;

        IF STRLEN(PrnString) >= StartPos THEN
            IF StartPos > 1 THEN
                PrnString := COPYSTR(PrnString, 1, StartPos - 1) + SubString + COPYSTR(PrnString, StartPos)
            ELSE
                PrnString := SubString + PrnString
        ELSE BEGIN
            FOR I := STRLEN(PrnString) + 1 TO StartPos - 1 DO
                PrnString := PrnString + ' ';
            PrnString := PrnString + SubString;
        END;
    end;

    local procedure ExportPrnString(var PrnString: Text[422])
    begin
        PrnString := PADSTR(PrnString, RecordLength, ' ');
        //TODO: Ver ExportFile.WRITE(PrnString);
        NoOfRec := NoOfRec + 1;
        PrnString := '';
    end;

    procedure PayeeCheckDigit(DigitString: Code[20]): Boolean
    var
        Weight: Code[8];
        Digit: Integer;
        I: Integer;
        Digit1: Integer;
        Digit2: Integer;
        CheckChar: Code[1];
    begin
        //Weight := '37137137';
        //Digit := 0;
        IF STRLEN(DigitString) = 18 THEN BEGIN
            PayeeAcctType := 1;
            EXIT(TRUE);                                   //checking Account
        END ELSE IF STRLEN(DigitString) = 16 THEN BEGIN
            PayeeAcctType := 3;                                   //debit card
            EXIT(TRUE);                                   //checking Account
        END ELSE
            EXIT(FALSE);
        /*
        IF STRLEN(DigitString) <= STRLEN(Weight) THEN
          EXIT(FALSE);
        
        FOR I := 1 TO STRLEN(Weight) DO BEGIN
          EVALUATE(Digit1,COPYSTR(DigitString,I,1));
          EVALUATE(Digit2,COPYSTR(Weight,I,1));
          Digit := Digit + Digit1 * Digit2;
        END;
        
        Digit := 10 - Digit MOD 10;
        IF Digit = 10 THEN
          CheckChar := '0'
        ELSE
          CheckChar := FORMAT(Digit);
        EXIT(DigitString[STRLEN(Weight)+1] = CheckChar[1]);
        */

    end;

    local procedure IncrementHashTotal(var HashTotal: Decimal; HashIncrement: Decimal)
    var
        SubTotal: Decimal;
    begin
        SubTotal := HashTotal + HashIncrement;
        IF SubTotal < 10000000000.0 THEN
            HashTotal := SubTotal
        ELSE
            HashTotal := SubTotal - 10000000000.0;
    end;

    local procedure MakeHash(InputString: Text[30]): Decimal
    var
        HashAmt: Decimal;
    begin
        InputString := DELCHR(InputString, '=', '.,- ');
        IF EVALUATE(HashAmt, InputString) THEN
            EXIT(HashAmt)
        ELSE
            EXIT(0);
    end;

    local procedure BuildIDModifier()
    begin
        ModifierValues[1] := 'A';
        ModifierValues[2] := 'B';
        ModifierValues[3] := 'C';
        ModifierValues[4] := 'D';
        ModifierValues[5] := 'E';
        ModifierValues[6] := 'F';
        ModifierValues[7] := 'G';
        ModifierValues[8] := 'H';
        ModifierValues[9] := 'I';
        ModifierValues[10] := 'J';
        ModifierValues[11] := 'K';
        ModifierValues[12] := 'L';
        ModifierValues[13] := 'M';
        ModifierValues[14] := 'N';
        ModifierValues[15] := 'O';
        ModifierValues[16] := 'P';
        ModifierValues[17] := 'Q';
        ModifierValues[18] := 'R';
        ModifierValues[19] := 'S';
        ModifierValues[20] := 'T';
        ModifierValues[21] := 'U';
        ModifierValues[22] := 'V';
        ModifierValues[23] := 'W';
        ModifierValues[24] := 'X';
        ModifierValues[25] := 'Y';
        ModifierValues[26] := 'Z';
    end;

    procedure TransmitExportedFile(BankAccountNo: Code[20]; FName: Text[30])
    var
        ExportFullPathName: Text[250];
        TransmitFullPathName: Text[250];
    begin
        BankAccount.GET(BankAccountNo);
        //TODO: Ver 
        /*
        WITH BankAccount DO BEGIN
            TESTFIELD("E-Pay Export File Path");
            IF "E-Pay Export File Path"[STRLEN("E-Pay Export File Path")] <> '\' THEN
                ERROR(Text002,
                      FIELDCAPTION("E-Pay Export File Path"),
                      TABLECAPTION,
                      "No.");
            TESTFIELD("E-Pay Trans. Program Path");
            IF "E-Pay Trans. Program Path"[STRLEN("E-Pay Trans. Program Path")] <> '\' THEN
                ERROR(Text002,
                      FIELDCAPTION("E-Pay Trans. Program Path"),
                      TABLECAPTION,
                      "No.");
            ExportFullPathName := "E-Pay Export File Path" + FName;
            TransmitFullPathName := "E-Pay Trans. Program Path" + FName;
        END;
        IF NOT EXISTS(ExportFullPathName) THEN
            ERROR(Text016, FName);
        COPY(ExportFullPathName, TransmitFullPathName);
        WITH BankAccount DO BEGIN
            IF CONFIRM(Text019, TRUE, FName, "E-Pay Trans. Program Path", Name, TABLECAPTION, FIELDCAPTION("No."), "No.")
            THEN BEGIN
                IF CONFIRM(Text017) THEN
                    ERASE(ExportFullPathName);
            END;
        END;*/
    end;

    procedure ExportFileName(): Text[250]
    begin
        //TODO: Ver 
        /*
        IF BankAccount."Last E-Pay Export File Name" = '' THEN BEGIN
            FileName := '';
            AddToPrnString(FileName, 'S01', 1, 3, Justification::Right, '');                      // Record Type of Input "02" is Detail
            AddToPrnString(FileName, BankAccount."Bank Account No.", 4, 3, Justification::Left, ' ');    // Bank 3 digit #
            AddToPrnString(FileName, 'A2.A10 ', 7, 6, Justification::Right, '');
            AddToPrnString(FileName, FORMAT(TODAY, 2, '0' + '<weekDay>'), 13, 2, Justification::Right, ''); //weekday
            AddNumToPrnString(FileName, BatchNo + 1, 15, 2);                                     // Sequence Number
        END ELSE BEGIN
            FileName := BankAccount."Last E-Pay Export File Name";
            AddToPrnString(FileName, FORMAT(TODAY, 2, '0' + '<weekDay>'), 13, 2, Justification::Right, ''); //weekday
            AddNumToPrnString(FileName, BatchNo + 1, 15, 2);                                     // Sequence Number
        END;
        */
        EXIT(FileName);
    end;
}

