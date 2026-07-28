codeunit 34002145 "Funciones entrenamientos"
{
    TableNo = 34002117;

    trigger OnRun()
    begin
    end;

    var
        GlobalRec: Record 34002117;
        Historico: Record 34002117;
        Emp: Record 5200;
        ConfNominas: Record 34002103;
        UserSetup: Record 91;
        RepresentantesEmpresa: Record 34002102;
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
        Notificacion: Label 'Notification of registration to training %1';
        TextoBody: Text[1024];
        Pagado_Periodo: Label 'Dear contribuort % 1, by means of this email you are notified that you have made the payment of your number corresponding to the period between% 2 and% 3.  Attached is the receipt or proof of payment. If you have any questions, please contact the person in charge of the payroll.';
        El_Importe: Label 'The net amount of your payment has already been transferred to your bank account.If you have any questions about your payment, please contact the person in charge of payroll.';
        Estimado: Label 'Dear %1, you have been ';
        Invitado: Label 'Invited';
        Invitada: Label 'Invited';
        Participar: Label 'to participate in training %1. The date of this training will be %2, starting at %3.';
        Info: Label 'For additional information, please contact %1, %2';
        Esperamos: Label 'We count on your presence';
        CarriageReturn: Char;
        Msg001: Label 'Notifications have been sent';

    procedure Code()
    var
        UserSetup: Record 91;
        CarriageReturn: Char;
    begin
    end;

    procedure GetReport(_ReportID: Integer; NombreArchivo: Text[250])
    begin
        IDReporte := _ReportID;
        _ArchivoPDF := NombreArchivo + '.pdf';
    end;

    procedure EnRecord(AsistEnt: Record 34002206)
    var
        CabEnt: Record 34002204;
        Asistentesentrenamientos: Record 34002206;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Recipient: Text;
        EmailNotSentErr: Label 'The training notification could not be sent to %1.';
    begin
        ConfNominas.GET();
        CarriageReturn := 13;
        RepresentantesEmpresa.FINDFIRST;

        Asistentesentrenamientos.RESET;
        Asistentesentrenamientos.SETRANGE("No. entrenamiento", AsistEnt."No. entrenamiento");
        Asistentesentrenamientos.SETRANGE("Fecha programacion", AsistEnt."Fecha programacion");
        Asistentesentrenamientos.SETRANGE(Notificado, FALSE);
        Asistentesentrenamientos.FINDSET;
        REPEAT
            CLEAR(Asunto);

            Emp.GET(Asistentesentrenamientos."No. empleado");
            CabEnt.GET(Asistentesentrenamientos."No. entrenamiento");
            Asunto := STRSUBSTNO(Notificacion, CabEnt."Titulo entrenamiento");

            TextoBody := STRSUBSTNO(Estimado, Emp."Full Name");
            IF Emp.Gender = 2 THEN
                TextoBody += Invitado
            ELSE
                TextoBody += Invitada;

            TextoBody += STRSUBSTNO(Participar, CabEnt."Titulo entrenamiento", Asistentesentrenamientos."Fecha programacion", Asistentesentrenamientos."Hora de Inicio");
            TextoBody += FORMAT(CarriageReturn);
            TextoBody += STRSUBSTNO(Info, RepresentantesEmpresa.Nombre, RepresentantesEmpresa."Job Title");

            SLEEP(ConfNominas."Tiempo espera Envio email");
            Recipient := Emp."Company E-Mail";
            if Recipient = '' then
                Recipient := Emp."E-Mail";
            if Recipient = '' then
                Error(EmailNotSentErr, Emp."No.");

            Clear(EmailMessage);
            EmailMessage.Create(Recipient, Asunto, TextoBody, false);
            if not Email.Send(EmailMessage) then
                Error(EmailNotSentErr, Recipient);

            Asistentesentrenamientos.Notificado := TRUE;
            Asistentesentrenamientos.MODIFY;
        UNTIL Asistentesentrenamientos.NEXT = 0;
        CLEARALL;

        MESSAGE(Msg001);
    end;

    local procedure RegistraEntrenamiento()
    begin
    end;
}

