table 55908 "Formas de Pago TPV"
{
    Caption = 'Tender Types POS';
    LookupPageID = 55913;

    fields
    {
        field(1; "ID Pago"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Pago';
            NotBlank = true;
        }
        field(2; Descripcion; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; Activo; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activo';
        }
        field(4; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = Cuenta,Cliente,Proveedor,Banco;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            TableRelation = IF (Tipo = CONST(Cuenta)) "G/L Account"
            ELSE IF (Tipo = CONST(Cliente)) Customer
            ELSE IF (Tipo = CONST(Proveedor)) Vendor
            ELSE IF (Tipo = CONST(Banco)) "Bank Account";
        }
        field(6; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
            TableRelation = Currency;
        }
        field(7; Cambio; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cambio';

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
            DataClassification = CustomerContent;
            Caption = 'Abre cajon';
        }
        field(9; "Filtro Cajero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Cajero';
        }
        field(10; "Filtro Fecha"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Fecha';
        }
        field(11; "Filtro Hora"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Filtro Hora';
        }
        field(12; "Notas de Credito"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Notas de Credito';
        }
        field(13; "Tarjeta Credito"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tarjeta Credito';
        }
        field(14; Devolucion; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Devolucion';
        }
        field(15; "Exencion IVA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Exencion IVA';
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
        rFormPago: Record 55908;
        error001: Label 'Already exist a Change tender type';
}

