tableextension 50047 EXCCRINoSeries extends "No. Series"
{
    fields
    {
        field(50000; "Tipo Documento"; Option)
        {
            Caption = 'Document Type', Comment = 'ESP=Tipo Documento';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Invoice,Credit Memo', Comment = 'ESP= ,Factura,Nota de Crédito';
            OptionMembers = " ",Factura,"Nota de Crédito";
        }
        field(34003001; "Descripcion NCF"; Text[60])
        {
            Caption = 'NCF Description', Comment = 'ESP=Descripción NCF';
            DataClassification = ToBeClassified;
        }
        field(34003002; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies', Comment = 'ESP=Nº copias factura';
            DataClassification = ToBeClassified;
        }
    }
}
