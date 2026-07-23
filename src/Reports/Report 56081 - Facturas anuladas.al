report 56081 "Facturas anuladas"
{
    // ------------------------------------------------------------------------
    // No.         Fecha           Firma         Descripcion
    // ------------------------------------------------------------------------
    // 139         20/11/2013      RRT           Adaptación informes a RTC.
    DefaultLayout = RDLC;
    RDLCLayout = './Facturas anuladas.rdlc';

    ApplicationArea = Basic, Suite, Service;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cust. Ledger Entry"; 21)
        {
            CalcFields = Amount;
            DataItemTableView = SORTING(Document No., Document Type, Customer No.)
                                WHERE(Open = FILTER(No));
            RequestFilterFields = "Document No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(rCliente_Name; rCliente.Name)
            {
            }
            column(Cust__Ledger_Entry_Amount; Amount)
            {
            }
            column(FechaAnulacion; FechaAnulacion)
            {
            }
            column(Cust__Ledger_Entry_Amount_Control1000000018; Amount)
            {
            }
            column(Cust__Ledger_EntryCaption; Cust__Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
            {
            }
            column(Cust__Ledger_Entry__Customer_No__Caption; FIELDCAPTION("Customer No."))
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(NombreCaption; NombreCaptionLbl)
            {
            }
            column(Fecha_AnulacionCaption; Fecha_AnulacionCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                lMostrar: Boolean;
            begin
                rCliente.GET("Customer No.");

                //+139.
                //... Adaptación del código existente en el trigger Body del mismo DataItem en el apartado Section.
                lMostrar := FALSE;
                FechaAnulacion := 0D;

                //En caso de que el campo "Cerrado por" lo tenga la factura
                IF "Closed by Entry No." <> 0 THEN BEGIN
                    rCustLedgerEntry.GET("Closed by Entry No.");
                    IF rCustLedgerEntry."Document Type" = rCustLedgerEntry."Document Type"::"Credit Memo" THEN BEGIN
                        rCustLedgerEntry.CALCFIELDS(Amount);
                        IF ABS(rCustLedgerEntry.Amount) = ABS("Closed by Amount") THEN BEGIN
                            lMostrar := TRUE;
                            FechaAnulacion := rCustLedgerEntry."Posting Date";
                        END;
                    END;
                END
                ELSE
                //En caso de que el campo "Cerrado por" lo tenga la Nota de credito
                  BEGIN
                    rCustLedgerEntry.RESET;
                    rCustLedgerEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    IF rCustLedgerEntry.FINDFIRST THEN
                        IF rCustLedgerEntry."Document Type" = rCustLedgerEntry."Document Type"::"Credit Memo" THEN
                            IF ABS(rCustLedgerEntry."Closed by Amount") = ABS(Amount) THEN BEGIN
                                lMostrar := TRUE;
                                FechaAnulacion := rCustLedgerEntry."Posting Date";
                            END;
                END;

                IF NOT lMostrar THEN
                    CurrReport.SKIP;

                //-139
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
        rCliente: Record 18;
        rCustLedgerEntry: Record 21;
        FechaAnulacion: Date;
        Cust__Ledger_EntryCaptionLbl: Label 'Cust. Ledger Entry';
        CurrReport_PAGENOCaptionLbl: Label 'Página';
        NombreCaptionLbl: Label 'Nombre';
        Fecha_AnulacionCaptionLbl: Label 'Fecha Anulacion';
        TotalCaptionLbl: Label 'Total';
}

