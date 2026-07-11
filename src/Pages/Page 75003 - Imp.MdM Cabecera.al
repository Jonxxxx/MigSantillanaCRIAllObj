page 75003 "Imp.MdM Cabecera"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table75003;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Id; Id)
                {
                }
                field(Operacion; Operacion)
                {
                }
                field("Fecha Creacion"; "Fecha Creacion")
                {
                }
                field(id_mensaje; id_mensaje)
                {
                }
                field(sistema_origen; sistema_origen)
                {
                }
                field(pais_origen; pais_origen)
                {
                }
                field(fecha_origen; fecha_origen)
                {
                }
                field(fecha; fecha)
                {
                }
                field(tipo; tipo)
                {
                }
                field(Entrada; Entrada)
                {
                }
                field(Traspasado; Traspasado)
                {
                }
                field(Estado; Estado)
                {
                }
                field("Estado Envio"; "Estado Envio")
                {
                }
                field(Attempt; Attempt)
                {
                }
                field("Texto Error"; "Texto Error")
                {
                    ColumnSpan = 2;
                    RowSpan = 2;
                }
                field("No Tablas"; "No Tablas")
                {
                }
                field("No Tablas Procesadas"; "No Tablas Procesadas")
                {
                }
            }
            part(; 75017)
            {
                SubPageLink = Id Cab.=FIELD("Id");
            }
        }
    }

    actions
    {
    }
}

