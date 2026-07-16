codeunit 56000 "Funciones Santillana"
{
    // Proyecto: Microsoft Dynamics Nav 2009 - Santillana
    // AMS     : Agustin Mendez
    // GRN     : Guillermo Roamn
    // YFC     : Yefrecis Cruz
    // --------------------------------------------------------------------------
    // No.     Fecha         Firma  Descripcion
    // ------------------------------------------------------------------------
    // 001     04-Junio-09   AMS    Pasamos los campos Precio venta, Descuento
    //                              e Importe.
    // #4161   29/09/2014    PLB    Solo permitir registrar la hoja de ruta si las lineas de pedido venta tienen rellenado
    //                              el no. factura
    // 
    // #37066  20/11/2015    FAA    Arrastrar numero de hoja de ruta al registro.
    // NopCommerce  05/Nov/2020   AMS    Se marcan como entregadas aquellas facturas provenientes del portal E-Commerce
    // 002     28/01/2020    YFC    SANTINAV-2068: Actualizar # consnecutivo en documentos electronicos tiquetes de tienda en linea
    // 003     21/10/2025    LDP    SANTINAV-8697: Problema con codigo QR en facturas electronicas ã Costa Rica

    Permissions = TableData 32 = rm,
                  TableData 112 = rm,
                  TableData 114 = rm,
                  TableData 5746 = rm,
                  TableData 5747 = rm,
                  TableData 5773 = rimd;
    SingleInstance = true;

    trigger OnRun()
    begin
        //Corrigeerror;
        //CorrigeContrato;

        //ActualizarConsecutivoFE();
    end;

    var
        Error001: Label 'Debe especificar Tarifa de venta para el producto %1';
        NoPedidoTransferencia: Code[20];
        Cliente: Record 18;
        NoLinea: Integer;
        ConfSantillana: Record 56001;
        txt001: Label 'From Customer:';
        Cantidad: Integer;
        TransferReceiptHeader: Record 5746;
        TransferReceiptLine: Record 5747;
        ItemLedgerEntryCons: Record 32;
        //TODO: Ver MailSetup: Record 409;
        //TODO: Ver SMTP: Codeunit 400;
        UserSetup: Record 56000;
        UserSetUp1: Record 56000;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        rSalesLines: Record 37;
        UltimoLote: Integer;
        rConfTPV: Record 34002500;
        rGenJournalLine: Record 81;
        rCustLedgerEntry: Record 21;
        rItem: Record 27;
        //TODO: Ver rICR: Record 5717;
        wDesc: Decimal;
        //TODO: Ver NoSerMang: Codeunit 396;
        Error002: Label 'Qty. Packed is greater than Qty. in Picking %1 for item %2';
        Error003: Label 'Existe, al menos, una linea con "%1" = %2 sin "%3" ("%4" = %5). Antes de registrar tiene que asociar la factura a esa linea.';
        TransHeader: Record 5740;
        TransferLine: Record 5741;
        NoLin: Integer;
        NewTransLine: Record 5741;
        DocDim: Codeunit 408;
        Prueba: Record 56022;
        Error004: Label 'El estado no se puede pasar a pendiente, ya existe packing para este pedido (%1).';
        Error005: Label 'Qty. Packed is greater than Qty. in Picking %1 for item %2';
        Error006: Label 'Qty. Packed is greater than Qty. in Picking %1 for item %2';
        Error007: Label 'Algunos productos no están completamente incluidos en el packing (%1)';

    procedure CalcrPrecio(ItemNo: Code[20]; CodCliente: Code[20]; CodUndMed: Code[20]; Fecha: Date): Decimal
    var
        SalesPrice: Record 7002;
        SalesDisc: Record 7004;
        wPrecio_Loc: Decimal;
    begin
        BuscaTarifa(ItemNo, CodCliente, wDesc, wPrecio_Loc);
        EXIT(wPrecio_Loc);
    end;

    procedure CalcDesc(ItemNo: Code[20]; CodCliente: Code[20]; CodUndMed: Code[20]; Fecha: Date): Decimal
    var
        SalesLineDisc: Record 7004;
        Item: Record 27;
        wDesc_Loc: Decimal;
        wPrecio_Loc: Decimal;
    begin
        BuscaTarifa(ItemNo, CodCliente, wDesc_Loc, wPrecio_Loc);
        EXIT(wDesc_Loc);
    end;

    procedure InsertaInvConsig(SalesHeader: Record 36)
    var
        SalesLines: Record 37;
        SalesLine1: Record 37;
        Item: Record 27;
        Item1: Record 27;
        Cliente: Record 18;
        NoLinea: Integer;
    begin
        SalesHeader.TESTFIELD("Location Code");
        Cliente.GET(SalesHeader."Sell-to Customer No.");
        SalesHeader.TESTFIELD("Location Code", Cliente."Cod. Almacen Consignacion");

        Item.RESET;
        IF Item.FINDFIRST THEN
            REPEAT
                Item1.RESET;
                Item1.GET(Item."No.");
                Item1.SETFILTER("Location Filter", SalesHeader."Location Code");
                Item1.CALCFIELDS(Item1.Inventory);
                IF Item1.Inventory <> 0 THEN BEGIN
                    //Insertamos la linea en el pedido de venta
                    SalesLines.RESET;
                    SalesLines.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLines.SETRANGE("Document No.", SalesHeader."No.");
                    IF SalesLines.FINDLAST THEN
                        NoLinea := SalesLines."Line No."
                    ELSE
                        NoLinea := 0;

                    NoLinea += 10000;
                    SalesLine1.INIT;
                    SalesLine1.VALIDATE("Document Type", SalesHeader."Document Type");
                    SalesLine1.VALIDATE("Document No.", SalesHeader."No.");
                    SalesLine1."Line No." := NoLinea;
                    SalesLine1.VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                    SalesLine1.VALIDATE(Type, SalesLine1.Type::Item);
                    SalesLine1.VALIDATE("No.", Item1."No.");
                    SalesLine1.VALIDATE("Location Code", SalesHeader."Location Code");
                    SalesLine1.VALIDATE(Quantity, Item1.Inventory);
                    SalesLine1.INSERT(TRUE);
                END;
            UNTIL Item.NEXT = 0;
    end;

    procedure BuscaLineasPendientesEntrega(TransferHeader: Record 5740): Boolean
    var
        TransferLine: Record 5741;
        TransferLine1: Record 5741;
        txt001: Label 'Existen lineas de pedidos pendientes de entrega para Cod. producto %1 Almacen %2 en el pedido %3';
    begin
        //Entramos en el bucle de las lineas de la transferencia actual
        TransferLine.RESET;
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        IF TransferLine.FINDFIRST THEN
            REPEAT
                TransferLine1.RESET;
                TransferLine1.SETRANGE("Item No.", TransferLine."Item No.");
                TransferLine1.SETRANGE("Transfer-to Code", TransferLine."Transfer-to Code");
                TransferLine1.SETFILTER("Quantity Shipped", '<>0');
                TransferLine1.SETFILTER("Qty. to Receive", '<>0');
                IF TransferLine1.FINDFIRST THEN
                    IF NOT CONFIRM(txt001, FALSE, TransferLine1."Item No.", TransferLine1."Transfer-to Code", TransferLine1."Document No.") THEN
                        EXIT(FALSE);
                EXIT(TRUE);
            UNTIL TransferLine.NEXT = 0;
    end;

    procedure BuscaLineasPendEntregaVenta(SalesHeader: Record 36): Boolean
    var
        SalesLine: Record 37;
        TransferLine1: Record 5741;
        txt001: Label 'Existen lineas de pedidos pendientes de entrega para Cod. producto %1 Almacen %2 en el pedido %3';
    begin
        //Entramos en el bucle de las lineas de la transferencia actual
        SalesLine.RESET;
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>''');
        IF SalesLine.FINDSET THEN
            REPEAT
                TransferLine1.RESET;
                TransferLine1.SETRANGE("Item No.", SalesLine."No.");
                TransferLine1.SETRANGE("Transfer-to Code", SalesLine."Location Code");
                TransferLine1.SETFILTER("Quantity Shipped", '<>0');
                TransferLine1.SETFILTER("Qty. to Receive", '<>0');
                IF TransferLine1.FINDFIRST THEN
                    IF NOT CONFIRM(txt001, FALSE, TransferLine1."Item No.", TransferLine1."Transfer-to Code", TransferLine1."Document No.") THEN
                        EXIT(FALSE);
                EXIT(TRUE);
            UNTIL SalesLine.NEXT = 0;
    end;

    procedure RecibeNoDoc(NoDocumento: Code[20])
    begin
        NoPedidoTransferencia := NoDocumento;
    end;

    procedure EnviaNoTransferencia(): Code[20]
    begin
        EXIT(NoPedidoTransferencia);
    end;

    procedure InsertaInvConsigTransfer(TransHeader: Record 5740)
    var
        Item: Record 27;
        TransferLine: Record 5741;
        TransferLine1: Record 5741;
        Item1: Record 27;
    begin
        TransHeader.TESTFIELD("Transfer-from Code");
        Cliente.GET(TransHeader."Transfer-from Code");

        Item.RESET;
        IF Item.FIND('-') THEN
            REPEAT
                Item1.RESET;
                Item1.SETRANGE("No.", Item."No.");
                Item1.SETFILTER("Location Filter", TransHeader."Transfer-from Code");
                IF Item1.FINDFIRST THEN BEGIN
                    Item1.CALCFIELDS(Item1.Inventory);
                    IF Item1.Inventory <> 0 THEN BEGIN
                        //Insertamos la linea en el pedido de Transferencia
                        TransferLine.RESET;
                        TransferLine.SETRANGE("Document No.", TransHeader."No.");
                        TransferLine.SETRANGE(TransferLine."Derived From Line No.", 0);
                        IF TransferLine.FINDLAST THEN
                            NoLinea := TransferLine."Line No."
                        ELSE
                            NoLinea := 0;
                        NoLinea += 10000;
                        TransferLine1.INIT;
                        TransferLine1.VALIDATE("Document No.", TransHeader."No.");
                        TransferLine1."Line No." := NoLinea;
                        TransferLine1.VALIDATE("Item No.", Item1."No.");
                        TransferLine1.VALIDATE(Quantity, Item1.Inventory);
                        TransferLine1."Precio Venta Consignacion" := CalcrPrecio(Item1."No.", TransHeader."Transfer-from Code",
                        TransferLine1."Unit of Measure Code", TransHeader."Posting Date");
                        TransferLine1."Descuento % Consignacion" := CalcDesc(Item1."No.", TransHeader."Transfer-from Code",
                                                                       TransferLine1."Unit of Measure Code", TransHeader."Posting Date");
                        TransferLine1.VALIDATE(Quantity);
                        TransferLine1.VALIDATE("Qty. to Ship", 0);
                        TransferLine1.INSERT(TRUE);
                    END;
                END;
            UNTIL Item.NEXT = 0;
    end;

    procedure CreaEmailPedidoVenta(SalesHeader: Record 36)
    var
        SenderName: Text[100];
        SenderAddress: Text[100];
        Recipient: Text[1024];
        Subject: Text[100];
        Body: Text[1024];
        SalesHeader1: Record 36;
    begin
        /*
        ConfSantillana.GET;
        ConfSantillana.TESTFIELD("Ubicacion Temp. Reportes HTML");
        MailSetup.GET;
        Recipient := '';
        
        UserSetup.GET(USERID);
        IF UserSetup."Envia E-mail pedido venta" THEN
          BEGIN
            Subject       := ConfSantillana."Titulo E-mail Pedido de Venta" + ' ' +SalesHeader."No." + ' '+txt001 +
                             SalesHeader."Sell-to Customer No." + '-'+SalesHeader."Bill-to Name";
            SenderName    := COMPANYNAME;
            SenderAddress := MailSetup."User ID";
            //Correos de usuario(s) destino
            UserSetUp1.RESET;
            UserSetUp1.SETRANGE("Recibe E-mail pedido venta",TRUE);
            IF UserSetUp1.FINDSET(FALSE,FALSE) THEN
              REPEAT
                UserSetUp1.TESTFIELD("E-Mail");
                Recipient += UserSetUp1."E-Mail"+';';
              UNTIL UserSetUp1.NEXT = 0;
        
            //Se quita el signo ultimo ;
            Recipient := COPYSTR(Recipient,1,(STRLEN(Recipient)-1));
        
            SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
            Body := '';
            SMTP.AppendBody(Body);
            SalesHeader1.RESET;
            SalesHeader1.SETRANGE("Document Type",SalesHeader."Document Type");
            SalesHeader1.SETRANGE("No.",SalesHeader."No.");
            REPORT.SAVEASHTML(50014,ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP25001.html',FALSE,SalesHeader1);
            SMTP.AddAttachment(ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP25001.html');
            SMTP.Send;
            ERASE(ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP25001.html');
        
            SalesHeader."Estado distribucion" := SalesHeader."Estado distribucion"::"Para Confirmar";
            SalesHeader.MODIFY;
          END;
         */

    end;

    procedure CreaEmailPedidoConsg(TransferHeader: Record 5740)
    var
        SenderName: Text[100];
        SenderAddress: Text[100];
        Recipient: Text[1024];
        Subject: Text[100];
        Body: Text[1024];
        TransferHeader1: Record 5740;
    begin
        /*
        ConfSantillana.GET;
        ConfSantillana.TESTFIELD("Ubicacion Temp. Reportes HTML");
        MailSetup.GET;
        Recipient := '';
        
        UserSetup.GET(USERID);
        IF UserSetup."Envia E-mail pedido venta" THEN
          BEGIN
            Cliente.GET(TransferHeader."Transfer-to Code");
            Subject       := ConfSantillana."Titulo E-mail Pedido de Venta" + ' ' +TransferHeader."No."+ ' '+txt001 +
                             Cliente."No." + '-'+Cliente.Name;
            SenderName    := COMPANYNAME;
            SenderAddress := MailSetup."User ID";
            //Correos de usuario(s) destino
            UserSetUp1.RESET;
            UserSetUp1.SETRANGE(UserSetUp1."Recibe E-mail pedido venta",TRUE);
            IF UserSetUp1.FINDSET(FALSE,FALSE) THEN
              REPEAT
                UserSetUp1.TESTFIELD("E-Mail");
                Recipient += UserSetUp1."E-Mail"+';';
              UNTIL UserSetUp1.NEXT = 0;
        
            //Se quita el signo ultimo ;
            Recipient := COPYSTR(Recipient,1,(STRLEN(Recipient)-1));
        
            SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
            Body := '';
            SMTP.AppendBody(Body);
            TransferHeader1.GET(TransferHeader."No.");
            REPORT.SAVEASHTML(50018,ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP5703.html',FALSE,TransferHeader1);
            SMTP.AddAttachment(ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP5703.html');
            SMTP.Send;
            ERASE(ConfSantillana."Ubicacion Temp. Reportes HTML"+'REP5703.html');
        
            TransferHeader."Estado distribucion" := TransferHeader."Estado distribucion"::"Para Confirmar";
            TransferHeader.MODIFY;
          END;
         */

    end;

    procedure ControlNoCopias(SalesHeader: Record 36; DocumentoImpreso: Option Picking)
    begin
        IF DocumentoImpreso = 0 THEN
            SalesHeader."No. copias Picking" := SalesHeader."No. copias Picking" + 1;
        SalesHeader.MODIFY;
        COMMIT;
    end;

    procedure ControlNoCopiasConsignacion(TransferHeader: Record 5740)
    begin
        TransferHeader."No. Copias impresas" := TransferHeader."No. Copias impresas" + 1;
        TransferHeader.MODIFY;
        COMMIT;
    end;

    procedure ControlNoCopiasCosngRecepcion(TransferRecHeader: Record 5746)
    begin
        TransferRecHeader."No. Copias imp. Recep." := TransferRecHeader."No. Copias imp. Recep." + 1;
        TransferRecHeader.MODIFY;
        COMMIT;
    end;

    procedure InvConsPedidoVenta(CodCliente: Code[20])
    var
        NoRecepcion: Code[20];
        CFuncSantillana: Codeunit 56000;
        NoPedidoActual: Code[20];
        SalesHeader: Record 36;
        SalesLine: Record 37;
        TransHeader1: Record 5740;
        SalesLine1: Record 37;
        TransRecHeader: Record 5746;
        TransRecLines: Record 5747;
        TransRecHeader1: Record 5746;
        TransRecLines1: Record 5747;
        ItemLedgerEntry: Record 32;
        rLinCons: Record 56011;
        rLinCons1: Record 56011;
        frmLinConsig: Page 56052;
    begin
        NoPedidoActual := CFuncSantillana.EnviaNoTransferencia;
        Counter := 0;
        CounterTotal := 0;

        rLinCons.RESET;
        rLinCons.SETRANGE("Document Type", rLinCons."Document Type"::Order);
        rLinCons.SETRANGE("Document No.", NoPedidoActual);
        rLinCons.SETRANGE("ID Usuario", USERID);
        rLinCons.DELETEALL;

        //Buscamos lineas pedido de venta a consignacion
        TransRecLines.RESET;
        TransRecLines.SETCURRENTKEY("Transfer-to Code");
        TransRecLines.SETRANGE("Transfer-to Code", CodCliente);
        CounterTotal := TransRecLines.COUNT;
        Window.OPEN(Text001);
        IF TransRecLines.FINDSET THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, TransRecLines."Document No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                //Se busca el No. de mov. producto correspondiente a la linea para pasarla a la linea de pedidos
                //de venta
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Document Line No.");
                ItemLedgerEntry.SETRANGE("Document No.", TransRecLines."Document No.");
                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                ItemLedgerEntry.SETRANGE("Document Line No.", TransRecLines."Line No.");
                ItemLedgerEntry.SETRANGE("Location Code", TransRecLines."Transfer-to Code");
                IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                    IF
                      ItemLedgerEntry."Cant. Consignacion Pendiente" > 0 THEN BEGIN
                        rLinCons1.RESET;
                        rLinCons1.SETRANGE("Document Type", rLinCons1."Document Type"::Order);
                        rLinCons1.SETRANGE("Document No.", NoPedidoActual);
                        rLinCons1.SETRANGE("ID Usuario", USERID);
                        IF rLinCons1.FINDLAST THEN
                            NoLinea := rLinCons1."Line No."
                        ELSE
                            NoLinea := 0;

                        NoLinea := NoLinea + 10000;
                        rLinCons.INIT;
                        rLinCons.VALIDATE("Document Type", rLinCons."Document Type"::Order);
                        rLinCons.VALIDATE("Document No.", NoPedidoActual);
                        rLinCons.VALIDATE("Line No.", NoLinea);
                        rLinCons.VALIDATE(Type, rLinCons.Type::Item);
                        rLinCons.VALIDATE("No.", TransRecLines."Item No.");
                        rLinCons.VALIDATE("No. Mov. Prod. Cosg. a Liq.", ItemLedgerEntry."Entry No.");
                        rLinCons.VALIDATE("ID Usuario", USERID);

                        //La cantidad que se pasa a las lineas de venta es la pendiente en el
                        //Mov. producto
                        rLinCons.VALIDATE(Quantity, ItemLedgerEntry."Cant. Consignacion Pendiente");
                        rLinCons.VALIDATE("Cantidad a Facturar", ItemLedgerEntry."Cant. Consignacion Pendiente");

                        rLinCons.VALIDATE("Unit of Measure Code", TransRecLines."Unit of Measure Code");

                        //el precio de venta es el actual. confirmado por Robert Molina el 22 Julio 2011
                        /*
                        SalesLine.VALIDATE("Unit Price",TransRecLines."Precio Venta Consignacion");
                        SalesLine.VALIDATE(SalesLine."Line Discount %",TransRecLines."Descuento % Consignacion");
                        */
                        /* //GRN 25/01/2012 Para buscar el ultimo precio de venta
                         SalesLine1.RESET;
                         SalesLine1.SETRANGE(SalesLine1."Document Type",SalesLine1."Document Type"::Order);
                         SalesLine1.SETRANGE(SalesLine1."Document No.",NoPedidoActual);
                         IF SalesLine1.FINDLAST THEN
                           NoLinea := SalesLine1."Line No."
                         ELSE
                           NoLinea := 0;

                         NoLinea += 10000;
                         SalesLine.INIT;
                         SalesLine.VALIDATE("Document Type",SalesLine."Document Type"::Order);
                         SalesLine.VALIDATE("Document No.",NoPedidoActual);
                         SalesLine.VALIDATE("Line No.",NoLinea);
                         SalesLine.VALIDATE(Type,SalesLine.Type::Item);
                         SalesLine.VALIDATE("No.",TransRecLines."Item No.");
                         rLinCons."Unit Price" := SalesLine."Unit Price";
                         */
                        //GRN Hasta aqui
                        rLinCons.VALIDATE("No. Pedido Consignacion", TransRecLines."Document No.");
                        rLinCons.VALIDATE("No. Linea Pedido Consignacion", TransRecLines."Line No.");
                        rLinCons.VALIDATE(Description, TransRecLines.Description);

                        rLinCons.INSERT(TRUE);
                    END;
                END;
            UNTIL TransRecLines.NEXT = 0;
        Window.CLOSE;

        COMMIT;
        rLinCons.RESET;
        rLinCons.SETRANGE("Document Type", rLinCons."Document Type"::Order);
        rLinCons.SETRANGE("Document No.", NoPedidoActual);
        rLinCons.SETRANGE("ID Usuario", USERID);
        frmLinConsig.SETTABLEVIEW(rLinCons);
        frmLinConsig.RecibeNoPedido(NoPedidoActual);
        frmLinConsig.RUNMODAL;
        CLEAR(frmLinConsig);

    end;

    procedure ActualizaCantPendCons(ItemLedgerEntryFromJournal: Record 32)
    var
        ItemLedgerEntry1: Record 32;
    begin
        TransferReceiptHeader.RESET;
        TransferReceiptHeader.SETRANGE(TransferReceiptHeader."No.", ItemLedgerEntryFromJournal."Document No.");
        TransferReceiptHeader.FINDFIRST;

        TransferReceiptLine.RESET;
        TransferReceiptLine.SETRANGE("Document No.", ItemLedgerEntryFromJournal."Document No.");
        TransferReceiptLine.SETRANGE("Line No.", ItemLedgerEntryFromJournal."Document Line No.");
        TransferReceiptLine.SETRANGE("Cantidad Consg. Aplicada", FALSE);
        IF TransferReceiptLine.FINDFIRST THEN BEGIN
            ItemLedgerEntry1.GET(TransferReceiptLine."No. Mov. Prod. Cosg. a Liq.");
            ItemLedgerEntry1."Cant. Consignacion Pendiente" := ItemLedgerEntry1."Cant. Consignacion Pendiente" -
                                                                TransferReceiptLine.Quantity;
            TransferReceiptLine."Cantidad Consg. Aplicada" := TRUE;
            TransferReceiptLine.MODIFY;
            ItemLedgerEntry1.MODIFY;
        END;
    end;

    procedure ControlNoCopiasNotaCredito(SalesCreditMemoHeader: Record 114)
    begin
        SalesCreditMemoHeader."No. Printed" := SalesCreditMemoHeader."No. Printed" + 1;
        SalesCreditMemoHeader.MODIFY;
        COMMIT;
    end;

    procedure EnviaAConfirmarConsignacion(TransferHeader: Record 5740)
    var
        SenderName: Text[100];
        SenderAddress: Text[100];
        Recipient: Text[1024];
        Subject: Text[100];
        Body: Text[1024];
        TransferHeader1: Record 5740;
    begin
        /*
        ConfSantillana.GET;
        MailSetup.GET;
        Recipient := '';
        
        UserSetup.GET(USERID);
        IF UserSetup."Envia E-mail Confirmacion Ped." THEN
          BEGIN
            Cliente.GET(TransferHeader."Transfer-to Code");
            Subject       := ConfSantillana."Titulo E-mail Confirm. Pedido" + ' ' +TransferHeader."No."+ ' '+txt001 +
                             Cliente."No." + '-'+Cliente.Name;
            SenderName    := COMPANYNAME;
            SenderAddress := MailSetup."User ID";
            //Correos de usuario(s) destino
            UserSetUp1.RESET;
            UserSetUp1.SETRANGE("Recibe E-mail Confirmacion Ped",TRUE);
            IF UserSetUp1.FINDSET(FALSE,FALSE) THEN
              REPEAT
                UserSetUp1.TESTFIELD("E-Mail");
                Recipient += UserSetUp1."E-Mail"+';';
              UNTIL UserSetUp1.NEXT = 0;
        
            //Se quita el signo ultimo ;
            Recipient := COPYSTR(Recipient,1,(STRLEN(Recipient)-1));
        
            SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
            Body := '';
            SMTP.AppendBody(Body);
            SMTP.Send;
        
            TransferHeader."Estado distribucion" := TransferHeader."Estado distribucion"::"Para Confirmar";
            TransferHeader.MODIFY;
          END;
          */

    end;

    procedure EnviaAConfirmarPedidoVenta(SalesHeader: Record 36)
    var
        SenderName: Text[100];
        SenderAddress: Text[100];
        Recipient: Text[1024];
        Subject: Text[100];
        Body: Text[1024];
        SalesHeader1: Record 36;
    begin

        ConfSantillana.GET;
        //TODO: Ver MailSetup.GET;
        Recipient := '';

        UserSetup.GET(USERID);
        /*
        IF UserSetup."Envia E-mail Confirmacion Ped." THEN
          BEGIN
            Subject       := ConfSantillana."Titulo E-mail Confirm. Pedido" + ' ' +SalesHeader."No." + ' '+txt001 +
                             SalesHeader."Sell-to Customer No." + '-'+SalesHeader."Bill-to Name";
            SenderName    := COMPANYNAME;
            SenderAddress := MailSetup."User ID";
            //Correos de usuario(s) destino
            UserSetUp1.RESET;
            UserSetUp1.SETRANGE("Recibe E-mail Confirmacion Ped",TRUE);
            IF UserSetUp1.FINDSET(FALSE,FALSE) THEN
              REPEAT
                UserSetUp1.TESTFIELD("E-Mail");
                Recipient += UserSetUp1."E-Mail"+';';
              UNTIL UserSetUp1.NEXT = 0;
        
            //Se quita el signo ultimo ;
            Recipient := COPYSTR(Recipient,1,(STRLEN(Recipient)-1));
        
            SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
            Body := '';
        
            SMTP.AppendBody(Body);
            SMTP.Send;
            SalesHeader."Estado distribucion" := SalesHeader."Estado distribucion"::"Para Confirmar";
            SalesHeader.MODIFY;
          END;
         */

    end;

    procedure CalcAvailableCredit(CustNo: Code[20]; SalesHeaderActual: Record 36): Decimal
    var
        TotalAmountLCY: Decimal;
        Cliente: Record 18;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        wPendiente: Decimal;
        wCreditoDisponible: Decimal;
        wPendienteActual: Decimal;
        wBalanceConsignacion: Decimal;
    begin
        ConfSantillana.GET;
        CLEAR(wPendiente);
        CLEAR(wBalanceConsignacion);
        Cliente.GET(CustNo);
        WITH Cliente DO BEGIN
            SETRANGE("Date Filter", 0D, WORKDATE);
            CALCFIELDS("Balance (LCY)");

            //Calculo el importe pendiente del pedido actual
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeaderActual."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeaderActual."No.");
            IF SalesLine.FINDSET THEN
                REPEAT
                    wPendienteActual += SalesLine."Outstanding Amount (LCY)";
                UNTIL SalesLine.NEXT = 0;

            SalesHeader.RESET;
            SalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", Status);
            SalesHeader.SETFILTER("Document Type", '%1|%2', SalesHeader."Document Type"::Order,
                                    SalesHeader."Document Type"::Invoice);
            SalesHeader.SETRANGE("Sell-to Customer No.", CustNo);
            SalesHeader.SETRANGE(Status, SalesHeader.Status::Released);
            IF SalesHeader.FINDSET THEN
                REPEAT
                    SalesLine.RESET;
                    SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            wPendiente += SalesLine."Outstanding Amount (LCY)"
                        UNTIL SalesLine.NEXT = 0;

                UNTIL SalesHeader.NEXT = 0;

            TotalAmountLCY := "Balance (LCY)" + wPendiente + wPendienteActual;

            //Se toma en cuenta el balance en consignacion que tiene el cliente
            //para el limite de credito
            CALCFIELDS("Balance en Consignacion");
            wBalanceConsignacion := "Balance en Consignacion";

            TotalAmountLCY += wBalanceConsignacion;

            IF "Credit Limit (LCY)" <> 0 THEN BEGIN
                IF ConfSantillana."Credito excedido %" <> 0 THEN BEGIN
                    wCreditoDisponible := ("Credit Limit (LCY)" * ConfSantillana."Credito excedido %") / 100;
                    wCreditoDisponible := "Credit Limit (LCY)" + wCreditoDisponible;
                END
                ELSE
                    wCreditoDisponible := "Credit Limit (LCY)";


                EXIT(wCreditoDisponible - TotalAmountLCY);
            END;
        END;
    end;

    procedure cuCreaCupones(CodColegio: Code[20]; CodVendedor: Code[20]; NombreVendedor: Text[100]; ValidaDesde: Date; ValidaHasta: Date; GradoAlumno: Text[30]; DescuentoAColegio: Decimal; DescAPadre: Decimal; AnoEscolar: Text[30]; NombreColegio: Text[100]; txtDescripcion: Text[250]; CantidadCupones: Integer; Lote: Integer; CantidadLimite: Integer; ImporteDescLimite: Decimal; CodCliente: Code[20]; Nombrecliente: Text[120])
    var
        rSalesperson: Record 13;
        rContacto: Record 5050;
        I: Integer;
        rCabCupon: Record 51009;
        rLinCupon: Record 51010;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        rConfEmpresa: Record 56001;
        //TODO: Ver cuNoSerMangm: Codeunit 396;
        rCreaCupLot: Record 51011;
        rCabCupon1: Record 51009;
        rAnoEscolar: Record 51013;
        rCrearCuponPorLote: Record 51011;
        NoSeries: Code[20];
        rVendPorColegio: Record 51014;
        Error001: Label 'You Must complete Salesperson Code';
        Error002: Label 'You must complete School Code';
        Error003: Label 'You must complete Valid From';
        Error004: Label 'You must complete Valid to';
        Error008: Label 'Family Discount Must be completed';
        Text001: Label 'Creating Coupons   #1########## @2@@@@@@@@@@@@@';
        Text002: Label '%1 Coupons out of a total of %2 have now been created.';
        Error005: Label 'You must complete Coupons Qty.';
        Error006: Label 'You must indicate No. Series No.';
        Error007: Label 'The Salesperson %1 is not included in School - Salespersons %2';
        txt001: Label 'Confirm that you want generate the coupons';
        Error009: Label 'Debe especificar una descripcion';
        GrupoNegCuponReg: Record 51017;
        GrupoNegCupon: Record 51016;
    begin
        UltimoLote := UltLoteCupon + 1;

        IF txtDescripcion = '' THEN
            ERROR(Error009);

        IF CodVendedor = '' THEN
            ERROR(Error001);
        IF CodColegio = '' THEN
            ERROR(Error002);
        IF ValidaDesde = 0D THEN
            ERROR(Error003);
        IF ValidaHasta = 0D THEN
            ERROR(Error004);

        IF CantidadCupones = 0 THEN
            ERROR(Error005);


        rConfEmpresa.GET;
        rConfEmpresa.TESTFIELD("No. serie Cupon");

        CounterTotal := CantidadCupones;
        Window.OPEN(Text001);

        REPEAT

            //TODO: Ver rCabCupon."No. Cupon" := cuNoSerMangm.GetNextNo(rConfEmpresa."No. serie Cupon", WORKDATE, TRUE);
            Counter := Counter + 1;
            Window.UPDATE(1, rCabCupon."No. Cupon");
            Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

            I += 1;
            rCabCupon.VALIDATE("Valido Desde", ValidaDesde);
            rCabCupon.VALIDATE("Valido Hasta", ValidaHasta);
            rCabCupon.VALIDATE("Cod. Colegio", CodColegio);
            //rCabCupon.VALIDATE("Cod. Nivel",Nivelalum);
            rCabCupon.VALIDATE("Descuento a Colegio", DescuentoAColegio);
            rCabCupon.VALIDATE("Descuento a Padres de Familia", DescAPadre);
            rCabCupon.VALIDATE("Cod. Vendedor", CodVendedor);
            rCabCupon.VALIDATE(Descripcion, txtDescripcion);
            rCabCupon."No. Lote" := UltimoLote;
            rCabCupon.VALIDATE("Fecha Creacion", WORKDATE);
            rCabCupon.VALIDATE("Hora Creacion", TIME);
            rCabCupon.VALIDATE("Creado por Usuario", USERID);
            rCabCupon.VALIDATE("Grado del Alumno", GradoAlumno);
            rCabCupon.VALIDATE("Cantidad Limite", CantidadLimite);
            rCabCupon.VALIDATE("Importe Dto. Limite", ImporteDescLimite);
            rCabCupon.VALIDATE("Ano Escolar", AnoEscolar);
            rCabCupon.VALIDATE("Cod. Cliente", CodCliente);
            rCabCupon.VALIDATE("Nombre Cliente", Nombrecliente);
            //rCabCupon.VALIDATE("Descripcion grado",DescGrado);

            //Inserta Grupo Negocio - NopCommerce
            GrupoNegCupon.RESET;
            GrupoNegCupon.SETRANGE(GrupoNegCupon."No. Lote cupon", Lote);
            IF GrupoNegCupon.FINDSET THEN
                REPEAT
                    GrupoNegCuponReg.INIT;
                    GrupoNegCuponReg."No. Lote cupon" := Lote;
                    GrupoNegCuponReg."Grupo Negocio" := GrupoNegCupon."Grupo Negocio";
                    GrupoNegCuponReg."No. Cupon" := rCabCupon."No. Cupon";
                    GrupoNegCuponReg.INSERT;
                UNTIL GrupoNegCupon.NEXT = 0;
            rCabCupon.INSERT(TRUE);

            rCreaCupLot.RESET;
            IF rCreaCupLot.FINDSET THEN
                REPEAT
                    IF rCreaCupLot."Cod. Producto" <> '' THEN BEGIN
                        rLinCupon.INIT;
                        rLinCupon.VALIDATE("No. Cupon", rCabCupon."No. Cupon");
                        rLinCupon.VALIDATE("Cod. Producto", rCreaCupLot."Cod. Producto");
                        rLinCupon.VALIDATE("Precio Venta", rCreaCupLot."Precio Venta");

                        rLinCupon.VALIDATE("% Descuento", rCreaCupLot."% Descuento");
                        rLinCupon.VALIDATE(Cantidad, 1);
                        rLinCupon.INSERT;
                    END;
                UNTIL rCreaCupLot.NEXT = 0;

        UNTIL I = CantidadCupones;

        Window.CLOSE;
        MESSAGE(Text002, I, CounterTotal);

        rCreaCupLot.RESET;
        rCreaCupLot.DELETEALL;
    end;

    procedure UltLoteCupon(): Integer
    var
        rCabCupon: Record 51009;
    begin
        rCabCupon.SETCURRENTKEY("No. Lote");
        IF rCabCupon.FINDLAST THEN
            EXIT(rCabCupon."No. Lote")
        ELSE
            EXIT(0);
    end;

    procedure RegVtasTPVNas()
    begin
        SELECTLATESTVERSION;
        //TODO: Ver REPORT.RUN(REPORT::Report51003, FALSE, FALSE);
    end;

    procedure RegPagosTPVNas()
    begin
        rConfTPV.GET();

        //Se igualan las dimensiones del pago a las de la factura
        rGenJournalLine.RESET;
        rGenJournalLine.SETRANGE("Journal Template Name", rConfTPV."Nombre libro diario");
        rGenJournalLine.SETRANGE("Journal Batch Name", rConfTPV."Nombre seccion diario");
        IF rGenJournalLine.FINDSET THEN
            REPEAT
                rCustLedgerEntry.RESET;
                rCustLedgerEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                rCustLedgerEntry.SETRANGE("Document No.", rGenJournalLine."Document No.");
                rCustLedgerEntry.SETRANGE("Document Type", rCustLedgerEntry."Document Type"::Invoice);
                rCustLedgerEntry.SETRANGE("Posting Date", rGenJournalLine."Posting Date");
                IF rCustLedgerEntry.FINDFIRST THEN BEGIN
                    rGenJournalLine."Dimension Set ID" := rCustLedgerEntry."Dimension Set ID";
                    rGenJournalLine.MODIFY;
                END;
            UNTIL rGenJournalLine.NEXT = 0;

        rGenJournalLine.RESET;
        rGenJournalLine.SETRANGE("Journal Template Name", rConfTPV."Nombre libro diario");
        rGenJournalLine.SETRANGE("Journal Batch Name", rConfTPV."Nombre seccion diario");


        //Se registran los pagos
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", rGenJournalLine);
    end;

    procedure AddProdCupon(CodCuponDesde: Code[20]; CodCuponHasta: Code[20]; CodProd: Code[20])
    var
        rCabCupon: Record 51009;
        rLinCupon: Record 51010;
        rCabCupon1: Record 51009;
    begin
        Counter := 0;
        CounterTotal := 0;


        Window.OPEN(Text001);

        rCabCupon1.RESET;
        rCabCupon1.SETRANGE("No. Cupon", CodCuponDesde, CodCuponHasta);
        CounterTotal := rCabCupon1.COUNT;
        IF rCabCupon1.FINDSET THEN
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, rCabCupon."No. Cupon");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                rCabCupon.GET(rCabCupon1."No. Cupon");
                rLinCupon.RESET;
                rLinCupon.INIT;
                rLinCupon.VALIDATE("No. Cupon", rCabCupon."No. Cupon");
                rLinCupon.VALIDATE("Cod. Producto", CodProd);
                rLinCupon.VALIDATE("% Descuento", rCabCupon."Descuento a Padres de Familia");
                rLinCupon.VALIDATE(Cantidad, 1);
                rLinCupon.INSERT;
            UNTIL rCabCupon1.NEXT = 0;
    end;

    procedure BuscaTarifa(CodProducto: Code[20]; CodCliente: Code[20]; var wDesc_Loc: Decimal; var wPrecio_Loc: Decimal)
    var
        rSalesHeader_Loc: Record 36;
        rSalesLines_Loc: Record 37;
    begin
        IF rItem.GET(CodProducto) THEN BEGIN
            rSalesHeader_Loc.RESET;
            rSalesHeader_Loc.INIT;
            rSalesHeader_Loc.VALIDATE("Document Type", 1);
            rSalesHeader_Loc."No." := txt001;
            rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
            rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
            rSalesHeader_Loc.INSERT(TRUE);

            rSalesLines_Loc.INIT;
            rSalesLines_Loc.Temporal := TRUE;
            rSalesLines_Loc.VALIDATE("Document Type", 1);
            rSalesLines_Loc."Document No." := txt001;
            rSalesLines_Loc."Line No." := 1000;
            rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
            rSalesLines_Loc.VALIDATE("No.", CodProducto);
            rSalesLines_Loc.VALIDATE(Quantity, 1);
            rSalesLines_Loc.INSERT(TRUE);
            wPrecio_Loc := rSalesLines_Loc."Unit Price";
            wDesc_Loc := rSalesLines_Loc."Line Discount %";

            IF rSalesHeader_Loc.DELETE(TRUE) THEN;

        END
        ELSE BEGIN
            //TODO: Ver 
            /*
                rICR.RESET;
                rICR.SETRANGE("Cross-Reference Type", rICR."Cross-Reference Type"::"Bar Code");
                rICR.SETRANGE("Cross-Reference No.", CodProducto);
                IF rICR.FINDFIRST THEN BEGIN
                    rSalesHeader_Loc.RESET;
                    rSalesHeader_Loc.INIT;
                    rSalesHeader_Loc.VALIDATE("Document Type", 1);
                    rSalesHeader_Loc."No." := txt001;
                    rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
                    rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
                    rSalesHeader_Loc.INSERT(TRUE);

                    rSalesLines_Loc.INIT;
                    rSalesLines_Loc.VALIDATE("Document Type", 1);
                    rSalesLines_Loc.Temporal := TRUE;
                    rSalesLines_Loc."Document No." := txt001;
                    rSalesLines_Loc."Line No." := 1000;
                    rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
                    rSalesLines_Loc.VALIDATE("No.", rICR."Item No.");
                    rSalesLines_Loc.VALIDATE(Quantity, 1);
                    rSalesLines_Loc.INSERT(TRUE);
                    wPrecio_Loc := rSalesLines_Loc."Unit Price";
                    wDesc_Loc := rSalesLines_Loc."Line Discount %";

                    IF rSalesHeader_Loc.DELETE(TRUE) THEN;

                END;
                */
        END;
    end;

    procedure InvConsTransf(CodCliente: Code[20])
    var
        NoRecepcion: Code[20];
        CFuncSantillana: Codeunit 56000;
        NoPedidoActual: Code[20];
        SalesHeader: Record 36;
        TransferLines: Record 5741;
        TransHeader1: Record 5740;
        TransferLine1: Record 5741;
        TransRecHeader: Record 5746;
        TransRecLines: Record 5747;
        TransRecHeader1: Record 5746;
        TransRecLines1: Record 5747;
        NoLinea: Integer;
        ItemLedgerEntry: Record 32;
        rLinCons: Record 56012;
        rLinCons1: Record 56012;
        rLinCons2: Record 56012;
        frmConsignacion: Page 56049;
    begin
        NoPedidoActual := CFuncSantillana.EnviaNoTransferencia;
        rLinCons.RESET;
        rLinCons.SETRANGE("Document No.", NoPedidoActual);
        rLinCons.SETRANGE("ID Usuario", USERID);
        rLinCons.DELETEALL;


        Counter := 0;
        CounterTotal := 0;

        Window.OPEN(Text001);

        TransHeader1.GET(NoPedidoActual);

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", CodCliente);
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            CounterTotal := ItemLedgerEntry.COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, ItemLedgerEntry."Document No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                rLinCons2.RESET;
                rLinCons2.SETRANGE(rLinCons2."Document No.", NoPedidoActual);
                rLinCons2.SETRANGE(rLinCons2."Item No.", ItemLedgerEntry."Item No.");
                rLinCons2.SETRANGE(rLinCons2."ID Usuario", USERID);
                IF rLinCons2.FINDFIRST THEN BEGIN
                    rLinCons2.Quantity += ItemLedgerEntry."Remaining Quantity";
                    rLinCons2.MODIFY;
                END
                ELSE BEGIN
                    IF ItemLedgerEntry."Remaining Quantity" <> 0 THEN BEGIN
                        rLinCons1.RESET;
                        rLinCons1.SETRANGE("Document No.", NoPedidoActual);
                        IF rLinCons1.FINDLAST THEN
                            NoLinea := rLinCons1."Line No."
                        ELSE
                            NoLinea := 0;

                        NoLinea += 10000;
                        rLinCons.INIT;
                        rLinCons.VALIDATE("Document No.", NoPedidoActual);
                        rLinCons.VALIDATE("Line No.", NoLinea);
                        rLinCons.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
                        rLinCons.VALIDATE(Quantity, ItemLedgerEntry."Remaining Quantity");
                        rLinCons.VALIDATE("Unit of Measure Code", ItemLedgerEntry."Unit of Measure Code");
                        rLinCons.VALIDATE(Quantity, ItemLedgerEntry."Remaining Quantity");
                        rLinCons.VALIDATE("Qty. to Ship", 0);
                        rLinCons.VALIDATE("ID Usuario", USERID);
                        rItem.GET(ItemLedgerEntry."Item No.");
                        rLinCons.VALIDATE(Description, rItem.Description);
                        rLinCons.INSERT(TRUE);
                    END;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;

        Window.CLOSE;

        COMMIT;
        CLEAR(frmConsignacion);
        rLinCons.RESET;
        rLinCons.SETRANGE("Document No.", NoPedidoActual);
        rLinCons.SETRANGE("ID Usuario", USERID);
        frmConsignacion.SETTABLEVIEW(rLinCons);
        frmConsignacion.RecibeNoPedido(NoPedidoActual);
        frmConsignacion.RUN;
        CLEAR(frmConsignacion);
    end;

    procedure RegistraPacking(CabPack: Record 56030)
    var
        linPack: Record 56031;
        CCP: Record 56032;
        txt001: Label 'There is nothing to post';
        CabPackReg: Record 56033;
        LinPackReg: Record 56034;
        CCPR: Record 56035;
        RWhseActLine: Record 5773;
        rWhseActHdr: Record 5772;
        WSH: Record 7320;
        NoPacking: Code[20];
        NoPick: Code[20];
        RWhseActLine1: Record 5773;
        PackCompleto: Boolean;
        CantBultos: Integer;
        CantAEmpac: Decimal;
        CantPenEmpac: Decimal;
        SalesOrder: Record 36;
        SalesLineOrder: Record 37;
        TMPSLO: Record 37 temporary;
    begin
        ConfSantillana.GET;
        ConfSantillana.TESTFIELD("No. Serie Packing Reg.");

        //Se valida que todas las cajas estén cerradas
        linPack.RESET;
        linPack.SETRANGE("No.", CabPack."No.");
        IF linPack.FINDSET THEN
            REPEAT
                linPack.TESTFIELD("Estado Caja", linPack."Estado Caja"::Cerrada);
            UNTIL linPack.NEXT = 0
        ELSE
            ERROR(txt001);

        CabPack.CALCFIELDS("Cantidad de Bultos");
        CantBultos := CabPack."Cantidad de Bultos";

        //Cabecera de Packing
        CabPackReg.INIT;
        CabPackReg.TRANSFERFIELDS(CabPack);
        //TODO: Ver CabPackReg."No." := NoSerMang.GetNextNo(ConfSantillana."No. Serie Packing Reg.", WORKDATE, TRUE);
        CabPackReg."No. Packing Origen" := CabPack."No.";
        CabPackReg."Fecha Registro" := WORKDATE;
        CabPackReg.INSERT;

        //Lineas de Packing
        linPack.RESET;
        linPack.SETRANGE("No.", CabPack."No.");
        IF linPack.FINDSET THEN
            REPEAT
                LinPackReg.INIT;
                LinPackReg.TRANSFERFIELDS(linPack);
                LinPackReg.VALIDATE("No.", CabPackReg."No.");
                LinPackReg.INSERT;
            UNTIL linPack.NEXT = 0;

        //Contenido Cajas
        CCP.RESET;
        CCP.SETRANGE("No. Packing", CabPack."No.");
        IF CCP.FINDSET THEN
            REPEAT
                CCPR.INIT;
                CCPR.TRANSFERFIELDS(CCP);
                CCPR.VALIDATE("No. Packing", CabPackReg."No.");
                CCPR.INSERT;

                //+#854
                IF NOT TieneGestionAlmacen THEN BEGIN

                    IF CCP."Tipo pedido" = CCP."Tipo pedido"::Venta THEN BEGIN
                        IF SalesLineOrder.GET(SalesLineOrder."Document Type"::Order, CCPR."No. Pedido", CCPR."No. Linea Pedido") THEN BEGIN
                            IF NOT TMPSLO.GET(TMPSLO."Document Type"::Order, SalesLineOrder."Document No.", SalesLineOrder."Line No.") THEN BEGIN
                                TMPSLO.INIT;
                                TMPSLO."Document Type" := SalesLineOrder."Document Type";
                                TMPSLO."Document No." := SalesLineOrder."Document No.";
                                TMPSLO."Line No." := SalesLineOrder."Line No.";
                                TMPSLO.Quantity := 0;
                                TMPSLO.INSERT;
                            END;
                            TMPSLO.Quantity += CCPR.Cantidad;

                            IF TMPSLO.Quantity > SalesLineOrder.Quantity THEN
                                ERROR(Error005, SalesLineOrder."Document No.", SalesLineOrder."No.");

                            TMPSLO.MODIFY;
                        END;
                    END;

                END
                ELSE BEGIN
                    //-#854
                    //Se actualizan las lineas de Picking registrados
                    RWhseActLine.RESET;
                    RWhseActLine.SETRANGE("Activity Type", RWhseActLine."Activity Type"::Pick);
                    RWhseActLine.SETRANGE("No.", CCPR."No. Picking");
                    RWhseActLine.SETRANGE("Action Type", RWhseActLine."Action Type"::Take);
                    RWhseActLine.SETRANGE(RWhseActLine."Item No.", CCPR."No. Producto");
                    IF RWhseActLine.FINDSET THEN BEGIN
                        CantAEmpac := CCP.Cantidad;
                        REPEAT
                            IF RWhseActLine.Quantity > RWhseActLine."Cantidad Empacada" THEN BEGIN
                                CantPenEmpac := RWhseActLine.Quantity - RWhseActLine."Cantidad Empacada";
                                IF CantPenEmpac <= CantAEmpac THEN BEGIN
                                    RWhseActLine."Cantidad Empacada" += CantPenEmpac;
                                    CantAEmpac := CantAEmpac - CantPenEmpac;
                                END
                                ELSE BEGIN
                                    RWhseActLine."Cantidad Empacada" += CantAEmpac;
                                    CantAEmpac := 0;
                                END;
                                IF RWhseActLine."Cantidad Empacada" > RWhseActLine.Quantity THEN
                                    ERROR(Error002, RWhseActLine."No.", RWhseActLine."Item No.");

                                RWhseActLine.VALIDATE("No. Packing", CabPack."No.");
                                RWhseActLine.VALIDATE("No. Caja", CCPR."No. Caja");
                                RWhseActLine.VALIDATE("No. Packing Registrado", CCPR."No. Packing");
                                RWhseActLine.VALIDATE("No. Linea Packing", CCPR."No. Linea");
                                IF RWhseActLine."Cantidad Empacada" >= RWhseActLine.Quantity THEN
                                    RWhseActLine."Packing Completado" := TRUE;
                                RWhseActLine.MODIFY;
                            END;
                        UNTIL (RWhseActLine.NEXT = 0) OR (CantAEmpac = 0);
                    END;
                    IF CantAEmpac > 0 THEN
                        ERROR(Error002, RWhseActLine."No.", RWhseActLine."Item No.");
                END; //+#854

            UNTIL CCP.NEXT = 0;

        NoPick := CabPack."Picking No.";

        //Se elimina el borrador de Packing
        //Lineas
        linPack.RESET;
        linPack.SETRANGE("No.", CabPack."No.");
        linPack.DELETEALL;

        //Contenido Cajas
        CCP.RESET;
        CCP.SETRANGE(CCP."No. Packing", CabPack."No.");
        CCP.DELETEALL;

        //Cabecera
        CabPack.DELETE;
        //+#854
        IF NOT TieneGestionAlmacen THEN BEGIN
            IF CabPackReg."Tipo pedido" = CabPackReg."Tipo pedido"::Venta THEN BEGIN
                SalesLineOrder.RESET;
                SalesLineOrder.SETRANGE("Document Type", SalesLineOrder."Document Type"::Order);
                SalesLineOrder.SETRANGE("Document No.", CabPackReg."No. Pedido");
                SalesLineOrder.SETRANGE(Type, SalesLineOrder.Type::Item);
                IF SalesLineOrder.FINDSET THEN
                    REPEAT
                        IF NOT TMPSLO.GET(SalesLineOrder."Document Type", SalesLineOrder."Document No.", SalesLineOrder."Line No.") THEN
                            ERROR(Error006, SalesLineOrder."No.");
                        IF SalesLineOrder.Quantity <> TMPSLO.Quantity THEN
                            ERROR(Error007, SalesLineOrder."No.");
                    UNTIL SalesLineOrder.NEXT = 0;
                SalesOrder.GET(SalesOrder."Document Type"::Order, CabPackReg."No. Pedido");
                SalesOrder."Estado packing" := SalesOrder."Estado packing"::Completo;
                SalesOrder.MODIFY;
            END;
        END
        ELSE BEGIN
            //-#854
            RWhseActLine.RESET;
            RWhseActLine.SETCURRENTKEY("No. Packing");
            RWhseActLine.SETRANGE("Activity Type", RWhseActLine."Activity Type"::Pick);
            RWhseActLine.SETRANGE("No.", NoPick);
            IF RWhseActLine.FINDFIRST THEN BEGIN
                IF WSH.GET(RWhseActLine."Whse. Document No.") THEN BEGIN
                    PackCompleto := TRUE;
                    RWhseActLine1.RESET;
                    RWhseActLine1.SETRANGE("Activity Type", RWhseActLine1."Activity Type"::Pick);
                    RWhseActLine1.SETRANGE("Whse. Document No.", WSH."No.");
                    RWhseActLine1.SETRANGE("Action Type", RWhseActLine1."Action Type"::Take);
                    IF RWhseActLine1.FINDSET THEN
                        REPEAT
                            IF NOT RWhseActLine1."Packing Completado" THEN
                                PackCompleto := FALSE
                        UNTIL (RWhseActLine1.NEXT = 0) OR (PackCompleto = FALSE);

                    WSH."Packing Completo" := PackCompleto;

                    WSH."Cantidad de Bultos" := CantBultos;
                    WSH.MODIFY;
                END;
            END;
        END; //-#854
    end;

    procedure ReabrirCajaPacking(LinPacking: Record 56031)
    begin
        LinPacking."Estado Caja" := LinPacking."Estado Caja"::Abierta;
        LinPacking.MODIFY;
    end;

    procedure RegHojaEnv(CHR: Record 56020; Imprime: Boolean)
    var
        LHR: Record 56021;
        CHRR: Record 56022;
        LHRR: Record 56023;
        NoSeriesMngm: Codeunit "No. Series";
        SRS: Record 311;
        LHRR2: Record 56023;
        SIH: Record 112;
        ActEstatusFactEcommerce: Codeunit 50011;
    begin
        SRS.GET;
        SRS.TESTFIELD("No. Serie Hoja de Ruta Reg.");
        CHR.TESTFIELD("Cod. Transportista");

        //+#4161
        LHR.RESET;
        LHR.SETRANGE("No. Hoja Ruta", CHR."No. Hoja Ruta");
        LHR.SETRANGE("Tipo Envio", LHR."Tipo Envio"::"Pedido Venta");
        LHR.SETRANGE("No. Factura", '');
        IF LHR.FINDFIRST THEN
            ERROR(Error003, LHR.FIELDCAPTION("Tipo Envio"), LHR."Tipo Envio", LHR.FIELDCAPTION("No. Factura"), LHR.FIELDCAPTION("No. Conduce"), LHR."No. Conduce");
        //-#4161

        CHRR.INIT;
        CHRR.TRANSFERFIELDS(CHR);
        CHRR."Hoja de Ruta Origen" := CHR."No. Hoja Ruta"; //#37066
        CHRR."No. Hoja Ruta" := NoSeriesMngm.GetNextNo(SRS."No. Serie Hoja de Ruta Reg.", WORKDATE, TRUE);
        CHRR.Hora := TIME;
        CHRR."Fecha Registro" := WORKDATE;
        CHRR.INSERT;

        LHR.RESET;
        LHR.SETRANGE(LHR."No. Hoja Ruta", CHR."No. Hoja Ruta");
        IF LHR.FINDSET THEN
            REPEAT
                LHRR.INIT;
                LHRR.TRANSFERFIELDS(LHR);
                LHRR."No. Hoja Ruta" := CHRR."No. Hoja Ruta";
                LHRR.INSERT;
                //NopCommerce++
                IF (LHR."Tipo Envio" = LHR."Tipo Envio"::"Pedido Venta") AND
                   (LHRR."No entregado" = FALSE) THEN BEGIN
                    IF SIH.GET(LHR."No. Factura") THEN BEGIN
                        IF SIH.Origen = SIH.Origen::"E-Commerce" THEN
                            ActEstatusFactEcommerce.Entregado(SIH);
                    END;
                END
            //NopCommerce--
            UNTIL LHR.NEXT = 0;
        CHR.DELETE(TRUE);

        IF Imprime THEN BEGIN
            CHRR.GET(CHRR."No. Hoja Ruta");
            CHRR.SETRECFILTER;
            REPORT.RUN(56024, FALSE, FALSE, CHRR);
        END;
    end;

    procedure Corrigeerror()
    var
        Cont: Record 5050;
    begin
        Cont.FIND('-');
        REPEAT
            IF Cont."Search Name" = '' THEN BEGIN
                Cont.VALIDATE(Name);
                Cont.MODIFY;
            END;
        UNTIL Cont.NEXT = 0;
    end;

    procedure TieneGestionAlmacen(): Boolean
    var
        RWhseActLine: Record 5773;
    begin
        //+#854
        RWhseActLine.RESET;
        RWhseActLine.SETRANGE("Activity Type", RWhseActLine."Activity Type"::Pick);
        RWhseActLine.SETRANGE("Action Type", RWhseActLine."Action Type"::Take);
        EXIT(RWhseActLine.FINDFIRST);
        //-#854
    end;

    procedure CorrigeContrato()
    var
        Contrato: Record 34002109;
        NuevaFechaInicio: Date;
    begin
        Contrato.GET('1015', 100);
        IF NOT CONFIRM('Periodo %1 - %2. ¿Cambiar fecha inicio a "%3"?', FALSE, Contrato."Fecha inicio", Contrato."Fecha finalizacion", NuevaFechaInicio) THEN BEGIN
            Contrato."Fecha inicio" := 20160118D;
            IF (Contrato."Fecha finalizacion" <> 0D) AND (Contrato."Fecha inicio" > Contrato."Fecha finalizacion") THEN
                ERROR('La fecha inicio no puede ser superior a la fecha finalizacion');
            Contrato.MODIFY;
            MESSAGE('Nuevo periodo %1 - %2', Contrato."Fecha inicio", Contrato."Fecha finalizacion");
        END;
    end;

    procedure ActualizarConsecutivoFE()
    var
        SIH: Record 112;
    begin
        //002-YFC

        SIH.RESET;
        SIH.SETCURRENTKEY(Origen, "Tipo Doc Electronico", Estado);
        SIH.SETRANGE(Origen, SIH.Origen::"E-Commerce");
        SIH.SETRANGE("Tipo Doc Electronico", SIH."Tipo Doc Electronico"::Tiquete);
        SIH.SETRANGE(Estado, 'rechazado');
        SIH.SETRANGE("No.", 'VFRE-000875');  //prueba
        //Message('%1',SIH.Count());

        IF SIH.FINDSET THEN
            REPEAT
                SIH.Consecutivo := '';
                SIH.MODIFY;
            UNTIL SIH.NEXT = 0;
        MESSAGE('finalizado');
    end;

    procedure CreaQRFE(No: Code[20])
    var
        CompanyInformation: Record 79;
        //TODO: Ver TempBlob: Record 99008535;
        QRCodeInput: Text[1024];
        QRCodeFileName: Text[1024];
        SIH: Record 112;
        SCrMH: Record 114;
    begin
        //TODO: Ver 
        /*
        //003+
        CompanyInformation.GET;

        IF SIH.GET(No) THEN BEGIN
            QRCodeInput := SIH."No.";
            CLEAR(TempBlob);
            CLEAR(QRCodeFileName);
            QRCodeFileName := GetQRCodeV2(QRCodeInput);
            UplFileBLOBImpndDelServerFileV2(TempBlob, QRCodeFileName);
            SIH."QR Code FE" := TempBlob.Blob;
            SIH.MODIFY;
            IF NOT ISSERVICETIER THEN
                IF EXISTS(QRCodeFileName) THEN
                    ERASE(QRCodeFileName);
        END ELSE
            IF SCrMH.GET(No) THEN BEGIN
                QRCodeInput := SCrMH."No.";
                CLEAR(TempBlob);
                CLEAR(QRCodeFileName);
                QRCodeFileName := GetQRCodeV2(QRCodeInput);
                UplFileBLOBImpndDelServerFileV2(TempBlob, QRCodeFileName);
                SCrMH."QR Code FE" := TempBlob.Blob;
                SCrMH.MODIFY;
                IF NOT ISSERVICETIER THEN
                    IF EXISTS(QRCodeFileName) THEN
                        ERASE(QRCodeFileName);
            END;
        */
    end;

    //TODO: Ver 
    /*
    [Scope('Personalization')]
    procedure CreateQRCodeV2(QRCodeInput: Text; var TempBLOB: Record 99008535)
    var
        QRCodeFileName: Text[1024];
    begin

        CLEAR(TempBLOB);
        QRCodeFileName := GetQRCodeV2(QRCodeInput);
        UplFileBLOBImpndDelServerFileV2(TempBLOB, QRCodeFileName);
    end;

    procedure UplFileBLOBImpndDelServerFileV2(var TempBlob: Record 99008535; FileName: Text[1024])
    var
        FileManagement: Codeunit 419;
    begin

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        DeleteServerFile(FileName);
    end;

    [Scope('Personalization')]
    procedure GetQRCodeV2(QRCodeInput: Text) QRCodeFileName: Text[1024]
    var
        EInvoiceObjectFactory: Codeunit 10147;
        IBarCodeProvider: DotNet IBarcodeProvider;
    begin
        EInvoiceObjectFactory.GetBarCodeProvider(IBarCodeProvider);
        QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
    end;

    local procedure DeleteServerFile(ServerFileName: Text)
    begin
        //IF ERASE(ServerFileName) THEN;
        //003-
    end;
    */
}

