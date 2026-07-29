table 34003022 "Cab. Dimensiones Requeridas"
{
    Caption = 'Required fields Header';

    fields
    {
        field(1; "No. Tabla"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Tabla';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(2; Nombre; Text[100])
        {
            Caption = 'Nombre';
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = CONST(Table),
                                                                        "Object ID" = FIELD("No. Tabla")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Activo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activo';
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

