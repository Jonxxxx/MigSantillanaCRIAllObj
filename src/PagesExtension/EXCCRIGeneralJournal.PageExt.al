pageextension 50017 EXCCRIGeneralJournal extends "General Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field(EXCCRILineNo; Rec."Line No.")
            {
                ApplicationArea = All;
                Caption = 'Line No.';
                ToolTip = 'Specifies the line number of the general journal line.';
            }
            field(EXCCRICollectorCode; Rec."Collector Code")
            {
                ApplicationArea = All;
                Caption = 'Collector Code';
                ToolTip = 'Specifies the collector assigned to the general journal line.';
            }
            field(EXCCRIFiscalReceiptNo; Rec."No. Comprobante Fiscal")
            {
                ApplicationArea = All;
                Caption = 'Fiscal Receipt No.';
                ToolTip = 'Specifies the fiscal receipt number assigned to the general journal line.';
            }
            field(EXCCRIFiscalReceiptDueDate; Rec."Fecha vencimiento NCF")
            {
                ApplicationArea = All;
                Caption = 'Fiscal Receipt Expiration Date';
                ToolTip = 'Specifies the expiration date of the fiscal receipt number.';
            }
            field(EXCCRIExpenseClassCode; Rec."Cod. Clasificacion Gasto")
            {
                ApplicationArea = All;
                Caption = 'Expense Classification Code';
                ToolTip = 'Specifies the expense classification code assigned to the general journal line.';
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXCCRIValidatePOSSection();
        exit(true);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        EXCCRIValidatePOSSection();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        EXCCRIValidatePOSSection();
        exit(true);
    end;

    local procedure EXCCRIValidatePOSSection()
    var
        EXCCRIGenJournalBatch: Record "Gen. Journal Batch";
    begin
        if EXCCRIGenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            if EXCCRIGenJournalBatch."Seccion POS" then
                Error(EXCCRIPosSectionErr);
    end;

    var
        EXCCRIPosSectionErr: Label 'The POS section cannot be modified manually.';
}
