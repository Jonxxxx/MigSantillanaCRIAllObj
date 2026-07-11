page 50026 "Catalago CAByS"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Catálago CAByS';
    PageType = List;
    SourceTable = 50026;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Codigo CABYS"; "Codigo CABYS")
                {
                }
                field(Descripción; Descripción)
                {
                }
                field("Tipo CABYS"; "Tipo CABYS")
                {
                }
                field("Tarifa IVA"; "Tarifa IVA")
                {
                }
                field("Tipo Impuesto"; "Tipo Impuesto")
                {
                }
            }
        }
    }

    actions
    {
    }
}

