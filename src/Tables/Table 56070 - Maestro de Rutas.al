table 55290 "Maestro de Rutas"
{
    // #29481  03/09/2015  FAA   Creada para este desarrollo.


    fields
    {
        field(1; Codigo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Codigo';
        }
        field(2; "Nombre de Ruta"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre de Ruta';
        }
    }

    keys
    {
        key(Key1; Codigo)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Codigo, "Nombre de Ruta")
        {
        }
    }

    trigger OnDelete()
    begin
        recRutasDistribucion.SETRANGE(Code, Codigo);
        IF recRutasDistribucion.FINDSET THEN
            ERROR(Error001);
    end;

    trigger OnRename()
    begin
        ERROR(Error002);
    end;

    var
        recRutasDistribucion: Record 55291;
        Error001: Label 'Este Codigo de Ruta tiene Lineas asociadas.';
        Error002: Label 'No se puede renombrar el Codigo de la ruta, ya que peude tener Documentos asociados';
}

