codeunit 34003007 "Envios de notificaciones"
{

    trigger OnRun()
    begin
    end;

    var
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        User: Record User;
        Asunto: Text[250];
        TextoBody: Text;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        AsciiStr: Text[250];
        AnsiStr: Text[250];
        Msg001: Label 'Se han enviado los correos de forma satisfactoria';
        EmailSendErr: Label 'The email could not be sent. Verify the email account configuration in Business Central.';

    procedure EnviaEmailEstCta(var Cust: Record Customer)
    var
        Cust2: Record Customer;
        CLE: Record "Cust. Ledger Entry";
        Divisa: Record Currency;
        Text001: Label '%1 - Statement of Balance Balance with %2';
        Text002: Label 'Mr.: %1';
        Text003: Label 'Attached the Aging Balance status with %1, with the following summary:';
        Text008: Label 'Please proceed with the payment of to due balance update your account.';
        Empresa: Text[65];
        Text009: Label 'Last payment date: %1';
        BalTotal: Decimal;
        Text010: Label 'Sending  @1@@@@@@@@@@@@@ \Customer  #2##############################';
        BalVencido: Decimal;
        FechaUltPago: Text;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        IF NOT Cust.FINDSET THEN
            EXIT;

        Cust.TESTFIELD("E-Mail");
        Counter := 0;
        Empresa := COPYSTR(COMPANYNAME, STRPOS(COMPANYNAME, '-') + 1, STRLEN(COMPANYNAME));

        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("E-Mail");
        User.RESET;
        User.SETRANGE("User Name", USERID);
        User.FINDFIRST;
        CounterTotal := Cust.COUNT;
        IF GUIALLOWED THEN
            Window.OPEN(Text010);
        REPEAT
            Counter := Counter + 1;
            IF GUIALLOWED THEN BEGIN
                Window.UPDATE(2, Cust.Name);
                Window.UPDATE(1, ROUND(Counter / CounterTotal * 10000, 1));
            END;
            Cust2.RESET;
            Cust2.SETRANGE("No.", Cust."No.");
            Cust2.SETRANGE("Date Filter", 0D, WORKDATE);
            Cust2.FINDFIRST;
            Cust2.CALCFIELDS("Balance Due (LCY)", "Balance (LCY)");

            CLEAR(FechaUltPago);
            CLE.RESET;
            CLE.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date", "Currency Code");
            CLE.SETRANGE("Customer No.", Cust."No.");
            CLE.SETFILTER("Document Type", '<>%1', CLE."Document Type"::"Credit Memo");
            CLE.SETRANGE(Positive, FALSE);
            CLE.SETFILTER("Original Amount", '<%1', 0);
            IF NOT CLE.FINDLAST THEN
                CLE.INIT
            ELSE
                FechaUltPago := FORMAT(CLE."Posting Date", 0, '<Day,2> <Month Text> <Year4>');

            Asunto := STRSUBSTNO(Text001, Cust."No.", Empresa);

            TextoBody := '<br>' + STRSUBSTNO(Text002, Cust.Name) + '<br>' + '<br>' + STRSUBSTNO(Text003, Empresa) + '<br>' + '<br>';

            TextoBody += '<table border="1"><background-color:gold;>' + '<tr>' + STRSUBSTNO('<td><b>%1<b></td>', 'Divisa') + STRSUBSTNO('<td><b>%1<b></td>', 'Balance al corte') +
                          STRSUBSTNO('<td align="right"><b>%1<b></td>', 'Balance vencido') + '</tr>';
            BalTotal := 0;
            BalVencido := 0;
            CLE.RESET;
            CLE.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
            CLE.SETRANGE("Customer No.", Cust."No.");
            CLE.SETRANGE(Open, TRUE);
            CLE.SETRANGE("Currency Code", '');
            IF CLE.FINDSET THEN
                REPEAT
                    CLE.CALCFIELDS("Remaining Amount");
                    BalTotal += CLE."Remaining Amount";
                    IF CLE."Due Date" < TODAY THEN
                        BalVencido += CLE."Remaining Amount";
                UNTIL CLE.NEXT = 0;

            IF BalTotal <> 0 THEN BEGIN
                TextoBody += '<tr>';
                TextoBody += STRSUBSTNO('<td align="left">%1</td>', 'RD$ ');
                TextoBody += STRSUBSTNO('<td align="right">%1</td>', BalTotal);
                TextoBody += STRSUBSTNO('<td align="right">%1</td>', BalVencido);
                TextoBody += '</tr>';
            END;

            BalTotal := 0;
            BalVencido := 0;
            Divisa.FIND('-');
            REPEAT
                BalTotal := 0;
                BalVencido := 0;
                CLE.RESET;
                CLE.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                CLE.SETRANGE("Customer No.", Cust."No.");
                CLE.SETRANGE(Open, TRUE);
                CLE.SETRANGE("Currency Code", Divisa.Code);
                IF CLE.FINDSET THEN
                    REPEAT
                        CLE.CALCFIELDS("Remaining Amount");
                        BalTotal += CLE."Remaining Amount";
                        IF CLE."Due Date" < TODAY THEN
                            BalVencido += CLE."Remaining Amount";
                    UNTIL CLE.NEXT = 0;
                IF BalTotal <> 0 THEN BEGIN
                    TextoBody += '<tr>';
                    TextoBody += STRSUBSTNO('<td align="left">%1</td>', Divisa.Symbol);
                    TextoBody += STRSUBSTNO('<td align="right">%1</td>', BalTotal);
                    TextoBody += STRSUBSTNO('<td align="right">%1</td>', BalVencido);
                    TextoBody += '</tr>';
                END;

            UNTIL Divisa.NEXT = 0;
            TextoBody += '</table>';
            TextoBody += '<br><br>';

            TextoBody += STRSUBSTNO(Text009, FechaUltPago) + '<br>' + '<br>' + Text008 + '<br>' + '<br>' + USERID + '<br>' + '<br>';

            TextoBody += '</table>';
            TextoBody += '<br><br>';
            Cust.TESTFIELD("E-Mail");
            CLEAR(EmailMessage);
            EmailMessage.Create(
                NormalizeEmailAddresses(Cust."E-Mail"),
                Asunto,
                TextoBody,
                TRUE);

            IF NOT Email.Send(EmailMessage) THEN
                ERROR(EmailSendErr);

        UNTIL Cust.NEXT = 0;

        IF GUIALLOWED THEN BEGIN
            Window.CLOSE;
            MESSAGE(Msg001);
        END;
    end;

    procedure EnviaEmailFactura(var NoDoc: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ReportSelection: Record "Report Selections";
        Cust: Record Customer;
        Divisa: Record Currency;
        Text001: Label 'Invoice %1';
        Text002: Label 'Mr.: %1';
        Text003: Label 'Attached is our Invoice No. %1, dated %2, NCF %3, corresponding to your Purchase Order %4';
        Text005: Label 'Amount: %1';
        Text006: Label 'Payment terms %1';
        Text007: Label 'Due date: %1';
        Text008: Label 'If you have any questions or disagreements regarding our bill, we request that you immediately respond to this email with your concern.';
        Text009: Label 'Please confirm receipt of this email.';
        Text010: Label 'Sending E-mail\Customer  #2##############################';
        FechaDoc: Text[60];
        Text011: Label 'The client %1 does not have email configured in the field %2, if you want to send the electronic documents, you must add an e-mail in the field';
        NCF: Text[19];
        NoOrden: Text[30];
        Moneda: Text[30];
        Importe: Text[30];
        TermPago: Text[30];
        FechaVenc: Text[60];
    begin

    end;

    procedure EnviaEmailPagosMovProv(var par_VLE: Record "Vendor Ledger Entry")
    var
        Vend: Record Vendor;
        VLE: Record "Vendor Ledger Entry";
        VLE2: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        DVLE2: Record "Detailed Vendor Ledg. Entry";
        Divisa: Record Currency;
        HistRet: Record 34003003;
        CKEntry: Record "Check Ledger Entry";
        PaymentMethod: Record "Payment Method";
        Empresa: Text[65];
        BalTotal: Decimal;
        BalVencido: Decimal;
        ImporteRetenciones: Decimal;
        FechaUltPago: Text;
        NombreArch1: Text[1024];
        NombreArch2: Text[1024];
        Primeravez: Boolean;
        Primeravez2: Boolean;
        MonedaPago: Code[10];
        MonedaDoc: Code[10];
        MonedaAplicado: Code[10];
        ExisteAttachment: Boolean;
        ListaDoc: Text[1024];
        TotalFact: Decimal;
        TotalRet: Decimal;
        TotalNeto: Decimal;
        TotalPagado: Decimal;
        ImportePte: Decimal;
        TotalPte: Decimal;
        TieneDetalle: Boolean;
        Text001: Label '%1 %2 | Payment notification from %3';
        Text002: Label 'Mr.: %1';
        Text003: Label 'Cortésmente les informamos que emitiremos próximamente a su favor un(a) %1, por la suma de %2 %3 correspondiente al pago de la(s) siguiente(s) factura(s) y/o documento(s):';
        Text003_b: Label 'Cortésmente les informamos que emitiremos próximamente a su favor un(a) %1, por la suma de %2 %3 correspondiente a pago adelantado';
        Text004: Label 'Issue date';
        Text005: Label 'No. NCF';
        Text006: Label 'Invoice amount';
        Text007: Label 'Amount of retention';
        Text008: Label 'Net amount';
        Text009: Label 'If you have any observations, please reply to this email,';
        Text010: Label 'Sending  @1@@@@@@@@@@@@@ \Customer  #2##############################';
        Text011: Label 'Invoice No.';
        Text012: Label 'Grand total';
        Text013: Label 'Kind regards,';
        Text014: Label 'Dear Sir/Madam, we kindly inform you that we will issue a %1 in your favor in the amount of %2 %3 corresponding to the payment of the following invoice (s) and / or document (s):';
        Text014_b: Label 'Dear Sir/Madam, we kindly inform you that we will issue a %1 in your favor in the amount of %2 %3 corresponding to the payment in advance';
        Text015: Label 'Notification sent';
        Text016: Label 'Amount applied';
        Text017: Label 'Remaining amount';
        Err001: Label 'There''s not %1 as beneficiary in the %2 %3';
        Err002: Label 'Sólo se pueden notificar %1 pago';
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentOutStream: OutStream;
        AttachmentInStream: InStream;
        VendorLedgerEntryRef: RecordRef;
        AttachmentName: Text[250];
    begin
        CompanyInfo.GET();

        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("E-Mail");

        User.RESET;
        User.SETRANGE("User Name", USERID);
        User.FINDFIRST;

        CLEAR(EmailMessage);
        CLEAR(TextoBody);
        CLEAR(Asunto);

        Primeravez := TRUE;
        Primeravez2 := TRUE;
        TieneDetalle := FALSE;
        ExisteAttachment := FALSE;
        TotalPagado := 0;
        TotalFact := 0;
        TotalRet := 0;
        TotalNeto := 0;
        TotalPte := 0;
        MonedaAplicado := '';
        MonedaDoc := '';
        MonedaPago := '';

        VLE2.RESET;
        VLE2.COPYFILTERS(par_VLE);

        VLE.RESET;
        VLE.COPYFILTERS(par_VLE);

        VLE2.FINDFIRST;
        Vend.GET(VLE2."Vendor No.");

        Vend.TESTFIELD("E-Mail");

        Asunto := STRSUBSTNO(Text001, Vend."No.", Vend.Name, CompanyInfo.Name);

        IF VLE.FINDSET THEN
            REPEAT
                IF VLE."Document Type" <> VLE."Document Type"::Payment THEN
                    ERROR(STRSUBSTNO(Err002, VLE.FIELDCAPTION("Document Type")));

                IF NOT PaymentMethod.GET(VLE."Payment Method Code") THEN
                    PaymentMethod.INIT;

                VLE.CALCFIELDS("Original Amount");
                DVLE.RESET;
                DVLE.SETCURRENTKEY("Vendor Ledger Entry No.", "Posting Date");
                DVLE.SETFILTER("Vendor Ledger Entry No.", '<>%1', VLE."Entry No.");
                DVLE.SETRANGE("Document No.", VLE."Document No.");
                DVLE.SETRANGE("Entry Type", DVLE."Entry Type"::Application);
                DVLE.SETFILTER(Amount, '<>%1', 0);
                DVLE.SETRANGE("Vendor No.", VLE."Vendor No.");
                IF DVLE.FINDSET THEN
                    REPEAT
                        TieneDetalle := TRUE;
                        VLE2.GET(DVLE."Vendor Ledger Entry No.");
                        ImporteRetenciones := 0;
                        HistRet.RESET;
                        HistRet.SETRANGE("No. documento", VLE2."Document No.");
                        IF HistRet.FINDSET THEN
                            REPEAT
                                ExisteAttachment := TRUE;
                                ImporteRetenciones += HistRet."Importe Retenido";
                                IF Primeravez2 THEN BEGIN
                                    Primeravez2 := FALSE;
                                    ListaDoc := HistRet."No. documento";
                                END
                                ELSE
                                    ListaDoc += '|' + HistRet."No. documento";
                            UNTIL HistRet.NEXT = 0;

                        VLE2.CALCFIELDS("Original Amount");

                        TotalPagado += DVLE.Amount;
                        TotalFact += VLE2."Original Amount";
                        TotalRet += ImporteRetenciones;

                        ImportePte := 0;
                        DVLE2.RESET;
                        DVLE2.SETCURRENTKEY("Vendor Ledger Entry No.", "Posting Date");
                        DVLE2.SETRANGE("Vendor Ledger Entry No.", VLE2."Entry No.");
                        DVLE2.SETFILTER("Document No.", '<>%1', VLE."Document No.");
                        IF DVLE2.FINDSET THEN
                            REPEAT
                                ImportePte += DVLE2.Amount;
                            UNTIL DVLE2.NEXT = 0;

                        TotalPte += ImportePte;
                        IF ImporteRetenciones <> 0 THEN
                            TotalNeto += VLE2."Original Amount" + ImporteRetenciones
                        ELSE
                            TotalNeto += ImportePte;

                        IF VLE."Currency Code" = '' THEN
                            MonedaPago := 'RD$ '
                        ELSE
                            MonedaPago := VLE."Currency Code" + ' ';

                        IF VLE2."Currency Code" = '' THEN
                            MonedaDoc := 'RD$ '
                        ELSE
                            MonedaDoc := VLE2."Currency Code" + ' ';

                        IF DVLE."Currency Code" = '' THEN
                            MonedaAplicado := 'RD$ '
                        ELSE
                            MonedaAplicado := DVLE."Currency Code" + ' ';

                        IF Primeravez THEN BEGIN
                            TextoBody := '<br><td>' + STRSUBSTNO(Text003, PaymentMethod.Description, MonedaPago,
                                FORMAT(VLE."Original Amount", 0, '<Integer Thousand><Decimals,3>')) + '</td>';
                            TextoBody += '<br><br><td>' + STRSUBSTNO(Text014, PaymentMethod.Description, MonedaPago,
                                FORMAT(VLE."Original Amount", 0, '<Integer Thousand><Decimals,3>')) + '</td>';

                            Primeravez := FALSE;

                            TextoBody += '<br><br>' + '<table border="5" bordercolorlight="blue" bordercolordark="#b9dcff">' + '<tr>' + STRSUBSTNO('<td><b>%1<b></td>', Text004) +
                                        STRSUBSTNO('<td><b>%1<b></td>', Text005) + STRSUBSTNO('<td><b>%1<b></td>', Text011) +
                                        STRSUBSTNO('<td align="right"><b>%1<b></td>', Text006) +
                                        STRSUBSTNO('<td align="right"><b>%1<b></td>', Text017) +
                                        STRSUBSTNO('<td align="right"><b>%1<b></td>', Text007) +
                                        STRSUBSTNO('<td align="right"><b>%1<b></td>', Text008) +
                                        STRSUBSTNO('<td align="right"><b>%1<b></td>', Text016) + '</tr>';
                        END;

                        TextoBody += STRSUBSTNO('<td align="right">%1</td>', FORMAT(VLE2."Document Date"));
                        TextoBody += STRSUBSTNO('<td>%1</td>', VLE2."No. Comprobante Fiscal");
                        TextoBody += STRSUBSTNO('<td>%1</td>', VLE2."External Document No.");
                        TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaDoc + FORMAT(VLE2."Original Amount", 0, '<Integer thousand><Decimals,3>'));
                        TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaDoc + FORMAT(ABS(ImportePte) + ABS(ImporteRetenciones), 0, '<Integer thousand><Decimals,3>'));
                        TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaDoc + FORMAT(ImporteRetenciones, 0, '<Integer thousand><Decimals,3>'));
                        IF ImporteRetenciones <> 0 THEN
                            TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaDoc + FORMAT(VLE2."Original Amount" + ImporteRetenciones, 0, '<Integer thousand><Decimals,3>'))
                        ELSE
                            TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaDoc + FORMAT(ImportePte, 0, '<Integer thousand><Decimals,3>'));
                        TextoBody += STRSUBSTNO('<td align="right">%1</td>', MonedaAplicado + FORMAT(DVLE.Amount, 0, '<Integer thousand><Decimals,3>'));
                        TextoBody += '<tr>';
                    UNTIL DVLE.NEXT = 0
                ELSE BEGIN
                    IF Primeravez THEN BEGIN
                        TextoBody := '<br><td>' + STRSUBSTNO(Text003_b, PaymentMethod.Description, MonedaPago,
                            FORMAT(VLE."Original Amount", 0, '<Integer Thousand><Decimals,3>')) + '</td>';
                        TextoBody += '<br><br><td>' + STRSUBSTNO(Text014_b, PaymentMethod.Description, MonedaPago,
                            FORMAT(VLE."Original Amount", 0, '<Integer Thousand><Decimals,3>')) + '</td>';

                        Primeravez := FALSE;
                    END;
                END;
            UNTIL VLE.NEXT = 0;

        IF ExisteAttachment THEN BEGIN
            VLE.RESET;
            VLE.SETFILTER("Document No.", ListaDoc);

            IF VLE.FINDSET THEN BEGIN
                AttachmentName := COPYSTR('C-Ret-' + VLE."Vendor No." + '.pdf', 1, MAXSTRLEN(AttachmentName));
                AttachmentTempBlob.CreateOutStream(AttachmentOutStream);
                VendorLedgerEntryRef.GetTable(VLE);
                REPORT.SAVEAS(
                    34003008,
                    '',
                    REPORTFORMAT::Pdf,
                    AttachmentOutStream,
                    VendorLedgerEntryRef);
                CLEAR(AttachmentOutStream);
            END ELSE
                ExisteAttachment := FALSE;
        END;

        IF TieneDetalle THEN BEGIN
            TextoBody += STRSUBSTNO('<td align="right"><b>%1<b></td>', Text012);
            TextoBody += STRSUBSTNO('<td><td><td align="right">%1</td>', '<b>' + MonedaDoc + FORMAT(TotalFact, 0, '<Integer thousand><Decimals,3>'));
            TextoBody += STRSUBSTNO('<td align="right">%1</td>', '<b>' + MonedaDoc + FORMAT(ABS(TotalPte) + ABS(TotalRet), 0, '<Integer thousand><Decimals,3>'));
            TextoBody += STRSUBSTNO('<td align="right">%1</td>', '<b>' + MonedaDoc + FORMAT(TotalRet, 0, '<Integer thousand><Decimals,3>'));
            TextoBody += STRSUBSTNO('<td align="right">%1</td>', '<b>' + MonedaDoc + FORMAT(TotalNeto, 0, '<Integer thousand><Decimals,3>'));
            TextoBody += STRSUBSTNO('<td align="right">%1</td>', '<b>' + MonedaAplicado + FORMAT(TotalPagado, 0, '<Integer thousand><Decimals,3>') + '</b>');
            TextoBody += '</tr></table><br><br><br><br>';
            TextoBody += STRSUBSTNO('<td>%1</td><br><br>', Text009);
            TextoBody += STRSUBSTNO('<td><b>%1<b></td><br><br>', Text013);
            TextoBody += STRSUBSTNO('<td><b>%1<b></td><br><br>', User."Full Name");
        END;

        EmailMessage.Create(
            NormalizeEmailAddresses(Vend."E-Mail"),
            Asunto,
            TextoBody,
            TRUE);

        IF UserSetup."E-Mail" <> '' THEN
            EmailMessage.AddRecipient("Email Recipient Type"::Cc, UserSetup."E-Mail");

        IF ExisteAttachment THEN BEGIN
            AttachmentTempBlob.CreateInStream(AttachmentInStream);
            EmailMessage.AddAttachment(
                AttachmentName,
                'application/pdf',
                AttachmentInStream);
        END;

        IF NOT Email.Send(EmailMessage) THEN
            ERROR(EmailSendErr);

        CLEARALL;

    end;

    local procedure NormalizeEmailAddresses(EmailAddresses: Text): Text
    begin
        EmailAddresses := DELCHR(EmailAddresses, '=', ' ');
        EXIT(CONVERTSTR(EmailAddresses, ',', ';'));
    end;

    procedure Ansi2Ascii(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AnsiStr, AsciiStr));
    end;

    procedure Ascii2Ansi(_Text: Text[250]): Text[250]
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AsciiStr, AnsiStr));
    end;

    local procedure MakeVars()
    begin
        AsciiStr := 'áéíóúñÑAÉIOUü''||-*/<><=~!^"';
        AnsiStr := 'aeiounNAEIOUU              ';
    end;

}