xmlport 34003008 "Archivo 606 - 2018"
{
    // Proyecto: Microsoft Dynamics Nav
    // ---------------------------------
    // JPG    : John Peralta Guzman
    // ------------------------------------------------------------------------
    // No.         Fecha       Firma      Descripcion
    // ------------------------------------------------------------------------
    // DSLoc1.04   26-jul-2019  JPG       itbis llevado al costo

    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;
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
                //SourceTableView = SORTING(Field7, Field8, Field5, Field6, Field18)
                //                  ORDER(Ascending)
                //                  WHERE(Field18 = FILTER(606));
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
                textelement(Periodo)
                {
                    Width = 6;
                }
                textelement(cantidadregistrostxt)
                {
                    XmlName = 'CantidadRegistrostxt';
                    Width = 12;
                }

                trigger OnAfterGetRecord()
                begin

                    ConfCompany.GET();
                    CodigoInformacion := '606';
                    Periodo := COPYSTR(ATI."Fecha Documento", 1, 4) + COPYSTR(ATI."Fecha Documento", 5, 2);
                    RNC := DELCHR(ConfCompany."VAT Registration No.", '=', '- ');
                    RNC := DELCHR(RNC, '=', '- ');
                    RncTxt := RNC;
                    CantidadRegistrostxt := DELCHR(FORMAT(CantidadRegistros), '=', ',');
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
                fieldelement(FechaComprobante; ATI_2."Fecha Documento")
                {
                }
                fieldelement(FechaPago; ATI_2."Fecha Pago")
                {
                    Width = 8;
                }
                textelement(Servicios)
                {
                }
                textelement(Bienes)
                {
                }
                textelement(MontoFacturado)
                {
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
                textelement(ITBISProp)
                {
                }
                textelement(ITBISCosto)
                {
                }
                textelement(ITBISAdelantado)
                {
                }
                textelement(ITBISCompras)
                {
                }
                textelement(TipoRetISR)
                {
                }
                textelement(RetencionISR)
                {
                    Width = 12;
                }
                textelement(ISRCompra)
                {
                }
                textelement(Selectivo)
                {
                }
                textelement(Otros)
                {
                }
                textelement(Propina)
                {
                }
                textelement(FormaPago)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Servicios := '';
                    TotITBIS := '';
                    ITBISRet := '';
                    MontoFacturado := '';
                    RetencionISR := '';
                    Bienes := '';
                    Propina := '';
                    Selectivo := '';
                    Otros := '';
                    ITBISProp := '';
                    ITBISCosto := '';
                    ITBISAdelantado := '';
                    ITBISCompras := '';
                    TipoRetISR := '';
                    ISRCompra := '';


                    TipoID := '1';
                    CLEAR(Espacios);

                    IF ATI_2.RNC = '' THEN
                        TipoID := '2';

                    RNCProveedor := ATI_2."RNC/Cedula";

                    RNC := DELCHR(RNCProveedor, '=', '- ');
                    RncTxt2 := RNC;

                    /*
                    //Fecha de pago
                    VLE.RESET;
                    VLE.SETCURRENTKEY("Document No.","Document Type","Vendor No.");
                    VLE.SETRANGE("Document No.",ATI_2."Numero Documento");
                    VLE.SETRANGE("Posting Date",ATI_2."fecha registro");
                    VLE.SETRANGE(Open,FALSE);
                    IF VLE.FINDFIRST THEN
                      BEGIN
                        IF VLE."Closed at Date" <> 0D THEN;
                      //  Periodo2 := ATI_2."Fecha Pago"+ATI_2."Dia Pago";
                      END;
                    */

                    IF ATI_2."Total Documento" > 0 THEN
                        BienServ := '1'
                    ELSE
                        BienServ := '3';

                    IF ATI_2."Monto Servicios" <> 0 THEN
                        Servicios := DELCHR(FORMAT(ATI_2."Monto Servicios"), '=', ',');

                    IF ATI_2."Monto Bienes" <> 0 THEN
                        Bienes := DELCHR(FORMAT(ATI_2."Monto Bienes"), '=', ',');

                    IF ATI_2."ITBIS Pagado" <> 0 THEN
                        TotITBIS := DELCHR(FORMAT(ATI_2."ITBIS Pagado"), '=', ',');

                    IF ATI_2."ITBIS Retenido" <> 0 THEN
                        ITBISRet := DELCHR(FORMAT(ATI_2."ITBIS Retenido"), '=', ',');

                    IF ATI_2."Total Documento" <> 0 THEN
                        MontoFacturado := DELCHR(FORMAT(ATI_2."Total Documento"), '=', ',');

                    IF ATI_2."ISR Retenido" <> 0 THEN
                        RetencionISR := DELCHR(FORMAT(ATI_2."ISR Retenido"), '=', ',');

                    IF ATI_2."Monto Selectivo" <> 0 THEN
                        Selectivo := DELCHR(FORMAT(ATI_2."Monto Selectivo"), '=', ',');
                    // DSLoc1.04
                    IF ATI_2."ITBIS llevado al costo" <> 0 THEN
                        ITBISCosto := DELCHR(FORMAT(ATI_2."ITBIS llevado al costo"), '=', ',');

                    // DSLoc1.04 jpg 08-07-2020
                    IF ATI_2."ITBIS Por adelantar" <> 0 THEN
                        ITBISAdelantado := DELCHR(FORMAT(ATI_2."ITBIS Por adelantar"), '=', ',');


                    RetISR := ATI_2."Tipo retencion ISR";
                    TipoRetISR := FORMAT(RetISR);
                    IDClasificacion := ATI_2."Clasific. Gastos y Costos NCF";
                    IF STRLEN(IDClasificacion) = 1 THEN
                        IDClasificacion := '0' + IDClasificacion;


                    IF ATI_2."Forma de pago DGII" = 0 THEN
                        ERROR(Err001);

                    CASE ATI_2."Forma de pago DGII" OF
                        0:
                            BEGIN
                            END;
                        1:
                            FormaPago := '01';
                        2:
                            FormaPago := '02';
                        3:
                            FormaPago := '03';
                        4:
                            FormaPago := '04';
                        5:
                            FormaPago := '05';
                        6:
                            FormaPago := '06';
                        7:
                            FormaPago := '07';
                        ELSE
                            FormaPago := '08';
                    END;


                    IF ATI_2."Monto otros" <> 0 THEN
                        Otros := FORMAT(ATI_2."Monto otros");
                    IF ATI_2."Monto Propina" <> 0 THEN
                        Propina := FORMAT(ATI_2."Monto Propina");

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
        RetISR: Integer;
        Err001: Label 'Forma de pago DGII debe tener un valor segun la legislacion fiscal';
}

