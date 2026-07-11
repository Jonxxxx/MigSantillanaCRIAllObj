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
                field("Cod. Divisa"; "Cod. Divisa")
                {
                }
                field("Grupo Contable"; "Grupo Contable")
                {
                }
                field("Fecha Registro"; "Fecha Registro")
                {
                }
                field("Dimension SET ID"; "Dimension SET ID")
                {
                }
                field("No. Mov. Detallado Prov"; "No. Mov. Detallado Prov")
                {
                }
                field("No. Mov. Proveedor"; "No. Mov. Proveedor")
                {
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field(Tipo; Tipo)
                {
                }
                field(Importe; Importe)
                {
                }
                field("Tipo Movimiento"; "Tipo Movimiento")
                {
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

