report 56031 "Desglose Ajuste Divisa"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; 379)
        {
            DataItemTableView = SORTING("Document No.", "Document Type", Posting Date)
                                ORDER(Ascending);
            RequestFilterFields = "Document No.", "Currency Code", "Posting Date", "Transaction No.";

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, "Detailed Cust. Ledg. Entry"."Posting Date");
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));


                CLE.GET("Cust. Ledger Entry No.");
                AjustDiv.INIT;
                AjustDiv."Cod. Divisa" := CLE."Currency Code";
                AjustDiv."Grupo Contable" := CLE."Customer Posting Group";
                AjustDiv."Fecha Registro" := CLE."Posting Date";
                DSE.RESET;
                DSE.SETRANGE("Dimension Set ID", CLE."Dimension Set ID");
                I := 0;

                N += 1;
                IF DSE.FINDSET THEN
                    REPEAT
                        IF I = 0 THEN BEGIN
                            AjustDiv."Cod. Dim. 1" := DSE."Dimension Code";
                            AjustDiv."Dimension 1" := DSE."Dimension Value Code";
                        END;

                        IF I = 1 THEN BEGIN
                            AjustDiv."Cod. Dim. 2" := DSE."Dimension Code";
                            AjustDiv."Dimension 2" := DSE."Dimension Value Code";
                        END;


                        IF I = 2 THEN BEGIN
                            AjustDiv."Cod. Dim. 3" := DSE."Dimension Code";
                            AjustDiv."Dimension 3" := DSE."Dimension Value Code";
                        END;

                        IF I = 3 THEN BEGIN
                            AjustDiv."Cod. Dim. 4" := DSE."Dimension Code";
                            AjustDiv."Dimension 4" := DSE."Dimension Value Code";
                        END;

                        IF I = 4 THEN BEGIN
                            AjustDiv."Cod. Dim. 5" := DSE."Dimension Code";
                            AjustDiv."Dimension 5" := DSE."Dimension Value Code";
                        END;

                        IF I = 5 THEN BEGIN
                            AjustDiv."Cod. Dim. 6" := DSE."Dimension Code";
                            AjustDiv."Dimension 6" := DSE."Dimension Value Code";
                        END;

                        IF I = 6 THEN BEGIN
                            AjustDiv."Cod. Dim. 7" := DSE."Dimension Code";
                            AjustDiv."Dimension 7" := DSE."Dimension Value Code";
                        END;




                    UNTIL DSE.NEXT = 0;

                AjustDiv.Consecutivo := N;
                AjustDiv."No. Documento" := CLE."Document No.";
                AjustDiv.Importe := "Amount (LCY)";
                AjustDiv."No. Mov. Detallado Prov" := "Entry No.";
                AjustDiv."No. Mov. Proveedor" := CLE."Entry No.";
                I += 1;
                AjustDiv."Dimension SET ID" := CLE."Dimension Set ID";
                AjustDiv.Tipo := 1;
                AjustDiv."Tipo Movimiento" := "Entry Type";
                AjustDiv.INSERT;
            end;

            trigger OnPreDataItem()
            begin
                CounterTotal := COUNT;
                Window.OPEN(Text001);
            end;
        }
        dataitem("Detailed Vendor Ledg. Entry"; 380)
        {
            DataItemTableView = SORTING("Document No.", "Document Type", Posting Date)
                                ORDER(Ascending);
            RequestFilterFields = "Document No.", "Currency Code", "Posting Date", "Transaction No.";

            trigger OnAfterGetRecord()
            begin
                VLE.GET("Vendor Ledger Entry No.");
                AjustDiv.INIT;
                AjustDiv."Cod. Divisa" := VLE."Currency Code";
                AjustDiv."Grupo Contable" := VLE."Vendor Posting Group";
                AjustDiv."Fecha Registro" := VLE."Posting Date";
                DSE.RESET;
                DSE.SETRANGE("Dimension Set ID", VLE."Dimension Set ID");
                I := 0;

                N += 1;
                IF DSE.FINDSET THEN
                    REPEAT
                        IF I = 0 THEN BEGIN
                            AjustDiv."Cod. Dim. 1" := DSE."Dimension Code";
                            AjustDiv."Dimension 1" := DSE."Dimension Value Code";
                        END;

                        IF I = 1 THEN BEGIN
                            AjustDiv."Cod. Dim. 2" := DSE."Dimension Code";
                            AjustDiv."Dimension 2" := DSE."Dimension Value Code";
                        END;


                        IF I = 2 THEN BEGIN
                            AjustDiv."Cod. Dim. 3" := DSE."Dimension Code";
                            AjustDiv."Dimension 3" := DSE."Dimension Value Code";
                        END;

                        IF I = 3 THEN BEGIN
                            AjustDiv."Cod. Dim. 4" := DSE."Dimension Code";
                            AjustDiv."Dimension 4" := DSE."Dimension Value Code";
                        END;

                        IF I = 4 THEN BEGIN
                            AjustDiv."Cod. Dim. 5" := DSE."Dimension Code";
                            AjustDiv."Dimension 5" := DSE."Dimension Value Code";
                        END;

                        IF I = 5 THEN BEGIN
                            AjustDiv."Cod. Dim. 6" := DSE."Dimension Code";
                            AjustDiv."Dimension 6" := DSE."Dimension Value Code";
                        END;

                        IF I = 6 THEN BEGIN
                            AjustDiv."Cod. Dim. 7" := DSE."Dimension Code";
                            AjustDiv."Dimension 7" := DSE."Dimension Value Code";
                        END;




                    UNTIL DSE.NEXT = 0;

                AjustDiv.Consecutivo := N;
                AjustDiv."No. Documento" := VLE."Document No.";
                AjustDiv.Importe := "Amount (LCY)";
                AjustDiv."No. Mov. Detallado Prov" := "Entry No.";
                AjustDiv."No. Mov. Proveedor" := VLE."Entry No.";
                I += 1;
                AjustDiv."Dimension SET ID" := VLE."Dimension Set ID";
                AjustDiv.Tipo := 0;
                AjustDiv."Tipo Movimiento" := "Entry Type";
                AjustDiv.INSERT;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
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
        AjustDiv.DELETEALL;
    end;

    var
        VLE: Record 25;
        AjustDiv: Record 56060;
        DSE: Record 480;
        I: Integer;
        N: Integer;
        CLE: Record 21;
        Window: Dialog;
        CounterTotal: Integer;
        Counter: Integer;
        CounterOK: Integer;
        Text001: Label 'Deleting orders  #1########## @2@@@@@@@@@@@@@';
}

