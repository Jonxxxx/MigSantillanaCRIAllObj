page 34002500 "Configuracion General DSPoS"
{
    PageType = Card;
    SourceTable = 34002500;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Nombre libro diario"; "Nombre libro diario")
                {
                }
                field("Nombre seccion diario"; "Nombre seccion diario")
                {
                }
                field(Pais; Pais)
                {
                    BlankZero = true;
                }
                field("Nombre Divisa Local"; "Nombre Divisa Local")
                {
                }
            }
            part(PartPage; 50114)
            {
            }
            part(PartPage1; 50113)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    var
    //TODO: Ver //TODO: Ver cfComunes: Codeunit 34002503;
    begin

        //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
        ERROR(error001);
    end;

    trigger OnOpenPage()
    begin
        IF NOT GET THEN
            INSERT;
    end;

    var
        error001: Label 'Funcion Solo Disponible en Servidor Central';
}

