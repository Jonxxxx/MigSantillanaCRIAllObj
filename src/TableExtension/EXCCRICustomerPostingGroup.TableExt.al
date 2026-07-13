tableextension 50022 EXCCRICustomerPostingGroup extends "Customer Posting Group"
{
    fields
    {
        field(51000; "Cliente Interno"; Boolean)
        {
            Caption = 'Internal Customer';
            DataClassification = ToBeClassified;
        }
        field(56000; "Invoice Report ID"; Integer)
        {
            Caption = 'Invoice Report ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(56001; "Invoice Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report), "Object ID" = field("Invoice Report ID")));
            Caption = 'Invoice Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(56002; "Credit Memo Report ID"; Integer)
        {
            Caption = 'Credit memo Report ID';
            DataClassification = ToBeClassified;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));
        }
        field(56003; "Credit Memo Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Report), "Object ID" = field("Credit Memo Report ID")));
            Caption = 'Credit Memo Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(56004; "No aplica Derechos de Autor"; Boolean)
        {
            Caption = 'Apply Author Copyright';
            DataClassification = ToBeClassified;
        }
        field(56005; Promocion; Boolean)
        {
            Caption = 'Promotion';
            DataClassification = ToBeClassified;
        }
        field(56010; "Cta. Dotacion Provision insolv"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(34003001; "Permite emitir NCF"; Boolean)
        {
            Caption = 'Allow to issue NCF';
            DataClassification = ToBeClassified;
        }
        field(34003002; "No. Serie NCF Factura Venta"; Code[20])
        {
            Caption = 'Sales Inv. NCF Serial No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003003; "No. Serie NCF Abonos Venta"; Code[20])
        {
            Caption = 'Sales Credit Memo NCF Serial No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34003004; "RNC/Cedula no Requerido"; Boolean)
        {
            Caption = 'VRN/Doc. ID not Required';
            DataClassification = ToBeClassified;
        }
        field(34003007; Internacional; Boolean)
        {
            Caption = 'International';
            DataClassification = ToBeClassified;
        }
    }
}
