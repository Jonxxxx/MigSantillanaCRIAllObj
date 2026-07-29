table 34002104 "Grupos Contables Empleados"
{
    DataCaptionFields = "Codigo";
    DrillDownPageID = 34002140;
    LookupPageID = 34002140;

    fields
    {
        field(1; "Codigo"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Descripcion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion';
        }
        field(3; "Excluir contabilizacion"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Excluir contabilizacion';
        }
    }

    keys
    {
        key(Key1; "Codigo")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Codigo", "Descripcion")
        {
        }
    }
}

