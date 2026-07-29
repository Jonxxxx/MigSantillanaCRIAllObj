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
                field("No. Hoja Ruta"; Rec."No. Hoja Ruta")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Hoja Ruta';
                }
                field("Cod. Transportista"; Rec."Cod. Transportista")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Transportista';
                }
                field("Nombre Transportista"; Rec."Nombre Transportista")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Transportista';
                }
                field("Fecha Planificacion Transporte"; Rec."Fecha Planificacion Transporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Planificacion Transporte';
                }
                field(Comentario; Rec.Comentario)
                {
                    ApplicationArea = All;
                    ToolTip = 'Comentario';
                }
                field(Hora; Rec.Hora)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
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

