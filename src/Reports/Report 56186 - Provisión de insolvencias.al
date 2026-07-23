report 56186 "Provisión de insolvencias"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Provisión de insolvencias.rdlc';
    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; 18)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Exento Provision" = CONST(False),
                                      Blocked = CONST(" "));
            dataitem("Integer"; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                dataitem("Cust. Ledger Entry"; 21)
                {
                    DataItemTableView = SORTING("Customer No.", "Posting Date", Open, Provisionado por insolvencia);

                    trigger OnAfterGetRecord()
                    begin

                        CLEAR(GenJnlLine);
                        wLine += 10000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name" := JournalTemplate;
                        GenJnlLine."Journal Batch Name" := BatchName;
                        GenJnlLine."Line No." := wLine;
                        GenJnlLine.VALIDATE("Posting Date", PostingDate);
                        IF Reversion THEN BEGIN
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Cancelar Prov. Insol.";
                        END
                        ELSE BEGIN
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Provisión Insolvencias";
                        END;
                        GenJnlLine."Document No." := 'INSOLV' + FORMAT(PostingDate);
                        GenJnlLine.VALIDATE("Account No.", "Cust. Ledger Entry"."Customer No.");
                        GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine.VALIDATE("Applies-to Doc. No.", "Cust. Ledger Entry"."Document No.");
                        IF GenJnlLine.Amount = 0 THEN
                            CurrReport.SKIP;
                        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.", CtaGastos);
                        GenJnlLine.INSERT(TRUE);
                        IF (Reversion) AND (FechaInicioPeriodo <> 0D) THEN BEGIN
                            SETFILTER("Date Filter", '<%1', FechaInicioPeriodo);
                            CALCFIELDS("Importe provisionado");
                            ImporteProvisionAnterior := "Importe provisionado";
                            SETRANGE("Date Filter");
                            IF ImporteProvisionAnterior = GenJnlLine.Amount THEN BEGIN
                                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.", CtaIngresos);
                                GenJnlLine.MODIFY;
                            END
                            ELSE
                                IF ImporteProvisionAnterior <> 0 THEN BEGIN
                                    GenJnlLine.VALIDATE(Amount, GenJnlLine.Amount - ImporteProvisionAnterior);
                                    GenJnlLine.MODIFY;
                                    wLine += 10000;
                                    CLEAR(GenJnlLine2);
                                    GenJnlLine2 := GenJnlLine;
                                    GenJnlLine2."Document Date" := FechaInicioPeriodo - 1;
                                    GenJnlLine2."Line No." := wLine;
                                    GenJnlLine2.VALIDATE(Amount, ImporteProvisionAnterior);
                                    GenJnlLine2.VALIDATE("Bal. Account No.", CtaIngresos);
                                    GenJnlLine2.INSERT;
                                END;
                        END;
                        IF (NOT Reversion) AND (FechaInicioPeriodo <> 0D) AND (GenJnlLine.Amount > 0) THEN BEGIN
                            SETFILTER("Date Filter", '>=%1', FechaInicioPeriodo);
                            CALCFIELDS("Importe provisionado");
                            ImpProvPeriodoActual := "Importe provisionado";
                            IF ImpProvPeriodoActual < GenJnlLine.Amount THEN BEGIN
                                IF ImpProvPeriodoActual > 0 THEN BEGIN
                                    ImporteProvisionAnterior := GenJnlLine.Amount - ImpProvPeriodoActual;
                                    GenJnlLine.VALIDATE(Amount, ImpProvPeriodoActual);
                                    GenJnlLine.MODIFY;
                                    wLine += 10000;
                                    CLEAR(GenJnlLine2);
                                    GenJnlLine2 := GenJnlLine;
                                    GenJnlLine2."Line No." := wLine;
                                    GenJnlLine2."Document Date" := FechaInicioPeriodo - 1;
                                    GenJnlLine2.VALIDATE(Amount, ImporteProvisionAnterior);
                                    GenJnlLine2.VALIDATE("Bal. Account No.", CtaIngresos);
                                    GenJnlLine2.INSERT;
                                END;
                                IF ImpProvPeriodoActual = 0 THEN BEGIN
                                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.", CtaIngresos);
                                    GenJnlLine.MODIFY;
                                END;
                            END;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin

                        SETRANGE("Customer No.", Customer."No.");
                        SETRANGE("Document Type", "Document Type"::Invoice);
                        IF Reversion THEN BEGIN
                            SETRANGE(Open, FALSE);
                            SETRANGE("Cust. Ledger Entry"."Provisionado por insolvencia", TRUE);
                        END ELSE BEGIN
                            SETRANGE(Open, TRUE);
                            SETRANGE("Provisionado por insolvencia");
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    IF Number = 1 THEN
                        Reversion := FALSE
                    ELSE
                        Reversion := TRUE;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Integer.Number, 1, 2);
                end;
            }

            trigger OnAfterGetRecord()
            begin

                wcont += 1;
                Ventana.UPDATE(1, Customer."No.");
                Ventana.UPDATE(3, wcont);
            end;

            trigger OnPostDataItem()
            begin
                Ventana.CLOSE;
            end;

            trigger OnPreDataItem()
            begin

                IF PostingDate = 0D THEN ERROR(Text004, Text005);
                IF BatchName = '' THEN ERROR(Text004, Text006);
                IF JournalTemplate = '' THEN ERROR(Text004, Text007);


                rConf.GET;
                rConf.TESTFIELD("Cta. Ingresos Prov. Insolv.");
                rConf.TESTFIELD("Cta. Gastos Prov. Insolv.");
                CtaGastos := rConf."Cta. Gastos Prov. Insolv.";
                CtaIngresos := rConf."Cta. Ingresos Prov. Insolv.";


                CLEAR(wcont);
                Periodo;
                GetLastLine;
                TotalCli := Customer.COUNT;
                Ventana.OPEN(Text001 +
                             Text002);
                Ventana.UPDATE(4, TotalCli);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                    }
                    field(JournalTemplate; JournalTemplate)
                    {
                        Caption = 'Journal Template';
                        TableRelation = "Gen. Journal Batch".Name;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GenJnlTemplates: Page 101;
                            GenJnlTemplate: Record 80;
                        begin
                            GenJnlTemplate.SETRANGE(Type, GenJnlTemplate.Type::"Cash Receipts");
                            GenJnlTemplate.SETRANGE(Recurring, FALSE);
                            GenJnlTemplates.SETTABLEVIEW(GenJnlTemplate);

                            GenJnlTemplates.LOOKUPMODE := TRUE;
                            GenJnlTemplates.EDITABLE := FALSE;
                            IF GenJnlTemplates.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GenJnlTemplates.GETRECORD(GenJnlTemplate);
                                JournalTemplate := GenJnlTemplate.Name;
                            END;
                        end;
                    }
                    field(BatchName; BatchName)
                    {
                        Caption = 'Batch Name';
                        TableRelation = "Gen. Journal Batch".Name;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GenJnlBatches: Page 251;
                        begin
                            IF JournalTemplate <> '' THEN BEGIN
                                GenJnlBatch.SETRANGE("Journal Template Name", JournalTemplate);
                                GenJnlBatches.SETTABLEVIEW(GenJnlBatch);
                            END;

                            GenJnlBatches.LOOKUPMODE := TRUE;
                            GenJnlBatches.EDITABLE := FALSE;
                            IF GenJnlBatches.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GenJnlBatches.GETRECORD(GenJnlBatch);
                                BatchName := GenJnlBatch.Name;
                            END;
                        end;
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

    var
        GenJnlBatch: Record 232;
        GenJnlLine: Record 81;
        PostingDate: Date;
        BatchName: Code[20];
        JournalTemplate: Text[10];
        Reversion: Boolean;
        CtaGastos: Code[20];
        CtaIngresos: Code[20];
        PorcProvision: Decimal;
        ImporteProvision: Decimal;
        FechaInicioPeriodo: Date;
        ImporteProvisionAnterior: Decimal;
        GenJnlLine2: Record 81;
        wLine: Integer;
        Ventana: Dialog;
        TotalCli: Integer;
        wcont: Integer;
        rConf: Record 56001;
        ImpProvPeriodoActual: Decimal;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Procesando #3######### de #4#########\\';
        Text002: Label 'Cliente #1#################\\';
        Text003: Label 'Factura #2#################\\';
        Text004: Label 'Se requiere introducir %1.';
        Text005: Label 'la fecha de registro';
        Text006: Label 'el libro dario';
        Text007: Label 'el nombre de la sección';
        Text008: Label 'la cuenta de gastos';
        Text009: Label 'la cuenta de ingresos';

    procedure Periodo()
    var
        AccountPeriod: Record 50;
    begin
        FechaInicioPeriodo := 0D;
        AccountPeriod.SETFILTER("Starting Date", '<=%1', PostingDate);
        IF AccountPeriod.FINDLAST THEN
            FechaInicioPeriodo := AccountPeriod."Starting Date";
    end;

    procedure ImporteProvAnterior()
    var
        CustLedEntry: Record 21;
    begin
    end;

    procedure GetLastLine()
    begin

        CLEAR(wLine);
        GenJnlLine.LOCKTABLE;
        GenJnlLine.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine.SETRANGE("Journal Batch Name", BatchName);
        IF GenJnlLine.FINDLAST THEN
            wLine := GenJnlLine."Line No.";
        GenJnlLine.RESET;
    end;
}

