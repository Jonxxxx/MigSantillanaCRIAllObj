table 55745 "Grupos Contables Empleados"
{
    DataCaptionFields = "Codigo";
    DrillDownPageID = 55781;
    LookupPageID = 55781;

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

