table 34002179 "Parametros Reloj Control Asist"
{
    Caption = 'Time and attendance clock setup';

    fields
    {
        field(1;"Clock ID";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Clock ID';
        }
        field(2;Description;Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3;Provider;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Provider';
            Description = 'Parametros conexion BD SQL externa';
        }
        field(4;"Data Source";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Data Source';
            Description = 'Parametros conexion BD SQL externa';
        }
        field(5;"Initial Catalog";Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Initial Catalog';
            Description = 'Parametros conexion BD SQL externa';
        }
        field(6;User;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'User';
            Description = 'Parametros conexion BD SQL externa';
        }
        field(7;Password;Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
            Description = 'Parametros conexion BD SQL externa';
        }
        field(8;"ID Campo Cod. Empleado";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Campo Cod. Empleado';
        }
        field(9;"ID Campo Cod. tarjeta";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Campo Cod. tarjeta';
        }
        field(10;"ID Campo Fecha registro";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Campo Fecha registro';
        }
        field(11;"ID Campo Hora registro";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Campo Hora registro';
        }
        field(12;"ID Campo ID Equipo";Code[3])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Campo ID Equipo';
        }
        field(13;"Nombre tabla ponchador";Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre tabla ponchador';
        }
        field(14;"Nombre campo filtro de fecha";Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre campo filtro de fecha';
        }
    }

    keys
    {
        key(Key1;"Clock ID")
        {
        }
    }

    fieldgroups
    {
    }
}

