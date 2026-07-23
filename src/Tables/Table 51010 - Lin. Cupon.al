table 51010 "Lin. Cupon"
{
    Caption = 'Coupon Lines';

    fields
    {
        field(1; "No. Cupon"; Code[20])
        {
            Caption = 'Coupon No.';
        }
        field(2; "Cod. Producto"; Code[20])
        {
            Caption = 'Coupon Code';
            TableRelation = Item;

            trigger OnValidate()
            var
                recCClote: Record 51011;
            begin

                recCClote.SETRANGE("Cod. Producto", "Cod. Producto");
                IF recCClote.FINDFIRST THEN
                    Descripcion := recCClote.Descripcion;
            end;
        }
        field(3; Descripcion; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Precio Venta"; Decimal)
        {
            Caption = 'Sales Price';
        }
        field(5; "% Descuento"; Decimal)
        {
            Caption = 'Discount %';
            DecimalPlaces = 4 :;
        }
        field(6; Cantidad; Integer)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin

                IF rCabCupon.GET("No. Cupon") THEN BEGIN
                    IF rUserSetup.GET(USERID) THEN BEGIN
                        IF NOT rUserSetup."Permite modificar Cupon" THEN
                            rCabCupon.TESTFIELD(rCabCupon.Impreso, FALSE);
                    END
                    ELSE
                        rCabCupon.TESTFIELD(rCabCupon.Impreso, FALSE);
                    "Cantidad Pendiente" := Cantidad;
                END;

            end;
        }
        field(7; "Cantidad Pendiente"; Integer)
        {
            Caption = 'Remaning Qty.';
        }
    }

    keys
    {
        key(Key1; "No. Cupon", "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        rConfSantillana.GET;
        rLinCupon.RESET;
        rLinCupon.SETRANGE("No. Cupon", "No. Cupon");
        IF (rLinCupon.COUNT + 1) > rConfSantillana."Cantidad Lineas en Cupon" THEN
            ERROR(Error002);


        rCabCupon.GET("No. Cupon");
        rCabCupon.TESTFIELD("Descuento a Padres de Familia");
        VALIDATE("% Descuento", rCabCupon."Descuento a Padres de Familia");
    end;

    trigger OnModify()
    begin
        rCabCupon.GET("No. Cupon");
        IF rCabCupon.Impreso THEN
            ERROR(Error001);
    end;

    var
        rProducto: Record 27;
        rCabCupon: Record 51009;
        Error001: Label 'Printed Coupon cannot be modified';
        rConfSantillana: Record 56001;
        rLinCupon: Record 51010;
        Error002: Label 'Lines Qty. exceed the qty. allowed for a Coupon';
        rUserSetup: Record 91;
}

