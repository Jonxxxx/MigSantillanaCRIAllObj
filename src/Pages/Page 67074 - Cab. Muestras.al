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
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Devolucion Consignacion" = FILTER(false),
                            "Pedido Consignacion" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Code';
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
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Code';
                    Editable = false;
                }
                field("Cod. Ubicacion Alm. Origen"; Rec."Cod. Ubicacion Alm. Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ubicacion Alm. Origen';
                    Editable = false;
                }
                field("Desc. Ubic. Alm. Origen"; Rec."Desc. Ubic. Alm. Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Ubic. Alm. Origen';
                    Editable = false;
                }
                field("Cod. Ubicacion Alm. Destino"; Rec."Cod. Ubicacion Alm. Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ubicacion Alm. Destino';
                    Editable = false;
                }
                field("Desc. Ubic. Alm. Destino"; Rec."Desc. Ubic. Alm. Destino")
                {
                    ApplicationArea = All;
                    ToolTip = 'Desc. Ubic. Alm. Destino';
                    Editable = false;
                }
                field(ClienteName; Cliente.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Nombre';
                    Editable = false;
                }
                field(ClienteAddress;
                Cliente.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Direccion';
                    Editable = false;
                }
                field(ClienteCity;
                Cliente.City)
                {
                    ApplicationArea = All;
                    Caption = 'Ciudad';
                    Editable = false;
                }
                field("Saldo Cliente"; Rec."Saldo Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Saldo Cliente';
                    Editable = false;
                }
                field("Importe Consignacion Orginal"; Rec."Importe Consignacion Orginal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Consignacion Orginal';
                    Editable = false;
                    MultiLine = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'External Document No.';
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'In-Transit Code';
                    Editable = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Assigned User ID';
                    Editable = false;
                }
                field("Importe Consignacion"; Rec."Importe Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Consignacion';
                    Caption = 'Importe PVA';
                    Editable = false;
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                    Editable = false;
                }
                field("Pedido Consignacion"; Rec."Pedido Consignacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pedido Consignacion';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Enabled = false;
                }
                field("Limite de credito cliente"; Rec."Limite de credito cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Limite de credito cliente';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Saldo Cliente 2"; "Importe Consignacion Orginal" + "Saldo Cliente" + "Importe Consignacion Orginal")
                {
                    ApplicationArea = All;
                    Caption = 'Saldo estimado';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(CREstimado; "Limite de credito cliente" - ("Saldo Cliente" + "Importe Consignacion Orginal"))
                {
                    ApplicationArea = All;
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
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Name';
                }
                field("Transfer-from Name 2"; Rec."Transfer-from Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Name 2';
                }
                field("Transfer-from Address"; Rec."Transfer-from Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Address';
                }
                field("Transfer-from Address 2"; Rec."Transfer-from Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Address 2';
                }
                field("Transfer-from City"; Rec."Transfer-from City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from City';
                }
                field("Transfer-from County"; Rec."Transfer-from County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from County';
                    Caption = 'Transfer-from State / ZIP Code';
                }
                field("Transfer-from Post Code"; Rec."Transfer-from Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Post Code';
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Contact';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Date';

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Outbound Whse. Handling Time';

                    trigger OnValidate()
                    begin
                        OutboundWhseHandlingTimeOnAfte;
                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Method Code';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Agent Code';

                    trigger OnValidate()
                    begin
                        ShippingAgentCodeOnAfterValida;
                    end;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Agent Service Code';

                    trigger OnValidate()
                    begin
                        ShippingAgentServiceCodeOnAfte;
                    end;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Time';

                    trigger OnValidate()
                    begin
                        ShippingTimeOnAfterValidate;
                    end;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipping Advice';
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                Editable = false;
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Name';
                }
                field("Transfer-to Name 2"; Rec."Transfer-to Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Name 2';
                }
                field("Transfer-to Address"; Rec."Transfer-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Address';
                }
                field("Transfer-to Address 2"; Rec."Transfer-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Address 2';
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to City';
                }
                field("Transfer-to County"; Rec."Transfer-to County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to County';
                    Caption = 'Transfer-to State / ZIP Code';
                }
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Post Code';
                }
                field("Transfer-to Contact"; Rec."Transfer-to Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Contact';
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Receipt Date';

                    trigger OnValidate()
                    begin
                        ReceiptDateOnAfterValidate;
                    end;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inbound Whse. Handling Time';

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
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transaction Type';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transaction Specification';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transport Method';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area';
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                    ApplicationArea = All;
                    ToolTip = 'Entry/Exit Point';
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
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    ToolTip = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5755;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    ToolTip = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5750;
                    RunPageLink = "Document Type" = CONST("Transfer Order"),
                                  "No." = FIELD("No.");
                }
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    ToolTip = 'S&hipments';
                    RunObject = Page 5752;
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
                action("Re&ceipts")
                {
                    ApplicationArea = All;
                    Caption = 'Re&ceipts';
                    ToolTip = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page 5753;
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
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
                    ApplicationArea = All;
                    Caption = 'Whse. Shi&pments';
                    ToolTip = 'Whse. Shi&pments';
                    RunObject = Page 7341;
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(0),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("&Whse. Receipts")
                {
                    ApplicationArea = All;
                    Caption = '&Whse. Receipts';
                    ToolTip = '&Whse. Receipts';
                    RunObject = Page 7342;
                    RunPageLink = "Source Type" = CONST(5741),
                                  "Source Subtype" = CONST(1),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    ToolTip = 'In&vt. Put-away/Pick Lines';
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = FILTER('Inbound Transfer' | 'Outbound Transfer'),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
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

                        ApplicationArea = All;
                        Caption = 'Period';
                        ToolTip = 'Period';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - The custom subpage ItemAvailability procedure is empty, so restoring this call would not provide period availability.
                            // Original code: CurrPage.TransferLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {

                        ApplicationArea = All;
                        Caption = 'Variant';
                        ToolTip = 'Variant';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - The custom subpage ItemAvailability procedure is empty, so restoring this call would not provide variant availability.
                            // Original code: CurrPage.TransferLines.PAGE.ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {

                        ApplicationArea = All;
                        Caption = 'Location';
                        ToolTip = 'Location';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - The custom subpage ItemAvailability procedure is empty, so restoring this call would not provide location availability.
                            // Original code: CurrPage.TransferLines.PAGE.ItemAvailability(2);
                        end;
                    }
                }
                action(EXCCRIDimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
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

                        ApplicationArea = All;
                        Caption = 'Shipment';
                        ToolTip = 'Shipment';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - The custom subpage OpenItemTrackingLines procedure recursively calls itself and must be corrected before this action can be restored.
                            // Original code: CurrPage.TransferLines.PAGE.OpenItemTrackingLines(0);
                        end;
                    }
                    action(Receipt)
                    {

                        ApplicationArea = All;
                        Caption = 'Receipt';
                        ToolTip = 'Receipt';
                        trigger OnAction()
                        begin
                            // TODO: Manual review - The custom subpage OpenItemTrackingLines procedure recursively calls itself and must be corrected before this action can be restored.
                            // Original code: CurrPage.TransferLines.PAGE.OpenItemTrackingLines(1);
                        end;
                    }
                }
            }
            group(EXCCRIImprimir)
            {
                Caption = 'Imprimir';
                action(Imprimir)
                {

                    ApplicationArea = All;
                    Caption = 'Imprimir';
                    ToolTip = 'Imprimir';
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

                    ApplicationArea = All;
                    Caption = '&Reserve';
                    ToolTip = '&Reserve';
                    trigger OnAction()
                    begin
                        CurrPage.TransferLines.PAGE.ShowReservation;
                    end;
                }
                action("Create &Whse. Receipt")
                {

                    ApplicationArea = All;
                    Caption = 'Create &Whse. Receipt';
                    ToolTip = 'Create &Whse. Receipt';
                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit 5751;
                    begin
                        GetSourceDocInbound.CreateFromInbndTransferOrder(Rec);
                    end;
                }
                action("Create Whse. S&hipment")
                {

                    ApplicationArea = All;
                    Caption = 'Create Whse. S&hipment';
                    ToolTip = 'Create Whse. S&hipment';
                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit 5752;
                    begin
                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    ApplicationArea = All;
                    Caption = 'Create Inventor&y Put-away / Pick';
                    ToolTip = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                action("Get Bin Content")
                {
                    ApplicationArea = All;
                    Caption = 'Get Bin Content';
                    ToolTip = 'Get Bin Content';
                    Ellipsis = true;
                    Image = GetBinContent;

                    trigger OnAction()
                    var
                        BinContent: Record 7302;
                        GetBinContent: Report 7391;
                    begin
                        BinContent.SETRANGE("Location Code", "Transfer-from Code");
                        GetBinContent.SETTABLEVIEW(BinContent);
                        GetBinContent.InitializeTransferHeader(Rec);
                        GetBinContent.RUNMODAL;
                    end;
                }
                action("Re&lease")
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    ToolTip = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit 5708;
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Reo&pen")
                {
                    ApplicationArea = All;
                    Caption = 'Reo&pen';
                    ToolTip = 'Reo&pen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit 5708;
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }

                action("Select &Samples")
                {
                    ApplicationArea = All;
                    Caption = 'Select &Samples';
                    ToolTip = 'Select &Samples';
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
                        SelProdMuestras.RecibeParametros("No.", Promotor.Code);
                        SelProdMuestras.RUNMODAL;
                        CLEAR(SelProdMuestras);

                    end;
                }

                action("Enviar Pedido por E-mail")
                {

                    ApplicationArea = All;
                    Caption = 'Enviar Pedido por E-mail';
                    ToolTip = 'Enviar Pedido por E-mail';
                    trigger OnAction()
                    begin
                        //002

                        // TODO: Manual review - CreaEmailPedidoConsg exists, but its complete legacy SMTP, HTML file, attachment, and status-update body is disabled.
                        // Original code: CFuncSantillana.CreaEmailPedidoConsg(Rec);
                        CurrPage.UPDATE;
                        //002
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    ToolTip = 'P&ost';
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

                        IF ConfAPS."Movilidad Activada" THEN BEGIN
                            IF NOT Blocked THEN BEGIN
                                Blocked := TRUE;
                                MODIFY;
                                MESSAGE(Msg001);
                            END;
                            CurrPage.CLOSE;
                        END
                        ELSE BEGIN
                            TransferPostShipment.RUN(Rec);
                            TransferPostReceipt.RUN(Rec);
                        END;
                    end;
                }
            }
            action("Pro&ductos")
            {
                ApplicationArea = All;
                Caption = 'Pro&ductos';
                ToolTip = 'Pro&ductos';
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
                ApplicationArea = All;
                Caption = '&Print';
                ToolTip = '&Print';
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
        TESTFIELD(Status, Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //006
        "Pedido Consignacion" := TRUE;
    end;

    var
        ConfAPS: Record 67000;
        // Original declaration preserved for the disabled e-mail action above.
        // CFuncSantillana: Codeunit 56000;
        rTransHeader: Record 5740;
        NombreCliente: Text[200];
        DireccionCliente: Text[200];
        "**003**": Integer;
        Cliente: Record 18;
        // TODO: Manual review - Codeunit 34002500 exists, but its only related page call is already disabled and no active behavior requires this declaration.
        // Original code: cuManejaParametros: Codeunit 34002500;
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

    procedure RecibeParametros(AlmOrigen: Code[20]; AlmDestino: Code[20]; Comercial: Code[20]; Colegio: Code[20])
    begin
        CodComercial := Comercial;
        CodColegio := Colegio;
        CodAlmFrom := AlmOrigen;
        CodAlmTo := AlmDestino;
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
        IF ("Limite de credito cliente" - ("Saldo Cliente" + "Importe Consignacion Orginal")) < 0 THEN;
    end;
}

