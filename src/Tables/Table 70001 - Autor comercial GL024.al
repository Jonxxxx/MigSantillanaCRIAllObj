table 70001 "Autor comercial GL024"
{

    fields
    {
        field(1;"ID autor";Code[20])
        {
            Description = 'ID de la tabla maestra de autores.';
        }
        field(2;"NIF Autor";Code[20])
        {
        }
        field(3;"Nombre comercial";Text[100])
        {
            Description = 'Nombre autor comercial';
        }
        field(4;"Pseud nimo";Code[1])
        {
            Description = 'Marcar con ''X'' en caso de Pseud nimo';
        }
    }

    keys
    {
        key(Key1;"ID autor")
        {
        }
    }

    fieldgroups
    {
    }
}

