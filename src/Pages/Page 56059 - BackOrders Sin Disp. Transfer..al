page 56059 "BackOrders Sin Disp. Transfer."
{
    // $001   25/06/2014    PLB   Campo "Cantidad a ajustar" editable
    //                            Permitir modificar registro
    //                            Nuevos puntos de menú:
    //                              - Sugerir Cantidad a Anular
    //                              - Actualizar Cantidad Pendiente
    // $002   14/10/2014    PLB   Utilizar función ActLinBO para actualizar la cantidad anulada
    //                            Campo "Cantidad Anulada"
    //                            Abrir y lanzar la transferencia
    //                            Mejorado rendimiento al abrir formulario
    // 
    // #56090 26/09/2016    PLB   Utilzar la funcion de disponibilidad personalizada para BackOrders
    //                            Ajustes en la visualización disponibilidad backorders

    ApplicationArea = Basic, Suite, Service;
    Caption = 'Transfer BackOrder Management';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 5741;
    SourceTableTemporary = true;
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
                field(Status; Status)
                {
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
                field("Transfer-to Code"; "Transfer-to Code")
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
                field("Cantidad a Anular"; "Cantidad a Anular")
                {
                }
                field("Cantidad a Ajustar"; "Cantidad a Ajustar")
                {
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Action1000000017>")
            {
                Caption = '&Abrir Documento';
                Image = View;
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

                        CLEAR(TH); //$+002

                        Counter := 0;
                        Window.OPEN(Text002);
                        CounterTotal := COUNT;
                        IF FINDSET THEN BEGIN
                            REPEAT
                                Counter := Counter + 1;
                                Window.UPDATE(1, "Item No.");
                                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                                IF "Cantidad a Anular" > 0 THEN BEGIN
                                    //+$002
                                    IF TH."No." <> "Document No." THEN BEGIN
                                        IF (TH."No." <> '') AND (TH.Status = TH.Status::Open) THEN
                                            ReleaseTransfDoc.RUN(TH);
                                        TH.GET("Document No.");
                                        IF (TH.Status <> TH.Status::Open) THEN
                                            ReleaseTransfDoc.Reopen(TH);
                                    END;
                                    //-$002

                                    TL.GET("Document No.", "Line No.");

                                    //+$002
                                    //TL.VALIDATE("Cantidad pendiente BO", "Cantidad pendiente BO" - "Cantidad a Anular");
                                    TL."Cantidad a Anular" := "Cantidad a Anular";
                                    TL.ActLinBO;
                                    //-$002

                                    TL.MODIFY;
                                    IF TL."Cantidad pendiente BO" = 0 THEN
                                        DELETE
                                    ELSE BEGIN
                                        "Cantidad pendiente BO" := TL."Cantidad pendiente BO";
                                        "Cantidad a Anular" := 0;
                                        MODIFY;
                                    END;
                                END;
                            UNTIL NEXT = 0;
                            //+$002
                            IF (TH."No." <> '') AND (TH.Status = TH.Status::Open) THEN
                                ReleaseTransfDoc.RUN(TH);
                            //-$002
                        END;

                        Window.CLOSE;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        TH.GET("Document No.");
        estatusTrans := TH.Status;
    end;

    trigger OnOpenPage()
    begin
        Window.OPEN(Text003);
        TL.RESET;
        CounterTotal := TL.COUNT;
        PrevTime := TIME; //+$002
        IF TL.FINDFIRST THEN
            REPEAT
                Counter := Counter + 1;
                //+$002
                //Window.UPDATE(1,TL."Item No.");
                //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));
                IF (TIME > (PrevTime + 1000)) THEN BEGIN
                    PrevTime := TIME;
                    Window.UPDATE(1, ROUND((Counter / CounterTotal) * 10000, 1));
                END;
                //-$002
                //IF (SalesInfoPaneMgt.CalcAvailabilityTransLine(TL) = 0) AND (TL."Cantidad pendiente BO" <> 0) THEN //-#56090
                IF (SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL) <= 0) AND (TL."Cantidad pendiente BO" <> 0) THEN //+#56090
                    BEGIN
                    WHSL.RESET;
                    WHSL.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    WHSL.SETRANGE("Source Type", 5741);
                    WHSL.SETRANGE("Source Subtype", 0);
                    WHSL.SETRANGE("Source No.", TL."Document No.");
                    WHSL.SETRANGE(WHSL."Item No.", TL."Item No.");
                    IF NOT WHSL.FINDFIRST THEN BEGIN
                        TRANSFERFIELDS(TL);
                        "Cantidad a Anular" := 0; //+$001
                        "Cantidad a Ajustar" := 0; //+$002
                        INSERT;
                    END;
                END;
            UNTIL TL.NEXT = 0;
        Window.CLOSE;
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
        TL: Record 5741;
        TH: Record 5740;
        estatusTrans: Option Abierto,Lanzado;
        ReleaseTransfDoc: Codeunit 5708;
        TL1Record: Record 5741;
        WHSL: Record 7321;
        PedTrans: Page 5740;
}

