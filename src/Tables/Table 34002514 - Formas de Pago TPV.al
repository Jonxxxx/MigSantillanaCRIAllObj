table 34002514 "Formas de Pago TPV"
{
    Caption = 'Tender Types POS';
    //TODO: Ver LookupPageID = 34002519;

    fields
    {
        field(1; "ID Pago"; Code[20])
        {
            Caption = 'Payment ID';
            NotBlank = true;
        }
        field(2; Descripcion; Text[250])
        {
            Caption = 'Description';
        }
        field(3; Activo; Boolean)
        {
            Caption = 'Active';
        }
        field(4; Tipo; Option)
        {
            Caption = 'Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = Cuenta,Cliente,Proveedor,Banco;
        }
        field(5; "No."; Code[20])
        {
            TableRelation = IF (Tipo = CONST(Cuenta)) "G/L Account"
            ELSE IF (Tipo = CONST(Cliente)) Customer
            ELSE IF (Tipo = CONST(Proveedor)) Vendor
            ELSE IF (Tipo = CONST(Banco)) "Bank Account";
        }
        field(6; "Cod. divisa"; Code[10])
        {
            Caption = 'Currency code';
            TableRelation = Currency;
        }
        field(7; Cambio; Boolean)
        {
            Caption = 'Change';

            trigger OnValidate()
            begin
                rFormPago.RESET;
                rFormPago.SETFILTER(rFormPago."ID Pago", '<>%1', "ID Pago");
                rFormPago.SETRANGE(rFormPago.Cambio, TRUE);
                IF rFormPago.FIND('-') THEN
                    ERROR(error001);
            end;
        }
        field(8; "Abre cajon"; Boolean)
        {
            Caption = 'Open Drawer';
        }
        field(9; "Filtro Cajero"; Code[20])
        {
            Caption = 'Cashier Filter';
        }
        field(10; "Filtro Fecha"; Date)
        {
            Caption = 'Date Filter';
        }
        field(11; "Filtro Hora"; Time)
        {
            Caption = 'Time Filter';
        }
        field(12; "Notas de Credito"; Boolean)
        {
        }
        field(13; "Tarjeta Credito"; Boolean)
        {
        }
        field(14; Devolucion; Boolean)
        {
            Caption = 'Return';
        }
        field(15; "Exencion IVA"; Boolean)
        {
            Caption = 'VAT exemption';
        }
    }

    keys
    {
        key(Key1; "ID Pago")
        {
        }
    }

    fieldgroups
    {
    }

    var
        rFormPago: Record 34002514;
        error001: Label 'Already exist a Change tender type';
}

