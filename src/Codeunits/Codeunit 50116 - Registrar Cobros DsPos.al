codeunit 50116 "Registrar Cobros DsPos"
{
    // Proyecto: Implementacion Business Central.
    // 
    // LDP: Luis Jose De La Cruz Paredes
    // ------------------------------------------------------------------------
    // No.        Fecha           Firma    Descripcion
    // ------------------------------------------------------------------------
    // 001       12-03-2024       LDP      Integracion DSPOS: Registro de cobros
    // 002       29-07-2024       LDP      SANTINAV-6732:Facturación Electronica DSPOS para migración a BC
    // 003       27-02-2026       LDP      SANTINAV-9039: Facturas sin registras DsPOS

    Permissions = TableData 112 = rim,
                  TableData 114 = rim,
                  TableData 50113 = rim;

    trigger OnRun()
    begin

        ProcesaNoLiquidados();
    end;

    var
        dImporte: Integer;
        ImporteNeto: Integer;
        ConfigEmpresa Record: 56001;
        rBankAccountLedgerEntry Record: 271;
        ImporteLiquidadoBanco: Decimal;
        ImporteTotalSic: Decimal;
        Message001: Label 'The invoice %1 has already been paid.';
        Message002: Label 'The sales credit memo %1 has already been settled.';
        Error003: Label '%1 está desactivado en Config. Santillana.';
        GenJnlLine Record: 81;
        GenJnlPostLine: Codeunit 12;
        OldCustLedgEntry Record: 21;
        NoLin: Integer;
        MediosdePagoMG Record: 50113;
        ConfMediosdepagos Record: 50110;
        Bancostienda Record: 34002504;
        SIH Record: 112;
        SCRM Record: 114;
        MontoIva: Decimal;
        MedPagoSIC Record: 50113;
        CustEntryApplyPostedEntries: Codeunit 226;
        DetailedCustLedgEntry Record: 379;
        BankAccountLedgerEntry Record: 271;
        CustLedgerEntry Record: 21;
        GeneralLedgerSetup Record: 98;

    [Scope('Personalization')]
    procedure RegistrarCobrosFacturaTPV(SalesInvHeader Record: 112")
    var
        Msg001: Label 'Liq. pago Doc. %1';
        Error001: Label 'No se ha liquidado Factura No. %1';
    begin
        NoLin := 0;
        dImporte := 0;
        ImporteNeto := 0;

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
        MediosdePagoMG.SETRANGE("Tipo documento", 1);
        MediosdePagoMG.SETRANGE("No. documento", SalesInvHeader."No.");
        MediosdePagoMG.SETRANGE("No. documento SIC", SalesInvHeader."No. Documento SIC");
        MediosdePagoMG.SETRANGE(Transferido, FALSE);//002+-
        MediosdePagoMG.SETFILTER(Importe, '<>%1', 0);
        IF MediosdePagoMG.FINDSET THEN BEGIN
            //003+ Ver si hay importe de clientes pendientes,
            //para saltar documentos que hayan aplicado notas de creditos o cobros desde BC+
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Document No.", SalesInvHeader."No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                //IF CustLedgerEntry."Remaining Amount" > 0 THEN BEGIN
                //003- Ver si hay importe de clientes pendientes+
                REPEAT
                    NoLin += 10000;
                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    IF ConfMediosdepagos.Credito THEN
                        EXIT;

                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SalesInvHeader.Tienda);
                    Bancostienda.SETRANGE("Cod. Divisa", '');//MediosdePagoMG."Cod. divisa"
                    IF Bancostienda.FINDFIRST THEN;

                    Bancostienda.TESTFIELD("Cod. Banco");
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
                    GenJnlLine."Document No." := SalesInvHeader."No.";
                    GenJnlLine."Posting Date" := SalesInvHeader."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SalesInvHeader."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SalesInvHeader."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE("Credit Amount", MediosdePagoMG.Importe);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SalesInvHeader."No.");
                    GenJnlLine.VALIDATE("External Document No.", SalesInvHeader."External Document No.");
                    GenJnlLine."Salespers./Purch. Code" := SalesInvHeader."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SalesInvHeader."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SalesInvHeader."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");

                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SalesInvHeader."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, TRUE);//034+-//01/01/2024
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Open := TRUE;
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;
                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                    MediosdePagoMG.Transferido := TRUE;//002+-
                    MediosdePagoMG.MODIFY;
                //END; //002+-
                UNTIL MediosdePagoMG.NEXT = 0;

                // 002+ Se marca como liquidado si los importes coinciden
                ImporteLiquidadoBanco := 0;
                ImporteTotalSic := 0;

                // Obtener importe liquidado del banco
                WITH rBankAccountLedgerEntry DO BEGIN
                    RESET;
                    SETRANGE("Document Type", "Document Type"::Payment);
                    SETRANGE("Document No.", SalesInvHeader."No.");
                    //SETRANGE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");
                    IF FINDSET THEN
                        REPEAT
                            ImporteLiquidadoBanco += "Amount (LCY)";
                        UNTIL NEXT = 0;
                END;

                // Obtener importe total SIC
                WITH MedPagoSIC DO BEGIN
                    RESET;
                    SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
                    SETRANGE("Tipo documento", 1);
                    SETRANGE("No. documento SIC", SalesInvHeader."No. Documento SIC");
                    SETFILTER(Importe, '<>%1', 0);
                    IF FINDSET THEN
                        REPEAT
                            ImporteTotalSic += Importe;
                        UNTIL NEXT = 0;
                END;

                // Comparar importes y marcar como liquidado si coinciden
                IF ABS(ImporteTotalSic - ImporteLiquidadoBanco) < 1 THEN BEGIN
                    WITH SIH DO BEGIN
                        RESET;
                        SETRANGE("No.", SalesInvHeader."No.");
                        IF FINDFIRST THEN BEGIN
                            "Liquidado TPV" := TRUE;
                            MODIFY;
                        END;
                    END;
                END;
                // 002- Se marca como liquidado si los importes coinciden
            END
        END;
    end;

    [Scope('Personalization')]
    procedure RegistrarCobrosNotaCreditoTPV(SalesCrMemoHeader Record: 114")
    var
        Msg001: Label 'Liq. pago Doc. %1';
        Errror001: Label 'No se ha liquidado NCR No. %1';
    begin
        NoLin := 0;
        dImporte := 0;
        ImporteNeto := 0;

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
        MediosdePagoMG.SETRANGE("Tipo documento", 2);
        MediosdePagoMG.SETRANGE("No. documento", SalesCrMemoHeader."No.");
        MediosdePagoMG.SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
        MediosdePagoMG.SETRANGE(Transferido, FALSE);//002+-
        MediosdePagoMG.SETFILTER(Importe, '<>%1', 0);
        IF MediosdePagoMG.FINDSET THEN BEGIN

            //003+ Ver si hay importe de clientes pendientes+
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                //IF CustLedgerEntry."Remaining Amount" > 0 THEN BEGIN
                //003- Ver si hay importe de clientes pendientes-

                REPEAT
                    NoLin += 10000;
                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SalesCrMemoHeader.Tienda);
                    Bancostienda.SETRANGE("Cod. Divisa", '');
                    IF Bancostienda.FINDFIRST THEN;
                    Bancostienda.TESTFIELD("Cod. Banco");
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine."Document No." := SalesCrMemoHeader."No.";
                    GenJnlLine."Posting Date" := SalesCrMemoHeader."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SalesCrMemoHeader."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SalesCrMemoHeader."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE(Amount, MediosdePagoMG.Importe);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::"Credit Memo");
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SalesCrMemoHeader."No.");
                    GenJnlLine.VALIDATE("External Document No.", SalesCrMemoHeader."Pre-Assigned No.");
                    GenJnlLine."Currency Factor" := SalesCrMemoHeader."Currency Factor";
                    GenJnlLine."Salespers./Purch. Code" := SalesCrMemoHeader."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SalesCrMemoHeader."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SalesCrMemoHeader."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");

                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, TRUE);
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Positive := FALSE;
                        OldCustLedgEntry.Open := TRUE;
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;

                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                    MediosdePagoMG.Transferido := TRUE;//002+-
                    MediosdePagoMG.MODIFY;
                //END; //002+-
                UNTIL MediosdePagoMG.NEXT = 0;

                // 002+ Se marca como liquidado si los importes coinciden
                ImporteLiquidadoBanco := 0;
                ImporteTotalSic := 0;

                // Obtener importe liquidado del banco
                WITH rBankAccountLedgerEntry DO BEGIN
                    RESET;
                    SETRANGE("Document Type", "Document Type"::Refund);
                    SETRANGE("Document No.", SalesCrMemoHeader."No.");
                    //SETRANGE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");
                    IF FINDSET THEN
                        REPEAT
                            ImporteLiquidadoBanco += "Amount (LCY)";
                        UNTIL NEXT = 0;
                END;

                // Obtener importe total SIC
                WITH MedPagoSIC DO BEGIN
                    RESET;
                    SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
                    SETRANGE("Tipo documento", 1);
                    SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
                    SETFILTER(Importe, '<>%1', 0);
                    IF FINDSET THEN
                        REPEAT
                            ImporteTotalSic += Importe;
                        UNTIL NEXT = 0;
                END;

                // Comparar importes y marcar como liquidado si coinciden
                IF ABS(ImporteTotalSic - ImporteLiquidadoBanco) < 1 THEN BEGIN
                    WITH SCRM DO BEGIN
                        RESET;
                        SETRANGE("No.", SalesCrMemoHeader."No.");
                        IF FINDFIRST THEN BEGIN
                            "Liquidado TPV" := TRUE;
                            MODIFY;
                        END;
                    END;
                END;
                // 002- Se marca como liquidado si los importes coinciden
            END;
        END;
    end;

    [Scope('Personalization')]
    procedure RegistrarCobrosFacturaTPVManual(SalesInvHeader Record: 112")
    var
        Msg001: Label 'Liq. pago Doc. %1';
        Error001: Label 'No existen líneas de pagos sic pendientes a liquidar para la factura %1';
        Error002: Label 'No existen líneas Medios de Pagos en tabla "Medios de Pagos SIC"';
    begin

        ConfigEmpresa.GET;
        IF NOT ConfigEmpresa."Liquidar Factura TPV" THEN
            ERROR(Error003, (ConfigEmpresa.FIELDCAPTION("Liquidar Factura TPV")));

        IF SalesInvHeader."Liquidado TPV" THEN BEGIN
            MESSAGE(Message001, SalesInvHeader."No.");
            EXIT;
        END;

        NoLin := 0;
        dImporte := 0;
        ImporteNeto := 0;

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
        MediosdePagoMG.SETRANGE("Tipo documento", 1);
        MediosdePagoMG.SETRANGE("No. documento", SalesInvHeader."No.");
        MediosdePagoMG.SETRANGE("No. documento SIC", SalesInvHeader."No. Documento SIC");
        MediosdePagoMG.SETRANGE(Transferido, FALSE);//002+-
        MediosdePagoMG.SETFILTER(Importe, '<>%1', 0);
        IF MediosdePagoMG.FINDSET THEN BEGIN

            //003+ Ver si hay importe de clientes pendientes+
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Document No.", SalesInvHeader."No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                //IF CustLedgerEntry."Remaining Amount" > 0 THEN BEGIN
                //003- Ver si hay importe de clientes pendientes-

                REPEAT
                    NoLin += 10000;
                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    IF ConfMediosdepagos.Credito THEN
                        EXIT;

                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SalesInvHeader.Tienda);
                    Bancostienda.SETRANGE("Cod. Divisa", '');//MediosdePagoMG."Cod. divisa"
                    IF Bancostienda.FINDFIRST THEN;

                    Bancostienda.TESTFIELD("Cod. Banco");
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Payment);
                    GenJnlLine."Document No." := SalesInvHeader."No.";
                    GenJnlLine."Posting Date" := SalesInvHeader."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SalesInvHeader."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SalesInvHeader."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE("Credit Amount", MediosdePagoMG.Importe);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::Invoice);
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SalesInvHeader."No.");
                    GenJnlLine.VALIDATE("External Document No.", SalesInvHeader."External Document No.");//034+-
                    GenJnlLine."Salespers./Purch. Code" := SalesInvHeader."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SalesInvHeader."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SalesInvHeader."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");

                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SalesInvHeader."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, TRUE);//034+-//01/01/2024
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Open := TRUE;
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;
                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                    MediosdePagoMG.Transferido := TRUE;//002+-
                    MediosdePagoMG.MODIFY;
                UNTIL MediosdePagoMG.NEXT = 0;

                // 002+ Se marca como liquidado si los importes coinciden
                ImporteLiquidadoBanco := 0;
                ImporteTotalSic := 0;

                // Obtener importe liquidado del banco
                WITH rBankAccountLedgerEntry DO BEGIN
                    RESET;
                    SETRANGE("Document Type", "Document Type"::Payment);
                    SETRANGE("Document No.", SalesInvHeader."No.");
                    //SETRANGE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");
                    IF FINDSET THEN
                        REPEAT
                            ImporteLiquidadoBanco += "Amount (LCY)";
                        UNTIL NEXT = 0;
                END;

                // Obtener importe total SIC
                WITH MedPagoSIC DO BEGIN
                    RESET;
                    SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
                    SETRANGE("Tipo documento", 1);
                    SETRANGE("No. documento SIC", SalesInvHeader."No. Documento SIC");
                    SETFILTER(Importe, '<>%1', 0);
                    IF FINDSET THEN
                        REPEAT
                            ImporteTotalSic += Importe;
                        UNTIL NEXT = 0;
                END;

                // Comparar importes y marcar como liquidado si coinciden
                IF ABS(ImporteTotalSic - ImporteLiquidadoBanco) < 1 THEN BEGIN
                    WITH SIH DO BEGIN
                        RESET;
                        SETRANGE("No.", SalesInvHeader."No.");
                        IF FINDFIRST THEN BEGIN
                            "Liquidado TPV" := TRUE;
                            MODIFY;
                        END;
                    END;
                END;
                // 002- Se marca como liquidado si los importes coinciden
            END;
        END ELSE
            MESSAGE(STRSUBSTNO(Error001, SalesInvHeader."No."));
    end;

    [Scope('Personalization')]
    procedure RegistrarCobrosNotaCreditoTPVManual(SalesCrMemoHeader Record: 114")
    var
        Msg001: Label 'Liq. pago Doc. %1';
        Error001: Label 'No existen líneas de pagos sic pendientes a liquidar para nota credito %1';
    begin
        ConfigEmpresa.GET;
        IF NOT ConfigEmpresa."Liquidar Nota Credito TPV" THEN
            ERROR(Error003, (ConfigEmpresa.FIELDCAPTION("Liquidar Nota Credito TPV")));

        IF SalesCrMemoHeader."Liquidado TPV" THEN BEGIN
            MESSAGE(Message002, SalesCrMemoHeader."No.");
            EXIT;
        END;

        NoLin := 0;
        dImporte := 0;
        ImporteNeto := 0;

        MediosdePagoMG.RESET;
        MediosdePagoMG.SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
        MediosdePagoMG.SETRANGE("Tipo documento", 2);
        MediosdePagoMG.SETRANGE("No. documento", SalesCrMemoHeader."No.");
        MediosdePagoMG.SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
        MediosdePagoMG.SETRANGE(Transferido, FALSE);//002+-
        MediosdePagoMG.SETFILTER(Importe, '<>%1', 0);//002+-
        IF MediosdePagoMG.FINDSET THEN BEGIN

            //003+ Ver si hay importe de clientes pendientes+
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            CustLedgerEntry.SETRANGE(Open, TRUE);
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                //IF CustLedgerEntry."Remaining Amount" > 0 THEN BEGIN
                //003- Ver si hay importe de clientes pendientes-

                REPEAT
                    NoLin += 10000;
                    ConfMediosdepagos.GET(MediosdePagoMG."Cod. medio de pago");
                    Bancostienda.RESET;
                    Bancostienda.SETRANGE("Cod. Tienda", SalesCrMemoHeader.Tienda);
                    Bancostienda.SETRANGE("Cod. Divisa", '');
                    IF Bancostienda.FINDFIRST THEN;
                    Bancostienda.TESTFIELD("Cod. Banco");
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    GenJnlLine."Line No." := NoLin;
                    GenJnlLine."Document No." := SalesCrMemoHeader."No.";
                    GenJnlLine."Posting Date" := SalesCrMemoHeader."Posting Date";
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::Customer);
                    GenJnlLine.VALIDATE("Account No.", SalesCrMemoHeader."Sell-to Customer No.");
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", Bancostienda."Cod. Banco");
                    GenJnlLine.Description := COPYSTR(STRSUBSTNO(Msg001, SalesCrMemoHeader."No." + ', ' + ConfMediosdepagos."Cod. Forma Pago"), 1, MAXSTRLEN(GenJnlLine.Description));
                    GenJnlLine.VALIDATE(Amount, MediosdePagoMG.Importe);
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
                    GenJnlLine.VALIDATE("Applies-to Doc. Type", GenJnlLine."Applies-to Doc. Type"::"Credit Memo");
                    GenJnlLine.VALIDATE("Applies-to Doc. No.", SalesCrMemoHeader."No.");
                    GenJnlLine.VALIDATE("External Document No.", SalesCrMemoHeader."Pre-Assigned No.");
                    GenJnlLine."Currency Factor" := SalesCrMemoHeader."Currency Factor";
                    GenJnlLine."Salespers./Purch. Code" := SalesCrMemoHeader."Salesperson Code";
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", SalesCrMemoHeader."Shortcut Dimension 1 Code");
                    GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", SalesCrMemoHeader."Shortcut Dimension 2 Code");
                    //GenJnlLine.VALIDATE("No. Tarjeta",MediosdePagoMG."Refencia Pago");//034+-Se inserta en numero de tarjeta del PUnto de Venta.
                    GenJnlLine.VALIDATE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");

                    OldCustLedgEntry.RESET;
                    OldCustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                    OldCustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                    OldCustLedgEntry.SETRANGE("Customer No.", SalesCrMemoHeader."Sell-to Customer No.");
                    OldCustLedgEntry.SETRANGE(Open, TRUE);
                    IF OldCustLedgEntry.FINDFIRST THEN BEGIN
                        OldCustLedgEntry.Positive := FALSE;
                        OldCustLedgEntry.Open := TRUE;//034+-
                        OldCustLedgEntry.MODIFY(TRUE);
                    END;

                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                    MediosdePagoMG.Transferido := TRUE;//002+-
                    MediosdePagoMG.MODIFY;
                UNTIL MediosdePagoMG.NEXT = 0;

                // 002+ Se marca como liquidado si los importes coinciden
                ImporteLiquidadoBanco := 0;
                ImporteTotalSic := 0;

                // Obtener importe liquidado del banco
                WITH rBankAccountLedgerEntry DO BEGIN
                    RESET;
                    SETRANGE("Document Type", "Document Type"::Refund);
                    SETRANGE("Document No.", SalesCrMemoHeader."No.");
                    //SETRANGE("Forma de Pago", ConfMediosdepagos."Cod. Forma Pago");
                    IF FINDSET THEN
                        REPEAT
                            ImporteLiquidadoBanco += "Amount (LCY)";
                        UNTIL NEXT = 0;
                END;

                // Obtener importe total SIC
                WITH MedPagoSIC DO BEGIN
                    RESET;
                    SETCURRENTKEY("Tipo documento", "No. documento", "No. documento SIC");
                    SETRANGE("Tipo documento", 1);
                    SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
                    SETFILTER(Importe, '<>%1', 0);
                    IF FINDSET THEN
                        REPEAT
                            ImporteTotalSic += Importe;
                        UNTIL NEXT = 0;
                END;

                // Comparar importes y marcar como liquidado si coinciden
                IF ABS(ImporteTotalSic - ImporteLiquidadoBanco) < 1 THEN BEGIN
                    WITH SCRM DO BEGIN
                        RESET;
                        SETRANGE("No.", SalesCrMemoHeader."No.");
                        IF FINDFIRST THEN BEGIN
                            "Liquidado TPV" := TRUE;
                            MODIFY;
                        END;
                    END;
                END;
                // 002- Se marca como liquidado si los importes coinciden
            END;
        END ELSE
            MESSAGE(STRSUBSTNO(Error001, SCRM."No."));
    end;

    procedure ProcesaNoLiquidados()
    var
        SalesInvoiceHeader Record: 112;
        SalesCrMemoHeader Record: 114;
        BankAccountLedgerEntry Record: 271;
        ImporteLiquidado: Decimal;
        FechaInicio: Date;
        CantidadDocs: Integer;
        MediosdePagoSIC Record: 50113;
    begin
        //SANTINAV-7551+ //LDP //04/02/2025
        //Facturas+
        //1. Buscar documentos no liquidados en SIH.

        //003+
        GeneralLedgerSetup.GET;
        CantidadDocs := 0;
        FechaInicio := 020226D;
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Venta TPV", TRUE);
        SalesInvoiceHeader.SETRANGE("Liquidado TPV", FALSE);
        SalesInvoiceHeader.SETFILTER("No. Documento SIC", '<>%1', '');
        SalesInvoiceHeader.SETFILTER("Posting Date", '>%1', GeneralLedgerSetup."Allow Posting From");
        //SalesInvoiceHeader.SETRANGE("Posting Date",GeneralLedgerSetup."Allow Posting From",GeneralLedgerSetup."Allow Posting To");
        CantidadDocs := SalesInvoiceHeader.COUNT;
        //003-
        IF SalesInvoiceHeader.FINDSET THEN
            REPEAT
            BEGIN
                //2. Validar que realmente no estén liquidados, no tenga un cobro en la tabla Movs. Banco (271).
                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE("Document Type", BankAccountLedgerEntry."Document Type"::Payment);
                BankAccountLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                IF NOT BankAccountLedgerEntry.FINDSET THEN BEGIN

                    MediosdePagoSIC.RESET;
                    MediosdePagoSIC.SETRANGE("No. documento SIC", SalesInvoiceHeader."No. Documento SIC");
                    MediosdePagoSIC.LOCKTABLE;
                    IF MediosdePagoSIC.FINDSET THEN
                        REPEAT
                            MediosdePagoSIC.Transferido := FALSE;
                            MediosdePagoSIC.MODIFY;
                        UNTIL MediosdePagoSIC.NEXT = 0;
                    COMMIT;
                    RegistrarCobrosFacturaTPV(SalesInvoiceHeader);
                END;
            END;
            UNTIL SalesInvoiceHeader.NEXT = 0;
        //Facturas-


        //Nota Credito+
        CantidadDocs := 0;
        SalesCrMemoHeader.RESET;
        SalesCrMemoHeader.SETRANGE("Venta TPV", TRUE);
        SalesCrMemoHeader.SETRANGE("Liquidado TPV", FALSE);
        SalesCrMemoHeader.SETFILTER("No. Documento SIC", '<>%1', '');
        //SalesCrMemoHeader.SETRANGE("Posting Date",GeneralLedgerSetup."Allow Posting From",GeneralLedgerSetup."Allow Posting To");
        //SalesCrMemoHeader.SETFILTER("Posting Date",'>%1',GeneralLedgerSetup."Allow Posting From");
        SalesCrMemoHeader.SETFILTER("Posting Date", '>%1', FechaInicio);

        CantidadDocs := SalesCrMemoHeader.COUNT;

        IF SalesCrMemoHeader.FINDSET THEN
            REPEAT
            BEGIN
                //2. Validar que realmente no estén liquidados, no tenga un cobro en la tabla Movs. Banco (271).
                BankAccountLedgerEntry.RESET;
                BankAccountLedgerEntry.SETRANGE("Document Type", BankAccountLedgerEntry."Document Type"::Refund);
                BankAccountLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");

                IF NOT BankAccountLedgerEntry.FINDSET THEN BEGIN

                    MediosdePagoSIC.RESET;
                    MediosdePagoSIC.SETRANGE("No. documento SIC", SalesCrMemoHeader."No. Documento SIC");
                    MediosdePagoSIC.LOCKTABLE;
                    IF MediosdePagoSIC.FINDSET THEN
                        REPEAT
                            MediosdePagoSIC.Transferido := FALSE;
                            MediosdePagoSIC.MODIFY(TRUE);
                        UNTIL MediosdePagoSIC.NEXT = 0;
                    COMMIT;
                    RegistrarCobrosNotaCreditoTPV(SalesCrMemoHeader);

                END;
            END;
            UNTIL SalesCrMemoHeader.NEXT = 0;
        //Nota Credito-
    end;
}

