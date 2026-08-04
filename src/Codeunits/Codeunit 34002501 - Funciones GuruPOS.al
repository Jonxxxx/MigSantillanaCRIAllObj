codeunit 34002501 "Funciones GuruPOS"
{
    trigger OnRun()
    begin
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        Error001: Label 'User %1 is not TPV user';
        rConfTPV: Record 34002500;
        rBotones: Record 34002507;
        cuManejaParametros: Codeunit 34002500;
        rSalesHeaderPOS: Record 34002512;
        rSalesLinePOS: Record 34002513;
        I: Integer;
        Ventana: Dialog;
        txt0001: Label 'Procesing line #1######';
        rCust: Record 18;
        rCustPostGroup: Record 92;
        fTipoNCF: Page 34002524;
        ReleaseSalesDoc: Codeunit 414;
        rGenJournalLine: Record 81;
        rFormPagosTPV: Record 34002514;
        rPagosTPV: Record 34002515;
        rDocumentDim: Record 357;
        rTPV: Record 34002503;
        rSHP: Record 34002512;
        rCurrExchRate: Record 330;
        rformasPago: Record 34002514;
        wBalance: Decimal;
        Error002: Label 'Debe elegir un tipo de NCF';
        Error003: Label 'Fecha de registro debe ser igual a la fecha del dia';
        rSalesLine: Record 37;
        rSalesPrice: Record 7002;
        ItemReference: Record "Item Reference";
        rItem: Record 27;
        Error004: Label 'There is not buttons or Actions defined';
        rGlobalSalesHeader: Record 36;
        rSalesLines: Record 37;

    procedure BuscaCodBarra(Itemcode: Code[20]; rSalesHeader: Record 36): Boolean
    var
        //rItemCrossRef: Record 5717;
        rSalesLine1: Record 37;
        NoLinea: Integer;
        rSalesLine: Record 37;
        Encontrado: Boolean;
        rItem: Record 27;
    begin

    end;

    procedure InsertaPedido(IDCajero: Code[20])
    var
        rSalesHeader: Record 36;
        rCajeros: Record 34002502;
        rGrupoCajeros: Record 34002501;
        rDimDefAlmacen: Record 34002505;
        rAlmacen: Record 14;
        rTienda: Record 34002504;
        rDocumentDim: Record 357;
        rTPV_Loc: Record 34002503;
    begin

    end;

    procedure MenuCaja(var intNoOfColumnsAcc: Integer; var intNoOfRowsAcc: Integer; var wCantBotAcc: Integer; var wCantBotPagos: Integer; var IntNoOfColumnsPagos: Integer; var IntNoOfROwsPagos: Integer; var IDSubMenuAcciones: array[5] of Integer)
    var
        rMenVtasTPV: Record 34002506;
        rAcciones: Record 34002508;
        wCantBotAcciones: Integer;
        NoColumnasAcciones: Integer;
        NoFilasAcciones: Integer;
        wCantButtsMen2: Integer;
        I: Integer;
        Nombre: Text[30];
        NoColumnasPagos: Integer;
        NoFilasAPagos: Integer;
        rTPV: Record 34002503;
        rBotones: Record 34002507;
        int: Integer;
    begin

    end;

    procedure ActValoresTPV(rSalesHeader: Record 36; var wTotal: Decimal; var wPago: Decimal; var wAcumulado: Decimal; var wDescuentos: Decimal; var wCambio: Decimal; var wBalance: Decimal)
    var
        rSalesLine: Record 37;
        wPreTotal: Decimal;
        wPrecioMenosDescuento: Decimal;
        rPagosTPV: Record 34002515;
    begin

    end;

    procedure AnulaPedidos(rSalesHeader: Record 36)
    var
        rSalesHeaderPOS: Record 34002512;
        rSalesLinesPOS: Record 34002513;
        rSalesLine: Record 37;
        rSalesLine1: Record 37;
        rSalesHeader1: Record 36;
    begin

    end;

    procedure AccionesMenuPago(boton: Integer; MenuID: Code[20]; NoPed: Code[20]; wBalance: Decimal)
    begin

    end;

    procedure RegistraPedidos(rSalesHeader: Record 36; wCambio: Decimal)
    var
        rSalesLine: Record 37;
        rSalesLine1: Record 34002513;
        rSalesLine2: Record 37;
        err001: Label 'Nothing to post';
        Err002: Label 'ORDER WITH REMAINING AMOUNT';
    begin

    end;

    procedure ValidaPedido(rSalesHeader: Record 36): Boolean
    var
        rSalesLine: Record 37;
    begin
        rSalesLine.RESET;
        rSalesLine.SETRANGE(rSalesLine."Document Type", rSalesHeader."Document Type");
        rSalesLine.SETRANGE(rSalesLine."Document No.", rSalesHeader."No.");
        IF rSalesLine.FIND('-') THEN
            REPEAT
                IF rSalesLine."Outstanding Amount" <> 0 THEN
                    EXIT(TRUE);
            UNTIL rSalesLine.NEXT = 0;
        EXIT(FALSE);
    end;

    procedure InsertaFormasPago(NoPedido: Code[20]; wImporte: Decimal)
    begin
    end;

    procedure ImpresionEtiquetas()
    var
        rSolicitudEtiquetas: Record 34002517;
        rItem: Record 27;
        rItem1: Record 27;
        rSolicitudEtiquetas1: Record 34002517;
    begin

    end;

    procedure BuscaDescripcion(Descr: Text[200]; rSalesHeader: Record 36) Encontrado: Boolean
    var
        rItem: Record 27;
        rSalesLine: Record 37;
        rSalesLine1: Record 37;
        NoLinea: Integer;
    begin
        rItem.RESET;
        rItem.SETCURRENTKEY("Search Description");
        rItem.SETFILTER(rItem."Search Description", '%1', Descr + '@*');
        IF rItem.FIND('+') THEN BEGIN
            rSalesLine1.RESET;
            rSalesLine1.SETRANGE(rSalesLine1."Document Type", rSalesHeader."Document Type");
            rSalesLine1.SETRANGE(rSalesLine1."Document No.", rSalesHeader."No.");
            IF rSalesLine1.FIND('+') THEN
                NoLinea := rSalesLine1."Line No."
            ELSE
                NoLinea := 10000;
            rSalesLine.INIT;
            rSalesLine."Document Type" := rSalesHeader."Document Type";
            rSalesLine.VALIDATE("Document Type");
            rSalesLine."Document No." := rSalesHeader."No.";
            rSalesLine.VALIDATE("Document No.");
            rSalesLine."Line No." := NoLinea + 1;
            rSalesLine.VALIDATE("Line No.");
            rSalesLine.Type := rSalesLine.Type::Item;
            rSalesLine.VALIDATE(Type);
            rSalesLine."No." := rItem."No.";
            rSalesLine.VALIDATE("No.");
            rSalesLine.Quantity := 1;
            rSalesLine.VALIDATE(Quantity);
            rSalesLine.INSERT(TRUE);
            Encontrado := TRUE;
        END
        ELSE
            Encontrado := FALSE;
        EXIT(Encontrado);
    end;

    procedure ValidaVtaCredito(rSalesHeader: Record 36): Boolean
    var
        rSalesline: Record 37;
        wTotal: Decimal;
        wDescuentos: Decimal;
        wPago: Decimal;
    begin

    end;

    procedure DescuentosGenerales(rSalesHeader: Record 36; PorcientoDesc: Decimal)
    begin
        rSalesLine.RESET;
        rSalesLine.SETRANGE(rSalesLine."Document Type", rSalesHeader."Document Type");
        rSalesLine.SETRANGE(rSalesLine."Document No.", rSalesHeader."No.");
        rSalesLine.SETRANGE(rSalesLine."Anulada en TPV", FALSE);
        IF rSalesLine.FINDFIRST THEN
            REPEAT
                rSalesLine.VALIDATE("Line Discount %", PorcientoDesc);
                rSalesLine.MODIFY(TRUE);
            UNTIL rSalesLine.NEXT = 0;
    end;

    procedure VerificadorPrecio(CodProd_Barr: Code[20]; var DescrProd: Text[100]; rSalesHeader: Record 36): Decimal
    var
        wPrecio: Decimal;
    begin
        //Se busca el precio por medio al codigo de producto   **Esta funcion actualmente solo funciona para la tarifa "All customer" es
        //**Debe completarse para las demas tarifas si es necesario.
        IF rItem.GET(CodProd_Barr) THEN BEGIN
            DescrProd := rItem.Description;
            rSalesPrice.RESET;
            rSalesPrice.SETRANGE(rSalesPrice."Item No.", rItem."No.");
            IF rSalesHeader."Customer Price Group" <> '' THEN
                rSalesPrice.SETRANGE(rSalesPrice."Sales Code", rSalesHeader."Customer Price Group");
            // rSalesPrice.SETRANGE(rSalesPrice."Sales Type",rSalesPrice."Sales Type"::"All Customers");
            IF rSalesPrice.FINDFIRST THEN BEGIN
                REPEAT
                    //Si el precio esta activo lo tomamos
                    IF (rSalesPrice."Ending Date" = 0D) OR (rSalesPrice."Ending Date" >= WORKDATE) THEN
                        wPrecio := rSalesPrice."Unit Price"
                    ELSE
                        wPrecio := 0;
                UNTIL (rSalesPrice.NEXT = 0) OR (wPrecio = 0);
            END
            ELSE
                wPrecio := 0;
        END
        ELSE
          //Si no se encuentra por producto se busca por Cod. Barra
          BEGIN
            ItemReference.RESET;
            ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code");
            ItemReference.SetRange("Reference Type No.", '');
            ItemReference.SetRange("Reference No.", CodProd_Barr);
            IF ItemReference.FINDFIRST THEN BEGIN
                rSalesPrice.RESET;
                rSalesPrice.SETRANGE(rSalesPrice."Item No.", ItemReference."Item No.");
                IF rSalesHeader."Customer Price Group" <> '' THEN
                    rSalesPrice.SETRANGE(rSalesPrice."Sales Code", rSalesHeader."Customer Price Group");
                IF rItem.GET(ItemReference."Item No.") THEN
                    DescrProd := rItem.Description;
                //  rSalesPrice.SETRANGE(rSalesPrice."Sales Type",rSalesPrice."Sales Type"::"All Customers");
                IF rSalesPrice.FINDFIRST THEN BEGIN
                    REPEAT
                        //Si el precio esta activo lo tomamos
                        IF (rSalesPrice."Ending Date" = 0D) OR (rSalesPrice."Ending Date" >= WORKDATE) THEN
                            wPrecio := rSalesPrice."Unit Price"
                    UNTIL rSalesPrice.NEXT = 0;
                END
                ELSE
                    wPrecio := 0;
            END
            ELSE
                wPrecio := 0;
        END;

        EXIT(wPrecio);
    end;

    procedure BuscaCodBarra_PedidosVendedore(Itemcode: Code[20]; rSalesHeader: Record 36): Boolean
    var

        rSalesLine1: Record 37;
        NoLinea: Integer;
        rSalesLine: Record 37;
        Encontrado: Boolean;
        rItem: Record 27;
    begin

    end;

    procedure BuscaCodBarra_PedidosConsVend(Itemcode: Code[20]; rTransferHeader: Record 5740): Boolean
    var
        //rItemCrossRef: Record 5717;
        rTransferLine1: Record 5741;
        NoLinea: Integer;
        rTransferLine: Record 5741;
        Encontrado: Boolean;
        rItem: Record 27;
    begin

    end;

    procedure ValidaTienda(SalesHeader: Record 36)
    var
        rSalesHeader: Record 36;
        rCajeros: Record 34002502;
        rGrupoCajeros: Record 34002501;
        rDimDefAlmacen: Record 34002505;
        rAlmacen: Record 14;
        rTienda: Record 34002504;
        rDocumentDim: Record 357;
        rTPV: Record 34002503;
    begin

    end;

    procedure AplicaCupon(NoPedido: Code[20]; NoCupon: Code[20])
    var
        rCabCupon: Record 55170;
        rLinCupon: Record 55171;
        Loc_Error001: Label 'Coupon No. %1 not found';
        Loc_Error002: Label 'The Coupon %1 is not asociated to with customer no. %2';
        rLinCupon2: Record 55171;
        loc_rSalesLine: Record 37;
    begin
        IF rGlobalSalesHeader.GET(1, NoPedido) THEN BEGIN
            IF rCabCupon.GET(NoCupon) THEN BEGIN
                IF rCabCupon."Cod. Cliente" = rGlobalSalesHeader."Sell-to Customer No." THEN BEGIN
                    rLinCupon.RESET;
                    rLinCupon.SETRANGE("No. Cupon", NoCupon);
                    rLinCupon.SETFILTER("Cantidad Pendiente", '>%1', 0);
                    IF rLinCupon.FINDSET THEN
                        REPEAT
                            loc_rSalesLine.RESET;
                            loc_rSalesLine.SETRANGE("Document Type", 1);
                            loc_rSalesLine.SETRANGE("Document No.", NoPedido);
                            loc_rSalesLine.SETRANGE(Type, loc_rSalesLine.Type::Item);
                            loc_rSalesLine.SETRANGE("No.", rLinCupon."Cod. Producto");
                            loc_rSalesLine.SETRANGE(Quantity, rLinCupon.Cantidad);
                            IF loc_rSalesLine.FINDFIRST THEN BEGIN
                                IF rLinCupon."Precio Venta" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Unit Price", rLinCupon."Precio Venta");
                                IF rLinCupon."% Descuento" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Line Discount %", rLinCupon."% Descuento");
                                loc_rSalesLine."Cod. Cupon" := NoCupon;
                                loc_rSalesLine.MODIFY;
                                rLinCupon2.GET(NoCupon, rLinCupon."Cod. Producto");
                                rLinCupon2."Cantidad Pendiente" := 0;
                                rLinCupon2.MODIFY;
                            END;
                        UNTIL rLinCupon.NEXT = 0;
                END
                ELSE
                    ERROR(Loc_Error002, NoCupon, rGlobalSalesHeader."Sell-to Customer No." + rGlobalSalesHeader."Sell-to Customer Name");
            END
            ELSE
                ERROR(Loc_Error001, NoCupon);
        END;
    end;

    procedure AplicaCuponSinCliente(NoPedido: Code[20]; NoCupon: Code[20])
    var
        rCabCupon: Record 55170;
        rLinCupon: Record 55171;
        Loc_Error001: Label 'Coupon No. %1 not found';
        Loc_Error002: Label 'The Coupon %1 is not asociated to with customer no. %2';
        rLinCupon2: Record 55171;
        loc_rSalesLine: Record 37;
    begin

        IF rGlobalSalesHeader.GET(1, NoPedido) THEN BEGIN
            IF rCabCupon.GET(NoCupon) THEN BEGIN
                IF (rCabCupon.Impreso) AND (WORKDATE >= rCabCupon."Valido Desde") AND (WORKDATE <= rCabCupon."Valido Hasta") AND
                   (rCabCupon.Anulado = FALSE) THEN BEGIN
                    rLinCupon.RESET;
                    rLinCupon.SETRANGE("No. Cupon", NoCupon);
                    rLinCupon.SETFILTER("Cantidad Pendiente", '>%1', 0);
                    IF rLinCupon.FINDSET THEN
                        REPEAT
                            loc_rSalesLine.RESET;
                            loc_rSalesLine.SETRANGE("Document Type", 1);
                            loc_rSalesLine.SETRANGE("Document No.", NoPedido);
                            loc_rSalesLine.SETRANGE(Type, loc_rSalesLine.Type::Item);
                            loc_rSalesLine.SETRANGE("No.", rLinCupon."Cod. Producto");
                            loc_rSalesLine.SETRANGE(Quantity, 0, rLinCupon."Cantidad Pendiente");
                            IF loc_rSalesLine.FINDFIRST THEN BEGIN
                                IF rLinCupon."Precio Venta" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Unit Price", rLinCupon."Precio Venta");
                                IF rLinCupon."% Descuento" <> 0 THEN
                                    loc_rSalesLine.VALIDATE("Line Discount %", rLinCupon."% Descuento");
                                loc_rSalesLine."Cod. Cupon" := NoCupon;
                                loc_rSalesLine.MODIFY;

                                rGlobalSalesHeader.GET(loc_rSalesLine."Document Type", loc_rSalesLine."Document No.");
                                rGlobalSalesHeader.VALIDATE("Cod. Cupon", NoCupon);
                                rGlobalSalesHeader.VALIDATE("Salesperson Code", rCabCupon."Cod. Vendedor");
                                rGlobalSalesHeader.MODIFY;

                            END;
                        UNTIL rLinCupon.NEXT = 0;
                END;
            END
            ELSE
                ERROR(Loc_Error001, NoCupon);
        END;

    end;

    procedure ActualizaCupon(rSalesHeader_Loc: Record 36)
    var
        rLinCupon: Record 55171;
        CantidadPendiente: Integer;
    begin
        rSalesLines.RESET;
        rSalesLines.SETRANGE("Document Type", rSalesHeader_Loc."Document Type");
        rSalesLines.SETRANGE("Document No.", rSalesHeader_Loc."No.");
        rSalesLines.SETRANGE(Type, rSalesLines.Type::Item);
        rSalesLines.SETFILTER(rSalesLines."Cod. Cupon", '<>%1', '');
        IF rSalesLines.FINDSET THEN
            REPEAT
                CantidadPendiente := 0;
                IF rLinCupon.GET(rSalesLines."Cod. Cupon", rSalesLines."No.") THEN BEGIN
                    CantidadPendiente := rLinCupon."Cantidad Pendiente" - ABS(rSalesLines.Quantity);
                    IF CantidadPendiente < 0 THEN
                        rLinCupon."Cantidad Pendiente" := 0
                    ELSE
                        rLinCupon."Cantidad Pendiente" := CantidadPendiente;
                    rLinCupon.MODIFY;
                END;
            UNTIL rSalesLines.NEXT = 0;
    end;

    procedure BuscaTarifa(CodCliente: Code[20]; CodProducto: Code[40]): Decimal
    var
        rSalesHeader_Loc: Record 36;
        txt001: Label 'test';
        rSalesLines_Loc: Record 37;
        wPrecio: Decimal;
    begin
        //Si es el codigo del producto
        IF rItem.GET(CodProducto) THEN BEGIN
            rSalesHeader_Loc.RESET;
            rSalesHeader_Loc.INIT;
            rSalesHeader_Loc.VALIDATE("Document Type", 1);
            rSalesHeader_Loc."No." := txt001;
            rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
            rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
            rSalesHeader_Loc.INSERT(TRUE);

            rSalesLines_Loc.INIT;
            rSalesLines_Loc.VALIDATE("Document Type", 1);
            rSalesLines_Loc."Document No." := txt001;
            rSalesLines_Loc."Line No." := 1000;
            rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
            rSalesLines_Loc.VALIDATE("No.", CodProducto);
            rSalesLines_Loc.VALIDATE(Quantity, 1);
            rSalesLines_Loc.INSERT(TRUE);
            wPrecio := rSalesLines_Loc."Unit Price";


            IF rSalesHeader_Loc.DELETE(TRUE) THEN;

            EXIT(wPrecio);
        END
        ELSE BEGIN
            ItemReference.RESET;
            ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::"Bar Code");
            ItemReference.SetRange(ItemReference."Item No.", CodProducto);
            IF ItemReference.FINDFIRST THEN BEGIN
                rSalesHeader_Loc.RESET;
                rSalesHeader_Loc.INIT;
                rSalesHeader_Loc.VALIDATE("Document Type", 1);
                rSalesHeader_Loc."No." := txt001;
                rSalesHeader_Loc.VALIDATE("Posting Date", WORKDATE);
                rSalesHeader_Loc.VALIDATE("Sell-to Customer No.", CodCliente);
                rSalesHeader_Loc.INSERT(TRUE);

                rSalesLines_Loc.INIT;
                rSalesLines_Loc.VALIDATE("Document Type", 1);
                rSalesLines_Loc."Document No." := txt001;
                rSalesLines_Loc."Line No." := 1000;
                rSalesLines_Loc.VALIDATE(Type, rSalesLines_Loc.Type::Item);
                rSalesLines_Loc.VALIDATE("No.", ItemReference."Item No.");
                rSalesLines_Loc.VALIDATE(Quantity, 1);
                rSalesLines_Loc.INSERT(TRUE);
                wPrecio := rSalesLines_Loc."Unit Price";
                IF rSalesHeader_Loc.DELETE(TRUE) THEN;

                EXIT(wPrecio);

            END;
        END;
    end;
}

