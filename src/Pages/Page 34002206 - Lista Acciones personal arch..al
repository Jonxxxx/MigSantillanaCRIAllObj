page 34002206 "Lista Acciones personal arch."
{
    Caption = 'Archived Personal Actions List';
    CardPageID = "Lista planificacion  entrenam";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 34002178;

    layout
    {
        area(content)
        {
            repeater(Group)
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
            }
        }
    }

    actions
    {
    }
}

