table 56002 "Config. Max. Lineas Reportes"
{

    fields
    {
        field(1; Country; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "Parametros Loc. x Pais";
        }
        field(2; "Sales Report ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Report ID';
            TableRelation = AllObjWithCaption."Object ID"
    where("Object Type" = const(Report));
        }
        field(3; "Sales Report Name"; Text[80])
        {
            Caption = 'Sales Report Name';
            //CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type"=CONST(Report),
            //                                                            "Object ID"=FIELD("Sales Report ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Maximun line number"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximun line number';
        }
    }

    keys
    {
        key(Key1; Country, "Sales Report ID")
        {
        }
    }

    fieldgroups
    {
    }
}

