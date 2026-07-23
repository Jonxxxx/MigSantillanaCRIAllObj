report 56008 "Genera Certificado Digital"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.

    ApplicationArea = Basic, Suite, Service;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; 112)
        {
            RequestFilterFields = "No.", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                //CPMCR-CEC+
                /*
                IF CAE <> '' THEN
                  CurrReport.SKIP;
                
                IF CAEC <> '' THEN
                  CurrReport.SKIP;
                */
                //CPMCR-CEC-

                //TODO: Ver cuFE.Factura("Sales Invoice Header");

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
        IF "Sales Invoice Header".GETFILTER("No.") = '' THEN
            ERROR(Error001);

        /*
        IF "Sales Invoice Header".GETFILTER("Posting Date") = '' THEN
          ERROR(Error002);
        */

    end;

    var
        Error001: Label 'Invoice No. Must be specified';
        Error002: Label 'Posting date must be specified';
        cuFE: Codeunit 56003;
        txtResp: array[7] of Text[1024];
}

