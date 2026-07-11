tableextension 70000108 tableextension70000108 extends "Gen. Journal Line"
{
    fields
    {
        modify("Account Type")
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee';

            //Unsupported feature: Property Modification (OptionString) on ""Account Type"(Field 3)".

        }
        modify("Account No.")
        {
            TableRelation = IF (Account Type=CONST(G/L Account)) "G/L Account" WHERE (Account Type=CONST(Posting),
                                                                                      Blocked=CONST(false))
                                                                                      ELSE IF (Account Type=CONST(Customer)) Customer
                                                                                      ELSE IF (Account Type=CONST(Vendor)) Vendor
                                                                                      ELSE IF (Account Type=CONST(Bank Account)) "Bank Account"
                                                                                      ELSE IF (Account Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                      ELSE IF (Account Type=CONST(IC Partner)) "IC Partner"
                                                                                      ELSE IF (Account Type=CONST(Employee)) Employee;
        }
        modify("Bal. Account No.")
        {
            TableRelation = IF (Bal.Account Type=CONST(G/L Account)) "G/L Account" WHERE (Account Type=CONST(Posting),
                                                                                           Blocked=CONST(false))
                                                                                           ELSE IF (Bal. Account Type=CONST(Customer)) Customer
                                                                                           ELSE IF (Bal. Account Type=CONST(Vendor)) Vendor
                                                                                           ELSE IF (Bal. Account Type=CONST(Bank Account)) "Bank Account"
                                                                                           ELSE IF (Bal. Account Type=CONST(Fixed Asset)) "Fixed Asset"
                                                                                           ELSE IF (Bal. Account Type=CONST(IC Partner)) "IC Partner"
                                                                                           ELSE IF (Bal. Account Type=CONST(Employee)) Employee;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Caption = 'Shortcut Dimension 1 Code';
        }
        modify("Shortcut Dimension 2 Code")
        {
            Caption = 'Shortcut Dimension 2 Code';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Bal. Gen. Posting Type")
        {
            Caption = 'Bal. Gen. Posting Type';
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Caption = 'Bal. Gen. Bus. Posting Group';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
        }
        modify("Bal. VAT Calculation Type")
        {
            Caption = 'Bal. VAT Calculation Type';
        }
        modify("Bal. VAT Base Amount")
        {
            Caption = 'Bal. Tax Base Amount';
        }
        modify("Bal. Tax Area Code")
        {
            Caption = 'Bal. Tax Area Code';
        }
        modify("Bal. Tax Group Code")
        {
            Caption = 'Bal. Tax Group Code';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Caption = 'Bal. VAT Bus. Posting Group';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Caption = 'Bal. VAT Prod. Posting Group';
        }
        modify("Source Curr. VAT Base Amount")
        {
            Caption = 'Source Curr. Tax Base Amount';
        }
        modify("Source Curr. VAT Amount")
        {
            Caption = 'Source Curr. Tax Amount';
        }
        modify("VAT Base Amount (LCY)")
        {
            Caption = 'Tax Base Amount ($)';
        }
        modify("Bal. VAT Amount (LCY)")
        {
            Caption = 'Bal. Tax Amount ($)';
        }
        modify("Bal. VAT Base Amount (LCY)")
        {
            Caption = 'Bal. Tax Base Amount ($)';
        }
        modify("IC Partner G/L Acc. No.")
        {
            Caption = 'IC Partner G/L Acc. No.';
        }
        modify("IC Partner Transaction No.")
        {
            Caption = 'IC Partner Transaction No.';
        }

        //Unsupported feature: Property Modification (Data type) on ""VAT Registration No."(Field 119)".

        modify("Copy VAT Setup to Jnl. Lines")
        {
            Caption = 'Copy Tax Setup to Jnl. Lines';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price ($)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price ($)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount ($)';
        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount ($)';
        }
        modify("Job Planning Line No.")
        {
            Caption = 'Job Planning Line No.';
        }
        modify("Direct Debit Mandate ID")
        {
            Caption = 'Direct Debit Mandate ID';
        }
        modify("No. of Depreciation Days")
        {
            Caption = 'No. of Depreciation Days';
        }
        modify("Depr. until FA Posting Date")
        {
            Caption = 'Depr. until FA Posting Date';
        }
        modify("Duplicate in Depreciation Book")
        {
            Caption = 'Duplicate in Depreciation Book';
        }
        modify("FA Error Entry No.")
        {
            Caption = 'FA Error Entry No.';
        }
        modify("Tax Jurisdiction Code")
        {
            Caption = 'Tax Jurisdiction Code';
        }
        modify("Gateway Operator OFAC Scr.Inc")
        {
            Caption = 'Gateway Operator OFAC Scr.Inc';
        }
        modify("Origin. DFI ID Qualifier")
        {
            Caption = 'Origin. DFI ID Qualifier';
        }
        modify("Receiv. DFI ID Qualifier")
        {
            Caption = 'Receiv. DFI ID Qualifier';
        }

        //Unsupported feature: Code Modification on ""Account Type"(Field 3).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        //+#144
        IF (("Account Type" = "Account Type"::"Provisión Insolvencias") OR
           ("Account Type" = "Account Type"::"Cancelar Prov. Insol.")) AND
           ("Bal. Account Type" = "Bal. Account Type"::Customer) THEN
          ERROR(Error006,FORMAT("Account Type"));
        //-#144

        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner","Account Type"::Employee]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
        #11..53
          END;

        VALIDATE("Deferral Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #8..56
        */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account No." <> xRec."Account No." THEN BEGIN
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
        END;

        IF xRec."Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] THEN
          "IC Partner Code" := '';

        IF "Account No." = '' THEN BEGIN
          CleanLine;
          EXIT;
        END;

        //+#144
        //IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner"] THEN
        IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"IC Partner",
                              "Account Type"::"Provisión Insolvencias","Account Type"::"Cancelar Prov. Insol."] THEN
        //-#144
          "IC Partner Code" := '';

        OnValidateAccountNoOnBeforeAssignValue(Rec,xRec);
        CASE "Account Type" OF
          "Account Type"::"G/L Account":
            GetGLAccount;
          //+#144
          //"Account Type"::Customer:
          "Account Type"::Customer,"Account Type"::"Provisión Insolvencias","Account Type"::"Cancelar Prov. Insol.":
          //-#144
            GetCustomerAccount;
          "Account Type"::Vendor:
            GetVendorAccount;
          "Account Type"::Employee:
            GetEmployeeAccount;
          "Account Type"::"Bank Account":
            GetBankAccount;
          "Account Type"::"Fixed Asset":
            GetFAAccount;
          "Account Type"::"IC Partner":
            GetICPartnerAccount;
        END;

        OnValidateAccountNoOnAfterAssignValue(Rec,xRec);

        VALIDATE("Currency Code");
        VALIDATE("VAT Prod. Posting Group");
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type"),"Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type"),"Bal. Account No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Salesperson/Purchaser","Salespers./Purch. Code",
          DATABASE::Campaign,"Campaign No.");

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);

        CASE "Account Type" OF
          "Account Type"::"G/L Account":
            UpdateAccountID;
          "Account Type"::Customer:
            UpdateCustomerID;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        OnValidateAccountNoOnBeforeAssignValue(Rec,xRec);
        #57..59
            GetGLAccount;
          "Account Type"::Customer:
        #29..63
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Account No."(Field 4)".



        //Unsupported feature: Code Modification on ""VAT %"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetCurrency;
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
        #4..42
        "VAT Base Amount" := Amount - "VAT Amount";
        "VAT Difference" := 0;

        IF "Currency Code" = '' THEN
          "VAT Amount (LCY)" := "VAT Amount"
        ELSE
          "VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                "VAT Amount","Currency Factor"));
        "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

        OnValidateVATPctOnBeforeUpdateSalesPurchLCY(Rec,Currency);
        UpdateSalesPurchLCY;

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..45
        "VAT Amount (LCY)" := CalcVATAmountLCY;
        #54..60
        */
        //end;

        //Unsupported feature: Property Deletion (Description) on ""Bal. Account No."(Field 11)".



        //Unsupported feature: Code Modification on ""Currency Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN BEGIN
          IF BankAcc.GET("Bal. Account No.") AND (BankAcc."Currency Code" <> '')THEN
            BankAcc.TESTFIELD("Currency Code","Currency Code");
        #4..12
          ERROR(
            Text001,
            FIELDCAPTION("Currency Code"),FIELDCAPTION("Recurring Method"),"Recurring Method");
        IF "Currency Code" <> '' THEN BEGIN
          IF ("Bal. Account Type" = "Bal. Account Type"::Employee) OR ("Account Type" = "Account Type"::Employee) THEN
            ERROR(OnlyLocalCurrencyForEmployeeErr);
        #19..30
        IF NOT CustVendAccountNosModified THEN
          IF ("Currency Code" <> xRec."Currency Code") AND (Amount <> 0) THEN
            PaymentToleranceMgt.PmtTolGenJnl(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15

        #16..33
        */
        //end;


        //Unsupported feature: Code Modification on "Amount(Field 13).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateAmount(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateAmount;
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. Type"(Field 35).OnValidate".

        //trigger  Type"(Field 35)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        //-#144
        IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
          IF (("Account Type" = "Account Type"::"Provisión Insolvencias") OR
             ("Account Type" = "Account Type"::"Cancelar Prov. Insol.")) AND ("Applies-to Doc. Type" <> "Applies-to Doc. Type"::Invoice)
          THEN
            ERROR(Error007);
        //-#144

        IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
          VALIDATE("Applies-to Doc. No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Applies-to Doc. Type" <> xRec."Applies-to Doc. Type" THEN
          VALIDATE("Applies-to Doc. No.",'');
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 36).OnLookup".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        xRec.Amount := Amount;
        xRec."Currency Code" := "Currency Code";
        xRec."Posting Date" := "Posting Date";

        GetAccTypeAndNo(Rec,AccType,AccNo);
        CLEAR(CustLedgEntry);
        CLEAR(VendLedgEntry);

        CASE AccType OF
          //+#144
          AccType::"Cancelar provisión insol.":
            BEGIN
              CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
              CustLedgEntry.SETRANGE("Customer No.",AccNo);
              CustLedgEntry.SETRANGE(Open);
              CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Invoice);
              CustLedgEntry.SETFILTER("Importe provisionado",'<>%1',0);
              IF "Applies-to Doc. No." <> '' THEN BEGIN
                CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
                CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                IF NOT CustLedgEntry.FIND('-') THEN BEGIN
                  CustLedgEntry.SETRANGE("Document Type");
                  CustLedgEntry.SETRANGE("Document No.");
                END;
              END;
              IF "Applies-to ID" <> '' THEN BEGIN
                CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Applies-to ID");
              END;
              IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
                CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Document Type");
              END;
              IF  "Applies-to Doc. No." <>''THEN BEGIN
                CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Document No.");
              END;
              ApplyCustEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
              ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
              ApplyCustEntries.SETRECORD(CustLedgEntry);
              ApplyCustEntries.LOOKUPMODE(TRUE);
              IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                ApplyCustEntries.GETRECORD(CustLedgEntry);
                CLEAR(ApplyCustEntries);
                VALIDATE("Currency Code");
                CustLedgEntry.CALCFIELDS("Importe provisionado");
                VALIDATE(Amount,CustLedgEntry."Importe provisionado");
                Description := Text021;
                GetDimCustLedgEntry(CustLedgEntry);
                "External Document No." := CustLedgEntry."Document No.";
                "Applies-to Doc. Type" := CustLedgEntry."Document Type";
                "Applies-to Doc. No." := CustLedgEntry."Document No.";
                "Applies-to ID" := '';
              END ELSE BEGIN
                "Applies-to Doc. No." := OldAppliesToDocNo;
                CLEAR(ApplyCustEntries);
              END;
            END;

          AccType::"Provisión insolvencias":
            BEGIN
              CustLedgEntry.SETCURRENTKEY("Customer No.",Open,Positive,"Due Date");
              CustLedgEntry.SETRANGE("Customer No.",AccNo);
              CustLedgEntry.SETRANGE(Open,TRUE);
              //+#144
              IF AccType = AccType::"Provisión insolvencias" THEN
                CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Invoice);
              //-#144
              IF "Applies-to Doc. No." <> '' THEN BEGIN
                CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
                CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                IF NOT CustLedgEntry.FIND('-') THEN BEGIN
                  CustLedgEntry.SETRANGE("Document Type");
                  CustLedgEntry.SETRANGE("Document No.");
                END;
              END;
              IF "Applies-to ID" <> '' THEN BEGIN
                CustLedgEntry.SETRANGE("Applies-to ID","Applies-to ID");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Applies-to ID");
              END;
              IF "Applies-to Doc. Type" <> "Applies-to Doc. Type"::" " THEN BEGIN
                CustLedgEntry.SETRANGE("Document Type","Applies-to Doc. Type");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Document Type");
              END;
              IF  "Applies-to Doc. No." <>''THEN BEGIN
                CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                IF NOT CustLedgEntry.FIND('-') THEN
                  CustLedgEntry.SETRANGE("Document No.");
              END;
              IF Amount <> 0 THEN BEGIN
                CustLedgEntry.SETRANGE(Positive,Amount < 0);
                IF CustLedgEntry.FIND('-') THEN;
                CustLedgEntry.SETRANGE(Positive);
              END;
              ApplyCustEntries.SetGenJnlLine(Rec,GenJnlLine.FIELDNO("Applies-to Doc. No."));
              ApplyCustEntries.SETTABLEVIEW(CustLedgEntry);
              ApplyCustEntries.SETRECORD(CustLedgEntry);
              ApplyCustEntries.LOOKUPMODE(TRUE);
              IF ApplyCustEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                ApplyCustEntries.GETRECORD(CustLedgEntry);
                CLEAR(ApplyCustEntries);
                IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
                  IF Amount = 0 THEN BEGIN
                    FromCurrencyCode1 := GetShowCurrencyCode("Currency Code");
                    ToCurrencyCode1 := GetShowCurrencyCode(CustLedgEntry."Currency Code");
                    IF NOT
                       CONFIRM(
                         Text003 +
                         Text004,TRUE,
                         FIELDCAPTION("Currency Code"),TABLECAPTION,FromCurrencyCode1,
                         ToCurrencyCode1)
                    THEN
                      ERROR(Text005);
                    VALIDATE("Currency Code",CustLedgEntry."Currency Code");
                  END ELSE
                    GenJnlApply.CheckAgainstApplnCurrency(
                      "Currency Code",CustLedgEntry."Currency Code",
                      GenJnlLine."Account Type"::Customer,TRUE);
                IF Amount = 0 THEN BEGIN
                  //+#144
                  IF AccType = AccType::"Provisión insolvencias" THEN BEGIN
                    CustLedgEntry.CALCFIELDS("Importe provisionado");
                    VALIDATE(Amount, - CustLedgEntry.ImporteaAprovisionar("Posting Date",PorcProvisionar) +
                    CustLedgEntry."Importe provisionado");
                    Description := STRSUBSTNO(Text020, PorcProvisionar);
                    GetDimCustLedgEntry(CustLedgEntry);
                    "External Document No." := CustLedgEntry."Document No.";
                  END
                  ELSE BEGIN
                  //-#144
                  CustLedgEntry.CALCFIELDS("Remaining Amount");
                  IF CustLedgEntry."Amount to Apply" <> 0 THEN BEGIN
                    IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE)
                    THEN BEGIN
                      IF ABS(CustLedgEntry."Amount to Apply") >=
                        ABS(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
                      THEN
                        Amount := -(CustLedgEntry."Remaining Amount" -
                          CustLedgEntry."Remaining Pmt. Disc. Possible")
                      ELSE
                        Amount := -CustLedgEntry."Amount to Apply";
                    END ELSE
                      Amount := -CustLedgEntry."Amount to Apply";
                  END ELSE BEGIN
                  IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(Rec,CustLedgEntry,0,FALSE)
                  THEN
                    Amount := -(CustLedgEntry."Remaining Amount" -
                      CustLedgEntry."Remaining Pmt. Disc. Possible")
                  ELSE
                    Amount := -CustLedgEntry."Remaining Amount";
                  END;
                  IF "Bal. Account Type" IN
                    ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor]
                  THEN
                    Amount := -Amount;
                  VALIDATE(Amount);
                  //+#144
                  END;
                  //-#144
                END;
                "Applies-to Doc. Type" := CustLedgEntry."Document Type";
                "Applies-to Doc. No." := CustLedgEntry."Document No.";
                "Applies-to ID" := '';
                //ADD-ON.GRG.10.11.12
                //TipoDoc:=CustLedgEntry.TipoDoc;
                //ADD-ON.GRG.10.11.12
               END ELSE BEGIN
                "Applies-to Doc. No." := OldAppliesToDocNo;
                CLEAR(ApplyCustEntries);
              END;
              //++ZZ GE::REG 25-09-13
              "Posting Group" :=  CustLedgEntry."Customer Posting Group";
              //++ZZ GE::REG 25-09-13
            END;

          AccType::Customer:
            LookUpAppliesToDocCust(AccNo);
          AccType::Vendor:
            LookUpAppliesToDocVend(AccNo);
          AccType::Employee:
            LookUpAppliesToDocEmpl(AccNo);
        END;
        SetJournalLineFieldsFromApplication;

        IF xRec.Amount <> 0 THEN
          IF NOT PaymentToleranceMgt.PmtTolGenJnl(Rec) THEN
            EXIT;

        IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
          UpdateAppliesToInvoiceID;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        #181..195
        */
        //end;


        //Unsupported feature: Code Modification on ""Applies-to Doc. No."(Field 36).OnValidate".

        //trigger  No()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF SuppressCommit THEN
          PaymentToleranceMgt.SetSuppressCommit(TRUE);

        IF "Applies-to Doc. No." <> xRec."Applies-to Doc. No." THEN
          ClearCustVendApplnEntry;

        IF ("Applies-to Doc. No." = '') AND (xRec."Applies-to Doc. No." <> '') THEN BEGIN
          PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");

          TempGenJnlLine := Rec;
          IF (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Customer) OR
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Vendor) OR
             (TempGenJnlLine."Bal. Account Type" = TempGenJnlLine."Bal. Account Type"::Employee)
          THEN
            CODEUNIT.RUN(CODEUNIT::"Exchange Acc. G/L Journal Line",TempGenJnlLine);

          CASE TempGenJnlLine."Account Type" OF
            //+#144
            //TempGenJnlLine."Account Type"::Customer
            TempGenJnlLine."Account Type"::Customer,TempGenJnlLine."Account Type"::"Provisión Insolvencias":
            //-#144
              BEGIN
                CustLedgEntry.SETCURRENTKEY("Document No.");
                CustLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                  CustLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                CustLedgEntry.SETRANGE("Customer No.",TempGenJnlLine."Account No.");
                CustLedgEntry.SETRANGE(Open,TRUE);
                IF CustLedgEntry.FINDFIRST THEN BEGIN
                  IF CustLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                    CustLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit",CustLedgEntry);
                  END;
                  "Exported to Payment File" := CustLedgEntry."Exported to Payment File";
                  "Applies-to Ext. Doc. No." := '';
                END;
              END;
            TempGenJnlLine."Account Type"::Vendor:
              BEGIN
                VendLedgEntry.SETCURRENTKEY("Document No.");
                VendLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                  VendLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                VendLedgEntry.SETRANGE("Vendor No.",TempGenJnlLine."Account No.");
                VendLedgEntry.SETRANGE(Open,TRUE);
                IF VendLedgEntry.FINDFIRST THEN BEGIN
                  IF VendLedgEntry."Amount to Apply" <> 0 THEN  BEGIN
                    VendLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit",VendLedgEntry);
                  END;
                  "Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                END;
                "Applies-to Ext. Doc. No." := '';
              END;
            TempGenJnlLine."Account Type"::Employee:
              BEGIN
                EmplLedgEntry.SETCURRENTKEY("Document No.");
                EmplLedgEntry.SETRANGE("Document No.",xRec."Applies-to Doc. No.");
                IF NOT (xRec."Applies-to Doc. Type" = "Document Type"::" ") THEN
                  EmplLedgEntry.SETRANGE("Document Type",xRec."Applies-to Doc. Type");
                EmplLedgEntry.SETRANGE("Employee No.",TempGenJnlLine."Account No.");
                EmplLedgEntry.SETRANGE(Open,TRUE);
                IF EmplLedgEntry.FINDFIRST THEN BEGIN
                  IF EmplLedgEntry."Amount to Apply" <> 0 THEN BEGIN
                    EmplLedgEntry."Amount to Apply" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Empl. Entry-Edit",EmplLedgEntry);
                  END;
                  "Exported to Payment File" := EmplLedgEntry."Exported to Payment File";
                END;
              END;
          END;
        END;

        //+#144
        IF "Account Type" = "Account Type"::"Cancelar Prov. Insol." THEN BEGIN
          IF "Applies-to Doc. No." <> '' THEN BEGIN
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
            CustLedgEntry.SETRANGE("Customer No.","Account No.");
            CustLedgEntry.SETRANGE(Open);
            CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Invoice);
            CustLedgEntry.SETFILTER("Importe provisionado",'<>%1',0);
            IF CustLedgEntry.FIND('-') THEN BEGIN
              "Currency Code" := '';
              CustLedgEntry.CALCFIELDS("Importe provisionado");
              VALIDATE(Amount,CustLedgEntry."Importe provisionado");
              Description := Text021;
              GetDimCustLedgEntry(CustLedgEntry);
              "External Document No." := CustLedgEntry."Document No.";
            END;
          END;
        END;

        IF "Account Type" = "Account Type"::"Provisión Insolvencias" THEN BEGIN
          IF "Applies-to Doc. No." <> '' THEN BEGIN
            CustLedgEntry.SETCURRENTKEY("Document No.");
            CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
            CustLedgEntry.SETRANGE("Customer No.","Account No.");
            CustLedgEntry.SETRANGE(Open,TRUE);
            CustLedgEntry.SETRANGE(CustLedgEntry."Document Type", CustLedgEntry."Document Type"::Invoice);
            IF CustLedgEntry.FIND('-') THEN BEGIN
              "Currency Code" := '';
              CLEAR(PorcProvisionar);
              CustLedgEntry.CALCFIELDS("Importe provisionado");
              VALIDATE(Amount,-CustLedgEntry.ImporteaAprovisionar("Posting Date",PorcProvisionar) + CustLedgEntry."Importe provisionado");
              Description := STRSUBSTNO(Text020,PorcProvisionar);
              GetDimCustLedgEntry(CustLedgEntry);
              "External Document No." := CustLedgEntry."Document No.";
            END;
          END;
        END;
        //-#144

        IF ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") AND (Amount <> 0) THEN BEGIN
          IF xRec."Applies-to Doc. No." <> '' THEN
            PaymentToleranceMgt.DelPmtTolApllnDocNo(Rec,xRec."Applies-to Doc. No.");
          SetApplyToAmount;
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
          xRec.ClearAppliedGenJnlLine;
        END;
        CASE "Account Type" OF
          "Account Type"::Customer:
            GetCustLedgerEntry;
          "Account Type"::Vendor:
            GetVendLedgerEntry;
          "Account Type"::Employee:
            GetEmplLedgerEntry;
        END;
        ValidateApplyRequirements(Rec);
        SetJournalLineFieldsFromApplication;

        IF "Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice THEN
          UpdateAppliesToInvoiceID;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..17
            TempGenJnlLine."Account Type"::Customer:
        #22..73
        #114..120

        #121..128

        #129..133
        */
        //end;


        //Unsupported feature: Code Modification on ""VAT Amount"(Field 44).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        GenJnlBatch.TESTFIELD("Allow VAT Difference",TRUE);
        IF NOT ("VAT Calculation Type" IN
        #4..29
        IF ABS("VAT Difference") > Currency."Max. VAT Difference Allowed" THEN
          ERROR(Text013,FIELDCAPTION("VAT Difference"),Currency."Max. VAT Difference Allowed");

        IF "Currency Code" = '' THEN
          "VAT Amount (LCY)" := "VAT Amount"
        ELSE
          "VAT Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date","Currency Code",
                "VAT Amount","Currency Factor"));
        "VAT Base Amount (LCY)" := "Amount (LCY)" - "VAT Amount (LCY)";

        UpdateSalesPurchLCY;
        #44..48

        IF "Deferral Code" <> '' THEN
          VALIDATE("Deferral Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..32
        "VAT Amount (LCY)" := CalcVATAmountLCY;
        #41..51
        */
        //end;


        //Unsupported feature: Code Modification on ""Bal. Account Type"(Field 63).OnValidate".

        //trigger  Account Type"(Field 63)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        //+#144
        IF (("Account Type" = "Account Type"::"Provisión Insolvencias") OR
           ("Account Type" = "Account Type"::"Cancelar Prov. Insol.")) AND
           ("Bal. Account Type" = "Bal. Account Type"::Customer) THEN
          ERROR(Error006,FORMAT("Account Type"));
        //-#144

        IF ("Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,"Account Type"::"Fixed Asset",
                               "Account Type"::"IC Partner","Account Type"::Employee]) AND
           ("Bal. Account Type" IN ["Bal. Account Type"::Customer,"Bal. Account Type"::Vendor,"Bal. Account Type"::"Fixed Asset",
        #11..57
          IF GenJnlTemplate.Type <> GenJnlTemplate.Type::Intercompany THEN
            FIELDERROR("Bal. Account Type");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #8..60
        */
        //end;

        //Unsupported feature: Deletion (FieldCollection) on ""No. Paginas"(Field 50000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Componentes Producto"(Field 50001)".


        //Unsupported feature: Deletion (FieldCollection) on "ISBN(Field 50002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Procedencia"(Field 50003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Edición"(Field 50004)".


        //Unsupported feature: Deletion (FieldCollection) on "Areas(Field 50005)".


        //Unsupported feature: Deletion (FieldCollection) on ""Nivel Educativo"(Field 50006)".


        //Unsupported feature: Deletion (FieldCollection) on "Cursos(Field 50007)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Talonario"(Field 50009)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Serie Talonario"(Field 50010)".


        //Unsupported feature: Deletion (FieldCollection) on "Aprobado(Field 50011)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Talonario"(Field 50012)".


        //Unsupported feature: Deletion (FieldCollection) on ""Forma de Pago"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Recibo a depositar"(Field 50014)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Talonario a depositar"(Field 50015)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo Ingreso"(Field 50016)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo pedido"(Field 53000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe a liquidar"(Field 53001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Venta a credito"(Field 53002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Colegio"(Field 56022)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe Retenido"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""Retencion ITBIS"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003003)".


        //Unsupported feature: Deletion (FieldCollection) on ""Cod. Clasificacion Gasto"(Field 34003007)".


        //Unsupported feature: Deletion (FieldCollection) on "Beneficiario(Field 34003008)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF"(Field 34003010)".


        //Unsupported feature: Deletion (FieldCollection) on ""Tipo de ingreso"(Field 34003011)".

        field(28; "Pending Approval"; Boolean)
        {
            Caption = 'Pending Approval';
            Editable = false;
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Journal Template Name,Journal Batch Name,Posting Date,Account No."(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "EmptyLine(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateLineBalance(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "SetUpNewLine(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "InitNewLine(PROCEDURE 94)".



    //Unsupported feature: Code Modification on "InitNewLine(PROCEDURE 94)".

    //procedure InitNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    "Posting Date" := PostingDate;
    "Document Date" := DocumentDate;
    Description := PostingDescription;
    "Shortcut Dimension 1 Code" := ShortcutDim1Code;
    "Shortcut Dimension 2 Code" := ShortcutDim2Code;
    "Dimension Set ID" := DimSetID;
    "Reason Code" := ReasonCode;

    OnAfterInitNewLine(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    OnAfterInitNewLine(Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoOnLines(PROCEDURE 78)".


    //Unsupported feature: Property Modification (Attributes) on "CheckDocNoBasedOnNoSeries(PROCEDURE 74)".



    //Unsupported feature: Code Modification on "CheckDocNoBasedOnNoSeries(PROCEDURE 74)".

    //procedure CheckDocNoBasedOnNoSeries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeCheckDocNoBasedOnNoSeries(Rec,LastDocNo,NoSeriesCode,NoSeriesMgtInstance,IsHandled);
    IF IsHandled THEN
    #4..6
      EXIT;

    IF (LastDocNo = '') OR ("Document No." <> LastDocNo) THEN
      IF "Document No." <> NoSeriesMgtInstance.GetNextNo(NoSeriesCode,"Posting Date",FALSE) THEN
        NoSeriesMgtInstance.TestManualWithDocumentNo(NoSeriesCode,"Document No.");  // allow use of manual document numbers.
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
      IF "Document No." <> NoSeriesMgtInstance.GetNextNo(NoSeriesCode,"Posting Date",FALSE) THEN BEGIN
        NoSeriesMgtInstance.TestManualWithDocumentNo(NoSeriesCode,"Document No.");  // allow use of manual document numbers.
        NoSeriesMgtInstance.ClearNoSeriesLine;
      END;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "RenumberDocumentNo(PROCEDURE 68)".


    //Unsupported feature: Property Modification (Attributes) on "SetCurrencyFactor(PROCEDURE 130)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateSource(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAAddCurrExchRate(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "GetShowCurrencyCode(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "ClearCustVendApplnEntry(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "CheckFixedCurrency(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "CreateDim(PROCEDURE 13)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateShortcutDimCode(PROCEDURE 14)".



    //Unsupported feature: Code Modification on "ValidateAmount(PROCEDURE 223)".

    //procedure ValidateAmount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetCurrency;
    IF "Currency Code" = '' THEN
      "Amount (LCY)" := Amount
    #4..35
    THEN BEGIN
      IF ("Applies-to Doc. No." <> '') OR ("Applies-to ID" <> '') THEN
        SetApplyToAmount;
      IF ShouldCheckPaymentTolerance THEN
        IF (xRec.Amount <> 0) OR (xRec."Applies-to Doc. No." <> '') OR (xRec."Applies-to ID" <> '') THEN
          PaymentToleranceMgt.PmtTolGenJnl(Rec);
    END;

    IF JobTaskIsSet THEN BEGIN
      CreateTempJobJnlLine;
      UpdatePricesFromJobJnlLine;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..38
      IF (xRec.Amount <> 0) OR (xRec."Applies-to Doc. No." <> '') OR (xRec."Applies-to ID" <> '') THEN
        PaymentToleranceMgt.PmtTolGenJnl(Rec);
    #42..47
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "LookupShortcutDimCode(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "ShowShortcutDimCode(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "GetFAVATSetup(PROCEDURE 17)".


    //Unsupported feature: Property Modification (Attributes) on "GetTemplate(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocCust(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocVend(PROCEDURE 36)".


    //Unsupported feature: Property Modification (Attributes) on "LookUpAppliesToDocEmpl(PROCEDURE 171)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToAmount(PROCEDURE 20)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateApplyRequirements(PROCEDURE 21)".


    //Unsupported feature: Property Modification (Attributes) on "JobTaskIsSet(PROCEDURE 28)".


    //Unsupported feature: Property Modification (Attributes) on "CreateTempJobJnlLine(PROCEDURE 27)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePricesFromJobJnlLine(PROCEDURE 22)".


    //Unsupported feature: Property Modification (Attributes) on "SetHideValidation(PROCEDURE 23)".


    //Unsupported feature: Property Modification (Attributes) on "IsApplied(PROCEDURE 30)".


    //Unsupported feature: Property Modification (Attributes) on "DataCaption(PROCEDURE 29)".


    //Unsupported feature: Property Modification (Attributes) on "GetCustLedgerEntry(PROCEDURE 33)".



    //Unsupported feature: Code Modification on "GetCustLedgerEntry(PROCEDURE 33)".

    //procedure GetCustLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Customer) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '') AND (Amount = 0)
    THEN BEGIN
      CustLedgEntry.RESET;
      CustLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
      CustLedgEntry.SETRANGE(Open,TRUE);
      IF NOT CustLedgEntry.FINDFIRST THEN
        ERROR(NotExistErr,"Applies-to Doc. No.");

      VALIDATE("Account No.",CustLedgEntry."Customer No.");
      OnGetCustLedgerEntryOnAfterAssignCustomerNo(Rec,CustLedgEntry);

      CustLedgEntry.CALCFIELDS("Remaining Amount");

      IF "Posting Date" <= CustLedgEntry."Pmt. Discount Date" THEN
        Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
      ELSE
        Amount := -CustLedgEntry."Remaining Amount";

      IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
        UpdateCurrencyCode(CustLedgEntry."Currency Code");

      SetAppliesToFields(
        CustLedgEntry."Document Type",CustLedgEntry."Document No.",CustLedgEntry."External Document No.");

      GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
      IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
        "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
      END ELSE
        VALIDATE(Amount);

      OnAfterGetCustLedgerEntry(Rec,CustLedgEntry);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Customer) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '')
    #3..11
      IF Amount = 0 THEN BEGIN
        CustLedgEntry.CALCFIELDS("Remaining Amount");

        IF "Posting Date" <= CustLedgEntry."Pmt. Discount Date" THEN
          Amount := -(CustLedgEntry."Remaining Amount" - CustLedgEntry."Remaining Pmt. Disc. Possible")
        ELSE
          Amount := -CustLedgEntry."Remaining Amount";

        IF "Currency Code" <> CustLedgEntry."Currency Code" THEN
          UpdateCurrencyCode(CustLedgEntry."Currency Code");

        SetAppliesToFields(
          CustLedgEntry."Document Type",CustLedgEntry."Document No.",CustLedgEntry."External Document No.");

        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
          "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
          VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
        END ELSE
          VALIDATE(Amount);

        OnAfterGetCustLedgerEntry(Rec,CustLedgEntry);
      END;
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetVendLedgerEntry(PROCEDURE 37)".



    //Unsupported feature: Code Modification on "GetVendLedgerEntry(PROCEDURE 37)".

    //procedure GetVendLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Vendor) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '') AND (Amount = 0)
    THEN BEGIN
      VendLedgEntry.RESET;
      VendLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
      VendLedgEntry.SETRANGE(Open,TRUE);
      IF NOT VendLedgEntry.FINDFIRST THEN
        ERROR(NotExistErr,"Applies-to Doc. No.");

      VALIDATE("Account No.",VendLedgEntry."Vendor No.");
      OnGetVendLedgerEntryOnAfterAssignVendorNo(Rec,VendLedgEntry);

      VendLedgEntry.CALCFIELDS("Remaining Amount");

      IF "Posting Date" <= VendLedgEntry."Pmt. Discount Date" THEN
        Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
      ELSE
        Amount := -VendLedgEntry."Remaining Amount";

      IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
        UpdateCurrencyCode(VendLedgEntry."Currency Code");

      SetAppliesToFields(
        VendLedgEntry."Document Type",VendLedgEntry."Document No.",VendLedgEntry."External Document No.");

      GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
      IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
        "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
      END ELSE
        VALIDATE(Amount);

      OnAfterGetVendLedgerEntry(Rec,VendLedgEntry);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Vendor) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '')
    #3..11
      IF Amount = 0 THEN BEGIN
        VendLedgEntry.CALCFIELDS("Remaining Amount");

        IF "Posting Date" <= VendLedgEntry."Pmt. Discount Date" THEN
          Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
        ELSE
          Amount := -VendLedgEntry."Remaining Amount";

        IF "Currency Code" <> VendLedgEntry."Currency Code" THEN
          UpdateCurrencyCode(VendLedgEntry."Currency Code");

        SetAppliesToFields(
          VendLedgEntry."Document Type",VendLedgEntry."Document No.",VendLedgEntry."External Document No.");

        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
          "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
          VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
        END ELSE
          VALIDATE(Amount);

        OnAfterGetVendLedgerEntry(Rec,VendLedgEntry);
      END;
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetEmplLedgerEntry(PROCEDURE 183)".



    //Unsupported feature: Code Modification on "GetEmplLedgerEntry(PROCEDURE 183)".

    //procedure GetEmplLedgerEntry();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Employee) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '') AND (Amount = 0)
    THEN BEGIN
      EmplLedgEntry.RESET;
      EmplLedgEntry.SETRANGE("Document No.","Applies-to Doc. No.");
      EmplLedgEntry.SETRANGE(Open,TRUE);
      IF NOT EmplLedgEntry.FINDFIRST THEN
        ERROR(NotExistErr,"Applies-to Doc. No.");

      VALIDATE("Account No.",EmplLedgEntry."Employee No.");
      EmplLedgEntry.CALCFIELDS("Remaining Amount");

      Amount := -EmplLedgEntry."Remaining Amount";

      SetAppliesToFields(EmplLedgEntry."Document Type",EmplLedgEntry."Document No.",'');

      GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
      IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
        "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
        VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
      END ELSE
        VALIDATE(Amount);

      OnAfterGetEmplLedgerEntry(Rec,EmplLedgEntry);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF ("Account Type" = "Account Type"::Employee) AND ("Account No." = '') AND
       ("Applies-to Doc. No." <> '')
    #3..10
      IF Amount = 0 THEN BEGIN
        EmplLedgEntry.CALCFIELDS("Remaining Amount");

        Amount := -EmplLedgEntry."Remaining Amount";

        SetAppliesToFields(EmplLedgEntry."Document Type",EmplLedgEntry."Document No.",'');

        GenJnlBatch.GET("Journal Template Name","Journal Batch Name");
        IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
          "Bal. Account Type" := GenJnlBatch."Bal. Account Type";
          VALIDATE("Bal. Account No.",GenJnlBatch."Bal. Account No.");
        END ELSE
          VALIDATE(Amount);

        OnAfterGetEmplLedgerEntry(Rec,EmplLedgEntry);
      END;
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IncludeVATAmount(PROCEDURE 38)".


    //Unsupported feature: Property Modification (Attributes) on "ConvertAmtFCYToLCYForSourceCurrency(PROCEDURE 39)".


    //Unsupported feature: Property Modification (Attributes) on "MatchSingleLedgerEntry(PROCEDURE 40)".


    //Unsupported feature: Property Modification (Attributes) on "GetStyle(PROCEDURE 41)".


    //Unsupported feature: Property Modification (Attributes) on "GetOverdueDateInteractions(PROCEDURE 75)".


    //Unsupported feature: Property Modification (Attributes) on "ClearDataExchangeEntries(PROCEDURE 42)".


    //Unsupported feature: Property Modification (Attributes) on "ClearAppliedGenJnlLine(PROCEDURE 49)".


    //Unsupported feature: Property Modification (Attributes) on "GetIncomingDocumentURL(PROCEDURE 50)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileError(PROCEDURE 64)".


    //Unsupported feature: Property Modification (Attributes) on "InsertPaymentFileErrorWithDetails(PROCEDURE 83)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileBatchErrors(PROCEDURE 67)".


    //Unsupported feature: Property Modification (Attributes) on "DeletePaymentFileErrors(PROCEDURE 61)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrors(PROCEDURE 24)".


    //Unsupported feature: Property Modification (Attributes) on "HasPaymentFileErrorsInBatch(PROCEDURE 65)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocEntryNo(PROCEDURE 63)".


    //Unsupported feature: Property Modification (Attributes) on "GetAppliesToDocDueDate(PROCEDURE 62)".


    //Unsupported feature: Property Modification (Attributes) on "IsCustVendICAdded(PROCEDURE 209)".


    //Unsupported feature: Property Modification (Attributes) on "IsExportedToPaymentFile(PROCEDURE 1020)".


    //Unsupported feature: Property Modification (Attributes) on "IsPaymentJournallLineExported(PROCEDURE 80)".


    //Unsupported feature: Property Modification (Attributes) on "IsAppliedToVendorLedgerEntryExported(PROCEDURE 79)".


    //Unsupported feature: Property Modification (Attributes) on "SetPostingDateAsDueDate(PROCEDURE 77)".


    //Unsupported feature: Property Modification (Attributes) on "CalculatePostingDate(PROCEDURE 76)".


    //Unsupported feature: Property Modification (Attributes) on "ImportBankStatement(PROCEDURE 73)".


    //Unsupported feature: Property Modification (Attributes) on "ExportPaymentFile(PROCEDURE 81)".


    //Unsupported feature: Property Modification (Attributes) on "TotalExportedAmount(PROCEDURE 85)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownExportedAmount(PROCEDURE 95)".


    //Unsupported feature: Property Modification (Attributes) on "CopyDocumentFields(PROCEDURE 129)".


    //Unsupported feature: Property Modification (Attributes) on "CopyCustLedgEntry(PROCEDURE 134)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlAllocation(PROCEDURE 113)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBuffer(PROCEDURE 112)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromInvoicePostBufferFA(PROCEDURE 111)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPrepmtInvoiceBuffer(PROCEDURE 110)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeader(PROCEDURE 109)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmt(PROCEDURE 127)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPrepmtPost(PROCEDURE 137)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderApplyTo(PROCEDURE 107)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPurchHeaderPayment(PROCEDURE 104)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeader(PROCEDURE 103)".



    //Unsupported feature: Code Modification on "CopyFromSalesHeader(PROCEDURE 103)".

    //procedure CopyFromSalesHeader();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Source Currency Code" := SalesHeader."Currency Code";
    "Currency Factor" := SalesHeader."Currency Factor";
    "VAT Base Discount %" := SalesHeader."VAT Base Discount %";
    Correction := SalesHeader.Correction;
    "EU 3-Party Trade" := SalesHeader."EU 3-Party Trade";
    "Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
    "Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
    "Country/Region Code" := SalesHeader."VAT Country/Region Code";
    "VAT Registration No." := SalesHeader."VAT Registration No.";
    "Source Type" := "Source Type"::Customer;
    "Source No." := SalesHeader."Bill-to Customer No.";
    "Posting No. Series" := SalesHeader."Posting No. Series";
    "Ship-to/Order Address Code" := SalesHeader."Ship-to Code";
    "IC Partner Code" := SalesHeader."Bill-to IC Partner Code";
    "Salespers./Purch. Code" := SalesHeader."Salesperson Code";
    "On Hold" := SalesHeader."On Hold";
    IF "Account Type" = "Account Type"::Customer THEN
      "Posting Group" := SalesHeader."Customer Posting Group";

    ////DSLoc1.04
    "No. Comprobante Fiscal" := SalesHeader."No. Comprobante Fiscal";
    "Cod. Clasificacion Gasto" := SalesHeader."Cod. Clasificacion Gasto";
    "Fecha vencimiento NCF" := SalesHeader."Fecha vencimiento NCF";
    "Tipo de ingreso" := SalesHeader."Tipo de ingreso";

    //004+
    "Tipo pedido" := SalesHeader."Tipo pedido";
    "Importe a liquidar" := SalesHeader."Importe a liquidar";
    IF SalesHeader."Venta a credito" THEN
      "Venta a credito" := TRUE;
    //004-

    "Cod. Colegio" := SalesHeader."Cod. Colegio"; //APS
    "Collector Code" := SalesHeader."Collector Code"; //017

    OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..19
    OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader,Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmt(PROCEDURE 119)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPrepmtPost(PROCEDURE 138)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderApplyTo(PROCEDURE 100)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromSalesHeaderPayment(PROCEDURE 99)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeader(PROCEDURE 98)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderApplyTo(PROCEDURE 97)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromServiceHeaderPayment(PROCEDURE 96)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentCustLedgEntry(PROCEDURE 205)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentVendLedgEntry(PROCEDURE 202)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromPaymentEmpLedgEntry(PROCEDURE 1250)".


    //Unsupported feature: Property Modification (Attributes) on "CheckModifyCurrencyCode(PROCEDURE 105)".



    //Unsupported feature: Code Modification on "SetAmountWithRemaining(PROCEDURE 101)".

    //procedure SetAmountWithRemaining();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF AmountToApply <> 0 THEN
      IF CalcPmtDisc AND (ABS(AmountToApply) >= ABS(RemainingAmount - RemainingPmtDiscPossible)) THEN
        Amount := -(RemainingAmount - RemainingPmtDiscPossible)
    #4..11
      Amount := -Amount;

    OnAfterSetAmountWithRemaining(Rec);
    ValidateAmount(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..14
    ValidateAmount;
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "IsOpenedFromBatch(PROCEDURE 87)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralAmount(PROCEDURE 88)".


    //Unsupported feature: Property Modification (Attributes) on "GetDeferralDocType(PROCEDURE 106)".


    //Unsupported feature: Property Modification (Attributes) on "IsForPurchase(PROCEDURE 86)".


    //Unsupported feature: Property Modification (Attributes) on "IsForSales(PROCEDURE 89)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePostRestrictions(PROCEDURE 90)".


    //Unsupported feature: Property Modification (Attributes) on "OnCheckGenJournalLinePrintCheckRestrictions(PROCEDURE 92)".


    //Unsupported feature: Property Modification (Attributes) on "OnMoveGenJournalLine(PROCEDURE 93)".


    //Unsupported feature: Property Modification (Attributes) on "IncrementDocumentNo(PROCEDURE 120)".


    //Unsupported feature: Property Modification (Attributes) on "NeedCheckZeroAmount(PROCEDURE 196)".


    //Unsupported feature: Property Modification (Attributes) on "IsRecurring(PROCEDURE 199)".



    //Unsupported feature: Code Modification on "GetGLAccount(PROCEDURE 146)".

    //procedure GetGLAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLAcc.GET("Account No.");
    CheckGLAcc(GLAcc);
    IF ReplaceDescription AND (NOT GLAcc."Omit Default Descr. in Jnl.") THEN
    #4..10
    THEN BEGIN
      "Posting Group" := '';
      "Salespers./Purch. Code" := '';
      //001
      "Collector Code" := '';
      //001
      "Payment Terms Code" := '';
    END;
    IF "Bal. Account No." = '' THEN
    #20..33
    VALIDATE("Deferral Code",GLAcc."Default Deferral Template Code");

    OnAfterAccountNoOnValidateGetGLAccount(Rec,GLAcc);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    #17..36
    */
    //end;


    //Unsupported feature: Code Modification on "GetGLBalAccount(PROCEDURE 121)".

    //procedure GetGLBalAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GLAcc.GET("Bal. Account No.");
    CheckGLAcc(GLAcc);
    IF "Account No." = '' THEN BEGIN
    #4..9
    THEN BEGIN
      "Posting Group" := '';
      "Salespers./Purch. Code" := '';

      //001
      "Collector Code" := '';
      //001

      "Payment Terms Code" := '';
    END;
    IF CopyVATSetupToJnlLines THEN BEGIN
    #21..31
        ClearBalancePostingGroups;

    OnAfterAccountNoOnValidateGetGLBalAccount(Rec,GLAcc);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    #18..34
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustomerAccount(PROCEDURE 47)".

    //procedure GetCustomerAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.GET("Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
    CheckICPartner(Cust."IC Partner Code","Account Type","Account No.");
    UpdateDescription(Cust.Name);
    "Payment Method Code" := Cust."Payment Method Code";
    VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account Code");
    "Posting Group" := Cust."Customer Posting Group";
    SetSalespersonPurchaserCode(Cust."Salesperson Code","Salespers./Purch. Code");

    //001
    "Collector Code" := Cust."Collector Code";
    //001

    "Payment Terms Code" := Cust."Payment Terms Code";

    Beneficiario         := Cust.Name; //GRN Para los cheques

    VALIDATE("Bill-to/Pay-to No.","Account No.");
    VALIDATE("Sell-to/Buy-from No.","Account No.");
    IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
      "Currency Code" := Cust."Currency Code";
    ClearPostingGroups;
    IF (Cust."Bill-to Customer No." <> '') AND (Cust."Bill-to Customer No." <> "Account No.") AND
       NOT HideValidationDialog
    THEN
      IF NOT ConfirmManagement.ConfirmProcess(
           STRSUBSTNO(
             Text014,Cust.TABLECAPTION,Cust."No.",Cust.FIELDCAPTION("Bill-to Customer No."),
             Cust."Bill-to Customer No."),TRUE)
      THEN
        ERROR('');
    VALIDATE("Payment Terms Code");
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerAccount(Rec,Cust,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    "Payment Terms Code" := Cust."Payment Terms Code";
    #18..35
    */
    //end;


    //Unsupported feature: Code Modification on "GetCustomerBalAccount(PROCEDURE 122)".

    //procedure GetCustomerBalAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.GET("Bal. Account No.");
    Cust.CheckBlockedCustOnJnls(Cust,"Document Type",FALSE);
    CheckICPartner(Cust."IC Partner Code","Bal. Account Type","Bal. Account No.");
    #4..6
    VALIDATE("Recipient Bank Account",Cust."Preferred Bank Account Code");
    "Posting Group" := Cust."Customer Posting Group";
    SetSalespersonPurchaserCode(Cust."Salesperson Code","Salespers./Purch. Code");

    //001
    "Collector Code" := Cust."Collector Code";
    //001

    "Payment Terms Code" := Cust."Payment Terms Code";
    VALIDATE("Bill-to/Pay-to No.","Bal. Account No.");
    VALIDATE("Sell-to/Buy-from No.","Bal. Account No.");
    #18..32
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetCustomerBalAccount(Rec,Cust,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    #15..35
    */
    //end;


    //Unsupported feature: Code Modification on "GetVendorAccount(PROCEDURE 115)".

    //procedure GetVendorAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Vend.GET("Account No.");
    Vend.CheckBlockedVendOnJnls(Vend,"Document Type",FALSE);
    CheckICPartner(Vend."IC Partner Code","Account Type","Account No.");
    #4..10
    "Posting Group" := Vend."Vendor Posting Group";
    SetSalespersonPurchaserCode(Vend."Purchaser Code","Salespers./Purch. Code");
    "Payment Terms Code" := Vend."Payment Terms Code";
    Beneficiario         := Vend.Name;  //GRN  Para los cheques
    VALIDATE("Bill-to/Pay-to No.","Account No.");
    VALIDATE("Sell-to/Buy-from No.","Account No.");
    IF NOT SetCurrencyCode("Bal. Account Type","Bal. Account No.") THEN
    #18..31
    CheckPaymentTolerance;

    OnAfterAccountNoOnValidateGetVendorAccount(Rec,Vend,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..13
    #15..34
    */
    //end;


    //Unsupported feature: Code Modification on "GetBankAccount(PROCEDURE 116)".

    //procedure GetBankAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankAcc.GET("Account No.");
    BankAcc.TESTFIELD(Blocked,FALSE);
    IF ReplaceDescription THEN
    #4..7
    THEN BEGIN
      "Posting Group" := '';
      "Salespers./Purch. Code" := '';

      //001
      "Collector Code" := '';
      //001

      "Payment Terms Code" := '';
      "IRS 1099 Code" := '';
    END;
    #19..26
    ClearPostingGroups;

    OnAfterAccountNoOnValidateGetBankAccount(Rec,BankAcc,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    #16..29
    */
    //end;


    //Unsupported feature: Code Modification on "GetBankBalAccount(PROCEDURE 124)".

    //procedure GetBankBalAccount();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    BankAcc.GET("Bal. Account No.");
    BankAcc.TESTFIELD(Blocked,FALSE);
    IF "Account No." = '' THEN
    #4..9
      "Posting Group" := '';
      "Salespers./Purch. Code" := '';
      "Payment Terms Code" := '';

      //001
      "Collector Code" := '';
      //001

    END;
    IF BankAcc."Currency Code" = '' THEN
      IF "Account No." = '' THEN
    #21..28
    ClearBalancePostingGroups;

    OnAfterAccountNoOnValidateGetBankBalAccount(Rec,BankAcc,CurrFieldNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..12
    #18..31
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "CreateFAAcquisitionLines(PROCEDURE 131)".



    //Unsupported feature: Code Modification on "CreateFAAcquisitionLines(PROCEDURE 131)".

    //procedure CreateFAAcquisitionLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Journal Template Name");
    TESTFIELD("Journal Batch Name");
    TESTFIELD("Posting Date");
    #4..14
    FAGenJournalLine.VALIDATE("Account Type","Account Type");
    FAGenJournalLine.VALIDATE("Account No.","Account No.");
    FAGenJournalLine.VALIDATE(Amount,Amount);
    FAGenJournalLine.VALIDATE("Posting Date","Posting Date");
    FAGenJournalLine.VALIDATE("FA Posting Type","FA Posting Type"::"Acquisition Cost");
    FAGenJournalLine.VALIDATE("External Document No.","External Document No.");
    #21..53
      BalancingGenJnlLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
      BalancingGenJnlLine.MODIFY(TRUE);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17
    FAGenJournalLine.VALIDATE("Currency Code","Currency Code");
    #18..56
    */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "SetAccountNoFromFilter(PROCEDURE 135)".


    //Unsupported feature: Property Modification (Attributes) on "GetNewLineNo(PROCEDURE 136)".


    //Unsupported feature: Property Modification (Attributes) on "VoidPaymentFile(PROCEDURE 139)".


    //Unsupported feature: Property Modification (Attributes) on "TransmitPaymentFile(PROCEDURE 142)".


    //Unsupported feature: Property Modification (Attributes) on "ValidateSalesPersonPurchaserCode(PROCEDURE 298)".


    //Unsupported feature: Property Modification (Attributes) on "CheckIfPrivacyBlocked(PROCEDURE 208)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetupNewLine(PROCEDURE 161)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearCustApplnEntryFields(PROCEDURE 212)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearEmplApplnEntryFields(PROCEDURE 218)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearVendApplnEntryFields(PROCEDURE 213)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromCustLedgEntry(PROCEDURE 181)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromGenJnlAllocation(PROCEDURE 182)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeader(PROCEDURE 160)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmt(PROCEDURE 195)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPrepmtPost(PROCEDURE 197)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderApplyTo(PROCEDURE 200)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromSalesHeaderPayment(PROCEDURE 201)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeader(PROCEDURE 141)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmt(PROCEDURE 186)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPrepmtPost(PROCEDURE 187)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderApplyTo(PROCEDURE 192)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPurchHeaderPayment(PROCEDURE 194)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeader(PROCEDURE 163)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderApplyTo(PROCEDURE 203)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromServHeaderPayment(PROCEDURE 204)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBuffer(PROCEDURE 144)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromInvPostBufferFA(PROCEDURE 184)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyGenJnlLineFromPrepmtInvBuffer(PROCEDURE 148)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLAccount(PROCEDURE 145)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetGLBalAccount(PROCEDURE 147)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerAccount(PROCEDURE 149)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetCustomerBalAccount(PROCEDURE 152)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorAccount(PROCEDURE 150)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetVendorBalAccount(PROCEDURE 153)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeAccount(PROCEDURE 189)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetEmployeeBalAccount(PROCEDURE 179)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankAccount(PROCEDURE 155)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetBankBalAccount(PROCEDURE 154)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFAAccount(PROCEDURE 157)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetFABalAccount(PROCEDURE 156)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerAccount(PROCEDURE 159)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterAccountNoOnValidateGetICPartnerBalAccount(PROCEDURE 158)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateTempJobJnlLine(PROCEDURE 151)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCreateTempJobJnlLine(PROCEDURE 162)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdatePricesFromJobJnlLine(PROCEDURE 166)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateDimTableIDs(PROCEDURE 164)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCreateFAAcquisitionLines(PROCEDURE 245)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearPostingGroups(PROCEDURE 168)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterClearBalPostingGroups(PROCEDURE 169)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetCustLedgerEntry(PROCEDURE 234)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetDeferralAmount(PROCEDURE 275)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetEmplLedgerEntry(PROCEDURE 237)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetVATPostingSetup(PROCEDURE 264)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterGetVendLedgerEntry(PROCEDURE 236)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterInitNewLine(PROCEDURE 263)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculateCalculateTax(PROCEDURE 253)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSalesTaxCalculateReverseCalculateTax(PROCEDURE 254)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateApplyRequirements(PROCEDURE 207)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterValidateShortcutDimCode(PROCEDURE 262)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCheckDirectPosting(PROCEDURE 220)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetAmountWithRemaining(PROCEDURE 233)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterSetJournalLineFieldsFromApplication(PROCEDURE 231)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterUpdateDocumentTypeAndAppliesToFields(PROCEDURE 221)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckDirectPosting(PROCEDURE 219)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckIfPostingDateIsEarlier(PROCEDURE 355)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeCheckDocNoBasedOnNoSeries(PROCEDURE 260)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeEmptyLine(PROCEDURE 265)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocCust(PROCEDURE 214)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocEmpl(PROCEDURE 216)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeLookUpAppliesToDocVend(PROCEDURE 215)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithCustLedgEntry(PROCEDURE 232)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeSetAmountWithVendLedgEntry(PROCEDURE 230)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterSetFilters(PROCEDURE 235)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateApplyRequirements(PROCEDURE 276)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenBusPostingGroup(PROCEDURE 248)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenPostingType(PROCEDURE 246)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateBalGenProdPostingGroup(PROCEDURE 249)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenBusPostingGroup(PROCEDURE 240)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenPostingType(PROCEDURE 244)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateGenProdPostingGroup(PROCEDURE 241)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeValidateShortcutDimCode(PROCEDURE 261)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetFAVATSetupOnBeforeCheckGLAcc(PROCEDURE 247)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetCustLedgerEntryOnAfterAssignCustomerNo(PROCEDURE 242)".


    //Unsupported feature: Property Modification (Attributes) on "OnGetVendLedgerEntryOnAfterAssignVendorNo(PROCEDURE 243)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocCustOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 225)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterSetFilters(PROCEDURE 239)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocEmplOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 229)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterSetFilters(PROCEDURE 238)".


    //Unsupported feature: Property Modification (Attributes) on "OnLookUpAppliesToDocVendOnAfterUpdateDocumentTypeAndAppliesTo(PROCEDURE 227)".


    //Unsupported feature: Property Modification (Attributes) on "OnModifyOnBeforeTestCheckPrinted(PROCEDURE 293)".


    //Unsupported feature: Property Modification (Attributes) on "OnSetUpNewLineOnBeforeIncrDocNo(PROCEDURE 250)".


    //Unsupported feature: Property Modification (Attributes) on "OnUpdateLineBalanceOnAfterAssignBalanceLCY(PROCEDURE 226)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateAmountOnAfterAssignAmountLCY(PROCEDURE 222)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBalVATPctOnAfterAssignBalVATAmountLCY(PROCEDURE 224)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalculateDueDate(PROCEDURE 251)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidatePaymentTermsCodeOnBeforeCalculatePmtDiscountDate(PROCEDURE 252)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATBaseAmountOnBeforeValidateAmount(PROCEDURE 273)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATPctOnBeforeUpdateSalesPurchLCY(PROCEDURE 271)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateVATProdPostingGroupOnBeforeVATCalculationCheck(PROCEDURE 266)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateAccountNoOnAfterAssignValue(PROCEDURE 259)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateAccountNoOnBeforeAssignValue(PROCEDURE 258)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBalAccountNoOnAfterAssignValue(PROCEDURE 257)".


    //Unsupported feature: Property Modification (Attributes) on "OnValidateBalAccountNoOnBeforeAssignValue(PROCEDURE 255)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAccountID(PROCEDURE 1166)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateCustomerID(PROCEDURE 175)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateAppliesToInvoiceID(PROCEDURE 167)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateGraphContactId(PROCEDURE 170)".


    //Unsupported feature: Property Modification (Attributes) on "UpdateJournalBatchID(PROCEDURE 173)".


    //Unsupported feature: Property Modification (Attributes) on "UpdatePaymentMethodId(PROCEDURE 198)".


    //Unsupported feature: Property Modification (Attributes) on "OnGenJnlLineGetVendorAccount(PROCEDURE 1217)".


    local procedure CalcVATAmountLCY(): Decimal
    var
        LCYCurrency: Record 4;
        VATAmountLCY: Decimal;
    begin
        IF "Currency Code" = '' THEN
            EXIT("VAT Amount");

        LCYCurrency.InitRoundingPrecision;
        IF "VAT Difference" = 0 THEN
            VATAmountLCY :=
              ROUND("Amount (LCY)" * "VAT %" / (100 + "VAT %"), LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection)
        ELSE
            VATAmountLCY :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "VAT Amount", "Currency Factor"),
                LCYCurrency."Amount Rounding Precision", LCYCurrency.VATRoundingDirection);

        EXIT(VATAmountLCY);
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "ValidateAmount(PROCEDURE 223).ShouldCheckPaymentTolerance(Parameter 1000)".



    //Unsupported feature: Property Modification (OptionString) on ""Applies-to Doc. No."(Field 36).OnLookup.AccType(Variable 1002)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Applies-to Doc. No." : G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee,,,Provisión insolvencias,Cancelar provisión insol.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Applies-to Doc. No." : G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text006(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=The %1 option can only be used internally in the system.;ESM=La opción %1 es de uso interno del sistema.;FRC=L'option %1 ne peur être utilisée à l'intérieur du système.;ENC=The %1 option can only be used internally in the system.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=The %1 option can only be used internally in the system.;ESM=La opción %1 es de uso interno del sistema.;FRC=L'option %1 ne peut être utilisée qu'en interne par le système.;ENC=The %1 option can only be used internally in the system.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text011(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=%1 must be negative.;ESM=El %1 debe ser negativo.;FRC=%1 doit être négatif.;ENC=%1 must be negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=%1 must be negative.;ESM=El %1 debe ser negativo.;FRC=%1 doit être négatif/ve.;ENC=%1 must be negative.;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (TextConstString) on "Text012(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=%1 must be positive.;ESM=El %1 debe ser positivo.;FRC=%1 doit être positif.;ENC=%1 must be positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=%1 must be positive.;ESM=El %1 debe ser positivo.;FRC=%1 doit être positif/ve.;ENC=%1 must be positive.;
    //Variable type has not been exported.
}

