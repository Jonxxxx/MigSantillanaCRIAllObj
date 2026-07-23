table 34003022 "Cab. Dimensiones Requeridas"
{
    Caption = 'Required fields Header';

    fields
    {
        field(1; "No. Tabla"; Integer)
        {
            Caption = 'Table No.';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(2; Nombre; Text[100])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = CONST(Table),
                                                                        "Object ID" = FIELD("No. Tabla")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Activo; Boolean)
        {
            Caption = 'Active';
        }
    }

    keys
    {
        key(Key1; "No. Tabla")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LinCampReq.RESET;
        LinCampReq.SETRANGE("No. Tabla", "No. Tabla");
        LinCampReq.DELETEALL;
    end;

    var
        LinCampReq: Record 34003021;
}

