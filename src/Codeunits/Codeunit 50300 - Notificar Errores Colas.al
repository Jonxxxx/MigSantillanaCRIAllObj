codeunit 55156 "Notificar Errores Colas"
{
    // ---------------------------------
    // YFC     : Yefrecis Francisco Cruz
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------------
    // No.         Firma     Fecha            Descripcion
    // ------------------------------------------------------------------------
    // 001         YFC      06/22/2020       SANTINAV-1458
    // 002         FES      01-Marzo-2023    SANTINAV-4392. Cambiar Remitente Envia Emails Errores Colas

    TableNo = 472;

    trigger OnRun()
    begin
        ConfEmpresa.GET;

        ConfEmpresa.TESTFIELD("Email GD Local");
        ConfEmpresa.TESTFIELD("Email Soporte Funcional");
        ConfEmpresa.TESTFIELD("Email Encargado Proyecto");

        //002+
        ConfEmpresa.TESTFIELD("Email Envia Errores Colas");
        ConfEmpresa.TESTFIELD("Password Email Errores Colas");
        //002

        Rec.CALCFIELDS("Object Caption to Run");
        SendEmail(ConfEmpresa."Email GD Local", Error01 + ' ' + Rec."Object Caption to Run", Error02 + ' ' + Rec."Error Message");
        SendEmail(ConfEmpresa."Email Soporte Funcional", Error01 + ' ' + Rec."Object Caption to Run", Error02 + ' ' + Rec."Error Message");
        SendEmail(ConfEmpresa."Email Encargado Proyecto", Error01 + ' ' + Rec."Object Caption to Run", Error02 + ' ' + Rec."Error Message");
    end;

    var
        ConfEmpresa: Record 56001;
        Error01: Label 'Error Cola Proyecto -';
        Error02: Label 'Error: ';

    procedure SendEmail(SendToAddress: Text[1024]; Subject: Text[200]; MessageBody: Text[1024])
    var
        CompanyInfo: Record 79;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        SendOK: Boolean;
        EmailNotSentErr: Label 'The email could not be sent to %1.';
        EmailSentMsg: Label 'Correo enviado';
    begin
        CompanyInfo.GET;
        ConfEmpresa.GET;
        ConfEmpresa.TESTFIELD("Email GD Local");
        ConfEmpresa.TESTFIELD("Email Soporte Funcional");
        ConfEmpresa.TESTFIELD("Email Encargado Proyecto");

        EmailMessage.Create(SendToAddress, Subject, MessageBody, false);
        SendOK := Email.Send(EmailMessage);
        if not SendOK then
            Error(EmailNotSentErr, SendToAddress);

        IF SendOK AND GUIALLOWED THEN
            MESSAGE(EmailSentMsg);
    end;
}

