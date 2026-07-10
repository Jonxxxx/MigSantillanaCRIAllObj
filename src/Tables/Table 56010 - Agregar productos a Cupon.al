table 56010 "Agregar productos a Cupon"
{

    fields
    {
        field(1; "No. Producto"; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF rItem.GET("No. Producto") THEN
                    VALIDATE(Descripcion, rItem.Description);
            end;
        }
        field(2; Descripcion; Text[200])
        {
            Caption = 'Description';
        }
        field(3; "User ID"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No. Producto", "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;
    end;

    var
        rItem: Record 27;
}

