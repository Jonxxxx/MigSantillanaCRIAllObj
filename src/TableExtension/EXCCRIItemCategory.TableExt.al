tableextension 50085 EXCCRIItemCategory extends "Item Category"
{
    fields
    {
        field(50000; "Interfaz web"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50007; "EspecificacionSIC"; Text[255])
        {
            DataClassification = CustomerContent;
        }

        field(75000; "Bloqueado"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(75001; "MdM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}
