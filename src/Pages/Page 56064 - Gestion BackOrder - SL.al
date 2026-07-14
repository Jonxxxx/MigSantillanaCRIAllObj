page 56064 "Gestion BackOrder - SL"
{
    // $001    25/06/2014      PLB           Campo "Cantidad a ajustar" editable
    //                                       Permitir modificar registro
    //                                       Nuevo puntos de menú:
    //                                         - Actualizar BO
    // $002   13/10/2014   PLB   Añadidas las opciones de anular pendiente BO
    //                           Mejorado el rendimiento al abrir la page
    //                           Campo "Cantidad Anulada"
    // 
    // $003   10/11/2014   PLB   Sólo revisar las líneas que tienen "Cantidad pendiente BO"
    // 
    // #56090 27/09/2016   PLB   Ajustes en la visualización disponibilidad backorders

    ApplicationArea = Basic, Suite, Service;
    Caption = 'Sales Lines BackOrder Mgt. ';
    InsertAllowed = false;
    PageType = List;
    SourceTable = 37;
    SourceTableView = SORTING(Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Shipment Date")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Order),
                            "Type" = FILTER(Item),
                            "No." = FILTER(<> ''),
                            "Cantidad pendiente BO" = FILTER(<> 0),
                            "Disponible BackOrder" = FILTER(True));
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
                    Editable = false;
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
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    Editable = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Cantidad Aprobada"; "Cantidad Aprobada")
                {
                    Editable = false;
                }
                field("Cantidad Anulada"; "Cantidad Anulada")
                {
                    Editable = false;
                }
                field("Cantidad pendiente BO"; "Cantidad pendiente BO")
                {
                    Editable = false;
                }
                //TODO: Ver
                /*
                field(SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
                    SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec))
                {
                    Caption = 'Qty. Available';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }*/
                field("Cantidad Solicitada"; "Cantidad Solicitada")
                {
                    Editable = false;
                }
                field("Cantidad a Ajustar"; "Cantidad a Ajustar")
                {
                }
                field("Cantidad a Anular"; "Cantidad a Anular")
                {
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Documento)
            {
                Caption = '&Document';
                Image = DocumentEdit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(PedVta);
                    SH.GET("Document Type", "Document No.");
                    PedVta.SETRECORD(SH);
                    //TODO: Ver PedVta.GestBackOrd(TRUE);
                    PedVta.RUNMODAL;
                    CLEAR(PedVta);
                end;
            }
            group("<Action1906587504>")
            {
                Caption = 'F&unctions';
                action(ActualizarBO)
                {
                    Caption = '&Update BO';
                    Image = RefreshPlanningLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        //$001
                        SL.COPY(Rec);
                        IF SL.FINDSET(TRUE, FALSE) THEN BEGIN
                            CLEAR(SH);
                            Counter := 0;
                            Window.OPEN(Text006);
                            CounterTotal := SL.COUNT;
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, "No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                                IF SL."Cantidad a Ajustar" <> 0 THEN BEGIN
                                    IF SH."No." <> SL."Document No." THEN BEGIN
                                        IF (SH."No." <> '') AND (SH.Status = SH.Status::Open) THEN
                                            ReleaseSalesDoc.PerformManualRelease(SH);
                                        SH.GET(SL."Document Type", SL."Document No.");
                                        IF SH.Status <> SH.Status::Open THEN BEGIN //+$002
                                            ReleaseSalesDoc.PerformManualReopen(SH);
                                            SL.FIND; //+$002
                                        END; //+$002
                                    END;

                                    //SL.FIND; //-$002
                                    SL.ActLinBO;
                                    SL.MODIFY;

                                    //+$002
                                END
                                ELSE IF SL."Cantidad a Anular" > 0 THEN BEGIN
                                    IF SH."No." <> SL."Document No." THEN BEGIN
                                        IF (SH."No." <> '') AND (SH.Status = SH.Status::Open) THEN
                                            ReleaseSalesDoc.PerformManualRelease(SH);
                                        SH.GET(SL."Document Type", SL."Document No.");
                                        IF SH.Status <> SH.Status::Open THEN BEGIN
                                            ReleaseSalesDoc.PerformManualReopen(SH);
                                            SL.FIND;
                                        END;
                                    END;

                                    SL.ActLinBO;
                                    SL.MODIFY;
                                    //-$002

                                END;
                            UNTIL SL.NEXT = 0;

                            IF (SH."No." <> '') AND (SH.Status = SH.Status::Open) THEN
                                ReleaseSalesDoc.PerformManualRelease(SH);
                            Window.CLOSE;
                        END;
                    end;
                }

                action("<Action1000000025>")
                {
                    Caption = '&Sugerir Cantidades';
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CantDisp: Decimal;
                    begin
                        //$002
                        SL.COPY(Rec);
                        IF SL.FINDSET(TRUE, FALSE) THEN BEGIN
                            Counter := 0;
                            Window.OPEN(Text002);
                            CounterTotal := SL.COUNT;
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, SL."No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                                //TODO: Ver CantDisp := SalesInfoPaneMgt.CalcAvailability_BackOrder(SL);
                                IF CantDisp > SL."Cantidad pendiente BO" THEN
                                    SL."Cantidad a Anular" := 0;
                                //TODO: Ver ELSE
                                //TODO: Ver SL."Cantidad a Anular" := SL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailability_BackOrder(SL);
                                SL."Cantidad a Ajustar" := SL."Cantidad pendiente BO" - SL."Cantidad a Anular";
                                SL.MODIFY;
                            UNTIL SL.NEXT = 0;
                            Window.CLOSE;
                        END;
                    end;
                }
                action("<Action1000000033>")
                {
                    Caption = '&Borrar Pedidos enviados';
                    Image = Delete;

                    trigger OnAction()
                    begin
                        //$002
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
        //Desmarcar todas las lineas de pedidos

        //+$002
        // Para mejorar el rendimiento, realizamos un MODIFYALL
        /****************************************************
        Counter := 0;
        Window.OPEN(Text004);
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Disponible BackOrder");
        SalesLine.SETRANGE(SalesLine."Disponible BackOrder",TRUE);
        IF SalesLine.FINDSET THEN
          BEGIN
            CounterTotal := SalesLine.COUNT;
            REPEAT
              Counter := Counter + 1;
              Window.UPDATE(1,SalesLine."No.");
              Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
              IF SL.GET(SalesLine."Document Type",SalesLine."Document No.",SalesLine."Line No.") THEN
                BEGIN
                  SL."Disponible BackOrder" := FALSE;
                  SL.MODIFY;
                END;
            UNTIL SalesLine.NEXT = 0;
          END;
        Window.CLOSE;
        COMMIT;
        ****************************************************/
        Window.OPEN(Text004);
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        IF NOT SalesLine.ISEMPTY THEN
            SalesLine.MODIFYALL("Disponible BackOrder", FALSE);
        Window.CLOSE;
        //-$002

        Counter := 0;
        Window.OPEN(Text003);
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document Type", Type); //+$002
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order); //+$002
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FINDSET THEN BEGIN
            PrevTime := TIME; //+$002
            CounterTotal := SalesLine.COUNT;
            REPEAT
                Counter := Counter + 1;
                //+$002
                //Window.UPDATE(1,SalesLine."No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                IF (TIME > (PrevTime + 1000)) THEN BEGIN
                    PrevTime := TIME;
                    Window.UPDATE(1, ROUND((Counter / CounterTotal) * 10000, 1));
                END;
                //-$002

                //TODO: Ver 
                //TODO: Ver IF (SalesLine."Cantidad pendiente BO" > 0) THEN // +$003
                //TODO: Ver IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SalesLine) > 0) AND
                //TODO: Ver (SH.GET(SalesLine."Document Type", SalesLine."Document No.")) THEN
                //+$002
                // El ELSE no tenía ningún sentido, los registros ya están marcados como FALSE
                /*********************************************************
                  SalesLine."Disponible BackOrder" := TRUE
              ELSE
                BEGIN
                  //Se verifica que la linea no esté en Envios de Almacen
                  WHSL.RESET;
                    whsl.setcurrentkey("Source Document","Source No."); //+$002
                  WHSL.SETRANGE("Source No.",SalesLine."Document No.");
                  WHSL.SETRANGE("Item No.",SalesLine."No.");
                  IF NOT WHSL.FINDFIRST THEN
                      SalesLine."Disponible BackOrder" := FALSE;
                END;
              SalesLine.MODIFY;
                *********************************************************/
                BEGIN
                    SalesLine."Disponible BackOrder" := TRUE;
                    SalesLine."Cantidad a Anular" := 0;
                    SalesLine.MODIFY;
                END;
            //-$002
            UNTIL SalesLine.NEXT = 0;
        END;
        Window.CLOSE;
        COMMIT;

    end;

    var
        SalesInfoPaneMgt: Codeunit 7171;
        SalesLine: Record 37;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        salesheader: Record 36;
        //TODO: Ver AppTemp: Record 464;
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        EstatusPed: Option Abierto,Lanzado,"Aprobación pendiente","Anticipo pendiente";
        UserSetup: Record 91;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        PrevTime: Time;
        SalesLine2Record: Record 37;
        WHSL: Record 7321;
        CantidadDis: Decimal;
        SH: Record 36;
        AppEnt: Record 454;
        AppEnt1Record: Record 454;
        AppEnt2Record: Record 454;
        SL: Record 37;
        PedVta: Page 42;
        Error001: Label 'Qty. to Adjust cannot be grater than the availability';
        Error002: Label 'User does not have permision to approve quantities in sales orders';
        Text001: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text002: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text003: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text004: Label 'Reading ';
        Text005: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Text006: Label 'Reading  #1########## @2@@@@@@@@@@@@@';

    procedure BorrarPedidosNoPdtes()
    var
        wPendiente: Boolean;
    begin
        //$002
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

