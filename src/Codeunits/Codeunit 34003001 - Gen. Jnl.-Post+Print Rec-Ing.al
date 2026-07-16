codeunit 34003001 "Gen. Jnl.-Post+Print Rec-Ing"
{
    // Proyecto: Microsoft Dynamics Nav 2009
    // AMS     : Agustin Mendez
    // --------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001     15-Enero-09     AMS           Para poder encontrar el ultimo
    //                                       Doc. Banco para imprimir el Recibo
    //                                       de ingreso

    TableNo = 81;

    trigger OnRun()
    begin
        GenJnlLine.COPY(Rec);
        Code;
        Rec.COPY(GenJnlLine);
    end;

    var
        Text000: Label 'cannot be filtered when posting recurring journals';
        Text001: Label 'Do you want to post the journal lines and print the report(s)?';
        Text002: Label 'There is nothing to post.';
        Text003: Label 'The journal lines were successfully posted.';
        Text004: Label 'The journal lines were successfully posted. You are now in the %1 journal.';
        GenJnlTemplate: Record 80;
        GenJnlLine: Record 81;
        GLReg: Record 45;
        CustLedgEntry: Record 21;
        VendLedgEntry: Record 25;
        GenJnlPostBatch: Codeunit 13;
        TempJnlBatchName: Code[10];
        "**001***": Integer;
        rBankAcc: Record 271;
        rMovCont: Record 17;

    local procedure "Code"()
    begin
        WITH GenJnlLine DO BEGIN
            GenJnlTemplate.GET("Journal Template Name");
            IF GenJnlTemplate."Force Posting Report" OR
               (GenJnlTemplate."Cust. Receipt Report ID" = 0) AND (GenJnlTemplate."Vendor Receipt Report ID" = 0)
            THEN
                GenJnlTemplate.TESTFIELD("Posting Report ID");
            IF GenJnlTemplate.Recurring AND (GETFILTER("Posting Date") <> '') THEN
                FIELDERROR("Posting Date", Text000);

            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;

            TempJnlBatchName := "Journal Batch Name";

            GenJnlPostBatch.RUN(GenJnlLine);

            IF GLReg.GET("Line No.") THEN BEGIN
                IF GenJnlTemplate."Cust. Receipt Report ID" <> 0 THEN BEGIN
                    CustLedgEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                    //001 REPORT.RUN(GenJnlTemplate."Cust. Receipt Report ID",FALSE,FALSE,CustLedgEntry);
                END;
                IF GenJnlTemplate."Vendor Receipt Report ID" <> 0 THEN BEGIN
                    VendLedgEntry.SETRANGE("Entry No.", GLReg."From Entry No.", GLReg."To Entry No.");
                    REPORT.RUN(GenJnlTemplate."Vendor Receipt Report ID", FALSE, FALSE, VendLedgEntry);
                END;
                //001 IF GenJnlTemplate."Posting Report ID" <> 0 THEN BEGIN
                //001  GLReg.SETRECFILTER;
                //001  REPORT.RUN(GenJnlTemplate."Posting Report ID",FALSE,FALSE,GLReg);
                //001 END;
            END;
            //001
            IF rMovCont.GET(GLReg."To Entry No.") THEN BEGIN
                rBankAcc.RESET;
                rBankAcc.SETRANGE(rBankAcc."Bank Account No.", rMovCont."Bal. Account No.");
                rBankAcc.SETRANGE(rBankAcc."Posting Date", rMovCont."Posting Date");
                rBankAcc.SETRANGE(rBankAcc."Document Type", rMovCont."Document Type");
                rBankAcc.SETRANGE(rBankAcc."Document No.", rMovCont."Document No.");
                COMMIT;
                REPORT.RUN(34003000, TRUE, FALSE, rBankAcc);
            END;
            //001


            IF "Line No." = 0 THEN
                MESSAGE(Text002)
            ELSE
                IF TempJnlBatchName = "Journal Batch Name" THEN
                    MESSAGE(Text003)
                ELSE
                    MESSAGE(
                      Text004,
                      "Journal Batch Name");

            IF NOT FIND('=><') OR (TempJnlBatchName <> "Journal Batch Name") THEN BEGIN
                RESET;
                FILTERGROUP(2);
                SETRANGE("Journal Template Name", "Journal Template Name");
                SETRANGE("Journal Batch Name", "Journal Batch Name");
                FILTERGROUP(0);
                "Line No." := 1;
            END;
        END;
    end;
}

