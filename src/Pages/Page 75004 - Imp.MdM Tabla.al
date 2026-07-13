page 75004 "Imp.MdM Tabla"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 75004;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Id; Id)
                {
                }
                field("Id Cab."; "Id Cab.")
                {
                }
                field(Operacion; Operacion)
                {
                }
                field("Id Tabla"; "Id Tabla")
                {
                }
                field(Code; Code)
                {
                }
                field("Code MdM"; "Code MdM")
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field(Tipo; Tipo)
                {
                }
                field("Nombre Elemento"; "Nombre Elemento")
                {
                }
                field(Visible; Visible)
                {
                }
                field(Procesado; Procesado)
                {
                }
            }
            part(Campos; 75005)
            {
                Caption = 'Campos';
                SubPageLink = "Id Rel" = FIELD("Id");
            }
        }
    }

    actions
    {
    }
}

