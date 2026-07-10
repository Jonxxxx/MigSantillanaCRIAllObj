codeunit 52507 "Actualizar Consecutivo rechaza"
{
    // YFC     : Yefrecis Cruz
    // --------------------------------------------------------------------------
    // No.     Fecha         Firma  Descripcion
    // ------------------------------------------------------------------------
    // 
    // 002     28/01/2020    YFC    SANTINAV-2068: Actualizar # consnecutivo en documentos electronicos tiquetes de tienda en linea

    Permissions = TableData 112 = rm;

    trigger OnRun()
    begin

        ActualizarConsecutivoFE();
    end;

    var
        intentos: Integer;
        enviados: Integer;

    procedure ActualizarConsecutivoFE()
    var
        SIH Record: 112;
        FE_nav: Codeunit 52504;
        i: Integer;
    begin
        //002-YFC
        /*
        FOR i:=1 TO 100 DO
        BEGIN
        
        SIH.RESET;
        SIH.SETCURRENTKEY(Origen,"Tipo Doc Electronico",Estado);
        
        //SIH.SETRANGE(Origen,SIH.Origen::"E-Commerce");
        //SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Factura);
        SIH.SETFILTER(Estado,'=%1','');
        //SIH.SETRANGE("No.",'VFRE-000874');  //prueba
        //SIH.SETFILTER("Posting Date",'04/18/2022',TODAY);
        SIH.SETRANGE("Posting Date",TODAY);
        //Message('%1',SIH.Count());
        
        IF SIH.FINDSET THEN
          REPEAT
            FE_nav.TiqueteElectronico_vCentral(SIH."No.");
          UNTIL SIH.NEXT = 0;
          //message('finalizado');
        
        
        
        SIH.RESET;
        SIH.SETCURRENTKEY(Origen,"Tipo Doc Electronico",Estado);
        //SIH.SETRANGE(Origen,SIH.Origen::"E-Commerce");
        //SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Factura);
        SIH.SETRANGE(Estado,'rechazado');
        SIH.SETRANGE("Posting Date",TODAY);
        //SIH.SETFILTER("Posting Date",'04/18/2022',TODAY);
        //SIH.SETRANGE("No.",'VFRE-002878');  //prueba
        //Message('%1',SIH.Count());
        
        IF SIH.FINDSET THEN
          REPEAT
            SIH.Consecutivo := '';
           // SIH.clave := '';
            SIH.MODIFY;
            COMMIT;
            FE_nav.TiqueteElectronico_vCentral(SIH."No.");
          UNTIL SIH.NEXT = 0;
         // message('finalizado');
        
         END;
         MESSAGE('finalizado');
         */
        /*
        enviados := 0;
        intentos := 0;
        
        SIH.RESET;
        SIH.SETCURRENTKEY("Sell-to Customer No.");
        SIH.SETRANGE("Sell-to Customer No.",'S023755');
        SIH.SETRANGE("No.",'VFR15-002294'); //prueba
        //PrueSIH.SETRANGE("Tipo Doc Electronico",PrueSIH."Tipo Doc Electronico"::Factura);
        SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE("Venta TPV",TRUE);
        SIH.SETRANGE("Posting Date",010122D,052223D); //32607 /28641
        SIH.SETFILTER("No. Documento SIC",'<>%1','');
        //PrueSIH.SETFILTER(Consecutivo,'<>%1','');
        SIH.SETFILTER(Estado,'<>%1','aceptado');
        MESSAGE(FORMAT(SIH.COUNT));
        IF SIH.FINDFIRST THEN
          BEGIN
            //MESSAGE(FORMAT(SIH."No."));
        
            //REPEAT
              SIH.Consecutivo := '';
              SIH.MODIFY;
              FE_nav.TiqueteElectronico_vCentral(SIH."No.");
              COMMIT;
              IF SIH.Estado = 'aceptado' THEN
                enviados += 1;
            //UNTIL (enviados = 1);
        
          END;
        MESSAGE('finalizado1:'+FORMAT(enviados));
        */
        ///////////////////////*************************//////////////////////////
        /*
        enviados := 0;
        intentos := 0;
        
        SIH.RESET;
        SIH.SETCURRENTKEY("Sell-to Customer No.");
        SIH.SETRANGE("Sell-to Customer No.",'S023755');
        //SIH.SETRANGE("No.",'VFR21-000112');
        //PrueSIH.SETRANGE("Tipo Doc Electronico",PrueSIH."Tipo Doc Electronico"::Factura);
        SIH.SETRANGE("Tipo Doc Electronico",SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE("Venta TPV",TRUE);
        SIH.SETRANGE("Posting Date",010122D,123122D); ///**** 2022
        //SIH.SETRANGE("Posting Date",010123D,052223D); //32607 /28641 /25127
        SIH.SETFILTER("No. Documento SIC",'<>%1','');
        //PrueSIH.SETFILTER(Consecutivo,'<>%1','');
        SIH.SETFILTER(Estado,'<>%1','aceptado');
        //SIH.CALCSUMS("Amount Including VAT");
        MESSAGE(FORMAT(SIH.COUNT));
        //MESSAGE(FORMAT(SIH."Amount Including VAT"));
        
        {
        IF SIH.FINDSET THEN
          REPEAT
            intentos += 1;
            //PrueSIH."Tipo Doc Electronico" := PrueSIH."Tipo Doc Electronico"::Tiquete;
           // PrueSIH.MODIFY;
              //MESSAGE(PrueSIH."No.");
              MESSAGE(SIH."No.");
              SIH.Consecutivo := '';
              SIH.MODIFY;
        
              FE_nav.TiqueteElectronico_vCentral(SIH."No.");
              COMMIT;
              IF SIH.Estado = 'aceptado' THEN
                enviados += 1;
        
          //UNTIL SIH.NEXT = 0;
          //UNTIL  (intentos = 3000) OR (enviados = 1 );
          //UNTIL  (intentos = 1000) OR (SIH.Estado = 'aceptado' );
          UNTIL  (SIH.NEXT = 0) OR (intentos = 2);
        
        MESSAGE(FORMAT(intentos)+':intentos');
        MESSAGE(FORMAT(enviados)+':firmados');
        // -- 002-YFC
        }
        MESSAGE('finalizado2');
        
        */
        //cuFE.TiqueteElectronicoNCR_vCentral(rSCMH."No.");

    end;
}

