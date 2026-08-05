tableextension 55085 EXCCRIItemCategory extends "Item Category"
{
    fields
    {
        field(55000; "Interfaz web"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55007; "EspecificacionSIC"; Text[255])
        {
            DataClassification = CustomerContent;
        }

        field(55681; "Bloqueado"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(55682; "MdM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}
