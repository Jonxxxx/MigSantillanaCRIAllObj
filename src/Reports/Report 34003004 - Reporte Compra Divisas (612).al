report 34003004 "Reporte Compra Divisas (612)"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'src/ReportsLayout/Reporte Compra Divisas (612).rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; 271)
        {
            DataItemTableView = SORTING("Bank Account No.", "Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "Bank Account No.", "Posting Date", "Document No.", "Currency Code", "Reason Code";
            column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
            {
            }
            column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
            {
            }
            column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
            {
            }
            column(CurrencyCode_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Currency Code")
            {
            }
            column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
            {
            }
            column(AmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Amount (LCY)")
            {
            }
            column(NombreBanco; Bank.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ArchITBIS);
                Bank.GET("Bank Account No.");
                IF (STRPOS(Description, 'US') <> 0) OR
                   (STRPOS(Description, 'U$') <> 0) THEN
                    ArchITBIS."Numero Documento" := "Document No.";
                ArchITBIS."Fecha Documento" := FORMAT("Posting Date", 0, '<year4>') + FORMAT("Posting Date", 0, '<Month,2>') +
                                                         FORMAT("Posting Date", 0, '<day,2>');

                ArchITBIS.Apellidos := '01'; //Divisa Origen
                ArchITBIS.Nombres := '02'; //Divisa Destino
                ArchITBIS."Razon Social" := DELCHR(Bank.Name, '=', ',');
                ArchITBIS."Nombre Comercial" := ArchITBIS."Razon Social";
                //RNCTxt                                 := DELCHR(Bank."VAT Registration No.",'=','- ');
                IF STRLEN(RNCTxt) < 10 THEN
                    ArchITBIS.RNC := RNCTxt
                ELSE
                    ArchITBIS.Cedula := COPYSTR(RNCTxt, 1, 11);
                CLEAR(Tasa);
                IF STRPOS(UPPERCASE(Description), 'TASA DE') <> 0 THEN BEGIN
                    Tasa := COPYSTR(Description, (STRPOS(UPPERCASE(Description), 'TASA DE')), 10);
                    Tasa := DELCHR(Tasa, '=', ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ%$#@!~^&*()/');
                END;
                IF Tasa = '' THEN
                    Tasa := '0';
                EVALUATE(ArchITBIS."Total Documento", Tasa);
                ArchITBIS."ITBIS Pagado" := "Amount (LCY)";
                ArchITBIS."Codigo reporte" := '612';
                IF NOT ArchITBIS.INSERT THEN
                    ArchITBIS.MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        //IF "Bank Account Ledger Entry".GETFILTER("Reason Code") = '' THEN
        //  ERROR(Error001);

        ArchITBIS.RESET;
        ArchITBIS.SETRANGE("Codigo reporte", '612');
        ArchITBIS.DELETEALL;
    end;

    var
        Bank: Record 270;
        ArchITBIS: Record 34003004;
        RNCTxt: Text[100];
        Tasa: Text[30];
        Error001: Label 'Debe especificar cod. auditoria para divisas';
}

