report 56036 "Ajusta Backorder"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; 36)
        {

            trigger OnAfterGetRecord()
            begin
                SL.RESET;
                SL.SETRANGE("Document Type", "Document Type");
                SL.SETRANGE("Document No.", "No.");
                IF SL.FINDSET THEN
                    REPEAT
                        IF SalesInfoPaneMgt.CalcAvailability_BackOrder(SL) <= 0 THEN BEGIN
                            WHSL.RESET;
                            WHSL.SETRANGE("Source No.", SL."Document No.");
                            WHSL.SETRANGE("Item No.", SL."No.");
                            IF NOT WHSL.FINDFIRST THEN BEGIN
                                Ajuste := 0;
                                Ajuste := SL.Quantity - SL."Quantity Shipped";
                                SL.Quantity := SL."Quantity Shipped";
                                SL.VALIDATE(Quantity);
                                Cust.GET("Sales Header"."Sell-to Customer No.");
                                IF Cust."Admite Pendientes en Pedidos" THEN
                                    SL."Cantidad pendiente BO" := Ajuste;
                                SL.MODIFY;
                            END;
                        END

                    UNTIL SL.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SL: Record 37;
        SalesInfoPaneMgt: Codeunit 7171;
        Ajuste: Decimal;
        WHSL: Record 7321;
        Cust: Record 18;
}

