xmlport 34003001 "ITBIS Ventas NCF Formato 607"
{
    Direction = Export;
    Format = FixedText;
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
                                  WHERE(Field1=CONST(1));*/
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
                textelement(TotalMontoFacturadotxt)
                {
                    Width = 16;
                }

                trigger OnAfterGetRecord()
                begin


                    ConfCompany.GET();
                    CodigoInformacion := '607';
                    Fecha := TranfITBIS."Fecha Documento";
                    CabPeriodo := COPYSTR(Fecha, 1, 4) + COPYSTR(Fecha, 5, 2);
                    TranfITBIS.RNC := DELCHR(ConfCompany."VAT Registration No.", '=', '- ');
                    TranfITBIS.RNC := DELCHR(TranfITBIS.RNC, '=', '- ');
                    Espacios := PADSTR(Espacios, 11 - STRLEN(TranfITBIS.RNC), ' ');
                    CabRncTxt := Espacios + TranfITBIS.RNC;
                    CantidadRegistrostxt := FORMAT((CantidadRegistros), 12, '<integer,12><Filler Character,0>');
                    CLEAR(Espacios);
                    TotalMontoFacturadotxt := FORMAT((dTotFact), 16, '<integer><Decimal,3>');
                    TotalMontoFacturadotxt := CONVERTSTR(TotalMontoFacturadotxt, ' ', '0');
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
                textelement(Fecha)
                {
                    Width = 8;
                }
                textelement(TotITBIS)
                {
                    Width = 12;
                }
                textelement(TotFact)
                {
                    Width = 12;
                }

                trigger OnAfterGetRecord()
                begin
                    WITH "Archivo Transferencia ITBIS" DO BEGIN
                        TipoID := '1';
                        CLEAR(Espacios);

                        IF RNC = '' THEN BEGIN
                            RNC := Cedula;
                            TipoID := '2';
                        END;

                        IF RNC = '' THEN
                            TipoID := '3';

                        RNC := DELCHR(RNC, '=', '- ');
                        Espacios := PADSTR(Espacios, 11 - STRLEN(RNC), ' ');
                        RncTxt := RNC + Espacios;

                        CLEAR(Espacios);
                        Espacios := PADSTR(Espacios, 25 - STRLEN("Numero Documento"), ' ');
                        NumDoc := "Numero Documento" + Espacios;

                        IF "Fecha Documento" <= '20061231' THEN
                            CLEAR(NCF)
                        ELSE
                            CLEAR(NumDoc);

                        Fecha := "Fecha Documento";
                        Periodo := '00000000';


                        IF "Total Documento" > 0 THEN
                            BienServ := '1'
                        ELSE
                            BienServ := '3';


                        CLEAR(Espacios);
                        TotFact := FORMAT(("Total Documento"), 12, '<Integer><Decimals,3>');
                        //  Espacios             := PADSTR(Espacios,12 - STRLEN(TotFact),'0');
                        //  TotFact              := Espacios + TotFact;
                        TotFact := CONVERTSTR(TotFact, ' ', '0');

                        CLEAR(Espacios);
                        TotITBIS := FORMAT(("ITBIS Pagado"), 12, '<Integer><Decimal,3>');
                        //  Espacios             := PADSTR(Espacios,12 - STRLEN(TotITBIS),'0');
                        //  TotITBIS             := Espacios + TotITBIS;
                        TotITBIS := CONVERTSTR(TotITBIS, ' ', '0');

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

