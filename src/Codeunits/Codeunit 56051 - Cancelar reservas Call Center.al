codeunit 56051 "Cancelar reservas Call Center"
{

    trigger OnRun()
    begin
        CancelarReservaCallCenter;
    end;

    procedure CancelarReservaCallCenter()
    var
        rConf: Record 56001;
        rSalesHeader: Record 36;
        rSalesLine: Record 37;
        lText001: Label 'Se borrarán las reservas de los pedidos de Call Center con fecha hasta día %1 (incluido). ¿Desea continuar?';
        wFecha: Date;
        ReservEngineMgt: Codeunit 99000831;
        ReservEntry: Record 337;
        ReserveSalesLine: Codeunit 99000832;
        lText002: Label 'Proceso finalizado';
    begin
        //+#830

        rConf.GET;
        rConf.TESTFIELD("Días Borrado Rvas. Call Center");
        wFecha := WORKDATE - rConf."Días Borrado Rvas. Call Center";
        IF CONFIRM(STRSUBSTNO(lText001, wFecha)) THEN BEGIN
            rSalesHeader.RESET;
            rSalesHeader.SETRANGE("Document Type", rSalesHeader."Document Type"::Order);
            rSalesHeader.SETRANGE("Document Date", 0D, wFecha);
            rSalesHeader.SETRANGE("Venta Call Center", TRUE);
            rSalesHeader.SETRANGE("Pago recibido", FALSE);
            IF rSalesHeader.FINDSET THEN
                REPEAT
                    rSalesLine.RESET;
                    rSalesLine.SETRANGE(rSalesLine."Document Type", rSalesHeader."Document Type");
                    rSalesLine.SETRANGE(rSalesLine."Document No.", rSalesHeader."No.");
                    IF rSalesLine.FINDSET THEN
                        REPEAT
                            IF (rSalesLine.Type = rSalesLine.Type::Item) AND (rSalesLine."No." <> '') THEN BEGIN
                                ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, TRUE);
                                ReserveSalesLine.FilterReservFor(ReservEntry, rSalesLine);
                                IF ReservEntry.FINDFIRST THEN
                                    REPEAT
                                        //ReservEngineMgt.CloseReservEntry2(ReservEntry); //-$001
                                        ReservEngineMgt.CloseReservEntry(ReservEntry, FALSE, FALSE);  //+$001
                                    UNTIL ReservEntry.NEXT = 0;
                            END;
                        UNTIL rSalesLine.NEXT = 0;
                UNTIL rSalesHeader.NEXT = 0;
        END;
        MESSAGE(lText002);
    end;
}

