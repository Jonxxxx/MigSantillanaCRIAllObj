page 55249 "BackOrders Sin Disp. Ped. Vta"
{
    // $001   25/06/2014    PLB   Nueva funcion BorrarPedidosNoPdtes()
    //                            Campo "Cantidad a ajustar" editable
    //                            Permitir modificar registro
    //                            Nuevos puntos de menú:
    //                            - Sugerir Cantidad a Anular
    //                            - Actualizar Cantidad Pendiente
    //                            - Borrar Pedidos enviados
    // $002   13/10/2014    PLB   Utilizar funcion ActLinBO para actualizar la cantidad anulada
    //                            Campo "Cantidad Anulada"
    //                            Abrir y lanzar los pedidos
    //                            Mejorar rendimiento al abrir página
    // MOI - 23/02/2015(#9653): Se muestran las lineas de venta que tienen disponibilidad negativa.
    // 
    // #55310 27/09/2016    PLB   Ajustes en la visualizacion disponibilidad backorders

    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 37;
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document Type';
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("Nombre Cliente"; salesheader."Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Cliente';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document No.';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shipment Date';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit of Measure';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity';
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line Discount %';
                    Editable = false;
                    Visible = false;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line Discount Amount';
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount';
                    Editable = false;
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount Including VAT';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                    Editable = false;
                }
                field(EstatusPed; EstatusPed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cantidad Solicitada"; Rec."Cantidad Solicitada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Solicitada';
                    Editable = false;
                }
                field("Cantidad Anulada"; Rec."Cantidad Anulada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Anulada';
                    Editable = false;
                }
                field("Porcentaje Cant. Aprobada"; Rec."Porcentaje Cant. Aprobada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porcentaje Cant. Aprobada';
                    Editable = false;
                }
                field("Cantidad Aprobada"; Rec."Cantidad Aprobada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Aprobada';
                    Editable = false;
                }
                field("Cantidad pendiente BO"; Rec."Cantidad pendiente BO")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad pendiente BO';
                    Editable = false;
                }
                field(QtyAvailableJX;
                SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Qty. Available';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cantidad a Anular"; Rec."Cantidad a Anular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad a Anular';
                }
                field("Cantidad a Ajustar"; Rec."Cantidad a Ajustar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad a Ajustar';
                    Editable = false;
                    Importance = Additional;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Requested Delivery Date';
                }
                field(ISBN; Rec.ISBN)
                {
                    ApplicationArea = All;
                    ToolTip = 'ISBN';
                    Editable = false;
                }
                field(EAN; Rec.EAN)
                {
                    ApplicationArea = All;
                    ToolTip = 'EAN';
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
                ApplicationArea = All;
                Caption = '&Abrir Documento';
                ToolTip = '&Abrir Documento';
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
                    ApplicationArea = All;
                    Caption = '&Sugerir Cantidad a Anular';
                    ToolTip = '&Sugerir Cantidad a Anular';
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
                    ApplicationArea = All;
                    Caption = 'A&ctualizar BO';
                    ToolTip = 'A&ctualizar BO';
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
                    ApplicationArea = All;
                    Caption = '&Borrar Pedidos enviados';
                    ToolTip = '&Borrar Pedidos enviados';
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
        SalesInfoPaneMgt: Codeunit EXCCRISalesInfoPaneMgt;
        SalesLine: Record 37;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        salesheader: Record 36;
        // TODO: Manual review - Application Temp is unavailable, and the approval declaration has no active caller because the related logic remains disabled.
        // Original code preserved below.
        // AppTemp: Record 464;
        // ApprovalMgt: Codeunit "Approvals Mgmt.";
        EstatusPed: Option Abierto,Lanzado,"Aprobacion pendiente","Anticipo pendiente";
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
        PedVta: Page 42;
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

