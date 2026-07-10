codeunit 52505 MACROmodin
{
    Permissions = TableData 112 = rm,
                  TableData 114 = rm;

    trigger OnRun()
    var
        r36Record 36;
        r112Record 112;
        r114Record 114;
        kk: Integer;
        lrSH Record: 36;
        lrTransCaja Record: 34002523;
    begin
        r112.GET('VFR4-001726');
        r112."Liquidado TPV" := TRUE;
        r112.MODIFY;

        r114.GET('VNR-044299');
        r114."Liquidado TPV" := TRUE;
        r114.MODIFY;
        EXIT;

        /*
        r114.GET('VNR5-000007');
        r114.Consecutivo := '00600001030000000013';
        r114.Clave := '50602032000310114588000600001030000000013323218278';
        r114.MODIFY;
        MESSAGE('OK 4');
        EXIT;
        */

        r112.GET('VFR3-001674');
        r112.Clave := '50603032000310114588000400001040000002047384558555';
        r112.Consecutivo := '00400001040000002047';
        r112.MODIFY;
        MESSAGE('OK 3');


        EXIT;


        /*
        //+#291272
        lrSH.GET(2,'VF4-000747');
        lrSH.CALCFIELDS("Amount Including VAT");
        lrTransCaja.RESET;
        lrTransCaja.SETCURRENTKEY("No. Registrado");
        lrTransCaja.SETRANGE("No. Registrado", lrSH."Posting No.");
        lrTransCaja.CALCSUMS(Importe);
        
        IF lrSH."Amount Including VAT" <> lrTransCaja.Importe THEN
          ERROR('4 -> '+FORMAT(lrSH."Amount Including VAT") + ' vs ' + FORMAT(lrTransCaja.Importe));
        
        ERROR('1 -> '+FORMAT(lrSH."Amount Including VAT") + ' vs ' + FORMAT(lrTransCaja.Importe));
        //-#291272
        */

        EXIT;

        /*
        r36.RESET;
        r36.SETRANGE("Document Type",r36."Document Type"::Invoice,r36."Document Type"::"Credit Memo");
        r36.SETRANGE("Venta TPV",TRUE);
        r36.SETRANGE("Registrado TPV",TRUE);
        r36.SETRANGE("Posting Date",010319D,310319D);
        IF r36.FINDFIRST THEN
          REPEAT
            IF r36."Document Type"= r36."Document Type"::Invoice THEN BEGIN
              IF r112.GET(r36."Posting No.") THEN BEGIN
                kk:=kk+1;
                //Eliminar(0,r36."No.");
              END;
            END
            ELSE BEGIN
              IF r114.GET(r36."Posting No.") THEN BEGIN
                kk:=kk+1;
                //Eliminar(1,r36."No.");
              END;
            END;
        
        
          UNTIL r36.NEXT=0;
        
        MESSAGE('ok '+FORMAT(r36.COUNT)+' vs '+FORMAT(kk));
        */

    end;

    procedure Eliminar(pTipo: Option Factura,NCR; pDoc: Code[20])
    var
        lrCF Record: 36;
        lrLF Record: 37;
    begin
        IF pTipo = pTipo::Factura THEN
            lrCF.GET(lrCF."Document Type"::Invoice, pDoc)
        ELSE
            lrCF.GET(lrCF."Document Type"::"Credit Memo", pDoc);

        lrLF.RESET;
        lrLF.SETRANGE("Document Type", lrCF."Document Type");
        lrLF.SETRANGE("Document No.", pDoc);

        IF lrLF.COUNT = 0 THEN
            ERROR('Revisar1 ' + pDoc);


        IF lrLF.COUNT > 10 THEN
            ERROR('Revisar ' + pDoc);

        lrLF.DELETEALL;

        lrCF.DELETE;
    end;
}

