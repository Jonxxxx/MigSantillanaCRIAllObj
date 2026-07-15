page 34002507 "Ficha Grupo Cajeros"
{
    DelayedInsert = true;
    Editable = true;
    PageType = Card;
    SourceTable = 34002507;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Tienda)
                {
                }
                field(Grupo; Grupo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Cliente al contado"; "Cliente al contado")
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
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;

    var
    //TODO: Ver cfComunes: Codeunit 34002503;
}

