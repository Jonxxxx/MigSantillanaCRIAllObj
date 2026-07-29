table 34002125 "Motivos acciones personal"
{
    Caption = 'Reason personnel action';
    DataPerCompany = false;

    fields
    {
        field(1; "Tipo de accion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo de accion';
            OptionCaption = ' ,Hiring,Change,Quit';
            OptionMembers = " ",Ingreso,Cambio,Salida;
        }
        field(2; Codigo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; Descripcion; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(4; "Emitir documento"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Emitir documento';
        }
        field(5; "ID Documento"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Documento';
        }
    }

    keys
    {
        key(Key1; "Tipo de accion", Codigo)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Incentivo: Record 34002126;
}

