page 56063 "Seguimiento Ped. Transferencia"
{
    // #117    23/10/2013    PLB             Seguimiento de pedidos
    // #1141   31/12/2013    PLB             Seguimiento de pedidos de transferencia
    // #2761   20/05/2014    CAT             Se informa el Numero de hoja de ruta y el Numero de hoja de ruta registrada

    Caption = 'Transfer Order Management';
    Editable = false;
    PageType = List;
    SourceTable = 5740;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-from Code';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting Date';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No.';
                }
                field("No. Envio de Almacen"; Rec."No. Envio de Almacen")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Envio de Almacen';
                }
                field("No. Hoja de Ruta"; Rec."No. Hoja de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Hoja de Ruta';
                }
                field("No. Hoja de Ruta Reg."; Rec."No. Hoja de Ruta Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Hoja de Ruta Reg.';
                }
                field("No. Picking"; Rec."No. Picking")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Picking';
                }
                field("No. Picking Reg."; Rec."No. Picking Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Picking Reg.';
                }
                field("No. Packing"; Rec."No. Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Packing';
                }
                field("TSHNo."; TSH."No.")
                {
                    ApplicationArea = All;
                }
                field("No. Envio"; Rec."No. Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Envio';
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Code';
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transfer-to Name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Assigned User ID';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000021>")
            {
                Caption = 'Acci&ones';
                action("<Action1000000009>")
                {
                    Caption = 'Seguimiento de pedido';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //+#117
                        OrderTracking.SetDoc(1, "No.");
                        OrderTracking.RUN;
                        //-#117
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LHR: Record 56021;
        LHRR: Record 56023;
        TSH: Record 5744;
    begin
        TH.RESET;
        IF TH.FINDSET THEN BEGIN
            Counter := 0;
            Window.OPEN(Text003);
            CounterTotal := TH.COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, TH."No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                //envio de almacen
                WHSL.RESET;
                WHSL.SETCURRENTKEY("No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
                WHSL.SETRANGE("Source Type", 5741);
                WHSL.SETRANGE("Source No.", TH."No.");
                IF WHSL.FINDFIRST THEN
                    TH."No. Envio de Almacen" := WHSL."No.";

                //Picking
                WHAl.RESET;
                WHAl.SETCURRENTKEY("Source Document", "Source No.");
                WHAl.SETRANGE("Source Document", WHAl."Source Document"::"Outbound Transfer");
                WHAl.SETRANGE("Source No.", TH."No.");
                IF WHAl.FINDFIRST THEN
                    TH."No. Picking" := WHAl."No.";

                //Picking Registrado
                RWAL.RESET;
                RWAL.SETCURRENTKEY("Source Document", "Source No.");
                RWAL.SETRANGE("Source Document", RWAL."Source Document"::"Outbound Transfer");
                RWAL.SETRANGE("Source No.", TH."No.");
                IF RWAL.FINDFIRST THEN
                    TH."No. Picking Reg." := RWAL."No.";

                //Packing
                LP.RESET;
                LP.SETCURRENTKEY("No. Picking");
                LP.SETRANGE("No. Picking", RWAL."No.");
                IF LP.FINDFIRST THEN
                    TH."No. Packing" := LP."No.";

                //Packing Registrado
                LPR.RESET;
                LPR.SETCURRENTKEY("No. Picking");
                LPR.SETRANGE(LPR."No. Picking", RWAL."No.");
                IF LPR.FINDFIRST THEN
                    TH."No. Packing Reg." := LPR."No.";
                TH.MODIFY;

                //Envio de transferencia
                TSH.RESET;
                TSH.SETCURRENTKEY("Transfer Order No.");
                TSH.SETRANGE("Transfer Order No.", TH."No.");
                IF TSH.FINDFIRST THEN
                    TH."No. Envio" := TSH."No.";
                TH.MODIFY;

                //+#2761

                TSH.RESET;
                TSH.SETRANGE(TSH."Transfer Order No.", TH."No.");
                IF TSH.FINDFIRST THEN BEGIN
                    //Numero Hoja de ruta
                    LHR.RESET;
                    LHR.SETCURRENTKEY("No. Pedido");
                    LHR.SETRANGE("No. Pedido", TSH."No.");
                    IF LHR.FINDFIRST THEN BEGIN
                        TH."No. Hoja de Ruta" := LHR."No. Hoja Ruta";
                        TH.MODIFY;
                    END;

                    //Numero Hoja de ruta REG.
                    LHRR.RESET;
                    LHRR.SETCURRENTKEY("No. Pedido");
                    LHRR.SETRANGE("No. Pedido", TSH."No.");
                    IF LHRR.FINDFIRST THEN BEGIN
                        TH."No. Hoja de Ruta Reg." := LHRR."No. Hoja Ruta";
                        TH.MODIFY;
                    END;
                END;
            //-#2761
            UNTIL TH.NEXT = 0;
            Window.CLOSE;
            COMMIT
        END;
    end;

    var
        WHSL: Record 7321;
        WHAl: Record 5767;
        RWAL: Record 5773;
        LP: Record 56031;
        LPR: Record 56034;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        TH: Record 5740;
        TSH: Record 5744;
        Text003: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        Contac: Record 5050;
        OrderTracking: Page 56081;
}

