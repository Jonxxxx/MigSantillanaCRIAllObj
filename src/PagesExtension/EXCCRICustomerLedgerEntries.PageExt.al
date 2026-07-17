pageextension 50009 EXCCRICustomerLedgerEntries extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Posting Date")
        {
            field(EXCCRIDocumentReceiptDate; Rec."Fecha Recepcion Documento")
            {
                ApplicationArea = All;
                Editable = EXCCRICanModifyDocumentReceiptDate;
                ToolTip = 'Specifies the date when the customer document was received.';
            }
            field(EXCCRIExternalDocumentNo; Rec."External Document No.")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the external document number associated with the customer ledger entry.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt number associated with the customer ledger entry.';
            }
            field(EXCCRIClosedByEntryNo; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the entry number that closed the customer ledger entry.';
            }
            field(EXCCRICollectorCode; Rec."Collector Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the collector associated with the customer ledger entry.';
            }
            field(EXCCRIProvisionedAmount; Rec."Importe provisionado")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the amount provisioned for the customer ledger entry.';
            }
            field(EXCCRILastProvisionDate; Rec."Fecha ult. provision")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the last date when the customer ledger entry was provisioned.';
            }
            field(EXCCRIProvisionedInsolvency; Rec."Provisionado por insolvencia")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies whether the customer ledger entry was provisioned because of insolvency.';
            }
        }
    }

    trigger OnOpenPage()
    var
        EXCCRIUserSetup: Record "User Setup";
    begin
        if not EXCCRIUserSetup.Get(UserId()) then
            Clear(EXCCRIUserSetup);

        EXCCRICanModifyDocumentReceiptDate :=
            EXCCRIUserSetup."Permite Mod. Fecha Recep. Doc.";
    end;

    var
        EXCCRICanModifyDocumentReceiptDate: Boolean;
}
