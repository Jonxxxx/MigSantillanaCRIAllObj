xmlport 34003000 "Archivo ITBIS Compras NCF 606"
{
    Direction = Export;
    Format = FixedText;
    TableSeparator = '<NewLine><None>';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(ati; 34003004)
            {
                MaxOccurs = Once;
                XmlName = 'ATI';
                //TODO: Ver 
                /*
                SourceTableView = SORTING(Field7, Field8, Field5, Field6, Field18)
                                  ORDER(Ascending)
                                  WHERE(Field18 = FILTER(606));*/
                textelement(codigoinformacion)
                {
                    XmlName = 'CodigoInformacion';
                    Width = 3;
                }
                textelement(rnctxt)
                {
                    XmlName = 'RncTxt';
                    Width = 11;
                }
                textelement(periodo)
                {
                    XmlName = 'Periodo';
                    Width = 6;
                }
                textelement(cantidadregistrostxt)
                {
                    XmlName = 'CantidadRegistrostxt';
                    Width = 12;
                }
                textelement(totalmontofacturadotxt)
                {
                    XmlName = 'TotalMontoFacturadotxt';
                    Width = 16;
                }
                textelement(RetencionRentatxt)
                {
                    Width = 12;
                }

                trigger OnAfterGetRecord()
                begin

                    ConfCompany.GET();
                    CodigoInformacion := '606';
                    Fecha := ATI."Fecha Documento";
                    Periodo := COPYSTR(Fecha, 1, 4) + COPYSTR(Fecha, 5, 2);
                    RNC := DELCHR(ConfCompany."VAT Registration No.", '=', '- ');
                    RNC := DELCHR(RNC, '=', '- ');
                    Espacios := PADSTR(Espacios, 11 - STRLEN(RNC), ' ');
                    RncTxt := Espacios + RNC;
                    CantidadRegistrostxt := FORMAT((CantidadRegistros), 12, '<integer,12><Filler Character,0>');
                    CLEAR(Ceros);
                    Ceros := PADSTR(Ceros, 16 - STRLEN(FORMAT((dTotFact), 0, '<integer><Decimal>')), '0');
                    TotalMontoFacturadotxt := Ceros + FORMAT((dTotFact), 0, '<integer><Decimal>');
                    CLEAR(Ceros);
                    Ceros := PADSTR(Ceros, 12 - STRLEN(FORMAT((RetencionRenta), 0, '<integer><Decimal>')), '0');
                    RetencionRentatxt := Ceros + FORMAT((RetencionRenta), 0, '<integer><Decimal>');
                end;

                trigger OnPreXmlItem()
                begin
                    TranfITBIS.RESET;
                    TranfITBIS.SETRANGE("Codigo reporte", '606');
                    IF TranfITBIS.FINDSET THEN BEGIN
                        CantidadRegistros := TranfITBIS.COUNT;
                        REPEAT
                            IF TranfITBIS."Tipo documento" = 1 THEN BEGIN
                                dTotFact += TranfITBIS."Total Documento";
                                RetencionRenta += TranfITBIS."ISR Retenido";
                            END
                            ELSE BEGIN
                                dTotFact -= TranfITBIS."Total Documento";
                                RetencionRenta -= TranfITBIS."ISR Retenido";
                            END;
                        UNTIL TranfITBIS.NEXT = 0;
                    END;
                end;
            }
            tableelement(ati_2; 34003004)
            {
                XmlName = 'ATI_2';
                //TODO: Ver 
                /*
                SourceTableView = SORTING(Field7, Field8, Field5, Field6, Field18)
                                  ORDER(Ascending)
                                  WHERE(Field18 = FILTER(606));*/
                textelement(rnctxt2)
                {
                    XmlName = 'RncTxt2';
                    Width = 11;
                }
                textelement(tipoid)
                {
                    XmlName = 'TipoID';
                    Width = 1;
                }
                textelement(idclasificacion)
                {
                    XmlName = 'IDClasificacion';
                    Width = 2;
                }
                fieldelement(NCF; ATI_2.NCF)
                {
                    Width = 19;
                }
                fieldelement(NCRRel; ATI_2."NCF Relacionado")
                {
                    Width = 19;
                }
                textelement(fecha)
                {
                    XmlName = 'Fecha';
                    Width = 8;
                }
                textelement(periodo2)
                {
                    XmlName = 'Periodo2';
                    Width = 8;
                }
                textelement(totitbis)
                {
                    XmlName = 'TotITBIS';
                    Width = 12;
                }
                textelement(itbisret)
                {
                    XmlName = 'ITBISRet';
                    Width = 12;
                }
                textelement(totfact)
                {
                    XmlName = 'TotFact';
                    Width = 12;
                }
                textelement(RetencionISR)
                {
                    Width = 12;
                }

                trigger OnAfterGetRecord()
                begin
                    TipoID := '1';
                    CLEAR(Espacios);

                    IF ATI_2.RNC = '' THEN
                        TipoID := '2';

                    RNCProveedor := ATI_2."RNC/Cedula";

                    RNC := DELCHR(RNCProveedor, '=', '- ');
                    Espacios := PADSTR(Espacios, 11 - STRLEN(RNC), ' ');
                    RncTxt2 := RNC + Espacios;

                    Fecha := ATI_2."Fecha Documento" + ATI_2.Dia;

                    //Fecha de pago
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
                    VLE.SETRANGE("Document No.", ATI_2."Numero Documento");
                    VLE.SETRANGE("Posting Date", ATI_2."fecha registro");
                    VLE.SETRANGE(Open, FALSE);
                    IF VLE.FINDFIRST THEN BEGIN
                        IF VLE."Closed at Date" <> 0D THEN;
                        Periodo2 := ATI_2."Fecha Pago" + ATI_2."Dia Pago";
                    END
                    ELSE
                        Periodo2 := '00000000';

                    IF ATI_2."Total Documento" > 0 THEN
                        BienServ := '1'
                    ELSE
                        BienServ := '3';


                    CLEAR(Espacios);
                    Espacios := PADSTR(Espacios, 12 - STRLEN(FORMAT((ATI_2."ITBIS Pagado"), 0, '<integer><Decimal,3>')), '0');
                    TotITBIS := Espacios + FORMAT((ATI_2."ITBIS Pagado"), 0, '<integer><Decimal,3>');

                    CLEAR(Espacios);
                    Espacios := PADSTR(Espacios, 12 - STRLEN(FORMAT((ATI_2."ITBIS Retenido"), 0, '<integer><Decimal,3>')), '0');
                    ITBISRet := Espacios + FORMAT((ATI_2."ITBIS Retenido"), 0, '<integer><Decimal,3>');

                    CLEAR(Espacios);
                    Espacios := PADSTR(Espacios, 12 - STRLEN(FORMAT((ATI_2."Total Documento"), 0, '<integer><Decimal,3>')), '0');
                    TotFact := Espacios + FORMAT((ATI_2."Total Documento"), 0, '<integer><Decimal,3>');

                    CLEAR(Espacios);
                    Espacios := PADSTR(Espacios, 12 - STRLEN(FORMAT((ATI_2."ISR Retenido"), 0, '<integer><Decimal,3>')), '0');
                    RetencionISR := Espacios + FORMAT((ATI_2."ISR Retenido"), 0, '<integer><Decimal,3>');


                    IDClasificacion := ATI_2."Clasific. Gastos y Costos NCF";
                    IF STRLEN(IDClasificacion) = 1 THEN
                        IDClasificacion := '0' + IDClasificacion;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        ConfCompany: Record 79;
        TranfITBIS: Record 34003004;
        AnoTxt: Text[4];
        MesTxt: Text[2];
        DiaTxt: Text[2];
        PrimeraVez: Integer;
        Espacios: Text[30];
        dTotFact: Decimal;
        dTotITBIS: Decimal;
        CantidadRegistros: Integer;
        BienServ: Code[10];
        RNC: Text[20];
        Ceros: Text[30];
        RetencionRenta: Decimal;
        RNCProveedor: Text[20];
        VLE: Record 25;
        VLE1: Record 25;
}

