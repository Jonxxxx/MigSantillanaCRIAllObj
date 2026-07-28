page 34002182 "Informacion del empleado"
{
    Caption = 'Informacion del empleado';
    PageType = CardPart;
    SourceTable = 5200;

    layout
    {
        area(content)
        {
            // TODO: Manual review - The disabled block uses the removed Employee.Picture field and unrelated sales drill-down pages, so its intended FactBox behavior is not verifiable.
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
        // TODO: Manual review - The verified payroll codeunit declaration is used only by the unresolved Employee.Picture FactBox block.
        // Original code: CUNomina: Codeunit 34002104;
}

