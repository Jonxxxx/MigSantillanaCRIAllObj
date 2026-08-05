tableextension 55046 EXCCRIShippingAgent extends "Shipping Agent"
{
    fields
    {
        field(55225; "No. Serie Guias"; Code[20])
        {
            Caption = 'Guide Series No.', Comment = 'ESP=No. Serie Guias';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(55226; "ID Reporte Guia"; Integer)
        {
            Caption = 'Guide Report ID', Comment = 'ESP=ID Reporte Guia';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(55227; "No. Cliente Santillana"; Code[20])
        {
            Caption = 'Santillana Customer No.', Comment = 'ESP=No. Cliente Santillana';
            DataClassification = CustomerContent;
        }
    }
}
