page 55242 "Cab. Hoja de Ruta Reg. List"
{
    CardPageID = "Cab. Hoja de Ruta Reg.";
    Editable = false;
    PageType = List;
    SourceTable = 55247;

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
                field("Hoja de Ruta Origen"; Rec."Hoja de Ruta Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hoja de Ruta Origen';
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
    }
}

