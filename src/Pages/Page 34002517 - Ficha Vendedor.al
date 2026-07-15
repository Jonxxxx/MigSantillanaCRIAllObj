page 34002517 "Ficha Vendedor"
{
    DelayedInsert = true;
    SourceTable = 34002517;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Tienda; Tienda)
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Nombre; Nombre)
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
        Error001: Label 'Funcion Solo disponible en Servidor Central';
    begin

        //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(Error001);
    end;
}

