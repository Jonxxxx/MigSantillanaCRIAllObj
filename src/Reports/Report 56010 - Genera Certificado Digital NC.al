report 56010 "Genera Certificado Digital NC"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; 114)
        {
            RequestFilterFields = "No.", "Posting Date";

            trigger OnAfterGetRecord()
            begin
                IF CAE <> '' THEN
                    CurrReport.SKIP;

                IF CAEC <> '' THEN
                    CurrReport.SKIP;


                cuFE.NotaCR("Sales Cr.Memo Header");
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
        IF "Sales Cr.Memo Header".GETFILTER("No.") = '' THEN
            ERROR(Error001);
    end;

    var
        Error001: Label 'Invoice No. Must be specified';
        Error002: Label 'Posting date must be specified';
        cuFE: Codeunit 56003;
        txtResp: array[7] of Text[1024];
}

