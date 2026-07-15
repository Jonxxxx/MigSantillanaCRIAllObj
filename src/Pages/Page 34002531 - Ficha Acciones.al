page 34002531 "Ficha Acciones"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    SourceTable = 34002512;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID Accion"; "ID Accion")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo Accion"; "Tipo Accion")
                {
                }
                field("Necesita Datos"; "Necesita Datos")
                {
                    Editable = false;
                }
                field("Tipo Datos"; "Tipo Datos")
                {
                    BlankZero = true;
                }
                field("Literal Pedir Datos"; "Literal Pedir Datos")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

