tableextension 70000018 tableextension70000018 extends "Cust. Ledger Entry" 
{
    fields
    {
        modify("Global Dimension 1 Code")
        {
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Closed by Entry No.")
        {
            Caption = 'Closed by Entry No.';
        }
        modify("Closed by Amount (LCY)")
        {
            Caption = 'Closed by Amount ($)';
        }
        modify("Remaining Pmt. Disc. Possible")
        {
            Caption = 'Remaining Pmt. Disc. Possible';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }
        modify("Applies-to Ext. Doc. No.")
        {
            Caption = 'Applies-to Ext. Doc. No.';
        }
        modify("Direct Debit Mandate ID")
        {
            Caption = 'Direct Debit Mandate ID';
        }

        //Unsupported feature: Deletion (FieldCollection) on ""Forma de Pago"(Field 50013)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha Recepcion Documento"(Field 52500)".


        //Unsupported feature: Deletion (FieldCollection) on ""Collector Code"(Field 56000)".


        //Unsupported feature: Deletion (FieldCollection) on ""Importe provisionado"(Field 56026)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha ult. provision"(Field 56027)".


        //Unsupported feature: Deletion (FieldCollection) on ""Provisionado por insolvencia"(Field 56028)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal"(Field 34003001)".


        //Unsupported feature: Deletion (FieldCollection) on ""No. Comprobante Fiscal DPP"(Field 34003002)".


        //Unsupported feature: Deletion (FieldCollection) on ""Fecha vencimiento NCF DPP"(Field 34003007)".

        field(27002;"CFDI Cancellation Reason Code";Code[10])
        {
            Caption = 'CFDI Cancelation Reason Code';
            TableRelation = "CFDI Cancellation Reason";
        }
        field(27003;"Substitution Entry No.";Integer)
        {
            Caption = 'Substitution Entry No.';
            TableRelation = "Cust. Ledger Entry" WHERE (Document Type=FILTER(Payment),
                                                        Electronic Document Status=FILTER(Stamp Received));
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""External Document No.,Posting Date"(Key)".

    }

    //Unsupported feature: Property Modification (Attributes) on "ShowDoc(PROCEDURE 7)".


    //Unsupported feature: Property Modification (Attributes) on "ShowPostedDocAttachment(PROCEDURE 15)".


    //Unsupported feature: Property Modification (Attributes) on "HasPostedDocAttachment(PROCEDURE 16)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnEntries(PROCEDURE 1)".


    //Unsupported feature: Property Modification (Attributes) on "DrillDownOnOverdueEntries(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "DrillDownOnOverdueEntries(PROCEDURE 4)".

    //procedure DrillDownOnOverdueEntries();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CustLedgEntry.RESET;
        DtldCustLedgEntry.COPYFILTER("Customer No.",CustLedgEntry."Customer No.");
        DtldCustLedgEntry.COPYFILTER("Currency Code",CustLedgEntry."Currency Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 1",CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.COPYFILTER("Initial Entry Global Dim. 2",CustLedgEntry."Global Dimension 2 Code");
        CustLedgEntry.SETCURRENTKEY("Customer No.","Posting Date");
        CustLedgEntry.SETFILTER("Date Filter",'..%1',WORKDATE);
        CustLedgEntry.SETFILTER("Due Date",'<%1',WORKDATE);
        CustLedgEntry.SETFILTER("Remaining Amount",'<>%1',0);
        OnBeforeDrillDownOnOverdueEntries(CustLedgEntry,DtldCustLedgEntry);
        PAGE.RUN(0,CustLedgEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        CustLedgEntry.SETFILTER("Date Filter",'<%1',TODAY);
        CustLedgEntry.SETFILTER("Due Date",'<%1',TODAY);
        #9..11
        */
    //end;

    //Unsupported feature: Property Modification (Attributes) on "GetOriginalCurrencyFactor(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Attributes) on "GetAdjustedCurrencyFactor(PROCEDURE 14)".


    //Unsupported feature: Property Modification (Attributes) on "ShowDimensions(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Attributes) on "SetStyle(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Attributes) on "SetApplyToFilters(PROCEDURE 9)".


    //Unsupported feature: Property Modification (Attributes) on "SetAmountToApply(PROCEDURE 35)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromGenJnlLine(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Attributes) on "CopyFromCVLedgEntryBuffer(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Attributes) on "RecalculateAmounts(PROCEDURE 26)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromGenJnlLine(PROCEDURE 8)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterCopyCustLedgerEntryFromCVLedgEntryBuffer(PROCEDURE 11)".


    //Unsupported feature: Property Modification (Attributes) on "ExportEDocument(PROCEDURE 1020000)".


    //Unsupported feature: Property Modification (Attributes) on "RequestStampEDocument(PROCEDURE 1020001)".


    //Unsupported feature: Property Modification (Attributes) on "CancelEDocument(PROCEDURE 1020002)".


    //Unsupported feature: Property Modification (Attributes) on "OnAfterShowDoc(PROCEDURE 18)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownEntries(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Attributes) on "OnBeforeDrillDownOnOverdueEntries(PROCEDURE 13)".

}

