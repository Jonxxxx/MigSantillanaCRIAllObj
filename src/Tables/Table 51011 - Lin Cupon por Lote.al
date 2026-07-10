table 51011 "Lin Cupon por Lote"
{
    Caption = 'Coupon Lines';

    fields
    {
        field(1; Lote; Integer)
        {
            TableRelation = "Cab. Cupon Lote".Lote;
        }
        field(2; "Cod. Producto"; Code[20])
        {
            Caption = 'Coupon Code';
            NotBlank = false;
            TableRelation = Item;

            trigger OnValidate()
            var
                rProducto: Record 27;
            begin

                IF "Cod. Producto" = '' THEN BEGIN
                    "Precio Venta" := 0;
                    "% Descuento" := 0;
                    Cantidad := 0;
                    Descripcion := '';
                END
                ELSE BEGIN
                    rProducto.GET("Cod. Producto");
                    Descripcion := rProducto.Description;
                    Cantidad := 1;
                    "Precio Venta" := PrecioPOS("Cod. Producto");
                END;

                AplicaDescuento;
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
        }
    }

    keys
    {
        key(Key1; Lote, "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Error001: Label 'Printed Coupon cannot be modified';

    procedure PrecioPOS(pProd: Code[20]): Decimal
    var
        rTarifas: Record 7002;
    begin

        rTarifas.RESET;
        rTarifas.SETRANGE("Item No.", pProd);
        rTarifas.SETFILTER("Starting Date", '<=%1|%2', WORKDATE, 0D);
        rTarifas.SETFILTER("Ending Date", '>=%1|%2', WORKDATE, 0D);
        IF rTarifas.FINDLAST THEN
            EXIT(rTarifas."Unit Price");
    end;

    procedure AplicaDescuento()
    var
        rCab: Record 51015;
    begin
        rCab.RESET;
        rCab.GET(Lote);
        CASE rCab."Dto. Aplica a Lineas" OF
            1:
                "% Descuento" := rCab."Dto Padre";
            2:
                "% Descuento" := rCab."Dto Colegio";
        END;
    end;
}

