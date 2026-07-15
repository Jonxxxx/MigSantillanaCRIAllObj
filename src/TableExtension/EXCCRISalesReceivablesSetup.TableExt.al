tableextension 50050 EXCCRISalesReceivablesSetup extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Pre Order Nos."; Code[10])
        {
            Caption = 'Pre Order Nos.', Comment = 'ESP=Nº serie pre pedido';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "No. Serie Pedidos Consignacion"; Code[20])
        {
            Caption = 'Consignment Series No.', Comment = 'ESP=No. Serie Pedidos Consignacion';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "No. Serie Ident. Devolucion"; Code[20])
        {
            Caption = 'Return Identifier Series Nos.', Comment = 'ESP=No. Serie Ident. Devolucion';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "No. Serie Ident. Dev. Reg."; Code[20])
        {
            Caption = 'Posted Return Identifier Series Nos.', Comment = 'ESP=No. Serie Ident. Dev. Reg.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50005; "No. Serie Hoja de Ruta"; Code[20])
        {
            Caption = 'Route Sheet Series No.', Comment = 'ESP=No. Serie Hoja de Ruta';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "No. Serie Hoja de Ruta Reg."; Code[20])
        {
            Caption = 'Posted Route Sheet Series No.', Comment = 'ESP=No. Serie Hoja de Ruta Reg.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
