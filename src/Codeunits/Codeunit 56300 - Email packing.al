codeunit 56300 "Email packing"
{
    TableNo = 36;

    trigger OnRun()
    var
        Texto: BigText;
    begin
        //REPORT.SAVEASHTML(50700,'C:/TEMP/PRUEBA.HTML');
        EnvioMailPacking(Rec);
    end;

    var
        Body: BigText;
        SMTPmail: Codeunit 400;

    procedure generaBody(parSalesHeader Record: 36")
    var
        rTextoConfig: Record 56090;
        rPick: Record 5773;
        rPack: Record 56034;
        nCajas: Integer;
        nPalets: Integer;
        rTempPack Record: 56034" temporary;
        TextoCajas: Label '%1 Caja(s) ';
        TextoPalets: Label '%1 Palet(s)';
        conj: Label 'y';
        TextoBultos: Text[30];
        antPalet: Code[20];
    begin

        rTempPack.DELETEALL;
        rPick.SETRANGE("Source Type", 37);
        rPick.SETRANGE("Source No.", parSalesHeader."No.");
        IF rPick.FINDSET THEN BEGIN
            CLEAR(antPalet);
            rPack.SETRANGE(rPack."No. Picking", rPick."No.");
            IF rPack.FINDSET THEN
                REPEAT
                    IF rPack."No. Palet" = '' THEN BEGIN
                        nCajas += 1;
                        rTempPack := rPack;
                        rTempPack.INSERT;
                    END
                    ELSE BEGIN
                        IF antPalet <> rPack."No. Palet" THEN BEGIN
                            nPalets += 1;
                            rTempPack := rPack;
                            rTempPack.INSERT;
                            antPalet := rPack."No. Palet";
                        END;
                    END;
                UNTIL rPack.NEXT = 0;
        END;
        IF nPalets > 0 THEN
            TextoBultos := STRSUBSTNO(TextoPalets, nPalets);
        IF nCajas > 0 THEN BEGIN
            IF TextoBultos <> '' THEN TextoBultos := TextoBultos + conj;
            TextoBultos := TextoBultos + STRSUBSTNO(TextoPalets, nPalets);
        END;

        rTextoConfig.SETRANGE("Id. Tabla", 56030);
        rTextoConfig.SETRANGE(Sección, rTextoConfig.Sección::Cabecera);
        IF rTextoConfig.FINDSET THEN
            REPEAT
                Body.ADDTEXT(STRSUBSTNO(rTextoConfig.Texto, parSalesHeader."No.", TextoBultos, parSalesHeader."Amount Including VAT",
                                        rTempPack."No. Caja", rTempPack."No. Palet", rTempPack."No. Pedido"));
            UNTIL rTextoConfig.NEXT = 0;

        IF rTempPack.FINDSET THEN
            REPEAT
                rTextoConfig.SETRANGE(Sección, rTextoConfig.Sección::Detalle);
                IF rTextoConfig.FINDSET THEN
                    REPEAT
                        Body.ADDTEXT(STRSUBSTNO(rTextoConfig.Texto, parSalesHeader."No.", TextoBultos, parSalesHeader."Amount Including VAT",
                                            rTempPack."No. Caja", rTempPack."No. Palet", rTempPack."No. Pedido"));
                    UNTIL rTextoConfig.NEXT = 0;
            UNTIL rTempPack.NEXT = 0;

        rTextoConfig.SETRANGE(Sección, rTextoConfig.Sección::Pie);
        IF rTextoConfig.FINDSET THEN
            REPEAT
                Body.ADDTEXT(STRSUBSTNO(rTextoConfig.Texto, parSalesHeader."No.", TextoBultos, parSalesHeader."Amount Including VAT",
                                        rTempPack."No. Caja", rTempPack."No. Palet", rTempPack."No. Pedido"));
            UNTIL rTextoConfig.NEXT = 0;
    end;

    procedure EnvioMailPacking(parSalesHeader Record: 36")
    var
        rCust: Record 18;
        Subject: Label 'Santillana-Prueba de envío';
        rConf: Record 56001;
    begin


        rCust.GET(parSalesHeader."Sell-to Customer No.");
        IF rCust."E-Mail" = '' THEN EXIT;

        generaBody(parSalesHeader);

        rConf.GET();
        rConf.TESTFIELD("E-mail notificación envio ped.");

        SMTPmail.CreateMessageBigBody('Santillana', rConf."E-mail notificación envio ped.", rCust."E-Mail", Subject, Body, TRUE);

        SMTPmail.Send();
    end;
}

