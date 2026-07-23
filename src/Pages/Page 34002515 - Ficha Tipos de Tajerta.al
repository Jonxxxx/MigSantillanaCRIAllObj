page 34002515 "Ficha Tipos de Tajerta"
{
    PageType = Card;
    SourceTable = 34002515;

    layout
    {
        area(content)
        {
            group(GeneralGroup)
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
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
        cfComunes: Codeunit 34002503;
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

