page 56024 "BackOrders Sin Disp. Ped. Vta"
{
    // $001   25/06/2014    PLB   Nueva función BorrarPedidosNoPdtes()
    //                            Campo "Cantidad a ajustar" editable
    //                            Permitir modificar registro
    //                            Nuevos puntos de menú:
    //                            - Sugerir Cantidad a Anular
    //                            - Actualizar Cantidad Pendiente
    //                            - Borrar Pedidos enviados
    // $002   13/10/2014    PLB   Utilizar función ActLinBO para actualizar la cantidad anulada
    //                            Campo "Cantidad Anulada"
    //                            Abrir y lanzar los pedidos
    //                            Mejorar rendimiento al abrir página
    // MOI - 23/02/2015(#9653): Se muestran las lineas de venta que tienen disponibilidad negativa.
    // 
    // #56090 27/09/2016    PLB   Ajustes en la visualización disponibilidad backorders

    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table37;
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Nombre Cliente"; salesheader."Bill-to Name")
                {
                    Caption = 'Nombre Cliente';
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field(EstatusPed; EstatusPed)
                {
                    Editable = false;
                }
                field("Cantidad Solicitada"; "Cantidad Solicitada")
                {
                    Editable = false;
                }
                field("Cantidad Anulada"; "Cantidad Anulada")
                {
                    Editable = false;
                }
                field("Porcentaje Cant. Aprobada"; "Porcentaje Cant. Aprobada")
                {
                    Editable = false;
                }
                field("Cantidad Aprobada"; "Cantidad Aprobada")
                {
                    Editable = false;
                }
                field("Cantidad pendiente BO"; "Cantidad pendiente BO")
                {
                    Editable = false;
                }
                field(SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
                    SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec))
                {
                    Caption = 'Qty. Available';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cantidad a Anular"; "Cantidad a Anular")
                {
                }
                field("Cantidad a Ajustar"; "Cantidad a Ajustar")
                {
                    Editable = false;
                    Importance = Additional;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
                field(ISBN; ISBN)
                {
                    Editable = false;
                }
                field(EAN; EAN)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000021>")
            {
                Caption = '&Abrir Documento';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(PedVta);
                    SH.GET("Document Type", "Document No.");
                    PedVta.SETRECORD(SH);
                    PedVta.RUNMODAL;
                    CLEAR(PedVta);
                end;
            }
            group("<Action1906587504>")
            {
                Caption = 'F&unctions';
                action("<Action1000000025>")
                {
                    Caption = '&Sugerir Cantidad a Anular';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //$001
                        IF FINDSET THEN
                            REPEAT
                                "Cantidad a Anular" := "Cantidad pendiente BO";
                                MODIFY;
                            UNTIL NEXT = 0;
                    end;
                }
                action("<Action1000000027>")
                {
                    Caption = 'A&ctualizar BO';
                    Image = RefreshPlanningLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //$001
                        IF NOT (UserSetup.GET(USERID) AND UserSetup."Aprueba Cantidades") THEN
                            ERROR(Error002);

                        CLEAR(SH); //$+002

                        Counter := 0;
                        Window.OPEN(Text002);
                        CounterTotal := COUNT;
                        IF FINDSET THEN BEGIN
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, "No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                                IF "Cantidad a Anular" > 0 THEN BEGIN
                                    //+$002
                                    IF SH."No." <> "Document No." THEN BEGIN
                                        IF (SH."No." <> '') AND (SH.Status = SH.Status::Open) THEN
                                            ReleaseSalesDoc.PerformManualRelease(SH);
                                        SH.GET("Document Type", "Document No.");
                                        IF SH.Status <> SH.Status::Open THEN
                                            ReleaseSalesDoc.PerformManualReopen(SH);
                                    END;
                                    //-$002

                                    SL.GET("Document Type", "Document No.", "Line No.");

                                    //+$002
                                    //SL.VALIDATE("Cantidad pendiente BO", "Cantidad pendiente BO" - "Cantidad a Anular");
                                    SL."Cantidad a Anular" := "Cantidad a Anular";
                                    SL.ActLinBO;
                                    //-$002

                                    SL.MODIFY;
                                    IF SL."Cantidad pendiente BO" = 0 THEN
                                        DELETE
                                    ELSE BEGIN
                                        "Cantidad pendiente BO" := SL."Cantidad pendiente BO";
                                        "Cantidad a Anular" := 0;
                                        MODIFY;
                                    END;
                                END;
                            UNTIL NEXT = 0;
                            //+$002
                            IF (SH."No." <> '') AND (SH.Status = SH.Status::Open) THEN
                                ReleaseSalesDoc.PerformManualRelease(SH);
                            //-$002
                        END;

                        Window.CLOSE;
                    end;
                }
                action("<Action1000000033>")
                {
                    Caption = '&Borrar Pedidos enviados';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        //$001
                        IF CONFIRM(Text004, FALSE) THEN
                            BorrarPedidosNoPdtes();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        salesheader.GET("Document Type", "Document No.");
        EstatusPed := salesheader.Status;
    end;

    trigger OnOpenPage()
    begin
        Counter := 0;
        Window.OPEN(Text003);
        SL.RESET;
        SL.SETFILTER("Document Type", '%1|%2', SL."Document Type"::Order, SL."Document Type"::Invoice);
        CounterTotal := SL.COUNT;
        PrevTime := TIME; //+$002
        IF SL.FINDFIRST THEN
            REPEAT
                Counter := Counter + 1;
                //+$002
                //Window.UPDATE(1,SL."No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                IF (TIME > (PrevTime + 1000)) THEN BEGIN
                    PrevTime := TIME;
                    Window.UPDATE(1, ROUND((Counter / CounterTotal) * 10000, 1));
                END;
                //-$002
                //IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SL) = 0) AND (SL."Cantidad pendiente BO" <> 0) THEN//MOI - 23/02/2015
                IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SL) <= 0) AND (SL."Cantidad pendiente BO" <> 0) THEN BEGIN
                    WHSL.RESET;
                    WHSL.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    WHSL.SETRANGE("Source Type", 37);
                    WHSL.SETRANGE("Source Subtype", 1);
                    WHSL.SETRANGE("Source No.", SL."Document No.");
                    WHSL.SETRANGE("Item No.", SL."No.");
                    IF NOT WHSL.FINDFIRST THEN BEGIN
                        TRANSFERFIELDS(SL);
                        "Cantidad a Anular" := 0; //+$001
                        "Cantidad a Ajustar" := 0; //+$002
                        INSERT;
                    END;
                END;
            UNTIL SL.NEXT = 0;
        Window.CLOSE;
    end;

    var
        SalesInfoPaneMgt: Codeunit 7171;
        SalesLine: Record 37;
        ReleaseSalesDoc: Codeunit 414;
        salesheader: Record 36;
        AppTemp: Record 464;
        ApprovalMgt: Codeunit 1535;
        EstatusPed: Option Abierto,Lanzado,"Aprobación pendiente","Anticipo pendiente";
        UserSetup: Record 91;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Error001: Label 'Qty. to Adjust cannot be grater than the availability';
        Error002: Label 'User does not have permision to approve quantities in sales orders';
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text002: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text003: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        PrevTime: Time;
        SalesLine2Record: Record 37;
        WHSL: Record 7321;
        SL: Record 37;
        PedVta: Page42;
        SH: Record 36;
        Text004: Label 'Se revisarán todos los pedidos y se borrarán aquellos que no tengan cantidad pendiente para enviar. ¿Continuar?';

    procedure BorrarPedidosNoPdtes()
    var
        wPendiente: Boolean;
    begin
        //$001
        SH.RESET;
        SH.SETRANGE("Document Type", SH."Document Type"::Order);
        IF SH.FINDSET THEN BEGIN
            Counter := 0;
            Window.OPEN(Text003);
            CounterTotal := SH.COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, SH."No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                wPendiente := TRUE;
                SL.SETRANGE("Document Type", SH."Document Type");
                SL.SETRANGE("Document No.", SH."No.");
                SL.SETRANGE(Type, SL.Type::Item);
                IF SL.FINDSET THEN
                    REPEAT
                        wPendiente := (SL."Outstanding Quantity" <> 0) OR (SL."Cantidad pendiente BO" <> 0);
                    UNTIL (SL.NEXT = 0) OR wPendiente;
                IF NOT wPendiente THEN BEGIN
                    SH.DELETE(TRUE);
                END;
            UNTIL SH.NEXT = 0;
            Window.CLOSE;
        END;
    end;
}

