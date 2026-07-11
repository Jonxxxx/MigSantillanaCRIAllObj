page 56065 "Gestion BackOrder - TL"
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
    Caption = 'Transfer Lines BackOrder Mgt. ';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 5741;
    SourceTableView = SORTING("Item No.")
                      ORDER(Ascending)
                      WHERE("Item No." = FILTER(<> ''),
                            "Cantidad pendiente BO" = FILTER(<> 0),
                            "Disponible BackOrder" = FILTER(Yes));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
                field("Transfer-from Code"; "Transfer-from Code")
                {
                }
                field(Quantity; Quantity)
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
                field("Cantidad Aprobada"; "Cantidad Aprobada")
                {
                    Editable = false;
                }
                field("Cantidad pendiente BO"; "Cantidad pendiente BO")
                {
                    Editable = false;
                }
                field(SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(Rec);
                    SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(Rec))
                {
                    Caption = 'Available Qty.';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cantidad a Ajustar"; "Cantidad a Ajustar")
                {
                }
                field("Cantidad a Anular"; "Cantidad a Anular")
                {
                }
                field("Receipt Date"; "Receipt Date")
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
                    CLEAR(PedTrans);
                    TH.GET("Document No.");
                    PedTrans.SETRECORD(TH);
                    PedTrans.RUNMODAL;
                    CLEAR(PedTrans);
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
                        ReleaseTransfDoc: Codeunit 5708;
                    begin
                        //$001
                        TL.COPY(Rec);
                        IF TL.FINDSET(TRUE, FALSE) THEN BEGIN
                            CLEAR(TH);
                            Counter := 0;
                            Window.OPEN(Text006);
                            CounterTotal := TL.COUNT;
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, TL."Item No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                                IF TL."Cantidad a Ajustar" <> 0 THEN BEGIN
                                    IF TH."No." <> TL."Document No." THEN BEGIN
                                        IF (TH."No." <> '') AND (TH.Status = TH.Status::Open) THEN
                                            ReleaseTransfDoc.RUN(TH);
                                        TH.GET(TL."Document No.");
                                        IF (TH.Status <> TH.Status::Open) THEN BEGIN //+$002
                                            ReleaseTransfDoc.Reopen(TH);
                                            TL.FIND; //+$002
                                        END; //+$002
                                    END;

                                    //TL.FIND; //-$002
                                    TL.ActLinBO;
                                    TL.MODIFY;

                                    //+$002
                                END
                                ELSE IF TL."Cantidad a Anular" > 0 THEN BEGIN
                                    IF TH."No." <> TL."Document No." THEN BEGIN
                                        IF (TH."No." <> '') AND (TH.Status = TH.Status::Open) THEN
                                            ReleaseTransfDoc.RUN(TH);
                                        TH.GET(TL."Document No.");
                                        IF (TH.Status <> TH.Status::Open) THEN BEGIN
                                            ReleaseTransfDoc.Reopen(TH);
                                            TL.FIND;
                                        END;
                                    END;

                                    TL.ActLinBO;
                                    TL.MODIFY;
                                    //-$002

                                END;
                            UNTIL TL.NEXT = 0;

                            IF (TH."No." <> '') AND (TH.Status = TH.Status::Open) THEN
                                ReleaseTransfDoc.RUN(TH);

                            Window.CLOSE;
                        END;
                    end;
                }
                separator()
                {
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
                        cantdisp: Decimal;
                    begin
                        //$002
                        TL.COPY(Rec);
                        IF TL.FINDSET(TRUE, FALSE) THEN BEGIN
                            CLEAR(TH);
                            Counter := 0;
                            Window.OPEN(Text006);
                            CounterTotal := TL.COUNT;
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, TL."Item No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                                cantdisp := SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL);
                                IF cantdisp > TL."Cantidad pendiente BO" THEN
                                    TL."Cantidad a Anular" := 0
                                ELSE
                                    TL."Cantidad a Anular" := TL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL);
                                TL."Cantidad a Ajustar" := TL."Cantidad pendiente BO" - TL."Cantidad a Anular";
                                TL.MODIFY;
                            UNTIL TL.NEXT = 0;

                            Window.CLOSE;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Desmarcar todas las lineas de pedidos
        //+$002
        /*****************************************************
        Counter := 0;
        Window.OPEN(Text004);
        TL.RESET;
        TL.SETCURRENTKEY("Disponible BackOrder");
        TL.SETRANGE("Disponible BackOrder",TRUE);
        IF TL.FINDSET THEN
          BEGIN
        CounterTotal := TL.COUNT;
           REPEAT
            Counter := Counter + 1;
            Window.UPDATE(1,TL."Item No.");
            Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
        
              IF TL1.GET(TL."Document No.",TL."Line No.") THEN
               BEGIN
                  TL1."Disponible BackOrder" := FALSE;
                  TL1.MODIFY;
                END;
            UNTIL TL.NEXT = 0;
          END;
        Window.CLOSE;
        COMMIT;
        *****************************************************/
        Window.OPEN(Text004);
        TL.MODIFYALL("Disponible BackOrder", FALSE);
        Window.CLOSE;
        //-$002

        Counter := 0;
        Window.OPEN(Text003);
        TL.RESET;
        CounterTotal := TL.COUNT;
        PrevTime := TIME; //+$002
        IF TL.FIND('-') THEN
            REPEAT
                Counter := Counter + 1;
                //+$002
                //Window.UPDATE(1,TL."Item No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                IF (TIME > (PrevTime + 1000)) THEN BEGIN
                    PrevTime := TIME;
                    Window.UPDATE(1, ROUND((Counter / CounterTotal) * 10000, 1));
                END;

                IF TL."Cantidad pendiente BO" > 0 THEN BEGIN //+$003

                    //Se verifica que la linea no esté en Envios de Almacen
                    WHSL.RESET;
                    WHSL.SETCURRENTKEY("Source Document", "Source No.");
                    WHSL.SETRANGE("Source No.", TL."Document No.");
                    WHSL.SETRANGE("Item No.", TL."Item No.");
                    IF NOT WHSL.FINDFIRST THEN
                        //-$002
                        IF (SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL) > 0) AND TH.GET(TL."Document No.") THEN BEGIN //+$002
                            TL."Disponible BackOrder" := TRUE;
                            //+$002
                            TL."Cantidad a Anular" := 0;
                            TL.MODIFY;
                        END;
                    //-$002

                    //Se verifica que la linea no esté en Envios de Almacen
                    //+$002
                    //WHSL.RESET;
                    //WHSL.SETRANGE("Source No.",TL."Document No.");
                    //WHSL.SETRANGE("Item No.",TL."Item No.");
                    //IF WHSL.FINDFIRST THEN
                    //  TL."Disponible BackOrder" := FALSE;
                    //TL.MODIFY;
                    //-$002

                END; //+$003
            UNTIL TL.NEXT = 0;
        Window.CLOSE;
        COMMIT;

    end;

    var
        SalesInfoPaneMgt: Codeunit 7171;
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
        TH: Record 5740;
        TL: Record 5741;
        WHSL: Record 7321;
        Text004: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        TL1Record: Record 5741;
        PedTrans: Page 5740;
        Text006: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
}

