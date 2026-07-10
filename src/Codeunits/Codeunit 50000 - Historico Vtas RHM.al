codeunit 50000 "Historico Vtas RHM"
{

    trigger OnRun()
    begin
        /*
        Facturas.DELETEALL;
        //EXIT;
        SIH.FIND('-');
        REPEAT
        {
        IF "venta tpv" = 1 THEN
           CurrReport.SKIP;
        }
            SIL.RESET;
            SIL.SETRANGE("Document No.",SIH."No.");
            SIL.SETRANGE(Type,SIL.Type::Item);
            SIL.SETFILTER("No.",'<>%1','');
            IF SIL.FINDSET THEN
               REPEAT
                IF Tmp.GET(SIL."No.") THEN
                   BEGIN
                    Facturas.NoDoc                         := SIL."Document No.";
                    Facturas.NoLin                         := SIL."Line No.";
                    Facturas."Tipo Factura"                := 'Factura';
                    Facturas."Cliente Santillana"          := SIL."Sell-to Customer No.";
                    Facturas."Destinatario Santillana"     := SIH."Bill-to Customer No.";
        //            Facturas."Orden de compra del cliente" :=
                    Facturas."Fecha Factura"               := FORMAT(SIH."Posting Date",0,'<Year4><Month,2><Day,2>');
                    Facturas."N° legal comprobante"        := SIH."No.";
                    IF SIH."Currency Code" = '' THEN
                       SIH."Currency Code" := 'CRC';
                    Facturas.Moneda                        := SIH."Currency Code";
                    Facturas."Código Material Santillana"  := SIL."No.";
        //            Facturas.ISBN                          := SIL.ISBN;
                    Facturas."P.V.P."                      := SIL."Unit Price";
                    Facturas.Descuento                     := SIL."Line Discount %";
                    Facturas.Cantidad                      := SIL.Quantity;
                    Facturas.INSERT;
                   END
               UNTIL SIL.NEXT =0;
        
        UNTIL SIH.NEXT = 0;
        
        SCMH.FIND('-');
        REPEAT
        {
        IF "Tipo pedido Vta." = 1 THEN
           CurrReport.SKIP;
        }
            SCML2.RESET;
            SCML2.SETRANGE("Document No.",SCMH."No.");
            SCML2.SETRANGE(Type,SCML2.Type::Item);
            SCML2.SETFILTER("No.",'<>%1','');
            IF SCML2.FINDSET THEN
               REPEAT
                IF Tmp.GET(SCML2."No.") THEN
                   BEGIN
                    Facturas.NoDoc                         := SCML2."Document No.";
                    Facturas.NoLin                         := SCML2."Line No.";
                    Facturas."Tipo Factura"                := 'Nota de credito';
                    Facturas."Cliente Santillana"          := SCMH."Sell-to Customer No.";
                    Facturas."Destinatario Santillana"     := SCMH."Bill-to Customer No.";
        //            Facturas."Orden de compra del cliente" :=
                    Facturas."Fecha Factura"               := FORMAT(SCMH."Posting Date",0,'<Year4><Month,2><Day,2>');
                    Facturas."N° legal comprobante"        := SCMH."No.";
                    IF SCMH."Currency Code" = '' THEN
                       SCMH."Currency Code" := 'CRC';
                    Facturas.Moneda                        := SCMH."Currency Code";
                    Facturas."Código Material Santillana"  := SCML2."No.";
        //            Facturas.ISBN                          := SCML2.ISBN;
                    Facturas."P.V.P."                      := SCML2."Unit Price";
                    Facturas.Descuento                     := SCML2."Line Discount %";
                    Facturas.Cantidad                      := SCML2.Quantity;
                    Facturas.INSERT;
                   END
               UNTIL SCML2.NEXT =0;
        
        UNTIL SCMH.NEXT = 0;
        */

    end;

    var
        SIH Record: 112;
        SIL Record: 113;
        SCMH Record: 114;
        SCML2Record 115;
        Tmp Record: 59001;
        Facturas Record: 59000;
        CLE Record: 21;
}

