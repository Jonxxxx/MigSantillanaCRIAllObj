xmlport 34003009 "Archivo 607 - 2018"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(ITBIS607)
        {
            tableelement(Table2000000026; 2000000026)
            {
                XmlName = 'Cabecera';
                //TODO: Ver 
                /*
                SourceTableView = SORTING(Field1)
                                  WHERE(Field1 = CONST(1));*/
                textelement(CodigoInformacion)
                {
                    Width = 3;
                }
                textelement(CabRncTxt)
                {
                    Width = 11;
                }
                textelement(CabPeriodo)
                {
                    Width = 6;
                }
                textelement(CantidadRegistrostxt)
                {
                    Width = 12;
                }

                trigger OnAfterGetRecord()
                begin


                    ConfCompany.GET();
                    CodigoInformacion := '607';
                    Fecha := TranfITBIS."Fecha Documento";
                    CabPeriodo := COPYSTR(Fecha, 1, 4) + COPYSTR(Fecha, 5, 2);
                    TranfITBIS.RNC := DELCHR(ConfCompany."VAT Registration No.", '=', '- ');
                    TranfITBIS.RNC := DELCHR(TranfITBIS.RNC, '=', '- ');
                    CabRncTxt := TranfITBIS.RNC;
                    CantidadRegistrostxt := FORMAT(CantidadRegistros);
                end;

                trigger OnPreXmlItem()
                begin
                    TranfITBIS.RESET;
                    TranfITBIS.SETRANGE(TranfITBIS."Codigo reporte", '607');
                    IF TranfITBIS.FIND('-') THEN BEGIN
                        CantidadRegistros := TranfITBIS.COUNT;
                        REPEAT
                            IF TranfITBIS."Tipo documento" = 1 THEN
                                dTotFact += TranfITBIS."Total Documento"
                            ELSE
                                dTotFact -= TranfITBIS."Total Documento";
                        UNTIL TranfITBIS.NEXT = 0;
                    END;
                end;
            }
            tableelement("Archivo Transferencia ITBIS"; 34003004)
            {
                XmlName = 'ITBIS';
                //TODO: Ver 
                /*
                SourceTableView = SORTING(Field7, Field8, Field5, Field6, Field18)
                                  WHERE(Field18 = CONST(607));*/
                textelement(RncTxt)
                {
                    Width = 11;
                }
                textelement(TipoID)
                {
                    Width = 1;
                }
                fieldelement(NCF; "Archivo Transferencia ITBIS".NCF)
                {
                    Width = 19;
                }
                fieldelement(NCFRelacionado; "Archivo Transferencia ITBIS"."NCF Relacionado")
                {
                    Width = 19;
                }
                fieldelement(TipoIngreso; "Archivo Transferencia ITBIS"."Tipo de ingreso")
                {
                }
                textelement(Fecha)
                {
                    Width = 8;
                }
                textelement(FechaRetencion)
                {
                }
                textelement(TotFact)
                {
                    Width = 12;
                }
                textelement(TotITBIS)
                {
                    Width = 12;
                }
                textelement(ITBISRetenido)
                {
                }
                textelement(ITBISPercibido)
                {
                }
                textelement(RetencionRenta)
                {
                }
                textelement(ISRpercibido)
                {
                }
                textelement(Selectivo)
                {
                }
                textelement(OtroImpuestos)
                {
                }
                textelement(Propina)
                {
                }
                textelement(Efectivo)
                {
                }
                textelement(Cheque)
                {
                }
                textelement(Tarjeta)
                {
                }
                textelement(Credito)
                {
                }
                textelement(Bonos)
                {
                }
                textelement(Permuta)
                {
                }
                textelement(Otros)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotITBIS := '';
                    ITBISRetenido := '';
                    ITBISPercibido := '';
                    RetencionRenta := '';
                    ISRpercibido := '';
                    Selectivo := '';
                    OtroImpuestos := '';
                    Propina := '';
                    Efectivo := '';
                    Cheque := '';
                    Tarjeta := '';
                    Credito := '';
                    Bonos := '';
                    Permuta := '';
                    Otros := '';
                    FechaRetencion := '';

                    IF (COPYSTR("Archivo Transferencia ITBIS".NCF, 1, 3) = 'B02') AND (("Archivo Transferencia ITBIS"."Total Documento" + "Archivo Transferencia ITBIS"."ITBIS Pagado") <= 250000) THEN
                        currXMLport.SKIP;

                    WITH "Archivo Transferencia ITBIS" DO BEGIN
                        TipoID := '1';
                        CLEAR(Espacios);

                        IF RNC = '' THEN BEGIN
                            RNC := "RNC/Cedula";
                            TipoID := '2';
                        END;

                        IF RNC = '' THEN
                            TipoID := '3';

                        RNC := DELCHR(RNC, '=', '- ');
                        RncTxt := RNC;

                        CLEAR(Espacios);
                        NumDoc := "Numero Documento";

                        IF "Fecha Documento" <= '20061231' THEN
                            CLEAR(NCF)
                        ELSE
                            CLEAR(NumDoc);

                        Fecha := "Fecha Documento";

                        IF "Total Documento" > 0 THEN
                            BienServ := '1'
                        ELSE
                            BienServ := '3';


                        CLEAR(Espacios);
                        TotFact := DELCHR(FORMAT("Total Documento"), '=', ', ');
                        TotFact := CONVERTSTR(TotFact, ' ', '0');

                        TotITBIS := FORMAT("ITBIS Pagado");
                        TotITBIS := DELCHR(TotITBIS, '=', ', ');

                        IF "ISR Retenido" <> 0 THEN BEGIN
                            RetencionRenta := FORMAT("ISR Retenido");
                            RetencionRenta := DELCHR(RetencionRenta, '=', ', ');
                            IF "Fecha Retencion Venta" <> '' THEN //jpg 17-11-2020 para capturar fecha retencion "Fecha Retencion" si el campo "Fecha Retencion Venta" es null
                                FechaRetencion := "Fecha Retencion Venta"
                            ELSE
                                FechaRetencion := FORMAT("Fecha Retencion", 0, '<year4>') + FORMAT("Fecha Retencion", 0, '<Month,2>') +
                                                            FORMAT("Fecha Retencion", 0, '<day,2>');

                        END;

                        IF "ITBIS Retenido" <> 0 THEN BEGIN
                            ITBISRetenido := FORMAT("ITBIS Retenido");
                            ITBISRetenido := DELCHR(ITBISRetenido, '=', ', ');
                            IF "Fecha Retencion Venta" <> '' THEN //jpg 17-11-2020 para capturar fecha retencion "Fecha Retencion" si el campo "Fecha Retencion Venta" es null
                                FechaRetencion := "Fecha Retencion Venta"
                            ELSE
                                FechaRetencion := FORMAT("Fecha Retencion", 0, '<year4>') + FORMAT("Fecha Retencion", 0, '<Month,2>') +
                                                            FORMAT("Fecha Retencion", 0, '<day,2>');

                        END;

                        IF "Monto Selectivo" <> 0 THEN
                            Selectivo := DELCHR(FORMAT("Monto Selectivo"), '=', ', ');
                        IF "Monto Propina" <> 0 THEN
                            Propina := DELCHR(FORMAT("Monto Propina"), '=', ', ');
                        IF "Monto otros" <> 0 THEN
                            Otros := DELCHR(FORMAT("Monto otros"), '=', ', ');

                        IF "Monto Efectivo" <> 0 THEN
                            Efectivo := DELCHR(FORMAT("Monto Efectivo"), '=', ', ')
                        ELSE
                            Efectivo := '0';
                        IF "Monto Cheque" <> 0 THEN
                            Cheque := DELCHR(FORMAT("Monto Cheque"), '=', ', ')
                        ELSE
                            Cheque := '0';
                        IF "Monto otros" <> 0 THEN
                            Otros := DELCHR(FORMAT("Monto otros"), '=', ', ');
                        IF "Monto tarjetas" <> 0 THEN
                            Tarjeta := DELCHR(FORMAT("Monto tarjetas"), '=', ', ')
                        ELSE
                            Tarjeta := '0';
                        IF "Venta a credito" <> 0 THEN
                            Credito := DELCHR(FORMAT("Venta a credito"), '=', ', ')
                        ELSE
                            Credito := '0';
                        IF "Venta bonos" <> 0 THEN
                            Bonos := DELCHR(FORMAT("Venta bonos"), '=', ', ')
                        ELSE
                            Bonos := '0';
                        IF "Venta Permuta" <> 0 THEN
                            Permuta := DELCHR(FORMAT("Venta Permuta"), '=', ', ')
                        ELSE
                            Permuta := '0';
                    END;
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
        CantidadRegistros: Integer;
        dTotFact: Decimal;
        Espacios: Text[30];
        BienServ: Code[10];
        NumDoc: Text[30];
        Periodo: Code[8];
}

