table 56050 "Crear Cupon por Lote."
{
    Caption = 'Coupon Lines';

    fields
    {
        field(2; "Cod. Producto"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Producto';
            NotBlank = false;
            TableRelation = Item;

            trigger OnValidate()
            begin
                rProducto.GET("Cod. Producto");
                Descripcion := rProducto.Description;
            end;
        }
        field(3; Descripcion; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Precio Venta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio Venta';
        }
        field(5; "% Descuento Padre"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Descuento Padre';
        }
        field(6; Cantidad; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(7; "Cod. Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact;
        }
        field(8; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
        }
        field(9; "Cod. Promotor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Promotor';
            TableRelation = "Salesperson/Purchaser";
        }
        field(10; Turno; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Turno';

            trigger OnValidate()
            begin

                IF ColAdop.GET("Cod. Colegio", "Cod. Nivel", "Cod. Promotor", Turno) THEN BEGIN

                END;
            end;
        }
        field(11; "Campana"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
            TableRelation = Campaign;
        }
        field(12; "% Descuento Colegio"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = '% Descuento Colegio';
        }
        field(13; "Cod. Grado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Grado';
        }
        field(55230; "Nombre Maestro"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Maestro';
        }
        field(55231; "Dto. Maestro"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Dto. Maestro';
        }
    }

    keys
    {
        key(Key1; "Cod. Producto")
        {
        }
    }

    fieldgroups
    {
    }

    var
        rProducto: Record 27;
        rCabCupon: Record 55170;
        Error001: Label 'Printed Coupon cannot be modified';
        ColAdop: Record 67036;
}

