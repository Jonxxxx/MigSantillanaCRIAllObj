page 67074 "Cab. Muestras"
{
    // Documentation()
    // Proyecto: Microsoft Dynamics Nav 2009
    // AMS     : Agustin Mendez
    // ------------------------------------------------------------------------
    // No.     Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 001     06-Julio-09     AMS           Se estima si el cliente excedera el limite de credito
    // 
    // 002     18-Enero-09     AMS           Envio de Pedido de venta por Correo Electronico.
    // 
    // 003     19-Enero-09     AMS           Datos Cliente.
    // 
    // 004     25-Mayo-10      AMS           Impresion reporte de Bultos
    // 
    // 005     06-Agosto-10    AMS           Deshacer Envio Transferencia
    // 
    // 006     10-Mayo-11      AMS           Desde este form se marca como pedido de Consignacion.

    Caption = 'Transfer Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 5740;
    SourceTableView = SORTING(No.)
                      ORDER(Ascending)
                      WHERE("Devolucion Consignacion" = FILTER(No),
                            "Pedido Consignacion" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-to Code"; "Transfer-to Code")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //006
                        IF Cliente.GET("Transfer-to Code") THEN
                            IF Cliente.Blocked <> 0 THEN
                                ERROR(Error003, Cliente.Blocked);
                        //006
                    end;
                }
                field("Transfer-from Code"; "Transfer-from Code")
                {
                    Editable = false;
                }
                field("Cod. Ubicacion Alm. Origen"; "Cod. Ubicacion Alm. Origen")
                {
                    Editable = false;
                }
                field("Desc. Ubic. Alm. Origen"; "Desc. Ubic. Alm. Origen")
                {
                    Editable = false;
                }
                field("Cod. Ubicacion Alm. Destino"; "Cod. Ubicacion Alm. Destino")
                {
                    Editable = false;
                }
                field("Desc. Ubic. Alm. Destino"; "Desc. Ubic. Alm. Destino")
                {
                    Editable = false;
                }
                field(Cliente.Name;
                    Cliente.Name)
                {
                    Caption = 'Nombre';
                    Editable = false;
                }
                field(Cliente.Address;
                    Cliente.Address)
                {
                    Caption = 'Direccion';
                    Editable = false;
                }
                field(Cliente.City;
                    Cliente.City)
                {
                    Caption = 'Ciudad';
                    Editable = false;
                }
                field("Saldo Cliente"; "Saldo Cliente")
                {
                    Editable = false;
                }
                field("Importe Consignacion Orginal"; "Importe Consignacion Orginal")
                {
                    Editable = false;
                    MultiLine = true;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("In-Transit Code"; "In-Transit Code")
                {
                    Editable = false;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    Editable = false;
                }
                field("Importe Consignacion"; "Importe Consignacion")
                {
                    Caption = 'Importe PVA';
                    Editable = false;
                }
                field("Cod. Vendedor"; "Cod. Vendedor")
                {
                    Editable = false;
                }
                field("Pedido Consignacion"; "Pedido Consignacion")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                    Enabled = false;
                }
                field("Limite de credito cliente"; "Limite de credito cliente")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Saldo Cliente" +"Importe Consignacion Orginal"; "Saldo Cliente" +"Importe Consignacion Orginal")
                {
                    Caption = 'Saldo estimado';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(CREstimado; "Limite de credito cliente" - ("Saldo Cliente" + "Importe Consignacion Orginal"))
                {
                    Caption = 'Credito Estimado';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
            part(TransferLines; 67076)
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Derived From Line No." = CONST(0);
            }
            group("Transfer-from")
            {
                Caption = 'Transfer-from';
                Editable = false;
                field("Transfer-from Name"; "Transfer-from Name")
                {
                }
                field("Transfer-from Name 2;"Transfer - from Name 2")
                {
                }
                field("Transfer-from Address"; "Transfer-from Address")
                {
                }
                field("Transfer-from Address 2;"Transfer - from Address 2")
                {
                }
                field("Transfer-from City"; "Transfer-from City")
                {
                }
                field("Transfer-from County"; "Transfer-from County")
                {
                    Caption = 'Transfer-from State / ZIP Code';
                }
                field("Transfer-from Post Code"; "Transfer-from Post Code")
                {
                }
                field("Transfer-from Contact"; "Transfer-from Contact")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {

                    trigger OnValidate()
                    begin
                        OutboundWhseHandlingTimeOnAfte;
                    end;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {

                    trigger OnValidate()
                    begin
                        ShippingAgentCodeOnAfterValida;
                    end;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {

                    trigger OnValidate()
                    begin
                        ShippingAgentServiceCodeOnAfte;
                    end;
                }
                field("Shipping Time"; "Shipping Time")
                {

                    trigger OnValidate()
                    begin
                        ShippingTimeOnAfterValidate;
                    end;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                Editable = false;
                field("Transfer-to Name"; "Transfer-to Name")
                {
                }
                field("Transfer-to Name 2;"Transfer -to Name 2")
                {
                }
                field("Transfer-to Address"; "Transfer-to Address")
                {
                }
                field("Transfer-to Address 2;"Transfer -to Address 2")
                {
                }
                field("Transfer-to City"; "Transfer-to City")
                {
                }
                field("Transfer-to County"; "Transfer-to County")
                {
                    Caption = 'Transfer-to State / ZIP Code';
                }
                field("Transfer-to Post Code"; "Transfer-to Post Code")
                {
                }
                field("Transfer-to Contact"; "Transfer-to Contact")
                {
                }
                field("Receipt Date"; "Receipt Date")
                {

                    trigger OnValidate()
                    begin
                        ReceiptDateOnAfterValidate;
                    end;
                }
                field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
                {

                    trigger OnValidate()
                    begin
                        InboundWhseHandlingTimeOnAfter;
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Editable = false;
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field(Area;Area)
        {
        }
                field("Entry/Exit Point";"Entry/Exit Point")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5755;
                                    RunPageLink = No.=FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5750;
                                    RunPageLink = "Document Type"=CONST("Transfer Order"),
                                  "No."=FIELD("No.");
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page 5752;
                                    RunPageLink = "Order No."=FIELD("No.");
                }
                action("Re&ceipts")
                {
                    Caption = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page 5753;
                                    RunPageLink = "Order No."=FIELD("No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action("Whse. Shi&pments")
                {
                    Caption = 'Whse. Shi&pments';
                    RunObject = Page 7341;
                                    RunPageLink = "Source Type"=CONST(5741),
                                  "Source Subtype"=CONST(0),
                                  "Source No."=FIELD("No.");
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                action("&Whse. Receipts")
                {
                    Caption = '&Whse. Receipts';
                    RunObject = Page 7342;
                                    RunPageLink = "Source Type"=CONST(5741),
                                  "Source Subtype"=CONST(1),
                                  "Source No."=FIELD("No.");
                    RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page 5774;
                                    RunPageLink = "Source Document"=FILTER(Inbound Transfer|Outbound Transfer),
                                  "Source No."=FIELD("No.");
                    RunPageView = SORTING(Source Document,Source No.,Location Code);
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            CurrPage.TransferLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            CurrPage.TransferLines.PAGE.ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            CurrPage.TransferLines.PAGE.ItemAvailability(2);
                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        CurrPage.TransferLines.PAGE.ShowDimensions;
                    end;
                }
                group("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    action(Shipment)
                    {
                        Caption = 'Shipment';

                        trigger OnAction()
                        begin
                            CurrPage.TransferLines.PAGE.OpenItemTrackingLines(0);
                        end;
                    }
                    action(Receipt)
                    {
                        Caption = 'Receipt';

                        trigger OnAction()
                        begin
                            CurrPage.TransferLines.PAGE.OpenItemTrackingLines(1);
                        end;
                    }
                }
            }
            group(Imprimir)
            {
                Caption = 'Imprimir';
                action(Imprimir)
                {
                    Caption = 'Imprimir';

                    trigger OnAction()
                    var
                        DocPrint: Codeunit 229;
                    begin
                        DocPrint.PrintTransferHeader(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Reserve")
                {
                    Caption = '&Reserve';

                    trigger OnAction()
                    begin
                        CurrPage.TransferLines.PAGE.ShowReservation;
                    end;
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit 5751;
                    begin
                        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
                    end;
                }
                action("Create Whse. S&hipment")
                {
                    Caption = 'Create Whse. S&hipment';

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                action("Get Bin Content")
                {
                    Caption = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;

                    trigger OnAction()
                    var
                        BinContent: Record 7302;
                        GetBinContent: Report "7391;
                    begin
                        BinContent.SETRANGE("Location Code","Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit 5708;
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit 5708;
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
                separator()
                {
                }
                action("Select &Samples")
                {
                    Caption = 'Select &Samples';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelProdMuestras: Page 67075;
                                             Promotor: Record 13;
                    begin
                        /*Promotor.RESET;
                        Promotor.SETRANGE("Location code","Transfer-from Code");
                        Promotor.FINDFIRST;
                        */
                        SelProdMuestras.RecibeParametros("No.",Promotor.Code);
                        SelProdMuestras.RUNMODAL;
                        CLEAR(SelProdMuestras);

                    end;
                }
                separator()
                {
                }
                action("Enviar Pedido por E-mail")
                {
                    Caption = 'Enviar Pedido por E-mail';

                    trigger OnAction()
                    begin
                        //002

                        CFuncSantillana.CreaEmailPedidoConsg(Rec);
                        CurrPage.UPDATE;
                        //002
                    end;
                }
                separator()
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        TransferPostShipment: Codeunit 5704;
                        TransferPostReceipt: Codeunit 5705;
                    begin
                        ConfAPS.GET();

                        IF ConfAPS."Movilidad Activada" THEN
                           BEGIN
                            IF NOT Blocked THEN
                               BEGIN
                                Blocked := TRUE;
                                MODIFY;
                                MESSAGE(Msg001);
                               END;
                               CurrPage.CLOSE;
                           END
                        ELSE
                           BEGIN
                            TransferPostShipment.RUN(Rec);
                            TransferPostReceipt.RUN(Rec);
                           END;
                    end;
                }
            }
            action("Pro&ductos")
            {
                Caption = 'Pro&ductos';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //003
                    //cuManejaParametros.Recibe_Consig_PantallaVend("No.",0,0);
                    PAGE.RUNMODAL(50011);
                    //003
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    DocPrint: Codeunit 229;
                begin
                    DocPrint.PrintTransferHeader(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //003
        IF NOT Cliente.GET("Transfer-to Code") THEN
           CLEAR(Cliente);
        LimitedecreditoclienteSaldoCli;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        TESTFIELD(Status,Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //006
        "Pedido Consignacion" := TRUE;
    end;

    var
        ConfAPS: Record 67000;
        CFuncSantillana: Codeunit 56000;
        rTransHeader: Record 5740;
        NombreCliente: Text[200];
        DireccionCliente: Text[200];
        "**003**": Integer;
        Cliente: Record 18;
        cuManejaParametros: Codeunit 34002500;
        I: Integer;
        TransferHeader: Record 5740;
        TransferLine: Record 5741;
        DefDim: Record 352;
        wCantidad: Decimal;
        wPrecio: Decimal;
        wCantidadAenviar: Decimal;
        wDescuentoPorc: Decimal;
        wDescuentoImporte: Decimal;
        Error003: Label 'Cliente Bloqueado %1';
        CodComercial: Code[20];
        CodColegio: Code[20];
        CodAlmFrom: Code[20];
        CodAlmTo: Code[20];
        Bins: Record 7354;
        Msg001: Label 'Samples had been posted successfully';

    procedure RecibeParametros(AlmOrigen: Code[20];AlmDestino: Code[20];Comercial: Code[20];Colegio: Code[20])
    begin
        CodComercial := Comercial;
        CodColegio   := Colegio;
        CodAlmFrom   := AlmOrigen;
        CodAlmTo     := AlmDestino;
    end;

    local procedure PostingDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentServiceCodeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentCodeOnAfterValida()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingTimeOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OutboundWhseHandlingTimeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ReceiptDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure InboundWhseHandlingTimeOnAfter()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure LimitedecreditoclienteSaldoCli()
    begin
        IF ("Limite de credito cliente" - ("Saldo Cliente" +"Importe Consignacion Orginal")) < 0 THEN;
    end;
}

