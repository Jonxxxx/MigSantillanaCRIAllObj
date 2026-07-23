xmlport 34003003 "Compras Divisas Formato 612"
{
    Direction = Export;
    Format = FixedText;
    TableSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(ITBIS612)
        {
            tableelement(Table2000000026; 2000000026)
            {
                XmlName = 'Cabecera';
                //TODO: Campo no existe 
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


                    rConfCompany.GET();
                    CodigoInformacion := '612';
                    CabPeriodo := COPYSTR(rTranfITBIS."Fecha Documento", 1, 4) + COPYSTR(rTranfITBIS."Fecha Documento", 5, 2);
                    rTranfITBIS.RNC := DELCHR(rConfCompany."VAT Registration No.", '=', '- ');
                    rTranfITBIS.RNC := DELCHR(rTranfITBIS.RNC, '=', '- ');
                    Espacios := PADSTR(Espacios, 11 - STRLEN(rTranfITBIS.RNC), ' ');
                    CabRncTxt := rTranfITBIS.RNC + Espacios;
                    CantidadRegistrostxt := FORMAT((CantidadRegistros), 12, '<integer,12><Filler Character,0>');
                    TotalMontoFacturadotxt := FORMAT((dTotFact), 16, '<integer><Decimal,3>');
                    TotalMontoFacturadotxt := CONVERTSTR(TotalMontoFacturadotxt, ' ', '0');
                end;

                trigger OnPreXmlItem()
                begin
                    rTranfITBIS.RESET;
                    rTranfITBIS.SETRANGE(rTranfITBIS."Codigo reporte", '612');
                    IF rTranfITBIS.FIND('-') THEN BEGIN
                        CantidadRegistros := rTranfITBIS.COUNT;
                        REPEAT
                            dTotFact += rTranfITBIS."Total Documento";
                        UNTIL rTranfITBIS.NEXT = 0;
                    END;
                end;
            }
            tableelement("Archivo Transferencia ITBIS"; 34003004)
            {
                XmlName = 'ITBIS';
                //TODO: Campo no existe 
                /*
                SourceTableView = SORTING(Field7, Field8, Field5, Field6, Field18)
                                  WHERE(Field18 = CONST(606));*/
                textelement(RncTxt)
                {
                    Width = 11;
                }
                textelement(TipoID)
                {
                    Width = 1;
                }
                fieldelement(RazonSocial; "Archivo Transferencia ITBIS"."Razon Social")
                {
                    Width = 45;
                }
                fieldelement(Fecha; "Archivo Transferencia ITBIS"."Fecha Documento")
                {
                    Width = 8;
                }
                fieldelement(Apellidos; "Archivo Transferencia ITBIS"."NCF Relacionado")
                {
                    Width = 19;
                }
                fieldelement(Nombres; "Archivo Transferencia ITBIS".Nombres)
                {
                    Width = 2;
                }
                textelement(TotFact)
                {
                    Width = 7;
                }
                textelement(TotITBIS)
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

                        RNC := DELCHR(RNC, '=', '- ');
                        Espacios := PADSTR(Espacios, 11 - STRLEN(RNC), ' ');
                        RncTxt := RNC + Espacios;


                        IF "Fecha Documento" <= '20061231' THEN
                            CLEAR("Numero Documento");

                        IF "Total Documento" > 0 THEN
                            BienServ := '1'
                        ELSE
                            BienServ := '3';

                        CLEAR(Espacios);
                        TotFact := FORMAT(("Total Documento"), 12, '<Integer><Decimals,3>');
                        TotFact := CONVERTSTR(TotFact, ' ', '0');

                        CLEAR(Espacios);
                        TotITBIS := FORMAT(("ITBIS Pagado"), 12, '<Integer><Decimal,3>');
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
        rConfCompany: Record 79;
        rTranfITBIS: Record 34003004;
        CantidadRegistros: Integer;
        dTotFact: Decimal;
        Espacios: Text[30];
        BienServ: Code[10];
}

