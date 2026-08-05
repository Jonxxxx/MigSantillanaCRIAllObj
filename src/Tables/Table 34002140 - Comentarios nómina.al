table 55781 "Comentarios nomina"
{
    LookupPageID = 55813;

    fields
    {
        field(1; Tipo; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo';
            OptionMembers = "Empresa cotizacion",Empleado,Convenios;
        }
        field(2; "Codigo"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(3; "No. Orden"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Orden';
        }
        field(4; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(5; Usuario; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Usuario';
        }
        field(6; Texto; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto';
        }
    }

    keys
    {
        key(Key1; Tipo, "Codigo", "No. Orden")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Usuario := USERID;
    end;
}

