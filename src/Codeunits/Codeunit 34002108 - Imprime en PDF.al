codeunit 55749 "Imprime en PDF"
{
    // Proyecto: Dynamics 365 Business Central
    // -----------------------------
    // JPG     : John Peralta
    // AMS     : Agustin Mendez
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------
    // No.       Fecha         Firma         Desscripcion
    // ------------------------------------------------------------------
    // 001       07-03-2022    FES           SANTINAV-4392: Configuracion de cuentas de correo para el envio de errores de colas de proyecto y boletas de pago
    // 002       05-05-2023    DAC           SANTINAV-4573 Configurar mensaje de correo para envio de comprobante de nomina

    TableNo = 55758;

    trigger OnRun()
    begin
        ConfNominas.GET();
        GlobalRec := Rec;
        Code();
    end;

    var
        GlobalRec: Record 55758;
        Historico: Record 55758;
        Emp: Record 5200;
        ConfNominas: Record 55744;
        Counter: Integer;
        UseAttachment: Boolean;
        _ArchivoPDF: Text[150];
        IDReporte: Integer;
        DefPrinter: Text[250];
        Asunto: Text[250];
        MailSent: Boolean;
        Text001: Label 'period %1 to %2.';
        Dia_Pago: Label 'It''s Payday!';
        TextoBody: Text[1024];
        Pagado_Periodo: Label 'Dear contribuort % 1, by means of this email you are notified that you have made the payment of your number corresponding to the period between% 2 and% 3. Attached is the Record 34002100of payment. If you have any questions, please contact the person in charge of the payroll.';
        El_Importe: Label 'The net amount of your payment has already been transferred to your bank account.If you have any questions about your payment, please contact the person in charge of payroll.';

    local procedure Code()
    var
        CarriageReturn: Char;
        SendOK: Boolean;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        AttachmentOutStream: OutStream;
        AttachmentInStream: InStream;
        HistoricoRecordRef: RecordRef;
        Recipient: Text;
        EmailNotSentErr: Label 'The payroll receipt email could not be sent to %1.';
        ReportNotGeneratedErr: Label 'The payroll receipt PDF could not be generated.';
    begin
        CarriageReturn := 13;

        Emp.GET(GlobalRec."No. empleado");
        Historico.SETRANGE("No. empleado", GlobalRec."No. empleado");
        Historico.SETRANGE(Periodo, GlobalRec.Periodo);
        Historico.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        Historico.FINDFIRST;
        //002 DAC Format Email start
        TextoBody := /*Dia_Pago +*/ FORMAT(CarriageReturn) + FORMAT(CarriageReturn) + STRSUBSTNO(Pagado_Periodo, Historico.Nombre, Historico.Inicio, Historico.Fin);// +
        //002 DAC Format Email end
        Asunto := ConfNominas."Texto email recibos" + ', ' + Historico.Nombre + ', ' + STRSUBSTNO(Text001, Historico.Inicio, Historico.Fin);
        TempBlob.CreateOutStream(AttachmentOutStream);
        HistoricoRecordRef.GetTable(Historico);
        if not Report.SaveAs(IDReporte, '', ReportFormat::Pdf, AttachmentOutStream, HistoricoRecordRef) then
            Error(ReportNotGeneratedErr);

        SLEEP(ConfNominas."Tiempo espera Envio email");

        Recipient := Emp."Company E-Mail";
        if Recipient = '' then
            Recipient := Emp."E-Mail";
        if Recipient = '' then
            exit;

        EmailMessage.Create(Recipient, Asunto, TextoBody, false);
        TempBlob.CreateInStream(AttachmentInStream);
        EmailMessage.AddAttachment(_ArchivoPDF, 'application/pdf', AttachmentInStream);
        SendOK := Email.Send(EmailMessage);
        if not SendOK then
            Error(EmailNotSentErr, Recipient);

        CLEARALL;

    end;

    procedure GetReport(_ReportID: Integer; NombreArchivo: Text[250])
    begin
        IDReporte := _ReportID;
        _ArchivoPDF := NombreArchivo + '.pdf';
    end;
}

