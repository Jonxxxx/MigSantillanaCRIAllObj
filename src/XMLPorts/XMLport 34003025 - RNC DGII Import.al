xmlport 34003025 "RNC DGII Import"
{
    Caption = 'RNC DGII Import';
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("RNC DGII"; 34003024)
            {
                XmlName = 'RNCDGII';
                textelement(RNC)
                {
                    MinOccurs = Zero;
                }
                textelement(Name)
                {
                    MinOccurs = Zero;
                }
                textelement(SearchName)
                {
                    MinOccurs = Zero;
                    TextType = Text;
                }
                textelement(Campo4)
                {
                    MinOccurs = Zero;
                }
                textelement(Campo5)
                {
                    MinOccurs = Zero;
                }
                textelement(Campo6)
                {
                    MinOccurs = Zero;
                }
                textelement(Campo7)
                {
                    MinOccurs = Zero;
                }
                textelement(Campo8)
                {
                    MinOccurs = Zero;
                }
                textelement(FechaRegistro)
                {
                    MinOccurs = Zero;
                }
                textelement(Estado)
                {
                    MinOccurs = Zero;
                }
                textelement(Tipo)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
                    n: Char;
                    NM: Char;
                begin
                    contador := contador + 1;
                    IF GUIALLOWED THEN BEGIN
                        Window.UPDATE(1, (contador / 705000 * 10000) DIV 1);
                        Window.UPDATE(2, contador);
                    END;

                    IF RNC = '' THEN
                        currXMLport.SKIP;

                    //IF NOT EVALUATE(EvaluarVat,COPYSTR(RNC,1,4))THEN
                    IF NOT EVALUATE(EvaluarVat, RNC) THEN
                        currXMLport.SKIP;

                    //IF RNCDGII.GET(RNC) THEN
                    // currXMLport.SKIP;

                    "RNC DGII"."VAT Registration No." := RNC;

                    IF Name <> '' THEN BEGIN
                        // Name := DELCHR(Name,'=',DELCHR(Name,'=','ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&áéíoúñÑ›ÉõÛ­ü '));
                        Name := CONVERTSTR(Name, 'áéíoúñÑ›ÉõÛ­ü', 'aeiounNAEIOUu');
                        //n := 165;
                        //NM := 164;
                        //Name := CONVERTSTR(Name,FORMAT(NM),'N');
                        "RNC DGII".Name := COPYSTR(Name, 1, MAXSTRLEN("RNC DGII".Name));
                    END;

                    IF SearchName <> '' THEN BEGIN
                        //SearchName := DELCHR(SearchName,'=',DELCHR(SearchName,'=','ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&áéíoúñÑ›ÉõÛ­ü '));
                        SearchName := CONVERTSTR(SearchName, 'áéíoúñÑ›ÉõÛ­ü', 'aeiounNAEIOUu');
                        "RNC DGII"."Search Name" := COPYSTR(SearchName, 1, MAXSTRLEN("RNC DGII"."Search Name"));
                    END;

                    IF Campo4 <> '' THEN BEGIN
                        //Campo4 := DELCHR(Campo4,'=',DELCHR(Campo4,'=','ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&áéíoúñÑ›ÉõÛ­ü '));
                        Campo4 := CONVERTSTR(Campo4, 'áéíoúñÑ›ÉõÛ­ü', 'aeiounNAEIOUu');
                        "RNC DGII"."Campo 4" := COPYSTR(Campo4, 1, MAXSTRLEN("RNC DGII"."Campo 4"));
                    END;

                    IF Campo5 <> '' THEN
                        "RNC DGII"."Campo 5" := COPYSTR(Campo5, 1, MAXSTRLEN("RNC DGII"."Campo 5"));

                    IF Campo6 <> '' THEN
                        "RNC DGII"."Campo 6" := COPYSTR(Campo6, 1, MAXSTRLEN("RNC DGII"."Campo 6"));

                    IF Campo7 <> '' THEN
                        "RNC DGII"."Campo 7" := COPYSTR(Campo7, 1, MAXSTRLEN("RNC DGII"."Campo 7"));

                    IF Campo8 <> '' THEN
                        "RNC DGII"."Campo 8" := COPYSTR(Campo8, 1, MAXSTRLEN("RNC DGII"."Campo 8"));

                    IF FechaRegistro <> '' THEN
                        "RNC DGII"."Fecha Registro DGII" := COPYSTR(FechaRegistro, 1, MAXSTRLEN("RNC DGII"."Fecha Registro DGII"));

                    IF Estado <> '' THEN
                        "RNC DGII".Estado := COPYSTR(Estado, 1, MAXSTRLEN("RNC DGII".Estado));

                    IF Tipo <> '' THEN
                        "RNC DGII".Tipo := COPYSTR(Tipo, 1, MAXSTRLEN("RNC DGII".Tipo));

                    //COMMIT;
                    CantInsertMod := CantInsertMod + 1;
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

    trigger OnPostXmlPort()
    begin
        IF GUIALLOWED THEN
            Window.CLOSE;

        IF GUIALLOWED THEN
            MESSAGE('%1 RNC Importado con exito.!!!', CantInsertMod);
    end;

    trigger OnPreXmlPort()
    begin

        IF GUIALLOWED THEN
            Window.OPEN('Importando datos... @1@@@@@@@@@@\ Cantidad RNC Leidos: #2############');

    end;

    var
        RNCDGII: Record 34003024;
        Window: Dialog;
        contador: Integer;
        EvaluarVat: BigInteger;
        CantInsertMod: Integer;
}

