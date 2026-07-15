page 34002113 "Lista de conceptos salariales"
{
    Editable = false;
    PageType = List;
    SourceTable = 34002111;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Shortcut Dimension"; "Shortcut Dimension")
                {
                }
                field(Codigo; Codigo)
                {
                }
                field(Descripcion; Descripcion)
                {
                }
                field("Tipo Cuenta Cuota Obrera"; "Tipo Cuenta Cuota Obrera")
                {
                }
                field("No. Cuenta Cuota Obrera"; "No. Cuenta Cuota Obrera")
                {
                }
                field("Tipo Cuenta Cuota Patronal"; "Tipo Cuenta Cuota Patronal")
                {
                }
                field("No. Cuenta Cuota Patronal"; "No. Cuenta Cuota Patronal")
                {
                }
                field("Tipo concepto"; "Tipo concepto")
                {
                    Visible = false;
                }
                field("Imprimir descripcion"; "Imprimir descripcion")
                {
                    Visible = false;
                }
                field(Provisionar; Provisionar)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Alta/modificacion")
            {
                Caption = '&Alta/modificacion';
                Enabled = false;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 34002110;
                RunPageLink = "Shortcut Dimension" = FIELD("Shortcut Dimension"),
                              Descripcion = FIELD(Descripcion);
                Visible = false;
            }
            action("&Listado")
            {
                Caption = '&Listado';
                Ellipsis = true;
                Enabled = false;
                Promoted = true;
                PromotedCategory = Process;
                //TODO: Ver RunObject = Report 34002102;
                Visible = false;
            }
        }
    }
}

