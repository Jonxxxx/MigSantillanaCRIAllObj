table 34002140 "Comentarios nomina"
{
    LookupPageID = 34002172;

    fields
    {
        field(1; Tipo; Option)
        {
            OptionMembers = "Empresa cotizacion",Empleado,Convenios;
        }
        field(2; "Codigo"; Code[15])
        {
        }
        field(3; "No. Orden"; Integer)
        {
        }
        field(4; Fecha; Date)
        {
        }
        field(5; Usuario; Code[60])
        {
        }
        field(6; Texto; Text[80])
        {
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

