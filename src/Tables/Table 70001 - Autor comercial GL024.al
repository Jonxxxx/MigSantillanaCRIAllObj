table 55654 "Autor comercial GL024"
{

    fields
    {
        field(1; "ID autor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID autor';
            Description = 'ID de la tabla maestra de autores.';
        }
        field(2; "NIF Autor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NIF Autor';
        }
        field(3; "Nombre comercial"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre comercial';
            Description = 'Nombre autor comercial';
        }
        field(4; "Pseud nimo"; Code[1])
        {
            DataClassification = CustomerContent;
            Caption = 'Pseud nimo';
            Description = 'Marcar con ''X'' en caso de Pseud nimo';
        }
    }

    keys
    {
        key(Key1; "ID autor")
        {
        }
    }

    fieldgroups
    {
    }
}

