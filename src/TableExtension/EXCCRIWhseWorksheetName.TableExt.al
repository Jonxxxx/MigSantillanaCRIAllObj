tableextension 55111 EXCCRIWhseWorksheetName extends "Whse. Worksheet Name"
{
    fields
    {
        modify("Location Code")
        {
            TableRelation = Location where(Inactivo = const(false));
        }
    }
}
