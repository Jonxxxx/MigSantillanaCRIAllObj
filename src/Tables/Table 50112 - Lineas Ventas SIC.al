table 55111 "Lineas Ventas SIC"
{
    // 
    //  LDP: Luis Jose De La Cruz Paredes
    //  ------------------------------------------------------------------------
    //  No.              Fecha           Firma    Descripcion
    //  ------------------------------------------------------------------------
    //  SIC-JERM         24/07/2023      LDP     SIC-JERM: Se agregan campos [Cupon]


    fields
    {
        field(1; "Tipo documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo documento';
        }
        field(2; "No. documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento';
        }
        field(3; "No. linea"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. linea';
        }
        field(4; "Cod. Cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cliente';
        }
        field(5; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(6; "Cod. Moneda"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Moneda';
        }
        field(7; Cantidad; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cantidad';
        }
        field(8; "Importe descuento"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe descuento';
        }
        field(9; "Precio de venta"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Precio de venta';
        }
        field(10; "Unidad de medida"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Unidad de medida';
        }
        field(11; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
        }
        field(12; "Importe ITBIS Incluido"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe ITBIS Incluido';
        }
        field(13; codproducto; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'codproducto';
            Enabled = true;
        }
        field(14; Transferido; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transferido';
        }
        field(15; ITBIS; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ITBIS';
        }
        field(16; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(17; Origen; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Origen';
            OptionCaption = ' ,Punto de Venta,From Hotel';
            OptionMembers = " ","Punto de Venta","From Hotel";
        }
        field(18; Cupon; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cupon';
            Description = 'LDP:SIC-JERM';
        }
        field(19; "No. documento SIC"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. documento SIC';
        }
    }

    keys
    {
        key(Key1; "Tipo documento", "No. documento", "No. linea", "Location Code", "No. documento SIC")
        {
        }
        key(Key2; "No. documento SIC")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*
        LineasVtasICG.RESET;
        IF LineasVtasICG.FINDLAST THEN
          Id := LineasVtasICG.Id + 1
        ELSE
          Id := 1;
        */

    end;
}

