codeunit 50010 CI_AnularFacturas
{

    trigger OnRun()
    begin

        //AnularFacturas();
        CrearFacturaCorreccion('VNR14-000029');
    end;

    var
        CorrectPostedSalesInvoice: Codeunit 1303;
        SalesHeader: Record 36;
        SalesHeader2: Record 36;
        SalesInvoiceHeader: Record 112;
        NotasCRaCorregirTEMPORAL: Record 50015;
        NotasCRaCorregirTEMPORAL2: Record 50015;
        SalesCrMemoHeader: Record 114;
        SIH: Record 112;
        SCMH: Record 114;

    local procedure AnularFacturas()
    begin
        SIH.RESET;
        SIH.SETRANGE("No.", 'VFR14-001828');

        IF SIH.FINDSET THEN BEGIN
            REPEAT

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", SIH."No.");


                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN


                    //TODO: Ver CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument2(SalesInvoiceHeader, SalesHeader);
                    // PAGE.RUN(PAGE::"Sales Credit Memo",SalesHeader);
                    //CurrPage.CLOSE;

                    //                FacturasAnular2.RESET;
                    //                FacturasAnular2.GET(FacturasAnular.NoFact);
                    //                  FacturasAnular2.Transferido := TRUE;
                    //                  FacturasAnular2.MODIFY(TRUE);

                    SalesHeader2.RESET;
                    SalesHeader2.SETRANGE("Applies-to Doc. No.", SalesInvoiceHeader."No.");
                    IF SalesHeader2.FINDSET THEN BEGIN
                        REPEAT
                            SalesHeader2.Correction := TRUE;
                            SalesHeader2."Razon anulacion NCF" := '04';
                            //SalesHeader2."Posting No. Series" :='ANFV';
                            SalesHeader2.MODIFY(TRUE);
                        UNTIL SalesHeader2.NEXT = 0;
                    END;
                END;

            UNTIL SIH.NEXT = 0;

        END;
    end;

    local procedure CrearFacturaCorreccion(DocNo_: Code[20])
    begin
        SCMH.RESET;
        SCMH.SETRANGE("No.", DocNo_);

        //NotasCRaCorregirTEMPORAL
        IF SCMH.FINDSET THEN BEGIN
            REPEAT

                SalesCrMemoHeader.RESET;
                SalesCrMemoHeader.SETRANGE("No.", SCMH."No.");

                IF SalesCrMemoHeader.FINDFIRST THEN BEGIN


                    //TODO: Ver CorrectPostedSalesInvoice.CreateSalesInvoiceCopyDocument(SalesCrMemoHeader, SalesHeader);

                    //                NotasCRaCorregirTEMPORAL2.RESET;
                    //                NotasCRaCorregirTEMPORAL2.GET(NotasCRaCorregirTEMPORAL."No. Documento");
                    //                  NotasCRaCorregirTEMPORAL2.Transferido := TRUE;
                    //                  NotasCRaCorregirTEMPORAL2.MODIFY(TRUE);

                    SalesHeader.Correction := TRUE;
                    //SalesHeader."No. Comprobante Fiscal" := NotasCRaCorregirTEMPORAL."No. Comprobante Fiscal";
                    //SalesHeader."No. Comprobante Fiscal Rel." := NotasCRaCorregirTEMPORAL."No. Comprobante Fiscal Rel.";
                    SalesHeader.MODIFY(TRUE);

                    // MESSAGE('Se ha creado una Factura Correctiva' + ': '+ SalesHeader."No.");
                    //CODEUNIT.RUN(CODEUNIT::"Sales-Post",SalesHeader);
                END;

            UNTIL SCMH.NEXT = 0;

        END;
    end;
}

