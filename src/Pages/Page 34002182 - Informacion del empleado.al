page 34002182 "Informacion del empleado"
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
            field(Picture; Picture)
            {
                Caption = 'Picture';
                ShowCaption = false;
            }
            field(Novedades; STRSUBSTNO('(%1)', CUNomina.BuscaNovedades(Rec)))
            {
                Caption = 'Customer No.';
            }
            field(Cualificaciones; STRSUBSTNO('(%1)', CUNomina.BuscaCualificaciones("No.")))
            {
                Caption = 'Quotes';
                DrillDownPageID = "Sales Quotes";
            }
            field(Dimensiones; STRSUBSTNO('(%1)', CUNomina.BuscaDimensiones("No.")))
            {
                Caption = 'Blanket Orders';
                DrillDownPageID = "Blanket Sales Orders";
            }*/
        }
    }

    actions
    {
    }

    var
    //TODO: Ver CUNomina: Codeunit 34002104;
}

