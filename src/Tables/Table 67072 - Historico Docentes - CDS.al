table 67072 "Historico Docentes - CDS"
{

    fields
    {
        field(1;Campana;Code[4])
        {
            DataClassification = CustomerContent;
            Caption = 'Campana';
        }
        field(2;"Cod. Docente";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = Docentes;
        }
        field(3;"Pertenece al CDS";Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pertenece al CDS';
        }
        field(4;"Cod. CDS";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. CDS';
        }
        field(5;"Ult. fecha activacion";Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ult. fecha activacion';
        }
        field(6;"Cod. Colegio";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Colegio';
            TableRelation = Contact;
        }
        field(7;"Cod. Nivel";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
        }
    }

    keys
    {
        key(Key1;Campana,"Cod. Docente")
        {
        }
    }

    fieldgroups
    {
    }
}

