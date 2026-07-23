xmlport 34003010 "Comprob. Anulados 608 - 2020"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;
    TableSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(ITBIS608)
        {
            tableelement(Table2000000026; 2000000026)
            {
                XmlName = 'Cabecera';
                //TODO: Campo no existe 
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


                    rConfCompany.GET();
                    CodigoInformacion := '608';
                    CabPeriodo := COPYSTR(rTranfITBIS."Fecha Documento", 1, 4) + COPYSTR(rTranfITBIS."Fecha Documento", 5, 2);
                    rTranfITBIS.RNC := DELCHR(rConfCompany."VAT Registration No.", '=', '- ');
                    rTranfITBIS.RNC := DELCHR(rTranfITBIS.RNC, '=', '- ');
                    Espacios := PADSTR(Espacios, 11 - STRLEN(rTranfITBIS.RNC), ' ');
                    //CabRncTxt              := rTranfITBIS.RNC+Espacios;
                    CabRncTxt := rTranfITBIS.RNC;
                    //CantidadRegistrostxt   := FORMAT((CantidadRegistros),12,'<integer,12><Filler Character,0>');
                    CantidadRegistrostxt := FORMAT((CantidadRegistros));
                end;

                trigger OnPreXmlItem()
                begin
                    rTranfITBIS.RESET;
                    rTranfITBIS.SETRANGE(rTranfITBIS."Codigo reporte", '608');
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
                SourceTableView = SORTING(Field11)
                                  WHERE(Field14 = FILTER(<> ''),
                                        Field18 = FILTER(608));*/
                textelement(NCFtxt)
                {
                    Width = 19;
                }
                fieldelement(Fecha; "Archivo Transferencia ITBIS"."Fecha Documento")
                {
                    Width = 8;
                }
                fieldelement(RazonAnulacion; "Archivo Transferencia ITBIS"."Razon Anulacion")
                {
                    Width = 2;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Archivo Transferencia ITBIS"."NCF Relacionado" = '' THEN
                        currXMLport.SKIP;
                    NCFtxt := "Archivo Transferencia ITBIS"."NCF Relacionado";
                    IF STRLEN(NCFtxt) = 11 THEN
                        NCFtxt := "Archivo Transferencia ITBIS"."NCF Relacionado" + '        ';
                    IF STRLEN(NCFtxt) = 13 THEN
                        NCFtxt := "Archivo Transferencia ITBIS"."NCF Relacionado" + '      ';
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
        NumDoc: Text[30];
        Periodo: Code[8];
}

