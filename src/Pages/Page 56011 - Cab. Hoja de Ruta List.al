page 55236 "Cab. Hoja de Ruta List"
{
    ApplicationArea = Basic, Suite;
    CardPageID = "Cab. Hoja de Ruta";
    Editable = false;
    PageType = List;
    SourceTable = 55245;
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

                ApplicationArea = All;
                Caption = '&Imp. Resumido';
                ToolTip = '&Imp. Resumido';
                trigger OnAction()
                var
                    rCHRL: Record 55245;
                begin
                    CurrPage.SETSELECTIONFILTER(rCHRL);
                    REPORT.RUNMODAL(55248, TRUE, FALSE, rCHRL);
                end;
            }
        }
    }
}

