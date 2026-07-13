table 34003021 "Lin. Campos Req. Maestros"
{
    Caption = 'Required fields Line';

    fields
    {
        field(1;"No. Tabla";Integer)
        {
            Caption = 'Table No.';
        }
        field(2;Nombre;Text[100])
        {
        }
        field(3;"No. Campo";Integer)
        {
            Caption = 'Field No.';
            NotBlank = true;

            trigger OnLookup()
            begin
                CLEAR(FieldForm);
                Fields.SETRANGE(TableNo,"No. Tabla");
                FieldForm.SETRECORD(Fields);
                FieldForm.SETTABLEVIEW(Fields);
                FieldForm.LOOKUPMODE(TRUE);
                IF FieldForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  FieldForm.GETRECORD(Fields);
                  "No. Campo" := Fields."No.";
                  "Nombre Campo" := Fields."Field Caption";
                END;
            end;

            trigger OnValidate()
            begin
                "Nombre Campo" := '';
                IF "No. Campo" <> 0 THEN BEGIN
                  Fields.GET("No. Tabla","No. Campo");
                  "Nombre Campo" := Fields."Field Caption";
                END;
            end;
        }
        field(4;"Nombre Campo";Text[80])
        {
            Caption = 'Field Name';
        }
    }

    keys
    {
        key(Key1;"No. Tabla","No. Campo")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Fields": Record "2000000041";
        FieldForm: Page "34003022";
}

