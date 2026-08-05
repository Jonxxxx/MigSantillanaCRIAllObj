table 55235 "Agregar productos a Cupon"
{

    fields
    {
        field(1; "No. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Producto';
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
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = User."User Name";
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

