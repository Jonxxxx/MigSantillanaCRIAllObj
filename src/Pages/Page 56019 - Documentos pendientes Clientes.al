page 55244 "Documentos pendientes Clientes"
{
    Editable = false;
    PageType = List;
    SourceTable = 55252;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Cliente"; Rec."Cod. Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cliente';
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                }
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("Fecha Vencimiento"; Rec."Fecha Vencimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Vencimiento';
                }
                field("Importe inicial"; Rec."Importe inicial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe inicial';
                }
                field("Importe Pendiente"; Rec."Importe Pendiente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente';
                }
                field("Cod. Divisa"; Rec."Cod. Divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Divisa';
                }
                field("Fecha Ult. Actualizacion"; Rec."Fecha Ult. Actualizacion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Ult. Actualizacion';
                }
                field("No. Doc. Externo"; Rec."No. Doc. Externo")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Doc. Externo';
                }
                field("Importe inicial ($)"; Rec."Importe inicial ($)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe inicial ($)';
                }
                field("Importe Pendiente ($)"; Rec."Importe Pendiente ($)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Pendiente ($)';
                }
            }
        }
    }

    actions
    {
    }
}

