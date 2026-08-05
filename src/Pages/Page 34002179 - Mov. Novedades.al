page 55820 "Mov. Novedades"
{
    DataCaptionFields = "Tipo de accion", "Emitir documento";
    Editable = false;
    PageType = List;
    SourceTable = 55755;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Editar salario"; Rec."Editar salario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Editar salario';
                }
                field("Tipo de accion"; Rec."Tipo de accion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de accion';
                    Visible = false;
                }
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                    Visible = false;
                }
                field("Emitir documento"; Rec."Emitir documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Emitir documento';
                    Visible = false;
                }
                field("ID Documento"; Rec."ID Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID Documento';
                }
                field("Editar cargo"; Rec."Editar cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Editar cargo';
                }
                field("Transferir entre empresas"; Rec."Transferir entre empresas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Transferir entre empresas';
                }
                field("Pagar preaviso"; Rec."Pagar preaviso")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar preaviso';
                }
                field("Pagar cesantia"; Rec."Pagar cesantia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagar cesantia';
                }
            }
        }
    }

    actions
    {
    }
}

