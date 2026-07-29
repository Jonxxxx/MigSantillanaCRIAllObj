page 56062 "Seguimiento Pedidos de Venta"
{
    // #117    23/10/2013    PLB             Seguimiento de pedidos
    // #1141   31/12/2013    PLB             Seguimiento de pedidos de transferencia
    // #2761   20/05/2014    CAT             Se informa el Numero de hoja de ruta y el Numero de hoja de ruta registrada

    Caption = 'Order Management';
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Location Code';
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
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bill-to Name';
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
                field("No. Packing Reg."; Rec."No. Packing Reg.")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Packing Reg.';
                }
                field("No. Envio"; Rec."No. Envio")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Envio';
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
                field("No. Factura"; Rec."No. Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Factura';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer No.';
                }
                field("En Hoja de Ruta"; Rec."En Hoja de Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'En Hoja de Ruta';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sell-to Customer Name';
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
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Editable = false;
                }
                field(ContacName; Contac.Name)
                {
                    ApplicationArea = All;
                    Caption = 'School Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Acci&ones")
            {
                Caption = 'Acci&ones';
                action("<Action1000000009>")
                {
                    ApplicationArea = All;
                    Caption = 'Seguimiento de pedido';
                    ToolTip = 'Seguimiento de pedido';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        OrderTracking: Page 56081;
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

    trigger OnAfterGetRecord()
    begin
        IF NOT Contac.GET("Cod. Colegio") THEN
            CLEAR(Contac);
    end;

    trigger OnOpenPage()
    var
        LHR: Record 56021;
        LHRR: Record 56023;
    begin
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
                //envio de almacen
                WHSL.RESET;
                WHSL.SETCURRENTKEY("No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
                WHSL.SETRANGE("Source Type", 37);
                WHSL.SETRANGE("Source No.", SH."No.");
                IF WHSL.FINDFIRST THEN
                    SH."No. Envio de Almacen" := WHSL."No.";

                //Picking
                WHAl.RESET;
                WHAl.SETCURRENTKEY("Source Document", "Source No.");
                WHAl.SETRANGE("Source Document", WHAl."Source Document"::"Sales Order");
                WHAl.SETRANGE("Source No.", SH."No.");
                IF WHAl.FINDFIRST THEN
                    SH."No. Picking" := WHAl."No.";

                //Picking Registrado  No.,Source Document,Source No.
                RWAL.RESET;
                RWAL.SETCURRENTKEY("Source Document", "Source No.");
                RWAL.SETRANGE("Source Document", RWAL."Source Document"::"Sales Order");
                RWAL.SETRANGE("Source No.", SH."No.");
                IF RWAL.FINDFIRST THEN
                    SH."No. Picking Reg." := RWAL."No.";

                //Packing
                LP.RESET;
                LP.SETCURRENTKEY("No. Picking");
                LP.SETRANGE("No. Picking", RWAL."No.");
                IF LP.FINDFIRST THEN
                    SH."No. Packing" := LP."No.";

                //Packing Registrado
                LPR.RESET;
                LPR.SETCURRENTKEY("No. Picking");
                LPR.SETRANGE(LPR."No. Picking", RWAL."No.");
                IF LPR.FINDFIRST THEN
                    SH."No. Packing Reg." := LPR."No.";
                SH.MODIFY;

                //Remision de venta
                SSH.RESET;
                SSH.SETCURRENTKEY("Order No.");
                SSH.SETRANGE("Order No.", SH."No.");
                IF SSH.FINDFIRST THEN
                    SH."No. Envio" := SSH."No.";

                //Factura de venta
                SIH.RESET;
                SIH.SETCURRENTKEY("Order No.");
                SIH.SETRANGE(SIH."Order No.", SH."No.");
                IF SIH.FINDFIRST THEN
                    SH."No. Factura" := SIH."No.";
                SH.MODIFY;

                //+#2761
                //Numero Hoja de ruta
                LHR.RESET;
                LHR.SETCURRENTKEY("No. Pedido");
                LHR.SETRANGE("No. Pedido", SH."No.");
                IF LHR.FINDFIRST THEN BEGIN
                    SH."No. Hoja de Ruta" := LHR."No. Hoja Ruta";
                    SH.MODIFY;
                END;

                //Numero Hoja de ruta REG.
                LHRR.RESET;
                LHRR.SETCURRENTKEY("No. Pedido");
                LHRR.SETRANGE("No. Pedido", SH."No.");
                IF LHRR.FINDFIRST THEN BEGIN
                    SH."No. Hoja de Ruta Reg." := LHRR."No. Hoja Ruta";
                    SH.MODIFY;
                END;

            //-#2761
            UNTIL SH.NEXT = 0;
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
        Text003: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        SH: Record 36;
        SSH: Record 110;
        SIH: Record 112;
        Contac: Record 5050;
}

