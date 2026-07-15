page 34002179 "Mov. Novedades"
{
    DataCaptionFields = "Tipo de accion", "Emitir documento";
    Editable = false;
    PageType = List;
    SourceTable = 34002114;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Editar salario"; "Editar salario")
                {
                }
                field("Tipo de accion"; "Tipo de accion")
                {
                    Visible = false;
                }
                field(Codigo; Codigo)
                {
                    Visible = false;
                }
                field("Emitir documento"; "Emitir documento")
                {
                    Visible = false;
                }
                field("ID Documento"; "ID Documento")
                {
                }
                field("Editar cargo"; "Editar cargo")
                {
                }
                field("Transferir entre empresas"; "Transferir entre empresas")
                {
                }
                field("Pagar preaviso"; "Pagar preaviso")
                {
                }
                field("Pagar cesantia"; "Pagar cesantia")
                {
                }
            }
        }
    }

    actions
    {
    }
}

