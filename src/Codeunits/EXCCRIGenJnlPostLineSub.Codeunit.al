codeunit 61001 EXCCRIGenJnlPostLineSub
{
    Permissions =
        tabledata "Cust. Ledger Entry" = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(
        var GLEntry: Record "G/L Entry";
        GenJournalLine: Record "Gen. Journal Line";
        Amount: Decimal;
        AddCurrAmount: Decimal;
        UseAddCurrAmount: Boolean;
        var CurrencyFactor: Decimal;
        var GLRegister: Record "G/L Register")
    var
        CustomerNo: Code[20];
    begin
        GLEntry."No. Comprobante Fiscal" := GenJournalLine."No. Comprobante Fiscal";
        GLEntry."Cod. Clasificacion Gasto" := GenJournalLine."Cod. Clasificacion Gasto";
        GLEntry."Fecha vencimiento NCF" := GenJournalLine."Fecha vencimiento NCF";
        GLEntry."Tipo de ingreso" := GenJournalLine."Tipo de ingreso";
        GLEntry.RNC := GenJournalLine."VAT Registration No.";

        if EXCCRIGetActiveInsolvencyContext(GenJournalLine, CustomerNo) then begin
            GLEntry."Source Type" := GLEntry."Source Type"::Customer;
            GLEntry."Source No." := CustomerNo;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure OnBeforeCustLedgEntryInsert(
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        var GenJournalLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register";
        var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        var NextEntryNo: Integer)
    begin
        CustLedgerEntry."Forma de Pago" := GenJournalLine."Forma de Pago";
        CustLedgerEntry."No. Comprobante Fiscal" := GenJournalLine."No. Comprobante Fiscal";
        CustLedgerEntry."Collector Code" := GenJournalLine."Collector Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeVendLedgEntryInsert', '', false, false)]
    local procedure OnBeforeVendLedgEntryInsert(
        var VendorLedgerEntry: Record "Vendor Ledger Entry";
        var GenJournalLine: Record "Gen. Journal Line";
        GLRegister: Record "G/L Register")
    begin
        VendorLedgerEntry."No. Comprobante Fiscal" := GenJournalLine."No. Comprobante Fiscal";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry(
        var BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."Forma de Pago" := GenJournalLine."Forma de Pago";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldCustLedgEntry', '', false, false)]
    local procedure OnAfterInsertDtldCustLedgEntry(
        var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GenJournalLine: Record "Gen. Journal Line";
        DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer";
        Offset: Integer)
    begin
        if DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Payment Discount" then
            exit;

        EXCCRICreatePmtDiscCreditMemo(DtldCustLedgEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(
        var GenJournalLine: Record "Gen. Journal Line";
        Balancing: Boolean)
    var
        ContextKey: Text;
        CustomerNo: Code[20];
    begin
        if not EXCCRIIsInsolvencyAccountType(GenJournalLine."Account Type") then
            exit;

        ContextKey := EXCCRIGetContextKey(GenJournalLine, Balancing);
        CustomerNo := GenJournalLine."Account No.";

        //TODO: Ver
        /*
        if GenJournalLine."Account Type" = GenJournalLine."Account Type"::"Provision Insolvencias" then begin
            EXCCRIProvisionContext.Remove(ContextKey);
            EXCCRIProvisionContext.Add(ContextKey, CustomerNo);
        end else begin
            EXCCRICancelProvisionContext.Remove(ContextKey);
            EXCCRICancelProvisionContext.Add(ContextKey, CustomerNo);
        end;*/

        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine."Account No." := EXCCRIGetProvisionAccount(CustomerNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnPostGLAccOnBeforeInsertGLEntry(
        var GenJournalLine: Record "Gen. Journal Line";
        var GLEntry: Record "G/L Entry";
        var IsHandled: Boolean;
        Balancing: Boolean)
    var
        CustomerNo: Code[20];
        IsProvision: Boolean;
    begin
        EXCCRISetBalancingProvisionAccount(GenJournalLine, GLEntry);

        if not EXCCRIGetInsolvencyContext(
            GenJournalLine,
            Balancing,
            CustomerNo,
            IsProvision)
        then
            exit;

        EXCCRIUpdateInsolvencyEntry(
            GenJournalLine,
            GLEntry,
            CustomerNo,
            IsProvision);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGenJnlLine', '', false, false)]
    local procedure OnAfterPostGenJnlLine(
        var GenJournalLine: Record "Gen. Journal Line";
        Balancing: Boolean)
    var
        ContextKey: Text;
        CustomerNo: Code[20];
    begin
        ContextKey := EXCCRIGetContextKey(GenJournalLine, Balancing);

        if EXCCRIProvisionContext.Get(ContextKey, CustomerNo) then begin
            //TODO: Ver GenJournalLine."Account Type" :=
            //TODO: Ver    GenJournalLine."Account Type"::"Provision Insolvencias";
            GenJournalLine."Account No." := CustomerNo;
            EXCCRIProvisionContext.Remove(ContextKey);
            exit;
        end;

        if EXCCRICancelProvisionContext.Get(ContextKey, CustomerNo) then begin
            //TODO: Ver GenJournalLine."Account Type" :=
            //TODO: Ver     GenJournalLine."Account Type"::"Cancelar Prov. Insol.";
            GenJournalLine."Account No." := CustomerNo;
            EXCCRICancelProvisionContext.Remove(ContextKey);
        end;
    end;

    local procedure EXCCRIIsInsolvencyAccountType(
        AccountType: Enum "Gen. Journal Account Type"): Boolean
    begin
        //TODO: Ver 
        /*
        exit(
            AccountType in
            [
                AccountType::"Provision Insolvencias",
                AccountType::"Cancelar Prov. Insol."
            ]);*/
    end;

    local procedure EXCCRIGetProvisionAccount(CustomerNo: Code[20]): Code[20]
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
    begin
        Customer.Get(CustomerNo);
        Customer.TestField("Customer Posting Group");

        CustomerPostingGroup.Get(Customer."Customer Posting Group");
        CustomerPostingGroup.TestField("Cta. Dotacion Provision insolv");

        exit(CustomerPostingGroup."Cta. Dotacion Provision insolv");
    end;

    local procedure EXCCRISetBalancingProvisionAccount(
        GenJournalLine: Record "Gen. Journal Line";
        var GLEntry: Record "G/L Entry")
    begin
        if not EXCCRIIsInsolvencyAccountType(GenJournalLine."Bal. Account Type") then
            exit;

        GLEntry."Bal. Account Type" := GLEntry."Bal. Account Type"::"G/L Account";
        GLEntry."Bal. Account No." :=
            EXCCRIGetProvisionAccount(GenJournalLine."Bal. Account No.");
    end;

    local procedure EXCCRIUpdateInsolvencyEntry(
        GenJournalLine: Record "Gen. Journal Line";
        var GLEntry: Record "G/L Entry";
        CustomerNo: Code[20];
        IsProvision: Boolean)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        GLEntry."Source Type" := GLEntry."Source Type"::Customer;
        GLEntry."Source No." := CustomerNo;

        if GenJournalLine."Applies-to Doc. No." = '' then
            exit;

        CustLedgerEntry.SetRange(
            "Document Type",
            GenJournalLine."Applies-to Doc. Type");
        CustLedgerEntry.SetRange(
            "Document No.",
            GenJournalLine."Applies-to Doc. No.");

        if not CustLedgerEntry.FindFirst() then
            exit;

        CustLedgerEntry.CalcFields("Importe provisionado");
        GLEntry."No. Mov. cliente provisionado" :=
            CustLedgerEntry."Entry No.";
        CustLedgerEntry."Provisionado por insolvencia" := IsProvision;
        CustLedgerEntry."Fecha ult. provision" :=
            GenJournalLine."Posting Date";
        CustLedgerEntry.Modify();
    end;

    local procedure EXCCRIGetInsolvencyContext(
        GenJournalLine: Record "Gen. Journal Line";
        Balancing: Boolean;
        var CustomerNo: Code[20];
        var IsProvision: Boolean): Boolean
    var
        ContextKey: Text;
    begin
        ContextKey := EXCCRIGetContextKey(GenJournalLine, Balancing);

        if EXCCRIProvisionContext.Get(ContextKey, CustomerNo) then begin
            IsProvision := true;
            exit(true);
        end;

        if EXCCRICancelProvisionContext.Get(ContextKey, CustomerNo) then begin
            IsProvision := false;
            exit(true);
        end;

        exit(false);
    end;

    local procedure EXCCRIGetActiveInsolvencyContext(
        GenJournalLine: Record "Gen. Journal Line";
        var CustomerNo: Code[20]): Boolean
    var
        IsProvision: Boolean;
    begin
        if EXCCRIGetInsolvencyContext(
            GenJournalLine,
            false,
            CustomerNo,
            IsProvision)
        then
            exit(true);

        exit(
            EXCCRIGetInsolvencyContext(
                GenJournalLine,
                true,
                CustomerNo,
                IsProvision));
    end;

    local procedure EXCCRIGetContextKey(
        GenJournalLine: Record "Gen. Journal Line";
        Balancing: Boolean): Text
    begin
        exit(
            StrSubstNo(
                '%1|%2|%3|%4|%5|%6',
                GenJournalLine."Journal Template Name",
                GenJournalLine."Journal Batch Name",
                GenJournalLine."Line No.",
                GenJournalLine."Document No.",
                Format(GenJournalLine."Posting Date", 0, 9),
                Format(Balancing, 0, 9)));
    end;

    local procedure EXCCRICreatePmtDiscCreditMemo(
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        NoSeriesLine: Record "No. Series Line";
        NoSeries: Codeunit "No. Series";
    begin
        if not Customer.Get(DtldCustLedgEntry."Customer No.") then
            exit;

        if not CustomerPostingGroup.Get(Customer."Customer Posting Group") then
            exit;

        if not CustomerPostingGroup."Permite emitir NCF" then
            exit;

        CustLedgerEntry.SetRange(
            "Closed by Entry No.",
            DtldCustLedgEntry."Cust. Ledger Entry No.");
        CustLedgerEntry.SetFilter(
            "Pmt. Disc. Given (LCY)",
            '>0');

        if not CustLedgerEntry.FindSet(true) then
            exit;

        repeat
            Customer.TestField("VAT Registration No.");
            CustomerPostingGroup.TestField(
                "No. Serie NCF Abonos Venta");

            CustLedgerEntry."No. Comprobante Fiscal DPP" :=
                NoSeries.GetNextNo(
                    CustomerPostingGroup."No. Serie NCF Abonos Venta",
                    DtldCustLedgEntry."Posting Date");

            Clear(NoSeriesLine);
            NoSeriesLine.SetRange(
                "Series Code",
                CustomerPostingGroup."No. Serie NCF Abonos Venta");
            NoSeriesLine.SetFilter(
                "Starting Date",
                '>=%1',
                DMY2Date(1, 5, 2018));
            NoSeriesLine.SetRange(Open, true);

            if NoSeriesLine.FindFirst() then
                if
                    (DtldCustLedgEntry."Posting Date" >
                     NoSeriesLine."Expiration date") and
                    (NoSeriesLine."Expiration date" <> 0D)
                then
                    Error(
                        EXCCRINCFExpirationErr,
                        DtldCustLedgEntry.FieldCaption("Posting Date"),
                        NoSeriesLine.FieldCaption("Expiration date"),
                        DtldCustLedgEntry."Posting Date",
                        NoSeriesLine."Expiration date");

            CustLedgerEntry."Fecha vencimiento NCF DPP" :=
                NoSeriesLine."Expiration date";
            CustLedgerEntry.Modify();
        until CustLedgerEntry.Next() = 0;
    end;

    var
        EXCCRIProvisionContext: Dictionary of [Text, Code[20]];
        EXCCRICancelProvisionContext: Dictionary of [Text, Code[20]];
        EXCCRINCFExpirationErr: Label
            '%1 cannot be later than %2 of the NCF number series. The corresponding values are %3 and %4.';
}
