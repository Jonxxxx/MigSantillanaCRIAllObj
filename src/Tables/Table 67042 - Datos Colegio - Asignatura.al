table 55509 "Datos Colegio - Asignatura"
{

    fields
    {
        field(1; "Codigo Colegio"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo Colegio';
            TableRelation = Contact;
        }
        field(2; "Cod. Nivel"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Nivel';
            TableRelation = "Nivel Educativo";
        }
        field(3; "Cod. local"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. local';
            TableRelation = "Talleres y Eventos - Grados" WHERE("No. Solicitud" = FIELD("Codigo Colegio"));
        }
        field(4; "Cod. Docente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Docente';
            TableRelation = Docentes;
        }
        field(5; "Descripcion Colegio"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Colegio';
        }
        field(6; "Nombre docente"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre docente';
        }
        field(7; "Cod. especialidad"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. especialidad';
        }
        field(8; "Pertenece al CDS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pertenece al CDS';
        }
        field(9; "Fecha inscripcion CDS"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha inscripcion CDS';
        }
        field(10; "Cod. nivel de decision"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. nivel de decision';
        }
        field(11; "Cod. Cargo"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Cargo';
            TableRelation = "Colegio - Adopciones compet." WHERE("Cod. Editorial" = FIELD("Codigo Colegio"));
        }
        field(12; "Descripcion puesto"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion puesto';
        }
        field(13; Observacion; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Observacion';
        }
        field(14; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Active,Bocked';
            OptionMembers = Activo,Bloqueado;
        }
    }

    keys
    {
        key(Key1; "Codigo Colegio", "Cod. Nivel", "Cod. Docente")
        {
        }
    }

    fieldgroups
    {
    }
}

