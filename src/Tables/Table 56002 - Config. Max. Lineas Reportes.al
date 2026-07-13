table 56002 "Config. Max. Lineas Reportes"
{

    fields
    {
        field(1; Country; Code[10])
        {
            Caption = 'Country';
            //TODO: Ver TableRelation = "Parametros Loc. x Pais";
        }
        field(2; "Sales Report ID"; Integer)
        {
            Caption = 'Sales Report ID';
            //TODO: Ver TableRelation = Object.ID WHERE ("Type"=CONST(Report));
        }
        field(3; "Sales Report Name"; Text[80])
        {
            //CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type"=CONST(Report),
            //                                                            Object ID=FIELD("Sales Report ID")));
            Caption = 'Check Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Maximun line number"; Integer)
        {
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

