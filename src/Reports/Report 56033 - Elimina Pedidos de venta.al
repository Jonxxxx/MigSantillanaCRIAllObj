report 56033 "Elimina Pedidos de venta"
{
    Caption = 'Delete Sales orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; 36)
        {
            DataItemTableView = SORTING("Document Type", No.)
                                WHERE("Document Type" = CONST(Order),
                                      Pre pedido=CONST(No));
            RequestFilterFields = "No.", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                SL.RESET;
                SL.SETRANGE("Document Type", "Document Type");
                SL.SETRANGE("Document No.", "No.");
                SL.SETFILTER("Qty. Shipped Not Invoiced", '<>%1', 0);
                IF SL.FINDFIRST THEN
                    CurrReport.SKIP;

                /*
                SL.RESET;
                SL.SETRANGE("Document Type","Document Type");
                SL.SETRANGE("Document No.","No.");
                SL.SETFILTER(SL."Cantidad pendiente BO",'<>%1',0);
                IF SL.FINDFIRST THEN
                   CurrReport.SKIP;
                */

                WhseShptLine.RESET;
                WhseShptLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                WhseShptLine.SETRANGE("Source Type", DATABASE::"Sales Line");
                WhseShptLine.SETRANGE("Source Subtype", 1);
                WhseShptLine.SETRANGE("Source No.", "No.");
                IF NOT WhseShptLine.FINDFIRST THEN BEGIN
                    WhseActivLine.RESET;
                    WhseActivLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
                    WhseActivLine.SETRANGE("Source Type", DATABASE::"Sales Line");
                    WhseActivLine.SETRANGE("Source Subtype", 1);
                    WhseActivLine.SETRANGE("Source No.", "No.");
                    IF NOT WhseActivLine.FINDFIRST THEN BEGIN
                        IF DELETE(TRUE) THEN
                            CounterOK += 1;
                    END;
                END;

            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE(Text002, CounterOK, CounterTotal);
            end;

            trigger OnPreDataItem()
            begin
                CounterTotal := COUNT;
                Window.OPEN(Text001);
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

    trigger OnPreReport()
    begin
        IF "Sales Header".GETFILTER("Posting Date") = '' THEN
            ERROR(Error001);
    end;

    var
        Text001: Label 'Deleting orders  #1########## @2@@@@@@@@@@@@@';
        WhseShptLine: Record 7321;
        WhseActivLine: Record 5767;
        SL: Record 37;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text002: Label '%1 orders out of a total of %2 have now been deleted.';
        CounterOK: Integer;
        Error001: Label 'Date Filter must be specified';
}

