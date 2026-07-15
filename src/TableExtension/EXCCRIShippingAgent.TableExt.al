tableextension 50046 EXCCRIShippingAgent extends "Shipping Agent"
{
    fields
    {
        field(56000; "No. Serie Guias"; Code[20])
        {
            Caption = 'Guide Series No.', Comment = 'ESP=No. Serie Guias';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(56001; "ID Reporte Guia"; Integer)
        {
            Caption = 'Guide Report ID', Comment = 'ESP=ID Reporte Guia';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(56002; "No. Cliente Santillana"; Code[20])
        {
            Caption = 'Santillana Customer No.', Comment = 'ESP=No. Cliente Santillana';
            DataClassification = ToBeClassified;
        }
    }
}
