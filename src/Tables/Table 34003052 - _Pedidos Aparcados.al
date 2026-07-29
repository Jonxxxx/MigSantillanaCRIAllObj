table 34003052 "_Pedidos Aparcados"
{
    // #217374, RRT, 10.09.19: Se aprovecha este desarrollo para renumerar esta tabla.


    fields
    {
        field(1;"No.";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2;"Numero Cliente";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Cliente';
        }
        field(3;"Numero Colegio";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Numero Colegio';
        }
        field(4;Identificacion;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Identificacion';
        }
        field(5;Nombre;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(6;Direccion;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Direccion';
        }
        field(7;"E-Mail";Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
        }
        field(8;Telefono;Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Telefono';
        }
        field(9;"Tipo Documento";Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
        }
        field(10;"Nombre Colegio";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Colegio';
        }
    }

    keys
    {
        key(Key1;"No.")
        {
        }
    }

    fieldgroups
    {
    }
}

