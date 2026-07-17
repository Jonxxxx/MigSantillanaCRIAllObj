pageextension 50073 EXCCRINoSeries extends "No. Series"
{
    layout
    {
        addafter(Description)
        {
            field(EXCCRINCFDescription; Rec."Descripcion NCF")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the fiscal receipt description associated with the number series.';
            }
            field(EXCCRIDocumentType; Rec."Tipo Documento")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the document type associated with the number series.';
            }
            field(EXCCRIInvoiceCopies; Rec."Invoice Copies")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of invoice copies to print for documents that use the number series.';
            }
        }
    }
}
