table 50007 "Datos PRISA"
{

    fields
    {
        field(1;"Area";Code[20])
        {
        }
        field(2;Categoria;Code[20])
        {
        }
        field(3;Tipo;Code[20])
        {
        }
        field(4;Sexo;Option)
        {
            OptionMembers = HOMBRE,MUJER;
        }
        field(5;"Cod. Empleado";Code[20])
        {
        }
        field(6;"Nombre Completo";Text[60])
        {
        }
        field(7;"Sueldos y Salarios";Decimal)
        {
        }
        field(8;"Cargas Sociales";Decimal)
        {
        }
        field(9;Tiempo;Decimal)
        {
        }
        field(10;"Gastos Sociales";Decimal)
        {
        }
        field(11;Indemnizaciones;Decimal)
        {
        }
        field(12;"Bonos y Gratificaciones";Decimal)
        {
        }
        field(13;"Retribuciones Variables";Decimal)
        {
        }
        field(14;"PTU - Gastos Personal";Decimal)
        {
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

