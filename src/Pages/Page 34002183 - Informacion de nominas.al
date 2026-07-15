page 34002183 "Informacion de nominas"
{
    Caption = 'Informacion del empleado';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            //TODO: Ver 
            /*
            field(Novedades; STRSUBSTNO('(%1)', CUNomina.BuscaNominas(Rec)))
            {
                Caption = 'Customer No.';
            }*/
        }
    }

    actions
    {
    }

    var
    //TODO: Ver  CUNomina: Codeunit 34002104;
}

