codeunit 56050 "Clasificacion devoluciones"
{
    // $001 05/May/14 JML : Clasificación devoluciones. Versión inicial.
    // $002 20/May/14 JML : Correcciones varias.
    // $003 26/May/14 JML : Correcciones varias.

    TableNo = 56025;

    trigger OnRun()
    begin

        IF NOT Closed THEN
            ERROR(Text001, "No.");

        intTotal := COUNT;
        dtClasificacion := CURRENTDATETIME;

        IF NOT Procesada THEN BEGIN

            TESTFIELD("Customer no.");
            TESTFIELD("Cod. Almacen");

            recCfgSantillana.GET;
            recCfgSantillana.TESTFIELD("Almacen prod. defectuosos");

            dlgProgeso.OPEN(Text006 + Text007 + Text008 + Text009 + Text010 + Text011);
            dlgProgeso.UPDATE(1, Text005);
            dlgProgeso.UPDATE(2, "No.");
            dlgProgeso.UPDATE(3, "Customer no.");

            recUsuAlm.RESET;
            recUsuAlm.SETRANGE("User ID", USERID);
            recUsuAlm.SETRANGE(Default, TRUE);
            recUsuAlm.FINDFIRST;

            GenerarTablaTempProductos(Rec);
            ClasificarDevConsignacion(Rec);

            GenerarTablaTempFacturas(Rec);
            ClasificarDevVentas(Rec);

            //JML Para pruebas. Despues del proceso no deberian quedar productos remanentes
            //recTmpProd.RESET;
            //recTmpProd.SETFILTER(Cantidad, '<>%1', 0);
            //IF recTmpProd.FINDFIRST THEN
            //  ERROR('No se han realizado todas las devoluciones');
            //recTmpProd.RESET;
            //recTmpProd.SETFILTER("Cantidad defectuosa", '<>%1', 0);
            //IF recTmpProd.FINDFIRST THEN
            //  ERROR('No se han realizado todas las devoluciones de defectuosos');
            //

            Procesada := TRUE;
            "Usuario clasificacion" := USERID;
            "Fecha hora clasificacion" := dtClasificacion;
            MODIFY;

            IF intTotal > 0 THEN
                dlgProgeso.UPDATE(6, ROUND(TraerPracesados(Rec) / intTotal * 10000, 1));

        END;
    end;

    var
        Text001: Label 'El documento de devolución %1 debe estar cerrado.';
        Text002: Label 'El documento de devolución %1 no debe estar procesado.';
        recUsuAlm: Record 7301;
        recCfgSantillana: Record 56001;
        Text003: Label 'El documento de devolución %1 no contiene líneas.';
        recTmpProd Record: 86000" temporary;
        recTmpFact Record: 86001" temporary;
        recTmpFactProd Record: 86001" temporary;
        recTmpFactLiquidadas Record: 86001" temporary;
        recTmpTransfer Record: 5740" temporary;
        Text004: Label 'Automatic return from customer %1';
        dlgProgeso: Dialog;
        optTipoDoc: Option Transferencia,Venta;
        Text005: Label 'Generando documentos';
        Text006: Label '################################1\\';
        Text007: Label 'Clas. devolución      ##########2\';
        Text008: Label 'Cliente               ##########3\\';
        Text009: Label 'Transfer.  generada   ##########4\';
        Text010: Label 'Dev. venta generada   ##########5\';
        Text011: Label '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@6';
        intTotal: Integer;
        dtClasificacion: DateTime;

    procedure GenerarTablaTempProductos(var recPrmCabDev Record: 56025")
    var
        recLinDev: Record 56026;
    begin

        //Genera una tabla con los productos y las cantidades totales que se deben devolver

        recLinDev.RESET;
        recLinDev.SETRANGE("No. Documento", recPrmCabDev."No.");
        recLinDev.SETFILTER("Item No.", '<>%1', '');
        recLinDev.SETFILTER(Quantity, '<>%1', 0);
        IF recLinDev.FINDSET THEN
            REPEAT

                recLinDev.CALCFIELDS("Inventario en Consignacion");

                recTmpProd.RESET;
                recTmpProd.SETRANGE("Item No.", recLinDev."Item No.");
                IF recTmpProd.FINDSET THEN BEGIN
                    //      IF recLinDev."Con defecto" THEN                                            //$002
                    IF (recLinDev."Con defecto" OR recLinDev.Recuperable) THEN                   //
                        recTmpProd."Cantidad defectuosa" += recLinDev.Quantity
                    ELSE
                        recTmpProd.Cantidad += recLinDev.Quantity;
                    recTmpProd.MODIFY;
                END
                ELSE BEGIN
                    recTmpProd.INIT;
                    recTmpProd."Customer No." := recLinDev."Customer No.";
                    recTmpProd."Document No." := recLinDev."No. Documento";
                    recTmpProd."Item No." := recLinDev."Item No.";
                    //      IF recLinDev."Con defecto" THEN                                            //$002
                    IF (recLinDev."Con defecto" OR recLinDev.Recuperable) THEN                   //
                        recTmpProd."Cantidad defectuosa" := recLinDev.Quantity
                    ELSE
                        recTmpProd.Cantidad := recLinDev.Quantity;

                    recTmpProd."Inventario en Consignacion" := recLinDev."Inventario en Consignacion";
                    recTmpProd.INSERT;
                END;
            UNTIL recLinDev.NEXT = 0;
    end;

    procedure ClasificarDevConsignacion(var recPrmCabDev Record: 56025")
    var
        decCdadADev: Decimal;
    begin

        recTmpProd.RESET;
        IF recTmpProd.FINDSET THEN
            REPEAT

                //Si hay inventario enconsignación se generaran devoluciones de transferencias.

                IF recTmpProd."Inventario en Consignacion" <> 0 THEN BEGIN

                    //Productos sin defectos
                    IF recTmpProd.Cantidad <> 0 THEN BEGIN
                        IF recTmpProd."Inventario en Consignacion" > recTmpProd.Cantidad THEN
                            decCdadADev := recTmpProd.Cantidad
                        ELSE
                            decCdadADev := recTmpProd."Inventario en Consignacion";

                        GenerarTransfer(recPrmCabDev, recPrmCabDev."Cod. Almacen", recTmpProd."Item No.", decCdadADev);
                        recTmpProd."Inventario en Consignacion" -= decCdadADev;
                        recTmpProd.Cantidad -= decCdadADev;
                        recTmpProd.MODIFY;
                    END;

                    //Productos defectuosos
                    IF recTmpProd."Inventario en Consignacion" <> 0 THEN BEGIN
                        IF recTmpProd."Cantidad defectuosa" <> 0 THEN BEGIN
                            IF recTmpProd."Inventario en Consignacion" > recTmpProd."Cantidad defectuosa" THEN
                                decCdadADev := recTmpProd."Cantidad defectuosa"
                            ELSE
                                decCdadADev := recTmpProd."Inventario en Consignacion";
                            IF decCdadADev <> 0 THEN BEGIN
                                GenerarTransfer(recPrmCabDev, recCfgSantillana."Almacen prod. defectuosos", recTmpProd."Item No.", decCdadADev);
                                recTmpProd."Inventario en Consignacion" -= decCdadADev;
                                recTmpProd."Cantidad defectuosa" -= decCdadADev;
                                recTmpProd.MODIFY;
                            END;
                        END;
                    END;
                END;

            UNTIL recTmpProd.NEXT = 0;
    end;

    procedure GenerarTransfer(var recPrmCabDev Record: 56025; codPrmAlmDestino: Code[10]; codPrmProd: Code[20]; decPrmCdad: Decimal)
    var
        recLinDev: Record 56026;
        codTrans: Code[20];
    begin
        recTmpTransfer.RESET;
        recTmpTransfer.SETRANGE("Transfer-from Code", TraerAlmacenConsigna(recPrmCabDev."Customer no."));
        recTmpTransfer.SETRANGE("Transfer-to Code", codPrmAlmDestino);
        IF recTmpTransfer.FINDFIRST THEN
            codTrans := recTmpTransfer."No."
        ELSE
            codTrans := InsertarCabTrans(recPrmCabDev, codPrmAlmDestino);

        InsertarLinTrans(codTrans, codPrmProd, decPrmCdad);
    end;

    procedure InsertarCabTrans(var recPrmCabDev Record: 56025; codPrmAlmDestino: Code[10]): Code[20]
    var
        recCabTrans: Record 5740;
    begin
        recCabTrans.INIT;
        recCabTrans."Devolucion Consignacion" := TRUE;
        recCabTrans."Pedido Consignacion" := TRUE;
        recCabTrans.INSERT(TRUE);
        recCabTrans.VALIDATE("Transfer-from Code", TraerAlmacenConsigna(recPrmCabDev."Customer no."));
        recCabTrans.VALIDATE("Transfer-to Code", codPrmAlmDestino);
        recCabTrans.VALIDATE("Posting Date", WORKDATE);
        recCabTrans."External Document No." := recPrmCabDev."External document no.";
        recCabTrans.MODIFY(TRUE);

        recTmpTransfer.INIT;
        recTmpTransfer."No." := recCabTrans."No.";
        recTmpTransfer."Transfer-from Code" := recCabTrans."Transfer-from Code";
        recTmpTransfer."Transfer-to Code" := recCabTrans."Transfer-to Code";
        recTmpTransfer.INSERT;

        InsertarDocRelacionado(recPrmCabDev."No.", optTipoDoc::Transferencia, recCabTrans."No.");

        dlgProgeso.UPDATE(4, recCabTrans."No.");

        EXIT(recCabTrans."No.");
    end;

    procedure InsertarLinTrans(codPrmTrans: Code[20]; codPrmProd: Code[20]; decPrmCdad: Decimal)
    var
        recLinTrans: Record 5741;
        intLinea: Integer;
    begin

        recLinTrans.RESET;
        recLinTrans.SETRANGE("Document No.", codPrmTrans);
        IF recLinTrans.FINDLAST THEN
            intLinea := recLinTrans."Line No.";

        intLinea += 10000;

        recLinTrans.INIT;
        recLinTrans."Document No." := codPrmTrans;
        recLinTrans."Line No." := intLinea;
        recLinTrans.VALIDATE("Item No.", codPrmProd);
        recLinTrans.VALIDATE(Quantity, decPrmCdad);

        recLinTrans.INSERT(TRUE);
    end;

    procedure ClasificarDevVentas(var recPrmCabDev Record: 56025")
    var
        decCdadADev: Decimal;
        codCabVta: Code[20];
        decCdadLiq: Decimal;
        blnPrimeraVez: Boolean;
    begin

        //Los productos, para los que no se ha generado transferencia devolución consignación, se inluirán en devoluciones de venta.

        //Los productos, sin defectos, se incluirán en devoluciones que liquidarán facturas de venta
        //Los productos defectuosos se inluirán en una devolución sin liquidar factura de venta
        //Y los productos, sin defectos, que no se pueden liquidar con facturas de venta se incluirán en una devolución sin liquidar factura


        //Devolución de productos sin defectos liquidables :

        //Si quedan algún producto por devolver
        recTmpProd.RESET;
        recTmpProd.SETFILTER(Cantidad, '<>%1', 0);
        IF recTmpProd.FINDFIRST THEN BEGIN
            recTmpFact.RESET;
            IF recTmpFact.FINDSET THEN
                REPEAT
                    recTmpFactProd.RESET;
                    recTmpFactProd.SETRANGE("No. factura", recTmpFact."No. factura");
                    recTmpFactProd.SETFILTER("Cantidad liquidable", '<>%1', 0);
                    IF recTmpFactProd.FINDSET THEN BEGIN
                        blnPrimeraVez := TRUE;
                        REPEAT
                            recTmpProd.RESET;
                            recTmpProd.SETRANGE("Item No.", recTmpFactProd."No. producto");
                            recTmpProd.SETFILTER(Cantidad, '<>%1', 0);
                            IF recTmpProd.FINDFIRST THEN BEGIN
                                IF recTmpProd.Cantidad <= recTmpFactProd."Cantidad liquidable" THEN
                                    decCdadLiq := recTmpProd.Cantidad
                                ELSE
                                    decCdadLiq := recTmpFactProd."Cantidad liquidable";

                                recTmpProd.Cantidad -= decCdadLiq;
                                recTmpProd.MODIFY;

                                IF blnPrimeraVez THEN BEGIN
                                    blnPrimeraVez := FALSE;
                                    codCabVta := InsertarCabDev(recPrmCabDev, TRUE,
                                                                recTmpFact."No. factura",
                                                                recTmpFact.Pendiente,
                                                                recPrmCabDev."Cod. Almacen");
                                END;
                                InsertarLinDev(codCabVta, recTmpFactProd, decCdadLiq);

                                recTmpFactProd."Cantidad liquidable" -= decCdadLiq;
                                recTmpFactProd.MODIFY;
                            END;

                        UNTIL recTmpFactProd.NEXT = 0;
                        LanzarCabDev(codCabVta);
                    END;
                UNTIL recTmpFact.NEXT = 0;
        END;

        //Devolución de productos defectuosos liquidables :

        //Si quedan algún producto defectuoso por devolver
        codCabVta := '';
        recTmpProd.RESET;
        recTmpProd.SETFILTER("Cantidad defectuosa", '<>%1', 0);
        IF recTmpProd.FINDFIRST THEN BEGIN
            recTmpFact.RESET;
            IF recTmpFact.FINDSET THEN
                REPEAT

                    recTmpFactProd.RESET;
                    recTmpFactProd.SETRANGE("No. factura", recTmpFact."No. factura");
                    recTmpFactProd.SETFILTER("Cantidad liquidable", '<>%1', 0);
                    IF recTmpFactProd.FINDSET THEN BEGIN
                        blnPrimeraVez := TRUE;
                        REPEAT

                            recTmpProd.RESET;
                            recTmpProd.SETRANGE("Item No.", recTmpFactProd."No. producto");
                            recTmpProd.SETFILTER("Cantidad defectuosa", '<>%1', 0);
                            IF recTmpProd.FINDFIRST THEN BEGIN
                                IF recTmpProd."Cantidad defectuosa" <= recTmpFactProd."Cantidad liquidable" THEN
                                    decCdadLiq := recTmpProd."Cantidad defectuosa"
                                ELSE
                                    decCdadLiq := recTmpFactProd."Cantidad liquidable";
                                recTmpProd."Cantidad defectuosa" -= decCdadLiq;
                                recTmpProd.MODIFY;

                                IF blnPrimeraVez THEN BEGIN
                                    blnPrimeraVez := FALSE;
                                    codCabVta := InsertarCabDev(recPrmCabDev, TRUE,
                                                                recTmpFact."No. factura",
                                                                recTmpFact.Pendiente,
                                                                recCfgSantillana."Almacen prod. defectuosos");
                                END;
                                InsertarLinDev(codCabVta, recTmpFactProd, decCdadLiq);

                                recTmpFactProd."Cantidad liquidable" -= decCdadLiq;
                                recTmpFactProd.MODIFY;
                            END;

                        UNTIL recTmpFactProd.NEXT = 0;
                        LanzarCabDev(codCabVta);
                    END;
                UNTIL recTmpFact.NEXT = 0;
        END;

        //Devolución del resto de productos sin defectos que no se pueden liquidar :

        codCabVta := '';
        recTmpProd.RESET;
        recTmpProd.SETFILTER(Cantidad, '<>%1', 0);
        IF recTmpProd.FINDFIRST THEN BEGIN
            recTmpFactProd.RESET;
            recTmpFactProd.SETRANGE("No. factura", '');
            recTmpFactProd.SETFILTER("Cantidad liquidable", '<>%1', 0);
            IF recTmpFactProd.FINDSET THEN BEGIN
                blnPrimeraVez := TRUE;
                REPEAT

                    recTmpProd.RESET;
                    recTmpProd.SETRANGE("Item No.", recTmpFactProd."No. producto");
                    recTmpProd.SETFILTER(Cantidad, '<>%1', 0);
                    IF recTmpProd.FINDFIRST THEN BEGIN

                        IF recTmpProd.Cantidad <= recTmpFactProd."Cantidad liquidable" THEN
                            decCdadLiq := recTmpProd.Cantidad
                        ELSE
                            decCdadLiq := recTmpFactProd."Cantidad liquidable";

                        recTmpProd.Cantidad -= decCdadLiq;
                        recTmpProd.MODIFY;

                        IF blnPrimeraVez THEN BEGIN
                            blnPrimeraVez := FALSE;
                            codCabVta := InsertarCabDev(recPrmCabDev, FALSE, '', FALSE, recPrmCabDev."Cod. Almacen");
                        END;
                        InsertarLinDev(codCabVta, recTmpFactProd, recTmpFactProd."Cantidad liquidable");

                        recTmpFactProd."Cantidad liquidable" -= decCdadLiq;
                        recTmpFactProd.MODIFY;
                    END;

                UNTIL recTmpFactProd.NEXT = 0;
                LanzarCabDev(codCabVta);
            END;
        END;

        //Devolución del resto de productos defectuosos que no se pueden liquidar :
        codCabVta := '';
        recTmpProd.RESET;
        recTmpProd.SETFILTER("Cantidad defectuosa", '<>%1', 0);
        IF recTmpProd.FINDFIRST THEN BEGIN
            recTmpFactProd.RESET;
            recTmpFactProd.SETRANGE("No. factura", '');
            recTmpFactProd.SETFILTER("Cantidad liquidable", '<>%1', 0);
            IF recTmpFactProd.FINDSET THEN BEGIN
                blnPrimeraVez := TRUE;
                REPEAT

                    recTmpProd.RESET;
                    recTmpProd.SETRANGE("Item No.", recTmpFactProd."No. producto");
                    recTmpProd.SETFILTER("Cantidad defectuosa", '<>%1', 0);
                    IF recTmpProd.FINDFIRST THEN BEGIN
                        IF recTmpProd."Cantidad defectuosa" <= recTmpFactProd."Cantidad liquidable" THEN
                            decCdadLiq := recTmpProd."Cantidad defectuosa"
                        ELSE
                            decCdadLiq := recTmpFactProd."Cantidad liquidable";

                        recTmpProd."Cantidad defectuosa" -= decCdadLiq;
                        recTmpProd.MODIFY;

                        IF blnPrimeraVez THEN BEGIN
                            blnPrimeraVez := FALSE;
                            codCabVta := InsertarCabDev(recPrmCabDev, FALSE, '', FALSE, recCfgSantillana."Almacen prod. defectuosos");
                        END;
                        InsertarLinDev(codCabVta, recTmpFactProd, recTmpFactProd."Cantidad liquidable");

                        recTmpFactProd."Cantidad liquidable" -= decCdadLiq;
                        recTmpFactProd.MODIFY;
                    END;

                UNTIL recTmpFactProd.NEXT = 0;
                LanzarCabDev(codCabVta);
            END;
        END;
    end;

    procedure InsertarCabDev(var recPrmCabDev Record: 56025; blmPrmLiquidarCdad: Boolean; codPrmFactOrigen: Code[20]; blnPrmPendiente: Boolean; codPrmAlmacen: Code[10]): Code[20]
    var
        recCabVta: Record 36;
        recDocDim: Integer;
    begin

        recCabVta.INIT;
        recCabVta."Document Type" := recCabVta."Document Type"::"Return Order";
        recCabVta.INSERT(TRUE);
        recCabVta.VALIDATE("Sell-to Customer No.", recPrmCabDev."Customer no.");
        recCabVta.VALIDATE("Posting Date", WORKDATE);
        recCabVta.VALIDATE("Location Code", codPrmAlmacen);
        recCabVta."Posting Description" := STRSUBSTNO(Text004, recPrmCabDev."Customer no.");
        recCabVta."External Document No." := recPrmCabDev."External document no.";                //$003

        IF blmPrmLiquidarCdad THEN BEGIN
            //Indica la factura original de las cantidades que se estan devolviendo.
            //recCabVta."No. Factura Fiscal Rel." := TraerNumFiscal(codPrmFactOrigen);
            recCabVta."No. Comprobante Fiscal Rel." := TraerNumFiscal(codPrmFactOrigen);
            //Si la factura que devolvemos esta pendiente se liquidan importes pendientes.
            IF blnPrmPendiente THEN BEGIN
                recCabVta.VALIDATE("Applies-to Doc. Type", recCabVta."Applies-to Doc. Type"::Invoice);
                recCabVta.VALIDATE("Applies-to Doc. No.", codPrmFactOrigen);
                TraerVendedor(codPrmFactOrigen, recCabVta);
            END
            ELSE   //Si la factura que devolvemos NO esta pendiente se liquidan importes según configuración.
                LiquidarImportes(recCabVta);
        END
        ELSE
            LiquidarImportes(recCabVta); //Aunque no liquidemos cantidades se debe liquidar los importes según configuración

        recCabVta.MODIFY(TRUE);

        InsertarDocRelacionado(recPrmCabDev."No.", optTipoDoc::Venta, recCabVta."No.");

        dlgProgeso.UPDATE(5, recCabVta."No.");

        EXIT(recCabVta."No.");
    end;

    procedure InsertarLinDev(codPrmDoc: Code[20]; var recPrmFacProd Record: 86001" temporary; decPrmCdad: Decimal)
    var
        recLinVta: Record 37;
        recDocDim: Integer;
        intLinea: Integer;
    begin
        recLinVta.RESET;
        recLinVta.SETRANGE("Document Type", recLinVta."Document Type"::"Return Order");
        recLinVta.SETRANGE("Document No.", codPrmDoc);
        IF recLinVta.FINDLAST THEN
            intLinea := recLinVta."Line No.";

        intLinea += 10000;

        recLinVta.INIT;
        recLinVta."Document Type" := recLinVta."Document Type"::"Return Order";
        recLinVta."Document No." := codPrmDoc;
        recLinVta."Line No." := intLinea;
        recLinVta.VALIDATE(Type, recLinVta.Type::Item);
        recLinVta.VALIDATE("No.", recPrmFacProd."No. producto");
        recLinVta.VALIDATE(Quantity, decPrmCdad);
        IF recPrmFacProd."No. mov. producto" <> 0 THEN
            recLinVta.VALIDATE("Appl.-from Item Entry", recPrmFacProd."No. mov. producto");
        recLinVta.INSERT(TRUE);
    end;

    procedure GenerarTablaTempFacturas(var recPrmCabDev Record: 56025")
    var
        recCabFac: Record 112;
        recMovCli: Record 21;
        recLinFac: Record 113;
        recMovValor: Record 5802;
        recMovProd: Record 32;
        decCdadADev: Decimal;
    begin
        //Genera una tabla temoral con las facturas que podemos liquidar
        //Para cada producto que se debe devolver se comprueba si hay facturas pendientes de liquidar y se guardan en
        //la tabla temporal con las cantidades que se pueden liquidar de cada producto.

        recTmpProd.RESET;
        IF recTmpProd.FINDSET THEN
            REPEAT

                decCdadADev := recTmpProd.Cantidad + recTmpProd."Cantidad defectuosa";

                IF (decCdadADev <> 0) THEN BEGIN
                    recMovCli.RESET;
                    recMovCli.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date");
                    recMovCli.ASCENDING(FALSE);
                    recMovCli.SETRANGE("Document Type", recMovCli."Document Type"::Invoice);
                    recMovCli.SETRANGE("Customer No.", recPrmCabDev."Customer no.");
                    //      recMovCli.SETRANGE(Open, TRUE);
                    IF recMovCli.FINDFIRST THEN
                        REPEAT
                            recLinFac.RESET;
                            recLinFac.SETRANGE("Document No.", recMovCli."Document No.");
                            recLinFac.SETRANGE(Type, recLinFac.Type::Item);
                            recLinFac.SETRANGE("No.", recTmpProd."Item No.");
                            IF recLinFac.FINDSET THEN
                                REPEAT

                                    //Guarda las facturas liquidables
                                    IF NOT recTmpFact.GET(recLinFac."Document No.") THEN BEGIN
                                        recTmpFact.INIT;
                                        recTmpFact."No. factura" := recLinFac."Document No.";
                                        recTmpFact.Pendiente := recMovCli.Open;
                                        recTmpFact.INSERT;
                                    END;

                                    //Guarda las cantidades liquidables por cada factura
                                    recTmpFactProd.INIT;
                                    recTmpFactProd."No. factura" := recLinFac."Document No.";
                                    recTmpFactProd."No. linea" := recLinFac."Line No.";
                                    recTmpFactProd."No. producto" := recTmpProd."Item No.";


                                    //$001  Se guarda el el mov. producto para liquidar en la devolución
                                    recMovValor.RESET;
                                    recMovValor.SETCURRENTKEY("Document No.");
                                    recMovValor.SETRANGE("Document No.", recLinFac."Document No.");
                                    recMovValor.SETRANGE("Document Type", recMovValor."Document Type"::"Sales Invoice");
                                    recMovValor.SETRANGE("Document Line No.", recLinFac."Line No.");
                                    IF recMovValor.FINDFIRST THEN BEGIN
                                        recMovProd.RESET;
                                        recMovProd.SETRANGE("Entry No.", recMovValor."Item Ledger Entry No.");
                                        recMovProd.SETFILTER("Shipped Qty. Not Returned", '<>%1', 0);
                                        IF recMovProd.FINDFIRST THEN BEGIN
                                            recTmpFactProd."No. mov. producto" := recMovProd."Entry No.";
                                            IF -recMovProd."Shipped Qty. Not Returned" >= decCdadADev THEN
                                                recTmpFactProd."Cantidad liquidable" := decCdadADev
                                            ELSE
                                                recTmpFactProd."Cantidad liquidable" := -recMovProd."Shipped Qty. Not Returned";
                                            recTmpFactProd.INSERT;
                                            InsertarFacturaLiquidadas;
                                            decCdadADev -= recTmpFactProd."Cantidad liquidable";
                                        END;
                                    END;

                                UNTIL (recLinFac.NEXT = 0) OR (decCdadADev = 0);
                        UNTIL (recMovCli.NEXT = 0) OR (decCdadADev = 0);

                    //Si quedan productos sin liquidar se guardan para generar una devolución sin fact. a liq.
                    IF decCdadADev <> 0 THEN BEGIN
                        recTmpFactProd.INIT;
                        recTmpFactProd."No. factura" := '';
                        recTmpFactProd."No. linea" := 0;
                        recTmpFactProd."No. producto" := recTmpProd."Item No.";
                        recTmpFactProd."Cantidad liquidable" := decCdadADev;
                        recTmpFactProd."No. mov. producto" := 0;
                        recTmpFactProd.INSERT;
                    END;
                END;

            UNTIL recTmpProd.NEXT = 0;
    end;

    procedure InsertarDocRelacionado(codPrmDev: Code[20]; intPrmTipo: Integer; codPrmDoc: Code[20])
    var
        recDocRel: Record 56013;
    begin
        recDocRel.INIT;
        recDocRel."No. clas. devoluciones" := codPrmDev;
        recDocRel."Tipo documento" := intPrmTipo;
        recDocRel."No. documento" := codPrmDoc;
        recDocRel.INSERT;
    end;

    procedure LanzarCabDev(codPrmDoc: Code[20])
    var
        recCabVta: Record 36;
        cduLanzar: Codeunit 414;
    begin
        IF codPrmDoc <> '' THEN BEGIN
            recCabVta.GET(recCabVta."Document Type"::"Return Order", codPrmDoc);
            cduLanzar.SetIgnorarControles(TRUE);
            cduLanzar.RUN(recCabVta);
        END;
    end;

    procedure TraerPracesados(var recPrmCabPre Record: 56025"): Integer
    var
        recDev: Record 56025;
    begin
        recDev.RESET;
        recDev.COPYFILTERS(recPrmCabPre);
        recDev.SETRANGE(recDev.Procesada, TRUE);
        EXIT(recDev.COUNT);
    end;

    procedure InsertarFacturaLiquidadas()
    begin
        recTmpFactLiquidadas := recTmpFactProd;
        recTmpFactLiquidadas.INSERT;
    end;

    procedure TraerAlmacenConsigna(codPrmCliente: Code[20]): Code[20]
    var
        recCliente: Record 18;
    begin
        IF recCliente.GET(codPrmCliente) THEN
            EXIT(recCliente."Cod. Almacen Consignacion");
    end;

    procedure LiquidarImportes(var recPrmCabVta Record: 36")
    var
        codFactLiq: Code[20];
    begin
        //Si no hay factura original:

        CASE recCfgSantillana."Liquidacion devoluciones" OF

            //Si está configurado como liq. manual se deja el campo en blanco
            recCfgSantillana."Liquidacion devoluciones"::Manual:
                BEGIN
                    recPrmCabVta."Applies-to Doc. Type" := recPrmCabVta."Applies-to Doc. Type"::" ";
                    recPrmCabVta."Applies-to Doc. No." := '';
                END;

            //Si está configurado por antigüedad se liquidará la factura más antigua
            recCfgSantillana."Liquidacion devoluciones"::"Por antiguedad":
                BEGIN
                    codFactLiq := TraerFacturaAntiguaNoLiquidada(recPrmCabVta."Sell-to Customer No.");
                    IF codFactLiq <> '' THEN BEGIN
                        recPrmCabVta.VALIDATE("Applies-to Doc. Type", recPrmCabVta."Applies-to Doc. Type"::Invoice);
                        recPrmCabVta.VALIDATE("Applies-to Doc. No.", codFactLiq);
                        TraerVendedor(codFactLiq, recPrmCabVta);
                    END;
                END;
        END;
    end;

    procedure TraerFacturaAntiguaNoLiquidada(codPrmCliente: Code[20]): Code[20]
    var
        recMovCli: Record 21;
    begin
        //Selecciona la factura mas antigua que no se haya liquidado
        recMovCli.RESET;
        recMovCli.SETCURRENTKEY("Document Type", "Customer No.", "Posting Date");
        recMovCli.SETRANGE("Document Type", recMovCli."Document Type"::Invoice);
        recMovCli.SETRANGE("Customer No.", codPrmCliente);
        recMovCli.SETRANGE(Open, TRUE);
        IF recMovCli.FINDFIRST THEN
            EXIT(recMovCli."Document No.");

        //IF recMovCli.FINDSET THEN
        //  REPEAT
        //Comprobamos que no se haya utilizado ya para liquidar en este mismo proceso
        //    recTmpFactLiquidadas.RESET;
        //    recTmpFactLiquidadas.SETRANGE("No. factura", recMovCli."Document No.");
        //    IF NOT recTmpFactLiquidadas.FINDFIRST THEN
        //      EXIT(recMovCli."Document No.");
        //  UNTIL recMovCli.NEXT = 0;
    end;

    procedure TraerVendedor(codPrmFacLiq: Code[20]; var recPrmCabVta Record: 36")
    var
        recFacVta: Record 112;
    begin
        IF recFacVta.GET(codPrmFacLiq) THEN
            IF recFacVta."Salesperson Code" <> '' THEN
                recPrmCabVta.VALIDATE("Salesperson Code", recFacVta."Salesperson Code");
    end;

    procedure TraerNumFiscal(codPrmFac: Code[20]): Code[40]
    var
        recCabFac: Record 112;
    begin
        IF recCabFac.GET(codPrmFac) THEN
            EXIT(recCabFac."No. Comprobante Fiscal");
    end;
}

