codeunit 34002108 "Imprime en PDF"
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

    TableNo = 34002117;

    trigger OnRun()
    begin
        ConfNominas.GET();
        GlobalRec := Rec;
        Code();
    end;

    var
        //TODO: Ver SMTPSetup: Record 409;
        //TODO: Ver SMTP: Codeunit 400;
        GlobalRec: Record 34002117;
        Historico: Record 34002117;
        Emp: Record 5200;
        ConfNominas: Record 34002103;
        cuMail: Codeunit 397;
        Counter: Integer;
        Path: Text[250];
        UseAttachment: Boolean;
        _ArchivoPDF: Text[150];
        _Directorio: Text[150];
        IDReporte: Integer;
        DefPrinter: Text[250];
        Asunto: Text[250];
        AttachmentFile: Text[250];
        MailSent: Boolean;
        Text001: Label 'period %1 to %2.';
        Dia_Pago: Label 'It''s Payday!';
        TextoBody: Text[1024];
        Pagado_Periodo: Label 'Dear contribuort % 1, by means of this email you are notified that you have made the payment of your number corresponding to the period between% 2 and% 3. Attached is the Record 34002100of payment. If you have any questions, please contact the person in charge of the payroll.';
        El_Importe: Label 'The net amount of your payment has already been transferred to your bank account.If you have any questions about your payment, please contact the person in charge of payroll.';
        EmpresaCot: Record 34002100;



    local procedure Code()
    var
        UserSetup: Record 91;
        CarriageReturn: Char;
        SendOK: Boolean;
        SMTP_ERROR: Label 'Error : %1';
    begin
        //UserSetup.GET(USERID);
        _Directorio := ConfNominas."Path Archivos Electronicos";
        CarriageReturn := 13;
        //TODO: Ver SMTPSetup.GET();

        //001+
        //SMTPSetup.TESTFIELD("User ID");
        EmpresaCot.FINDFIRST;
        EmpresaCot.TESTFIELD("Email Envia Boleta de Pago");
        EmpresaCot.TESTFIELD("Password Email Boleta Pago");
        //001-

        Emp.GET(GlobalRec."No. empleado");
        Historico.SETRANGE("No. empleado", GlobalRec."No. empleado");
        Historico.SETRANGE(Periodo, GlobalRec.Periodo);
        Historico.SETRANGE("Tipo de nomina", GlobalRec."Tipo de nomina");
        Historico.FINDFIRST;
        //002 DAC Format Email start
        TextoBody := /*Dia_Pago +*/ FORMAT(CarriageReturn) + FORMAT(CarriageReturn) + STRSUBSTNO(Pagado_Periodo, Historico.Nombre, Historico.Inicio, Historico.Fin);// +
        //002 DAC Format Email end
        Asunto := ConfNominas."Texto email recibos" + ', ' + Historico.Nombre + ', ' + STRSUBSTNO(Text001, Historico.Inicio, Historico.Fin);
        //TODO: Ver REPORT.SAVEASPDF(IDReporte, _Directorio + _ArchivoPDF, Historico);
        SLEEP(ConfNominas."Tiempo espera Envio email");
        AttachmentFile := _Directorio + _ArchivoPDF;
        //TODO: Ver 
        /*
        IF Emp."Company E-Mail" <> '' THEN
            //001+
            //SMTP.CreateMessage(COMPANYNAME,SMTPSetup."User ID",Emp."Company E-Mail",Asunto,TextoBody,FALSE)
            SMTP.CreateMessage(COMPANYNAME, EmpresaCot."Email Envia Boleta de Pago", Emp."Company E-Mail", Asunto, TextoBody, FALSE)
        //001-
        ELSE
            IF Emp."E-Mail" <> '' THEN
                //001+
                //SMTP.CreateMessage(COMPANYNAME,SMTPSetup."User ID",Emp."E-Mail",Asunto,TextoBody,FALSE);
                SMTP.CreateMessage(COMPANYNAME, EmpresaCot."Email Envia Boleta de Pago", Emp."E-Mail", Asunto, TextoBody, FALSE);
        //001-
        SMTP.AddAttachment(AttachmentFile, _ArchivoPDF);
        */
        //001+
        //SMTP.Send;
        //TODO: Ver SendOK := SMTP.TrySendCR(EmpresaCot."Email Envia Boleta de Pago", EmpresaCot."Password Email Boleta Pago");

        //TODO: Ver IF NOT SendOK THEN
        //TODO: Ver     ERROR(STRSUBSTNO(SMTP_ERROR, SMTP.GetLastSendMailErrorText));
        //001-

        //TODO: Ver ERASE(_Directorio + _ArchivoPDF);
        CLEARALL;

    end;

    procedure GetReport(_ReportID: Integer; NombreArchivo: Text[250])
    begin
        IDReporte := _ReportID;
        _ArchivoPDF := NombreArchivo + '.pdf';
    end;
}

