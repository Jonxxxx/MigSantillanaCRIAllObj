page 34002111 "Lista Acciones de personal"
{
    Caption = 'Personnel activities list';
    CardPageID = "Ficha Acciones de personal";
    Editable = false;
    PageType = List;
    SourceTable = 34002133;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo de accion"; "Tipo de accion")
                {
                }
                field("Cod. accion"; "Cod. accion")
                {
                }
                field("No. empleado"; "No. empleado")
                {
                }
                field("Nombre completo"; "Nombre completo")
                {
                }
                field("ID Documento"; "ID Documento")
                {
                }
                field("Descripcion accion"; "Descripcion accion")
                {
                }
                field("Fecha accion"; "Fecha accion")
                {
                }
                field("Fecha efectividad"; "Fecha efectividad")
                {
                }
                field(Comentario; Comentario)
                {
                }
                field("Cargo actual"; "Cargo actual")
                {
                }
                field("Descripcion cargo actual"; "Descripcion cargo actual")
                {
                }
                field("Nuevo cargo"; "Nuevo cargo")
                {
                }
                field("Descripcion cargo nuevo"; "Descripcion cargo nuevo")
                {
                }
                field("Sueldo actual"; "Sueldo actual")
                {
                }
                field("Sueldo Nuevo"; "Sueldo Nuevo")
                {
                }
                field("Departamento actual"; "Departamento actual")
                {
                }
                field("Nombre  depto. actual"; "Nombre  depto. actual")
                {
                }
                field("Departamento nuevo"; "Departamento nuevo")
                {
                }
                field("Nombre depto. nuevo"; "Nombre depto. nuevo")
                {
                }
                field("Ubicacion actual"; "Ubicacion actual")
                {
                }
                field("Ubicacion nueva"; "Ubicacion nueva")
                {
                }
                field("Empresa nueva"; "Empresa nueva")
                {
                }
                field("Numero cuenta actual"; "Numero cuenta actual")
                {
                }
                field("Numero cuenta nueva"; "Numero cuenta nueva")
                {
                }
                field("Nivel actual"; "Nivel actual")
                {
                }
                field("Nivel nuevo"; "Nivel nuevo")
                {
                }
                field("Tipo de contrato"; "Tipo de contrato")
                {
                }
                field("Preparado por"; "Preparado por")
                {
                }
                field("Revisado por"; "Revisado por")
                {
                }
                field("Autorizado por"; "Autorizado por")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Convenio")
            {
                Caption = '&Convenio';
                action(Ficha)
                {
                    Caption = 'Ficha';
                    RunObject = Page 34002140;
                    ShortCutKey = 'Shift+F7';
                }
                action("C&omentarios")
                {
                    Caption = 'C&omentarios';
                    //TODO: Ver RunObject = Page 34002156;
                }
            }
        }
    }
}

