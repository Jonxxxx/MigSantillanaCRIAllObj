tableextension 55050 EXCCRISalesReceivablesSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(55225; "Pre Order Nos."; Code[10])
        {
            Caption = 'Pre Order Nos.', Comment = 'ESP=Nº serie pre pedido';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55227; "No. Serie Pedidos Consignacion"; Code[20])
        {
            Caption = 'Consignment Series No.', Comment = 'ESP=No. Serie Pedidos Consignacion';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55228; "No. Serie Ident. Devolucion"; Code[20])
        {
            Caption = 'Return Identifier Series Nos.', Comment = 'ESP=No. Serie Ident. Devolucion';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55229; "No. Serie Ident. Dev. Reg."; Code[20])
        {
            Caption = 'Posted Return Identifier Series Nos.', Comment = 'ESP=No. Serie Ident. Dev. Reg.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55230; "No. Serie Hoja de Ruta"; Code[20])
        {
            Caption = 'Route Sheet Series No.', Comment = 'ESP=No. Serie Hoja de Ruta';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55231; "No. Serie Hoja de Ruta Reg."; Code[20])
        {
            Caption = 'Posted Route Sheet Series No.', Comment = 'ESP=No. Serie Hoja de Ruta Reg.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
