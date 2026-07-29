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
                field("Shortcut Dimension"; Rec."Shortcut Dimension")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension';
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Tipo Cuenta Cuota Obrera"; Rec."Tipo Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Obrera';
                }
                field("No. Cuenta Cuota Obrera"; Rec."No. Cuenta Cuota Obrera")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Obrera';
                }
                field("Tipo Cuenta Cuota Patronal"; Rec."Tipo Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta Cuota Patronal';
                }
                field("No. Cuenta Cuota Patronal"; Rec."No. Cuenta Cuota Patronal")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Cuenta Cuota Patronal';
                }
                field("Tipo concepto"; Rec."Tipo concepto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo concepto';
                    Visible = false;
                }
                field("Imprimir descripcion"; "Imprimir descripcion")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Provisionar; Rec.Provisionar)
                {
                    ApplicationArea = All;
                    ToolTip = 'Provisionar';
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
                ApplicationArea = All;
                Caption = '&Alta/modificacion';
                ToolTip = '&Alta/modificacion';
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
                ApplicationArea = All;
                Caption = '&Listado';
                ToolTip = '&Listado';
                Ellipsis = true;
                Enabled = false;
                Promoted = true;
                PromotedCategory = Process;
                // TODO: Manual review - Custom report 34002102 is unavailable; the current object with this ID is not a report.
                // Original code: RunObject = Report 34002102;
                Visible = false;
            }
        }
    }
}

