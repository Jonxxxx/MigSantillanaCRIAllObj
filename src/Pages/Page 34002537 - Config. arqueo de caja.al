page 34002537 "Config. arqueo de caja"
{
    PageType = List;
    SourceTable = 34002527;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. divisa"; "Cod. divisa")
                {
                }
                field(Tipo; Tipo)
                {
                }
                field(Importe; Importe)
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
        //TODO: Ver cfComunes: Codeunit 34002503;
        Error001: Label 'Funcion Solo Disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

