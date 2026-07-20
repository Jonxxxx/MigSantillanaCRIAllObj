using System.Email;

codeunit 61012 EXCCRIEmailMgt
{
    procedure CreateMessageBigBody(
        SenderName: Text[100];
        SenderAddress: Text[50];
        Recipients: Text[1024];
        Subject: Text[200];
        Body: BigText;
        HtmlFormatted: Boolean)
    var
        EmailAccountMgt: Codeunit "Email Account";
        BodyText: Text;
    begin
        if not EmailAccountMgt.ValidateEmailAddresses(Recipients, true) then
            Error(EXCCRIInvalidRecipientsErr, Recipients);

        if not EmailAccountMgt.ValidateEmailAddress(SenderAddress, false) then
            Error(EXCCRIInvalidSenderErr, SenderAddress);

        Body.GetSubText(BodyText, 1);

        Clear(EXCCRIEmailMessage);
        EXCCRIEmailMessage.Create(
            Recipients,
            Subject,
            BodyText,
            HtmlFormatted,
            false);

        EXCCRIRequestedSenderName := SenderName;
        EXCCRIRequestedSenderAddress := SenderAddress;
        EXCCRIMessageCreated := true;
        Clear(EXCCRILastSendErrorText);
    end;

    procedure TrySendCR(
        SenderMail: Text[100];
        Password: Text[30]): Boolean
    begin
        Clear(Password);
        exit(TrySend(SenderMail));
    end;

    procedure TrySend(SenderMail: Text): Boolean
    var
        TempEmailAccount: Record "Email Account" temporary;
        Email: Codeunit Email;
        EmailAccountMgt: Codeunit "Email Account";
        SendResult: Boolean;
    begin
        Clear(EXCCRILastSendErrorText);

        if not EXCCRIMessageCreated then begin
            EXCCRILastSendErrorText := EXCCRIMessageNotCreatedErr;
            exit(false);
        end;

        if SenderMail = '' then
            SenderMail := EXCCRIRequestedSenderAddress;

        if
            LowerCase(SenderMail) <>
            LowerCase(EXCCRIRequestedSenderAddress)
        then begin
            EXCCRILastSendErrorText :=
                StrSubstNo(
                    EXCCRISenderMismatchErr,
                    EXCCRIRequestedSenderAddress,
                    SenderMail);
            EXCCRIClearMessage();
            exit(false);
        end;

        EmailAccountMgt.GetAllAccounts(TempEmailAccount);
        TempEmailAccount.SetRange("Email Address", SenderMail);

        if not TempEmailAccount.FindFirst() then begin
            EXCCRILastSendErrorText :=
                StrSubstNo(
                    EXCCRIEmailAccountNotFoundErr,
                    EXCCRIRequestedSenderName,
                    SenderMail);
            EXCCRIClearMessage();
            exit(false);
        end;

        SendResult :=
            Email.Send(
                EXCCRIEmailMessage,
                TempEmailAccount);

        if not SendResult then
            EXCCRILastSendErrorText :=
                StrSubstNo(
                    EXCCRISendFailedErr,
                    SenderMail);

        EXCCRIClearMessage();
        exit(SendResult);
    end;

    procedure GetLastSendMailErrorText(): Text
    begin
        exit(EXCCRILastSendErrorText);
    end;

    local procedure EXCCRIClearMessage()
    begin
        Clear(EXCCRIEmailMessage);
        Clear(EXCCRIRequestedSenderName);
        Clear(EXCCRIRequestedSenderAddress);
        EXCCRIMessageCreated := false;
    end;

    var
        EXCCRIEmailMessage: Codeunit "Email Message";
        EXCCRIRequestedSenderName: Text[100];
        EXCCRIRequestedSenderAddress: Text[250];
        EXCCRILastSendErrorText: Text;
        EXCCRIMessageCreated: Boolean;
        EXCCRIInvalidRecipientsErr: Label
            'One or more recipient email addresses are invalid: %1.';
        EXCCRIInvalidSenderErr: Label
            'The sender email address is invalid: %1.';
        EXCCRIMessageNotCreatedErr: Label
            'The email message has not been created.';
        EXCCRISenderMismatchErr: Label
            'The requested sender address %1 does not match the configured sending account %2.';
        EXCCRIEmailAccountNotFoundErr: Label
            'The email account %1 (%2) is not configured in Email Accounts.';
        EXCCRISendFailedErr: Label
            'Business Central could not send the email using account %1.';
}
