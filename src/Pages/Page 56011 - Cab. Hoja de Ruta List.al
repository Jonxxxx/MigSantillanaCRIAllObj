page 56011 "Cab. Hoja de Ruta List"
{
    ApplicationArea = Basic, Suite;
    CardPageID = "Cab. Hoja de Ruta";
    Editable = false;
    PageType = List;
    SourceTable = 56020;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Hoja Ruta"; "No. Hoja Ruta")
                {
                }
                field("Cod. Transportista"; "Cod. Transportista")
                {
                }
                field("Nombre Transportista"; "Nombre Transportista")
                {
                }
                field("Fecha Planificacion Transporte"; "Fecha Planificacion Transporte")
                {
                }
                field(Comentario; Comentario)
                {
                }
                field(Hora; Hora)
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Imp. Resumido")
            {
                Caption = '&Imp. Resumido';

                trigger OnAction()
                var
                    rCHRL: Record 56020;
                begin
                    CurrPage.SETSELECTIONFILTER(rCHRL);
                    REPORT.RUNMODAL(56023, TRUE, FALSE, rCHRL);
                end;
            }
        }
    }
}

