codeunit 50111 "Validaciones de  Errores"
{

    trigger OnRun()
    begin
        /*SH.RESET;
        SH.SETRANGE("No.",'VFR6-002906');
        IF SH.FINDFIRST THEN ;
          SH.VALIDATE(Status,SH.Status::Open);
          SH.MODIFY(TRUE);*/

    end;

    var
        ValidarCab: Boolean;
        ValidarMedPag: Boolean;
        Errores: Text[250];
        Text01: Label 'Campos en blanco: ';
        CabVentasSIC: Record 50111;
        SH: Record 36;

    procedure ValidacionesCabecera(): Boolean
    begin
        /*
        WITH CabVentasICG DO BEGIN
          Errores := '';
          ValidarCab :=  FALSE;
        
          IF tipodoc = '' THEN
            Errores += 'tipodoc,';
        
          IF numdoc = '' THEN
            Errores += 'numdoc,';
        
          IF codcliente = '' THEN
            Errores += 'codcliente,';
        
          IF codmoneda = '' THEN
            Errores += 'codmoneda,';
        
          IF tasacambio = '' THEN
            Errores += 'tasacambio,';
        
          IF fecha = '' THEN
            Errores += 'fecha,';
        
          IF numcomprobante = '' THEN
            Errores += 'numcomprobante,';
        
          IF (ncf_afecta = '') AND (tipodoc = '2') THEN
            Errores += 'ncf_afecta,';
        
          IF codalmacen = '' THEN
            Errores += 'codalmacen,';
        
         // IF rnc_cliente = '' THEN
          //  Errores += 'rnc_cliente,';
        
          IF ("Source Counter" <= 0) THEN
            Errores += '"Source Counter",';
        
          IF fvenceserieresol = '' THEN
            Errores += 'fvenceserieresol';
        
          IF Errores <> '' THEN
            BEGIN
              Errores := Text01 + Errores;
              ValidarCab := TRUE;
            END;
        
           MODIFY;
           EXIT(ValidarCab);
        END;
        |*/



    end;

    procedure ValidacionesLineas()
    begin
        /*
        WITH LineasVtasICG DO BEGIN
          Errores := '';
          //ValidarLin :=  FALSE;
        
          IF numdoc = '' THEN
            Errores += 'numdoc,';
        
          IF numlinea = '' THEN
            Errores += 'numlinea,';
        
          IF codproducto = '' THEN
            Errores += 'codproducto,';
        
          IF unidad_medida = '' THEN
            Errores += 'unidad_medida,';
        
          IF cantidad = '' THEN
            Errores += 'cantidad,';
        
          IF precio_venta = '' THEN
            Errores += 'precio_venta,';
        
          IF importe_dto = '' THEN
            Errores += 'importe_dto,';
        
          IF "Source Counter" <= 0 THEN
            Errores += '"Source Counter",';
        
          IF Errores <> '' THEN
            BEGIN
              Errores := Text01 + Errores;
              //ValidarLin := TRUE;
        
              CabVentasICG.RESET;
              CabVentasICG.SETCURRENTKEY(numdoc);
              CabVentasICG.SETRANGE(numdoc, numdoc);
              IF CabVentasICG.FINDFIRST THEN
                BEGIN
                  CabVentasICG.ErroresLineas := TRUE;
                  CabVentasICG.MODIFY;
                END
            END;
        
           MODIFY;
          // EXIT(ValidarLin);
        END;
        */

    end;

    procedure ValidacionesCabeceraSIC(CabVentasSIC: Record 50111): Boolean
    begin

        WITH CabVentasSIC DO BEGIN
            Errores := '';
            ValidarCab := FALSE;

            IF CabVentasSIC."Tipo documento" = 0 THEN
                Errores += 'tipodoc,';

            IF CabVentasSIC."No. documento" = '' THEN
                Errores += 'numdoc,';

            IF CabVentasSIC."Cod. Cliente" = '' THEN
                Errores += 'codcliente,';

            IF CabVentasSIC."Cod. Moneda" = '' THEN
                Errores += 'codmoneda,';

            IF CabVentasSIC."Tasa de cambio" = 0 THEN
                Errores += 'tasacambio,';

            IF CabVentasSIC.Fecha = 0D THEN
                Errores += 'fecha,';

            IF CabVentasSIC."No. comprobante" = '' THEN
                Errores += 'numcomprobante,';

            IF (CabVentasSIC."NCF Afectado" = '') AND (CabVentasSIC."Tipo documento" = 2) THEN
                Errores += 'ncf_afecta,';

            IF CabVentasSIC."Cod. Almacen" = '' THEN
                Errores += 'codalmacen,';

            // IF rnc_cliente = '' THEN
            //  Errores += 'rnc_cliente,';

            //IF ("Source Counter" <= 0) THEN
            // Errores += '"Source Counter",';

            IF CabVentasSIC."Fecha Venc. NCF" = 0D THEN
                Errores += 'fvenceserieresol';

            IF CabVentasSIC.Errores <> '' THEN BEGIN
                Errores := Text01 + Errores;
                ValidarCab := TRUE;
            END;

            MODIFY;
            EXIT(ValidarCab);
        END;
    end;
}

