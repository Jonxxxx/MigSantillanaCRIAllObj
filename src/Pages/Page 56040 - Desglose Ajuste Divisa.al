page 56040 "Desglose Ajuste Divisa"
{
    PageType = List;
    SourceTable = 56060;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Divisa"; Rec."Cod. Divisa")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Divisa';
                }
                field("Grupo Contable"; Rec."Grupo Contable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Contable';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("Dimension SET ID"; Rec."Dimension SET ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dimension SET ID';
                }
                field("No. Mov. Detallado Prov"; Rec."No. Mov. Detallado Prov")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mov. Detallado Prov';
                }
                field("No. Mov. Proveedor"; Rec."No. Mov. Proveedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Mov. Proveedor';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field(Importe; Rec.Importe)
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe';
                }
                field("Tipo Movimiento"; Rec."Tipo Movimiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Movimiento';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Ejecutar)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    REPORT.RUNMODAL(56031, TRUE, FALSE);
                end;
            }
        }
    }
}

