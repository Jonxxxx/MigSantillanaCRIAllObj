page 55026 "Catalago CAByS"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Catálago CAByS';
    PageType = List;
    SourceTable = 55026;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo CABYS"; Rec."Codigo CABYS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo CABYS';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Tipo CABYS"; Rec."Tipo CABYS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo CABYS';
                }
                field("Tarifa IVA"; Rec."Tarifa IVA")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tarifa IVA';
                }
                field("Tipo Impuesto"; Rec."Tipo Impuesto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Impuesto';
                }
            }
        }
    }

    actions
    {
    }
}

