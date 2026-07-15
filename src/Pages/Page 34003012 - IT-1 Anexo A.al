page 34003012 "IT-1 Anexo A"
{
    Caption = 'IT-1 Anexo A';
    Description = 'IT-1 Anexo A';
    Editable = false;
    PageType = Card;
    SourceTable = 34003004;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group("TIPO NCF")
            {
                field("Cant B01 y E31 IT-1"; "Cant B01 y E31 IT-1")
                {
                }
                field("Cant B02 y E32 IT-1"; "Cant B02 y E32 IT-1")
                {
                }
                field("Cant B03 y E33 IT-1"; "Cant B03 y E33 IT-1")
                {
                }
                field("Cant B04 y E34 IT-1"; "Cant B04 y E34 IT-1")
                {
                }
                field("Cant B12 IT-1"; "Cant B12 IT-1")
                {
                }
                field("Cant B14 y E44 IT-1"; "Cant B14 y E44 IT-1")
                {
                }
                field("Cant B15 y E45 IT-1"; "Cant B15 y E45 IT-1")
                {
                }
                field("Cant B16 y E46 IT-1"; "Cant B16 y E46 IT-1")
                {
                }
                field(CantOtrasPositiva; CantOtrasPositiva)
                {
                    Caption = 'Otras Operaciones (Positiva) Cantidad';
                }
                field(CantOtrasNegativas; CantOtrasNegativas)
                {
                    Caption = 'Otras Operaciones (Negativas) Cantidad';
                }
                field("Monto B01 y E31 IT-1"; "Monto B01 y E31 IT-1")
                {
                }
                field("Monto B02 y E32 IT-1"; "Monto B02 y E32 IT-1")
                {
                }
                field("Monto B03 y E33 IT-1"; "Monto B03 y E33 IT-1")
                {
                }
                field("Monto B04 y E34 IT-1"; "Monto B04 y E34 IT-1")
                {
                }
                field("Monto B12 IT-1"; "Monto B12 IT-1")
                {
                }
                field("Monto B14 y E44 IT-1"; "Monto B14 y E44 IT-1")
                {
                }
                field("Monto B15 y E45 IT-1"; "Monto B15 y E45 IT-1")
                {
                }
                field("Monto B16 y E46 IT-1"; "Monto B16 y E46 IT-1")
                {
                }
                field(MontoOtrasPositiva; MontoOtrasPositiva)
                {
                    Caption = 'Otras Operaciones (Positiva Monto';
                }
                field(MontoOtrasNegativas; MontoOtrasNegativas)
                {
                    Caption = 'Otras Operaciones (Negativas) Monto';
                }
            }
            group("TIPO DE VENTAS")
            {
                field("MontoEfectivo IT-1"; "MontoEfectivo IT-1")
                {
                }
                field("MontoChequeTransferencia IT-1"; "MontoChequeTransferencia IT-1")
                {
                }
                field("MontoTarjeta IT-1"; "MontoTarjeta IT-1")
                {
                }
                field("MontoCredito IT-1"; "MontoCredito IT-1")
                {
                }
                field("MontoBonosCertificado IT-1"; "MontoBonosCertificado IT-1")
                {
                }
                field("MontoPermuta IT-1"; "MontoPermuta IT-1")
                {
                }
                field(MontoOtrasFormasDeVenta; MontoOtrasFormasDeVenta)
                {
                    Caption = 'Otras Formas de Venta';
                }
            }
            group("TIPO DE INGRESOS")
            {
                field("Monto Operacional IT-1"; "Monto Operacional IT-1")
                {
                }
                field("Monto Financiero IT-1"; "Monto Financiero IT-1")
                {
                }
                field("Monto Extraordinarios IT-1"; "Monto Extraordinarios IT-1")
                {
                }
                field("Monto Arrendamiento IT-1"; "Monto Arrendamiento IT-1")
                {
                }
                field("Monto VentaActivo IT-1"; "Monto VentaActivo IT-1")
                {
                }
                field("Monto IngresoOtros IT-1"; "Monto IngresoOtros IT-1")
                {
                }
            }
            group("DATOS INFORMATIVOS")
            {
                field(MontoNC30Factura; MontoNC30Factura)
                {
                    Caption = 'Total Notas de Crédito Emitidas con mas de Trenta(30) Dias desde la Facturacion';

                    trigger OnDrillDown()
                    begin
                        ArchivoTransferenciaITBIS.RESET;
                        ArchivoTransferenciaITBIS.SETRANGE("Codigo reporte", '607');
                        //ArchivoTransferenciaITBIS.SETFILTER(NCF,'B01*|B31*');
                        IF ArchivoTransferenciaITBIS.FINDSET THEN
                            REPEAT
                                IF (COPYSTR(ArchivoTransferenciaITBIS.NCF, 1, 3) = 'B04') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF, 1, 3) = 'E34') THEN BEGIN
                                    //mayores a 30 dias de facturadas las factura original
                                    SalesCrMemoHeader.RESET;
                                    IF SalesCrMemoHeader.GET(ArchivoTransferenciaITBIS."Numero Documento") THEN BEGIN
                                        SalesInvoiceHeader.RESET;
                                        SalesInvoiceHeader.SETRANGE("No. Comprobante Fiscal", SalesCrMemoHeader."No. Comprobante Fiscal Rel.");
                                        SalesInvoiceHeader.SETRANGE("Bill-to Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
                                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                                            Days := SalesCrMemoHeader."Posting Date" - SalesInvoiceHeader."Posting Date";
                                            IF Days > 30 THEN
                                                ArchivoTransferenciaITBIS.MARK(TRUE);
                                        END;
                                    END;
                                END
                            UNTIL ArchivoTransferenciaITBIS.NEXT = 0;


                        ArchivoTransferenciaITBIS.MARKEDONLY(TRUE);
                        PAGE.RUNMODAL(34003004, ArchivoTransferenciaITBIS);
                    end;
                }
                field("MontoEspecial IT-1"; "MontoEspecial IT-1")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*
     CLEAR(Cant02y32);
     CLEAR(Cant01y31);
     CLEAR(Cant03y33);
     CLEAR(Cant04y34);
     CLEAR(Cant12);
     CLEAR(Cant14y44);
     CLEAR(Cant15y45);
     CLEAR(Cant16y46);
     CLEAR(CantOtrasPositiva);
     CLEAR(CantOtrasNegativas);
     CLEAR(CantTotal);
     CLEAR(Monto01y31);
     CLEAR(Monto02y32);
     CLEAR(Monto03y33);
     CLEAR(Monto04y34);
     CLEAR(Monto12);
     CLEAR(Monto14y44);
     CLEAR(Monto15y45);
     CLEAR(Monto16y46);
     CLEAR(MontoTotalTiposCompobantes);
     CLEAR(MontoOtrasPositiva);
     CLEAR(MontoOtrasNegativas);
     CLEAR(MontoEfectivo);
     CLEAR(MontoChequeTransferencia);
     CLEAR(MontoTarjeta);
     CLEAR(MontoCredito);
     CLEAR(MontoBonosCertificado);
     CLEAR(MontoPermuta);
     CLEAR(MontoTotalTipoVenta);
     CLEAR(MontoTipoIngresoOperacional);
     CLEAR(MontoTipoIngresoFinanciero);
     CLEAR(MontoTipoIngresoExtraordinarios);
     CLEAR(MontoTipoIngresoArrendamiento);
     CLEAR(MontoTipoIngresoVentaActivo);
     CLEAR(MontoTipoIngresoOtros);
     CLEAR(MontoTotalTipoIngreso);
     CLEAR(MontoNC30Factura);
     CLEAR(MontoEspecial);

     ArchivoTransferenciaITBIS.RESET;
     ArchivoTransferenciaITBIS.SETRANGE("Codigo reporte",'607');
     //ArchivoTransferenciaITBIS.SETFILTER(NCF,'B01*|B31*');
     IF ArchivoTransferenciaITBIS.FINDSET THEN
       REPEAT

          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B01') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B31') THEN
           BEGIN
              Cant01y31 += 1;
              Monto01y31 += ArchivoTransferenciaITBIS."Total Documento";
           END ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B02') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B32') THEN
           BEGIN
              Cant02y32 += 1;
              Monto02y32 += ArchivoTransferenciaITBIS."Total Documento";
           END ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B04') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B34') THEN
           BEGIN
              Cant04y34 += 1;
              Monto04y34 += ArchivoTransferenciaITBIS."Total Documento";

             //mayores a 30 dias de facturadas las factura original
             SalesCrMemoHeader.RESET;
             IF SalesCrMemoHeader.GET(ArchivoTransferenciaITBIS."Numero Documento") THEN BEGIN
                 SalesInvoiceHeader.RESET;
                 SalesInvoiceHeader.SETRANGE("No. Comprobante Fiscal",SalesCrMemoHeader."No. Comprobante Fiscal Rel.");
                 SalesInvoiceHeader.SETRANGE("Bill-to Customer No.",SalesCrMemoHeader."Bill-to Customer No.");
                 IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                     Days := SalesCrMemoHeader."Posting Date" - SalesInvoiceHeader."Posting Date";
                     IF Days > 30 THEN
                       MontoNC30Factura += ArchivoTransferenciaITBIS."Total Documento";
               END;
             END;

           END
           ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B12') THEN
           BEGIN
              Cant12 += 1;
              Monto12 += ArchivoTransferenciaITBIS."Total Documento";
           END ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B14') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B44') THEN
           BEGIN
              Cant14y44 += 1;
              Monto14y44 += ArchivoTransferenciaITBIS."Total Documento";

           END ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B15') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B45') THEN
           BEGIN
              Cant15y45 += 1;
              Monto15y45 += ArchivoTransferenciaITBIS."Total Documento";
           END ELSE
          IF (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B16') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF,1,3) = 'B46') THEN
           BEGIN
              Cant16y46 += 1;
              Monto16y46 += ArchivoTransferenciaITBIS."Total Documento";
           END;

         MontoTotalTiposCompobantes += ArchivoTransferenciaITBIS."Total Documento";
         CantTotal += 1;


         MontoBonosCertificado += ArchivoTransferenciaITBIS."Venta bonos";
         MontoEfectivo += ArchivoTransferenciaITBIS."Monto Efectivo";
         MontoChequeTransferencia+= ArchivoTransferenciaITBIS."Monto Cheque";
         MontoTarjeta += ArchivoTransferenciaITBIS."Monto tarjetas";
         MontoCredito+= ArchivoTransferenciaITBIS."Venta a credito";
         MontoPermuta+= ArchivoTransferenciaITBIS."Venta Permuta";

        CASE ArchivoTransferenciaITBIS."Tipo de ingreso" OF
          '01':
             MontoTipoIngresoOperacional+= ArchivoTransferenciaITBIS."Total Documento";
           '02':
             MontoTipoIngresoFinanciero+= ArchivoTransferenciaITBIS."Total Documento";
           '03':
             MontoTipoIngresoExtraordinarios+= ArchivoTransferenciaITBIS."Total Documento";
           '04':
             MontoTipoIngresoArrendamiento+= ArchivoTransferenciaITBIS."Total Documento";
           '05':
             MontoTipoIngresoVentaActivo+= ArchivoTransferenciaITBIS."Total Documento";
           '06':
             MontoTipoIngresoOtros+= ArchivoTransferenciaITBIS."Total Documento";
         END;

         CASE ArchivoTransferenciaITBIS."Tipo de ingreso" OF
           '1':
             MontoTipoIngresoOperacional+= ArchivoTransferenciaITBIS."Total Documento";
           '2':
             MontoTipoIngresoFinanciero+= ArchivoTransferenciaITBIS."Total Documento";
           '3':
             MontoTipoIngresoExtraordinarios+= ArchivoTransferenciaITBIS."Total Documento";
           '4':
             MontoTipoIngresoArrendamiento+= ArchivoTransferenciaITBIS."Total Documento";
           '5':
             MontoTipoIngresoVentaActivo+= ArchivoTransferenciaITBIS."Total Documento";
           '6':
             MontoTipoIngresoOtros+= ArchivoTransferenciaITBIS."Total Documento";
         END;

       UNTIL ArchivoTransferenciaITBIS.NEXT = 0;


     MontoEspecial := Monto14y44;
     */


        //MontoNC30Factura
        ArchivoTransferenciaITBIS.RESET;
        ArchivoTransferenciaITBIS.SETRANGE("Codigo reporte", '607');
        //ArchivoTransferenciaITBIS.SETFILTER(NCF,'B01*|B31*');
        IF ArchivoTransferenciaITBIS.FINDSET THEN
            REPEAT
                IF (COPYSTR(ArchivoTransferenciaITBIS.NCF, 1, 3) = 'B04') OR (COPYSTR(ArchivoTransferenciaITBIS.NCF, 1, 3) = 'E34') THEN BEGIN
                    //mayores a 30 dias de facturadas las factura original
                    SalesCrMemoHeader.RESET;
                    IF SalesCrMemoHeader.GET(ArchivoTransferenciaITBIS."Numero Documento") THEN BEGIN
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE("No. Comprobante Fiscal", SalesCrMemoHeader."No. Comprobante Fiscal Rel.");
                        SalesInvoiceHeader.SETRANGE("Bill-to Customer No.", SalesCrMemoHeader."Bill-to Customer No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            Days := SalesCrMemoHeader."Posting Date" - SalesInvoiceHeader."Posting Date";
                            IF Days > 30 THEN
                                MontoNC30Factura += ArchivoTransferenciaITBIS."Total Documento";
                        END;
                    END;

                END



            UNTIL ArchivoTransferenciaITBIS.NEXT = 0;


    end;

    var
        Cant01y31: Integer;
        Cant02y32: Integer;
        Cant03y33: Integer;
        Cant04y34: Integer;
        Cant12: Integer;
        Cant14y44: Integer;
        Cant15y45: Integer;
        Cant16y46: Integer;
        CantOtrasPositiva: Integer;
        CantOtrasNegativas: Integer;
        CantTotal: Integer;
        Monto01y31: Decimal;
        Monto02y32: Decimal;
        Monto03y33: Decimal;
        Monto04y34: Decimal;
        Monto12: Decimal;
        Monto14y44: Decimal;
        Monto15y45: Decimal;
        Monto16y46: Decimal;
        MontoTotalTiposCompobantes: Decimal;
        MontoOtrasPositiva: Decimal;
        MontoOtrasNegativas: Decimal;
        MontoEfectivo: Decimal;
        MontoChequeTransferencia: Decimal;
        MontoTarjeta: Decimal;
        MontoCredito: Decimal;
        MontoBonosCertificado: Decimal;
        MontoPermuta: Decimal;
        MontoOtrasFormasDeVenta: Decimal;
        MontoTotalTipoVenta: Decimal;
        MontoTipoIngresoOperacional: Decimal;
        MontoTipoIngresoFinanciero: Decimal;
        MontoTipoIngresoExtraordinarios: Decimal;
        MontoTipoIngresoArrendamiento: Decimal;
        MontoTipoIngresoVentaActivo: Decimal;
        MontoTipoIngresoOtros: Decimal;
        MontoTotalTipoIngreso: Decimal;
        MontoNC30Factura: Decimal;
        ArchivoTransferenciaITBIS: Record 34003004;
        Cantidad: Code[20];
        Monto: Code[20];
        MontoEspecial: Decimal;
        SalesInvoiceHeader: Record 112;
        SalesCrMemoHeader: Record 114;
        Days: Integer;
}

