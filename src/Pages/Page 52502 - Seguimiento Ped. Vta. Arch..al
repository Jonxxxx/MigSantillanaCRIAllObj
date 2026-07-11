page 52502 "Seguimiento Ped. Vta. Arch."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 5107;
    SourceTableView = SORTING("Ultima Version")
                      ORDER(Ascending)
                      WHERE("Ultima Version" = FILTER(Yes));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("No. Envio de Almacen"; "No. Envio de Almacen")
                {
                }
                field("No. Picking"; "No. Picking")
                {
                }
                field("No. Picking Reg."; "No. Picking Reg.")
                {
                }
                field("No. Packing"; "No. Packing")
                {
                }
                field("No. Packing Reg."; "No. Packing Reg.")
                {
                }
                field("No. Envio"; "No. Envio")
                {
                }
                field("No. Hoja Ruta"; "No. Hoja Ruta")
                {
                }
                field("No. Factura"; "No. Factura")
                {
                }
                field("Order Date"; "Order Date")
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F5';

                    trigger OnAction()
                    begin
                        CASE "Document Type" OF
                            "Document Type"::Order:
                                PAGE.RUN(PAGE::"Sales Order Archive", Rec);
                            "Document Type"::Quote:
                                PAGE.RUN(PAGE::"Sales Quote Archive", Rec);
                            "Document Type"::"Return Order":
                                PAGE.RUN(PAGE::"Sales Return Order Archive", Rec);
                        END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        BuscarDocs;
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
        SH: Record 5107;
        SSH: Record 110;
        SIH: Record 112;
        Text003: Label 'Reading  #1########## @2@@@@@@@@@@@@@';
        SH1Record: Record 5107;
        FechaDesde: Date;
        FechaHasta: Date;
        Text004: Label 'Checking Orders #1########## @2@@@@@@@@@@@@@';
        LHRR: Record 56023;
        Error001: Label 'Date From must be specified';
        Error002: Label 'Date To Must be specified';

    procedure PasarFechas(datPrmFechaIni: Date; datPrmFechaFin: Date)
    begin
        FechaDesde := datPrmFechaIni;
        FechaHasta := datPrmFechaFin;
    end;

    procedure BuscarDocs()
    begin

        CLEAR(SH1);
        SH1.SETCURRENTKEY("Ultima Version");
        SH1.SETRANGE("Ultima Version", TRUE);
        SH1.SETRANGE("Posting Date", FechaDesde, FechaHasta);
        IF SH1.FINDLAST THEN BEGIN
            Counter := 0;
            Window.OPEN(Text004);
            CounterTotal := SH1.COUNT;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, SH1."No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                SH.GET(SH1."Document Type", SH1."No.", SH1."Doc. No. Occurrence", SH1."Version No.");
                SH."Ultima Version" := FALSE;
                SH.MODIFY;
            UNTIL SH1.NEXT = 0;
            Window.CLOSE;
        END;

        CLEAR(SH1);
        SH1.SETRANGE("Document Type", SH."Document Type"::Order);
        SH1.SETRANGE("Posting Date", FechaDesde, FechaHasta);
        IF SH1.FINDSET THEN BEGIN
            Counter := 0;
            Window.OPEN(Text003);
            CounterTotal := SH1.COUNT;
            REPEAT
                CLEAR(SH);
                SH.RESET;
                SH.SETRANGE("Document Type", SH1."Document Type");
                SH.SETRANGE("No.", SH1."No.");
                SH.SETRANGE("Posting Date", FechaDesde, FechaHasta);
                IF SH.FINDLAST THEN BEGIN
                    Counter := Counter + 1;
                    Window.UPDATE(1, SH1."No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                    //envio de almacen
                    WHSL.RESET;
                    WHSL.SETCURRENTKEY("No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    WHSL.SETRANGE("Source Type", 37);
                    WHSL.SETRANGE("Source No.", SH."No.");
                    IF WHSL.FINDFIRST THEN
                        SH."No. Envio de Almacen" := WHSL."No."
                    ELSE
                        SH."No. Envio de Almacen" := '';

                    //Picking
                    WHAl.RESET;
                    WHAl.SETCURRENTKEY("Source Document", "Source No.");
                    WHAl.SETRANGE("Source Document", WHAl."Source Document"::"Sales Order");
                    WHAl.SETRANGE("Source No.", SH."No.");
                    IF WHAl.FINDFIRST THEN
                        SH."No. Picking" := WHAl."No."
                    ELSE
                        SH."No. Picking" := '';

                    //Packing Registrado
                    CLEAR(RWAL);
                    RWAL.SETCURRENTKEY("Source Document", "Source No.");
                    RWAL.SETRANGE("Source Document", RWAL."Source Document"::"Sales Order");
                    RWAL.SETRANGE("Source No.", SH."No.");
                    IF RWAL.FINDFIRST THEN
                        SH."No. Picking Reg." := RWAL."No."
                    ELSE
                        SH."No. Picking Reg." := '';


                    //Packing
                    LP.RESET;
                    LP.SETCURRENTKEY("No. Picking");
                    LP.SETRANGE("No. Picking", RWAL."No.");
                    IF LP.FINDFIRST THEN
                        SH."No. Packing" := LP."No."
                    ELSE
                        SH."No. Packing" := '';

                    //Packing Registrado
                    LPR.RESET;
                    LPR.SETCURRENTKEY("No. Picking");
                    LPR.SETRANGE(LPR."No. Picking", RWAL."No.");
                    IF LPR.FINDFIRST THEN
                        SH."No. Packing Reg." := LPR."No."
                    ELSE
                        SH."No. Packing Reg." := '';
                    SH.MODIFY;

                    //Remision de venta
                    SSH.RESET;
                    SSH.SETCURRENTKEY("Order No.");
                    SSH.SETRANGE("Order No.", SH."No.");
                    IF SSH.FINDFIRST THEN
                        SH."No. Envio" := SSH."No."
                    ELSE
                        SH."No. Envio" := '';

                    //Hoja de Ruta
                    CLEAR(LHRR);
                    LHRR.SETCURRENTKEY("No. Pedido");
                    LHRR.SETRANGE(LHRR."No. Pedido", SH."No.");
                    IF LHRR.FINDFIRST THEN
                        SH."No. Hoja Ruta" := LHRR."No. Hoja Ruta";

                    //Factura de venta
                    SIH.RESET;
                    SIH.SETCURRENTKEY("Order No.");
                    SIH.SETRANGE(SIH."Order No.", SH."No.");
                    IF SIH.FINDFIRST THEN
                        SH."No. Factura" := SIH."No."
                    ELSE
                        SH."No. Factura" := '';
                    SH."Ultima Version" := TRUE;
                    SH.MODIFY;
                    COMMIT
                END;
            UNTIL SH1.NEXT = 0;
            Window.CLOSE;
        END;

        SETRANGE("Posting Date", FechaDesde, FechaHasta);
    end;
}

