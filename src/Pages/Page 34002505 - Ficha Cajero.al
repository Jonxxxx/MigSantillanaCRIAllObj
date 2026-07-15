page 34002505 "Ficha Cajero"
{
    DelayedInsert = true;
    PageType = Card;
    SourceTable = 34002505;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Tienda)
                {
                }
                field(ID; ID)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Grupo Cajero"; "Grupo Cajero")
                {
                }
                field(Contrasena; Contrasena)
                {
                    ExtendedDatatype = Masked;
                }
                field(Tipo; Tipo)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    //TODO: Ver cfComunes: Codeunit 34002503;
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

