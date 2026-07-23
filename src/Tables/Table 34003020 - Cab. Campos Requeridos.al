table 34003020 "Cab. Campos Requeridos"
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
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("No. Tabla")));
            Caption = 'Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; Activo; Boolean)
        {
            Caption = 'Active';

            trigger OnValidate()
            begin
                /*
                IF Activo THEN
                  BEGIN
                    LinCampReq.RESET;
                    LinCampReq.SETRANGE("No. Tabla","No. Tabla");
                    LinCampReq.SETRANGE(LinCampReq."No. Campo",1);
                    IF NOT LinCampReq.FINDFIRST THEN
                      BEGIN
                
                      END
                  END;
                */

            end;
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
        txt001: Label 'El Campo 1 de la tabla debe estar incluido dentro de los requeridos';
}

