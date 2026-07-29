page 34002525 "Solicitud de etiquetas"
{
    PageType = List;
    SourceTable = 34002525;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID Reporte"; Rec."ID Reporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Reporte';
                }
                field("Nombre reporte"; Rec."Nombre reporte")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre reporte';
                }
                field(Confirmada; Rec.Confirmada)
                {
                    ApplicationArea = All;
                    ToolTip = 'Confirmada';
                }
                field(Cantidad; Rec.Cantidad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad';
                }
                field("Cod. barra"; Rec."Cod. barra")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. barra';
                }
                field("No. producto"; Rec."No. producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. producto';
                }
                field("Descripcion producto"; Rec."Descripcion producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion producto';
                }
                field("Fecha solicitud"; Rec."Fecha solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha solicitud';
                }
                field(g; '')
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Ejecutar impresion")
            {
                Caption = 'Ejecutar impresion';
            }
        }
    }

    var
        // TODO: Manual review - The legacy Object virtual table is unavailable in SaaS, and the DsPOS declaration has no caller in the empty print action.
        // Original code preserved below.
        // rObject: Record 2000000001;
        // cFDsPOS: Codeunit 34002503;
}

