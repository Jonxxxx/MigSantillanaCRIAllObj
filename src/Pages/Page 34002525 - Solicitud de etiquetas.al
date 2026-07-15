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
                field("ID Reporte"; "ID Reporte")
                {
                }
                field("Nombre reporte"; "Nombre reporte")
                {
                }
                field(Confirmada; Confirmada)
                {
                }
                field(Cantidad; Cantidad)
                {
                }
                field("Cod. barra"; "Cod. barra")
                {
                }
                field("No. producto"; "No. producto")
                {
                }
                field("Descripcion producto"; "Descripcion producto")
                {
                }
                field("Fecha solicitud"; "Fecha solicitud")
                {
                }
                field(g; '')
                {
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
    //TODO: Ver rObject: Record 2000000001;
    //TODO: Ver cFDsPOS: Codeunit 34002503;
}

