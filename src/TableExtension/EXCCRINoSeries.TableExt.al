tableextension 55047 EXCCRINoSeries extends "No. Series"
{
    fields
    {
        field(55000; "Tipo Documento"; Option)
        {
            Caption = 'Document Type', Comment = 'ESP=Tipo Documento';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Invoice,Credit Memo', Comment = 'ESP= ,Factura,Nota de Credito';
            OptionMembers = " ",Factura,"Nota de Credito";
        }
        field(34003001; "Descripcion NCF"; Text[60])
        {
            Caption = 'NCF Description', Comment = 'ESP=Descripcion NCF';
            DataClassification = CustomerContent;
        }
        field(34003002; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies', Comment = 'ESP=Nº copias factura';
            DataClassification = CustomerContent;
        }
    }
}
