page 34002516 "Lista Tipos de Tarjeta"
{
    CardPageID = "Ficha Tipos de Tajerta";
    Editable = false;
    PageType = List;
    SourceTable = 34002515;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
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
        cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

