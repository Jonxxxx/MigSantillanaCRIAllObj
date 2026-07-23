report 56034 "Elimina Transferencias"
{
    Caption = 'Delete Sales orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Transfer Header"; 5740)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "No.");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                TL.RESET;
                TL.SETRANGE("Document No.", "No.");
                TL.SETFILTER("Outstanding Quantity", '<>%1', 0);
                IF TL.FINDFIRST THEN
                    CurrReport.SKIP;

                /*
                TL.RESET;
                TL.SETRANGE("Document No.","No.");
                TL.SETFILTER(TL."Cantidad pendiente BO",'<>%1',0);
                IF TL.FINDFIRST THEN
                   CurrReport.SKIP;
                */

                WhseShptLine.RESET;
                WhseShptLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                WhseShptLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
                WhseShptLine.SETRANGE("Source Subtype", 0);
                WhseShptLine.SETRANGE("Source No.", "No.");
                IF NOT WhseShptLine.FINDFIRST THEN BEGIN
                    WhseActivLine.RESET;
                    WhseActivLine.SETCURRENTKEY("Source Type", "Source Subtype", "Source No.", "Source Line No.", "Source Subline No.");
                    WhseActivLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
                    WhseActivLine.SETRANGE("Source Subtype", 0);
                    WhseActivLine.SETRANGE("Source No.", "No.");
                    IF NOT WhseActivLine.FINDFIRST THEN BEGIN
                        ReleaseTransferDoc.Reopen("Transfer Header");
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
        IF "Transfer Header".GETFILTER("Posting Date") = '' THEN
            ERROR(Error001);
    end;

    var
        Text001: Label 'Deleting orders  #1########## @2@@@@@@@@@@@@@';
        WhseShptLine: Record 7321;
        WhseActivLine: Record 5767;
        TL: Record 5741;
        ReleaseTransferDoc: Codeunit 5708;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        Text002: Label '%1 orders out of a total of %2 have now been deleted.';
        CounterOK: Integer;
        Error001: Label 'Date Filter must be specified';
}

