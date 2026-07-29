table 50007 "Datos PRISA"
{

    fields
    {
        field(1;"Area";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Area';
        }
        field(2;Categoria;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Categoria';
        }
        field(3;Tipo;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
        }
        field(4;Sexo;Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sexo';
            OptionMembers = HOMBRE,MUJER;
        }
        field(5;"Cod. Empleado";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Empleado';
        }
        field(6;"Nombre Completo";Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Completo';
        }
        field(7;"Sueldos y Salarios";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sueldos y Salarios';
        }
        field(8;"Cargas Sociales";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cargas Sociales';
        }
        field(9;Tiempo;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tiempo';
        }
        field(10;"Gastos Sociales";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gastos Sociales';
        }
        field(11;Indemnizaciones;Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Indemnizaciones';
        }
        field(12;"Bonos y Gratificaciones";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Bonos y Gratificaciones';
        }
        field(13;"Retribuciones Variables";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Retribuciones Variables';
        }
        field(14;"PTU - Gastos Personal";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PTU - Gastos Personal';
        }
    }

    keys
    {
        key(Key1;"Area",Categoria,Tipo,Sexo,"Cod. Empleado")
        {
        }
    }

    fieldgroups
    {
    }
}

