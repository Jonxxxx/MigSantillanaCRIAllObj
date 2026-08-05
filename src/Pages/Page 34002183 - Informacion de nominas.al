page 55824 "Informacion de nominas"
{
    Caption = 'Informacion del empleado';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            field(Novedades; STRSUBSTNO('(%1)', CUNomina.BuscaNominas(Rec)))
            {
                ApplicationArea = All;
                Caption = 'Customer No.';
            }
        }
    }

    actions
    {
    }

    var
        CUNomina: Codeunit 55745;
}

