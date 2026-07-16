codeunit 34003002 "Validaciones Localizacion"
{
    // Proyecto: Microsoft Dynamics Nav
    // ---------------------------------
    // AMS     : Agustin Méndez
    // GRN     : Guillermo Román
    // JPG     : John Peralta
    // FES     : Fausto Serrata
    // ------------------------------------------------------------------------
    // No.         Fecha       Firma      Descripcion
    // ------------------------------------------------------------------------
    // DSLoc1.01   01-Ene-2007   AMS/GRN     Funcionalidad de NCF
    // DSLoc1.03   17-Abr-2018   AMS/GRN     Funcionalidad de NCF nuevo 2018
    // DSLoc1.04   04-jun-2019   JPG         Funcionalidad de NCF nuevo 2019 B16 y E, texto correcion a Correc ya que se corto ncf a 11  y 13
    // 001         10-Ene-2020   FES         Correccion validacion cantidad digitos NCF inician con B o E.
    //                                       Cambio mensaje error para NCF Electronicos (13 posiciones)
    // DSLoc2.0   18-may-2020   JPG         Modificaciones para validar letra inicial y vat regi


    trigger OnRun()
    begin
    end;

    var
        Err001: Label 'Invalid NCF, this is for Credit Memo';
        Err002: Label 'Invalid NCF, this is for End users';
        Err003: Label 'First character must be A';
        Err004: Label 'Invalid NCF there''s not classification for it';
        Err005: Label 'Invalid NCF this is for Unique Income';
        Err006: Label 'Invalid NCF lenght, must be 19 char long';
        Err007: Label 'Character after position 1 must be numerics';
        Err008: Label 'NCF # %1 is duplicated for \Vendor No. %2';
        Err009: Label 'Specify %1 for %2 %3';
        Err010: Label 'The length of the NCF from May 2018 must be 11 ';
        Err011: Label 'First character must be B or E';
        Err012: Label 'Invalid NCF lenght, must be 11 char long';
        Err013: Label 'The Income type for %1 %2 must be %3, it will not allow any other value';
        Err014: Label 'The Income type must be 05 when selling FA';
        Text001: Label 'CORREC';
        Error012: Label 'NCF Already exist in %1 %2';
        Text002: Label 'Invoice';
        Text003: Label 'Credit Memo';
        I: Integer;
        Err015: Label '%1 must have value in %2. Verify the %3 with %4 %5, %6 %7';
        Err016: Label 'Invalid NCF lenght, must be 13 char long';
        Vendor: Record 23;
        Err017: Label 'First character NCF Rel must be A, B or C';
        Err018: Label 'Invalid NCF Rel. there''s not classification for it';
        Err020: Label 'The invoice must have Retention';

    procedure ValidaNCFCompras(PurchHeader: Record 38)
    var
        VendorPostingGr: Record 93;
        PurchCrMemoHeader: Record 124;
        PurchInvHeader: Record 122;
    begin
        IF PurchHeader."Posting Date" >= DMY2DATE(1, 5, 2018) THEN BEGIN
            ValidaNCFCompras2018(PurchHeader);
            EXIT;
        END;
        WITH PurchHeader DO BEGIN
            VendorPostingGr.GET("Vendor Posting Group");

            IF (VendorPostingGr."NCF Obligatorio") AND (NOT Correction) THEN
                TESTFIELD("No. Comprobante Fiscal");

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN

                //AMS Este control debe estar en la tabla, en el campo NCF. cuando se genera un error despues que se ha generado el NCF Navision
                //guarda este NCF en la cabecera y sigue la funcionalidad de No. Siguiente Fact.
                //IF NOT rVendorPostingGr."NCF Obligatorio" THEN
                //   TESTFIELD("No. Comprobante Fiscal",'');

                IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                    ERROR(Err006);

                //GRN Para que no se digite un NCF en un proveedor que no lo requiera

                IF COPYSTR("No. Comprobante Fiscal", 10, 2) = '02' THEN
                    ERROR(Err002);

                IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                    CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                        '05' .. '10':
                            ERROR(Err004);
                        '12':
                            ERROR(Err005);
                        '15' .. '99':
                            ERROR(Err004);
                    END;

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF (COPYSTR("No. Comprobante Fiscal", 10, 2) <> '04') AND (NOT Correction) THEN
                        ERROR(Err002);
                END
                ELSE
                    IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) THEN
                        IF (COPYSTR("No. Comprobante Fiscal", 10, 2) = '04') AND (NOT Correction) THEN
                            ERROR(Err001);


                //jpg++ 13-05-2020 validar que solo sean A
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) <> 'A') THEN
                    ERROR(Err003);

                /*
                 CASE COPYSTR("No. Comprobante Fiscal",1,1) OF
                  'K'..'O':
                    ERROR(Err003);
                  'V'..'Z':
                    ERROR(Err003);
                 END;
                  */
                //jpg -- 13-05-2020 validar que solo sean A

                //Para validar caracteres numericos solamente despues la posicion 1
                ValidaCaracteres("No. Comprobante Fiscal", 19);
            END;

            //DSLoc1.01 To avoid a non-requested Vendor's NCF
            IF NOT Correction THEN BEGIN
                IF (NOT VendorPostingGr."NCF Obligatorio") AND (NOT VendorPostingGr."Permite Emitir NCF") THEN
                    TESTFIELD("No. Comprobante Fiscal", '');
            END
            ELSE
                TESTFIELD("Applies-to Doc. No."); //DSLoc1.01 To avoid a error in Corrected Documents

            IF ("Document Type" IN ["Document Type"::"Credit Memo"]) AND ("No. Comprobante Fiscal" <> '') THEN BEGIN
                PurchCrMemoHeader.SETCURRENTKEY("VAT Registration No.", "No. Comprobante Fiscal");
                PurchCrMemoHeader.SETRANGE("VAT Registration No.", "VAT Registration No.");
                PurchCrMemoHeader.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal");
                IF PurchCrMemoHeader.FINDFIRST THEN
                    ERROR(Err008, "No. Comprobante Fiscal", "Buy-from Vendor No.");
            END
            ELSE
                IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                    PurchInvHeader.SETCURRENTKEY("VAT Registration No.", "No. Comprobante Fiscal");
                    PurchInvHeader.SETRANGE("VAT Registration No.", "VAT Registration No.");
                    PurchInvHeader.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal");
                    IF PurchInvHeader.FINDFIRST THEN
                        ERROR(Err008, "No. Comprobante Fiscal", "Buy-from Vendor No.");
                END;

            //DSLoc1.01 To let the NCF available
            IF Correction THEN
                IF ("Document Type" IN ["Document Type"::"Credit Memo"]) AND (Correction) THEN BEGIN
                    PurchInvHeader.GET(PurchHeader."Applies-to Doc. No.");
                    PurchInvHeader."No. Comprobante Fiscal" := Text001 + COPYSTR(PurchInvHeader."No. Comprobante Fiscal", 11, 9);
                    PurchInvHeader.MODIFY;
                END;

        END;

    end;

    procedure ValidaNCFVentas(SalesHeader: Record 36)
    var
        rCustPostingGr: Record 92;
    begin
        IF SalesHeader."Posting Date" >= DMY2DATE(1, 5, 2018) THEN BEGIN
            ValidaNCFVentas2018(SalesHeader);
            EXIT;
        END;
        WITH SalesHeader DO BEGIN
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                IF Correction THEN
                    SalesHeader.TESTFIELD("Razon anulacion NCF");

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                    ERROR(Err006);

                IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                    CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                        // AMS '05'..'10':
                        //   ERROR(Err004);
                        '12':
                            ERROR(Err005);
                    //  '15'..'99':
                    //    ERROR(Err004);
                    END;

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF COPYSTR("No. Comprobante Fiscal", 10, 2) <> '04' THEN
                        ERROR(Err002);
                    IF Correction THEN
                        SalesHeader.TESTFIELD("Razon anulacion NCF");
                END;
                CASE COPYSTR("No. Comprobante Fiscal", 1, 1) OF
                    'K' .. 'O':
                        ERROR(Err003);
                    'V' .. 'Z':
                        ERROR(Err003);
                END;
                //Para validar caracteres numericos solamente despues la posicion 1
                ValidaCaracteres("No. Comprobante Fiscal", 19);
            END;
        END;
    end;

    procedure ValidaNCFVentasServ(ServHeader: Record 5900)
    var
        rCustPostingGr: Record 92;
    begin
        IF ServHeader."Posting Date" >= DMY2DATE(1, 5, 2018) THEN BEGIN
            ValidaNCFVentasServ2018(ServHeader);
            EXIT;
        END;

        WITH ServHeader DO BEGIN
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                IF Correction THEN
                    ServHeader.TESTFIELD("Razon anulacion NCF");

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                    ERROR(Err006);

                IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                    CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                        // AMS '05'..'10':
                        //   ERROR(Err004);
                        '12':
                            ERROR(Err005);
                    //  '15'..'99':
                    //    ERROR(Err004);
                    END;

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF COPYSTR("No. Comprobante Fiscal", 10, 2) <> '04' THEN
                        ERROR(Err002);
                    IF Correction THEN
                        ServHeader.TESTFIELD("Razon anulacion NCF");
                END;
                CASE COPYSTR("No. Comprobante Fiscal", 1, 1) OF
                    'K' .. 'O':
                        ERROR(Err003);
                    'V' .. 'Z':
                        ERROR(Err003);
                END;
                //Para validar caracteres numericos solamente despues la posicion 1
                ValidaCaracteres("No. Comprobante Fiscal", 19);
            END;
        END;
    end;

    procedure ValidaNCFED(GJL: Record 81)
    begin
        WITH GJL DO BEGIN
            IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                ERROR(Err006);

            IF COPYSTR("No. Comprobante Fiscal", 10, 2) = '02' THEN
                ERROR(Err002);

            CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                '05' .. '10':
                    ERROR(Err004);
                '12':
                    ERROR(Err005);
            // AMS '15'..'99':
            // AMS   ERROR(Err004);
            END;

            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                IF COPYSTR("No. Comprobante Fiscal", 10, 2) <> '04' THEN
                    ERROR(Err002);

            CASE COPYSTR("No. Comprobante Fiscal", 1, 1) OF
                'K' .. 'O':
                    ERROR(Err003);
                'V' .. 'Z':
                    ERROR(Err003);
            END;

            //Para validar caracteres numericos solamente despues la posicion 1
            ValidaCaracteres("No. Comprobante Fiscal", 19);
        END;
    end;

    procedure ValidaNCFReLCompras(PurchHeader: Record 38)
    var
        VLE: Record 25;
    begin
        WITH PurchHeader DO BEGIN
            IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                ERROR(Err006);

            IF COPYSTR("No. Comprobante Fiscal Rel.", 10, 2) = '04' THEN
                ERROR(Err001)
            ELSE
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    IF COPYSTR("No. Comprobante Fiscal Rel.", 10, 2) <> '01' THEN
                        ERROR(Err002);

            CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                '05' .. '10':
                    ERROR(Err004);
                '12':
                    ERROR(Err005);
                '15' .. '99':
                    ERROR(Err004);
            END;

            CASE COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) OF
                'K' .. 'O':
                    ERROR(Err003);
                'V' .. 'Z':
                    ERROR(Err003);
            END;
            //Para validar caracteres numericos solamente despues la posicion 1
            ValidaCaracteres("No. Comprobante Fiscal Rel.", 19);
        END;
    end;

    procedure ValidaNCFReLVentas(SalesHeader: Record 36)
    begin
        WITH SalesHeader DO BEGIN
            IF STRLEN("No. Comprobante Fiscal") <> 19 THEN
                ERROR(Err006);

            IF COPYSTR("No. Comprobante Fiscal Rel.", 10, 2) = '04' THEN
                ERROR(Err001)
            ELSE
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    IF COPYSTR("No. Comprobante Fiscal Rel.", 10, 2) <> '01' THEN
                        ERROR(Err002);

            CASE COPYSTR("No. Comprobante Fiscal", 10, 2) OF
                '05' .. '10':
                    ERROR(Err004);
                '12':
                    ERROR(Err005);
            //AMS   '15'..'99':
            //AMS    ERROR(Err004);
            END;

            CASE COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) OF
                'K' .. 'O':
                    ERROR(Err003);
                'V' .. 'Z':
                    ERROR(Err003);
            END;
            //Para validar caracteres numericos solamente despues la posicion 1
            ValidaCaracteres("No. Comprobante Fiscal", 19);
        END;
    end;

    procedure ValidaCaracteres(NCF: Code[19]; Longitud: Integer)
    begin
        //Para validar caracteres numericos solamente despues la posicion 1
        FOR I := 2 TO Longitud DO BEGIN
            CASE COPYSTR(NCF, I, 1) OF
                '0' .. '9':
                    BEGIN
                    END;
                ELSE
                    ERROR(Err007);
            END;
        END;
    end;

    procedure ValidaClasifGasto(PurchHeader: Record 38)
    var
        VPG: Record 93;
    begin
        WITH PurchHeader DO BEGIN
            VPG.GET("Vendor Posting Group");
            IF ((VPG."NCF Obligatorio") AND (NOT Correction)) OR ((VPG."Permite Emitir NCF") AND (NOT Correction)) THEN
                IF "Cod. Clasificacion Gasto" = '' THEN
                    ERROR(Err009, FIELDCAPTION("Cod. Clasificacion Gasto"), FIELDCAPTION("Document Type"), "Document Type");
        END;
    end;

    procedure ValidaExiste(SalesHeader: Record 36; NCF: Code[19])
    var
        SIH_: Record 112;
        SCMH_: Record 114;
    begin
        WITH SalesHeader DO BEGIN
            IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) THEN BEGIN
                SIH_.RESET;
                SIH_.SETCURRENTKEY("No. Comprobante Fiscal");
                SIH_.SETRANGE("No. Comprobante Fiscal", NCF);
                IF SIH_.FINDFIRST THEN
                    ERROR(Error012, Text002, SIH_."No.");
            END;

            IF ("Document Type" IN ["Document Type"::"Credit Memo", "Document Type"::"Return Order"]) THEN BEGIN
                SCMH_.RESET;
                SCMH_.SETCURRENTKEY("No. Comprobante Fiscal");
                SCMH_.SETRANGE("No. Comprobante Fiscal", NCF);
                IF SCMH_.FINDFIRST THEN
                    ERROR(Error012, Text003, SCMH_."No.");
            END;
        END;
    end;

    procedure ValidaExisteServ(ServHeader: Record 5900; NCF: Code[19])
    var
        SSIH_: Record 5992;
        SSCMH_: Record 5994;
    begin
        WITH ServHeader DO BEGIN
            IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) THEN BEGIN
                SSIH_.RESET;
                SSIH_.SETCURRENTKEY("No. Comprobante Fiscal");
                SSIH_.SETRANGE("No. Comprobante Fiscal", NCF);
                IF SSIH_.FINDFIRST THEN
                    ERROR(Error012, Text002, SSIH_."No.");
            END;

            IF ("Document Type" = "Document Type"::"Credit Memo") THEN BEGIN
                SSCMH_.RESET;
                SSCMH_.SETCURRENTKEY("No. Comprobante Fiscal");
                SSCMH_.SETRANGE("No. Comprobante Fiscal", NCF);
                IF SSCMH_.FINDFIRST THEN
                    ERROR(Error012, Text003, SSCMH_."No.");
            END;
        END;
    end;

    procedure ValidaNCFCompras2018(PurchHeader: Record 38)
    var
        VendorPostingGr: Record 93;
        PurchCrMemoHeader: Record 124;
        PurchInvHeader: Record 122;
        PurchLines: Record 39;
        RetencionDocProveedores: Record 34003002;
    begin
        //DS//DSLoc1.03
        WITH PurchHeader DO BEGIN
            //DSLoc1.04
            IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') AND (STRLEN(PurchHeader."No. Comprobante Fiscal") <> 11) THEN
                ERROR(Err010)
            ELSE
                IF ((COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') AND (STRLEN(PurchHeader."No. Comprobante Fiscal") <> 13)) THEN
                    ERROR(Err016);

            // para generar y validar comprobante a nivel de "Buy-from Vendor No." ya que el pay vendor cambia el Vendor Posting Group al cambiarlo
            Vendor.RESET;
            Vendor.GET("Buy-from Vendor No.");
            VendorPostingGr.GET(Vendor."Vendor Posting Group");

            IF (VendorPostingGr."NCF Obligatorio") AND (NOT Correction) THEN
                TESTFIELD("No. Comprobante Fiscal")
            ELSE
                IF (VendorPostingGr."NCF Obligatorio") AND (PurchHeader."No. Comprobante Fiscal" = '') THEN
                    EXIT;

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN

                // DSLoc2.0 validar rnc si hay comprobante
                TESTFIELD("VAT Registration No.");

                //GRN Para que no se digite un NCF en un proveedor que no lo requiera
                IF COPYSTR("No. Comprobante Fiscal", 2, 2) = '02' THEN
                    ERROR(Err002);

                //DSLoc1.04
                IF COPYSTR("No. Comprobante Fiscal", 2, 2) = '32' THEN
                    ERROR(Err002);

                //GRN Si es informal, debe llevar retencion
                IF COPYSTR("No. Comprobante Fiscal", 2, 2) = '11' THEN BEGIN
                    //Buscamos al menos una linea con ITBIS
                    PurchLines.RESET;
                    PurchLines.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLines.SETRANGE("Document No.", PurchHeader."No.");
                    PurchLines.SETFILTER(Quantity, '<>%1', 0);
                    PurchLines.SETFILTER("VAT %", '<>%1', 0);
                    IF PurchLines.FINDFIRST THEN BEGIN
                        //Verificamos si hay retencion
                        RetencionDocProveedores.RESET;
                        RetencionDocProveedores.SETRANGE("Tipo documento", PurchHeader."Document Type");
                        RetencionDocProveedores.SETRANGE("No. documento", PurchHeader."No.");
                        IF NOT RetencionDocProveedores.FINDFIRST THEN
                            ERROR(Err020);
                    END;
                END;

                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') THEN
                    IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                        CASE COPYSTR("No. Comprobante Fiscal", 2, 2) OF
                            '05' .. '10':
                                ERROR(Err004);
                            '12':
                                ERROR(Err005);
                            '18' .. '99':
                                ERROR(Err004);
                        END;
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') THEN
                    IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                        CASE COPYSTR("No. Comprobante Fiscal", 2, 2) OF
                            '01' .. '30':
                                ERROR(Err004);
                            '35' .. '40':
                                ERROR(Err004);
                            '42':
                                ERROR(Err004);
                            '48' .. '99':
                                ERROR(Err004);
                        END;


                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') THEN
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                        IF (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '04') AND (NOT Correction) THEN
                            ERROR(Err002);
                    END
                    ELSE
                        IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) THEN
                            IF (COPYSTR("No. Comprobante Fiscal", 2, 2) = '04') AND (NOT Correction) THEN
                                ERROR(Err001);

                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') THEN
                    IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                        IF (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '34') AND (NOT Correction) THEN
                            ERROR(Err002);
                    END
                    ELSE
                        IF ("Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]) THEN
                            IF (COPYSTR("No. Comprobante Fiscal", 2, 2) = '34') AND (NOT Correction) THEN
                                ERROR(Err001);


                //DSLoc2.0  validar que solo sean B o E
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) <> 'B') AND (COPYSTR("No. Comprobante Fiscal", 1, 1) <> 'E') THEN
                    ERROR(Err011);

                /* CASE COPYSTR("No. Comprobante Fiscal",1,1) OF
                  'A':
                    ERROR(Err011);
                  'C'..'D':
                    ERROR(Err011);
                  'F'..'Z':
                    ERROR(Err011);
                  '0'..'9':
                    ERROR(Err011);
                 END;*/
                //jpg -- 13-05-2020 validar que solo sean B o E

                //Para validar caracteres numericos solamente despues la posicion 1
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') THEN
                    ValidaCaracteres("No. Comprobante Fiscal", 11);
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') THEN
                    ValidaCaracteres("No. Comprobante Fiscal", 13);
            END;

            //DSLoc1.01 To avoid a non-requested Vendor's NCF
            IF NOT Correction THEN BEGIN
                IF (NOT VendorPostingGr."NCF Obligatorio") AND (NOT VendorPostingGr."Permite Emitir NCF") THEN
                    TESTFIELD("No. Comprobante Fiscal", '');
            END
            ELSE
                TESTFIELD("Applies-to Doc. No."); //DSLoc1.01 To avoid a error in Corrected Documents

            IF ("Document Type" IN ["Document Type"::"Credit Memo"]) AND ("No. Comprobante Fiscal" <> '') THEN BEGIN
                PurchCrMemoHeader.SETCURRENTKEY("VAT Registration No.", "No. Comprobante Fiscal");
                PurchCrMemoHeader.SETRANGE("VAT Registration No.", "VAT Registration No.");
                PurchCrMemoHeader.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal");
                PurchCrMemoHeader.SETFILTER("No.", '<>%1', "Posting No.");
                IF PurchCrMemoHeader.FINDFIRST THEN
                    ERROR(Err008, "No. Comprobante Fiscal", "Buy-from Vendor No.");
            END
            ELSE
                IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                    PurchInvHeader.SETCURRENTKEY("VAT Registration No.", "No. Comprobante Fiscal");
                    PurchInvHeader.SETRANGE("VAT Registration No.", "VAT Registration No.");
                    PurchInvHeader.SETRANGE("No. Comprobante Fiscal", "No. Comprobante Fiscal");
                    PurchInvHeader.SETFILTER("No.", '<>%1', "Posting No.");
                    IF PurchInvHeader.FINDFIRST THEN
                        ERROR(Err008, "No. Comprobante Fiscal", "Buy-from Vendor No.");
                END;

            //DSLoc1.01 To let the NCF available
            IF Correction THEN
                IF ("Document Type" IN ["Document Type"::"Credit Memo"]) AND (Correction) THEN BEGIN
                    PurchInvHeader.GET(PurchHeader."Applies-to Doc. No.");
                    PurchInvHeader."No. Comprobante Fiscal" := Text001 + COPYSTR(PurchInvHeader."No. Comprobante Fiscal", 6, 8);
                    PurchInvHeader.MODIFY;
                END;
            IF Correction THEN
                IF ("Document Type" IN ["Document Type"::Invoice]) AND (Correction) THEN BEGIN
                    PurchCrMemoHeader.RESET;
                    PurchCrMemoHeader.GET(PurchHeader."Applies-to Doc. No.");
                    PurchCrMemoHeader."No. Comprobante Fiscal" := Text001 + COPYSTR(PurchCrMemoHeader."No. Comprobante Fiscal", 6, 8);
                    PurchCrMemoHeader.MODIFY;
                END;

            ValidaClasifGasto(PurchHeader);

            //Verifico las lineas
            IF NOT Invoice THEN
                EXIT;
            PurchLines.RESET;
            PurchLines.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchLines.SETRANGE("Document No.", PurchHeader."No.");
            PurchLines.SETFILTER(Quantity, '<>%1', 0);
            PurchLines.SETFILTER("Direct Unit Cost", '<>%1', 0);
            IF PurchLines.FINDSET THEN
                REPEAT
                    IF PurchLines."VAT Prod. Posting Group" = '' THEN
                        ERROR(STRSUBSTNO(Err015, PurchLines.FIELDCAPTION("VAT Prod. Posting Group"), PurchLines.TABLECAPTION, PurchLines.TABLECAPTION, PurchLines.Type, PurchLines."No.", PurchLines.FIELDCAPTION(Description), PurchLines.Description));
                UNTIL PurchLines.NEXT = 0;
        END;

    end;

    procedure ValidaNCFVentas2018(SalesHeader: Record 36)
    var
        CustPostingGr: Record 92;
        SalesLines: Record 37;
        GLAccount: Record 15;
    begin
        WITH SalesHeader DO BEGIN
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                IF Correction THEN
                    SalesHeader.TESTFIELD("Razon anulacion NCF");

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                IF (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '02') AND (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '04') THEN
                    TESTFIELD("Fecha vencimiento NCF");
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') AND (STRLEN("No. Comprobante Fiscal") <> 11) THEN
                    ERROR(Err010)
                ELSE
                    IF ((COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') AND (STRLEN("No. Comprobante Fiscal") <> 13)) THEN
                        ERROR(Err016);

                IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                    CASE COPYSTR("No. Comprobante Fiscal", 2, 2) OF
                        '12':
                            ERROR(Err005);
                    END;


                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF COPYSTR("No. Comprobante Fiscal", 2, 2) <> '04' THEN
                        ERROR(Err002);
                    IF Correction THEN
                        SalesHeader.TESTFIELD("Razon anulacion NCF");
                END;

                //DSLoc2.0  validar que solo sean B o E
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) <> 'B') AND (COPYSTR("No. Comprobante Fiscal", 1, 1) <> 'E') THEN
                    ERROR(Err011);
                /* //DSLoc1.04
                        CASE COPYSTR("No. Comprobante Fiscal",1,1) OF
                        'A':
                          ERROR(Err011);
                        'C'..'D':
                          ERROR(Err011);
                        'F'..'Z':
                          ERROR(Err011);
                       END;*/

                //Para validar caracteres numericos solamente despues la posicion 1
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'B') THEN
                    ValidaCaracteres("No. Comprobante Fiscal", 11);
                //DSLoc1.04
                IF (COPYSTR("No. Comprobante Fiscal", 1, 1) = 'E') THEN
                    ValidaCaracteres("No. Comprobante Fiscal", 13);

            END ELSE BEGIN //jpg 2-9-2020 validar que no. comprobante no este vacio si debe generarlo
                CustPostingGr.RESET;
                IF SalesHeader.Invoice THEN
                    IF CustPostingGr.GET(SalesHeader."Customer Posting Group") THEN
                        IF (CustPostingGr."Permite emitir NCF") AND (NOT Correction) THEN
                            TESTFIELD("No. Comprobante Fiscal");
            END;

            //Verifico las lineas
            SalesLines.RESET;
            SalesLines.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLines.SETRANGE("Document No.", SalesHeader."No.");
            SalesLines.SETFILTER(Quantity, '<>%1', 0);
            SalesLines.SETFILTER("Unit Price", '<>%1', 0);
            IF SalesLines.FINDSET THEN
                REPEAT
                    IF SalesLines.Type = SalesLines.Type::"G/L Account" THEN BEGIN
                        GLAccount.GET(SalesLines."No.");
                        IF (SalesHeader."Tipo de ingreso" <> GLAccount."Cod. Clasificacion Gasto") AND (GLAccount."Cod. Clasificacion Gasto" <> '') THEN
                            ERROR(STRSUBSTNO(Err013, SalesLines.FIELDCAPTION(Type), SalesLines."No.", GLAccount."Cod. Clasificacion Gasto"));
                    END
                    ELSE
                        IF SalesLines.Type = SalesLines.Type::"Fixed Asset" THEN BEGIN
                            IF SalesHeader."Tipo de ingreso" <> '05' THEN
                                ERROR(Err014);
                        END;
                    SalesLines.TESTFIELD("VAT Prod. Posting Group");
                UNTIL SalesLines.NEXT = 0;

        END;

    end;

    procedure ValidaNCFVentasServ2018(ServHeader: Record 5900)
    var
        CustPostingGr: Record 92;
    begin
        WITH ServHeader DO BEGIN
            IF "Document Type" = "Document Type"::"Credit Memo" THEN
                IF Correction THEN
                    ServHeader.TESTFIELD("Razon anulacion NCF");

            IF "No. Comprobante Fiscal" <> '' THEN BEGIN
                IF (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '02') AND (COPYSTR("No. Comprobante Fiscal", 2, 2) <> '04') THEN
                    TESTFIELD("Fecha vencimiento NCF");
                IF STRLEN("No. Comprobante Fiscal") <> 11 THEN
                    ERROR(Err006);

                IF ("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Order) THEN
                    CASE COPYSTR("No. Comprobante Fiscal", 2, 2) OF
                        '12':
                            ERROR(Err005);
                    END;

                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    IF COPYSTR("No. Comprobante Fiscal", 2, 2) <> '04' THEN
                        ERROR(Err002);
                    IF Correction THEN
                        ServHeader.TESTFIELD("Razon anulacion NCF");
                END;
                CASE COPYSTR("No. Comprobante Fiscal", 1, 1) OF
                    'A':
                        ERROR(Err003);
                    'C' .. 'Z':
                        ERROR(Err003);
                END;
                //Para validar caracteres numericos solamente despues la posicion 1
                ValidaCaracteres("No. Comprobante Fiscal", 11);
            END;
        END;
    end;

    procedure ValidaNCFRelacionadoCompras(PurchHeader: Record 38)
    var
        VendorPostingGr: Record 93;
        PurchCrMemoHeader: Record 124;
        PurchInvHeader: Record 122;
        PurchLines: Record 39;
        RetencionDocProveedores: Record 34003002;
    begin
        //DSLoc2.0
        WITH PurchHeader DO BEGIN

            IF "No. Comprobante Fiscal Rel." <> '' THEN BEGIN
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 11) THEN
                    ERROR(Err010)
                ELSE
                    IF ((COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 13)) THEN
                        ERROR(Err016)
                    ELSE
                        IF ((COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 19)) THEN
                            ERROR(Err006);


                // validar que solo sean B o E  A
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'B') AND (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'E') AND (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'A') THEN
                    ERROR(Err017);



                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '05' .. '10':
                            ERROR(Err018);
                        '18' .. '99':
                            ERROR(Err018);
                    END;

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '05' .. '10':
                            ERROR(Err018);
                        '18' .. '99':
                            ERROR(Err018);
                    END;

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '01' .. '30':
                            ERROR(Err018);
                        '35' .. '40':
                            ERROR(Err018);
                        '42':
                            ERROR(Err018);
                        '48' .. '99':
                            ERROR(Err018);
                    END;


                //Para validar caracteres numericos solamente despues la posicion 1
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 11);

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 13);

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 19);

            END;
        END;
    end;

    procedure ValidaNCFRelacionadoVentas(SalesHeader: Record 36)
    begin
        //DSLoc2.0
        WITH SalesHeader DO BEGIN

            IF "No. Comprobante Fiscal Rel." <> '' THEN BEGIN
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 11) THEN
                    ERROR(Err010)
                ELSE
                    IF ((COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 13)) THEN
                        ERROR(Err016)
                    ELSE
                        IF ((COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') AND (STRLEN("No. Comprobante Fiscal Rel.") <> 19)) THEN
                            ERROR(Err006);


                // validar que solo sean B o E  A
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'B') AND (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'E') AND (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) <> 'A') THEN
                    ERROR(Err017);


                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '05' .. '10':
                            ERROR(Err018);
                        '18' .. '99':
                            ERROR(Err018);
                    END;

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '05' .. '10':
                            ERROR(Err018);
                        '18' .. '99':
                            ERROR(Err018);
                    END;

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') THEN
                    CASE COPYSTR("No. Comprobante Fiscal Rel.", 2, 2) OF
                        '01' .. '30':
                            ERROR(Err018);
                        '35' .. '40':
                            ERROR(Err018);
                        '42':
                            ERROR(Err018);
                        '48' .. '99':
                            ERROR(Err018);
                    END;


                //Para validar caracteres numericos solamente despues la posicion 1
                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'B') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 11);

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'E') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 13);

                IF (COPYSTR("No. Comprobante Fiscal Rel.", 1, 1) = 'A') THEN
                    ValidaCaracteres("No. Comprobante Fiscal Rel.", 19);

            END;
        END;
    end;
}

