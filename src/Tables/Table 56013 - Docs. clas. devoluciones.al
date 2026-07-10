table 56013 "Docs. clas. devoluciones"
{
    Caption = 'Docs. clasificaci n devoluciones';

    fields
    {
        field(10;"No. clas. devoluciones";Code[20])
        {
            Caption = 'N  clasificaci n devoluciones';
        }
        field(20;"Tipo documento";Option)
        {
            OptionCaption = 'Transferencia,Venta';
            OptionMembers = Transferencia,Venta;
        }
        field(30;"No. documento";Code[20])
        {
        }
        field(40;"Usuario imp.";Code[20])
        {
            Description = 'Para el report en RTC';
        }
        field(50;"Fecha hora imp.";DateTime)
        {
            Description = 'Para el report en RTC';
        }
    }

    keys
    {
        key(Key1;"No. clas. devoluciones","Tipo documento","No. documento")
        {
        }
    }

    fieldgroups
    {
    }
}

