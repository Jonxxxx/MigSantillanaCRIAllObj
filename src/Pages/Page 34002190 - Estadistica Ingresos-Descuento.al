page 55831 "Estadistica Ingresos-Descuento"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 55756;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Concepto salarial"; Rec."Concepto salarial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Concepto salarial';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Importe Acumulado"; Rec."Importe Acumulado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Acumulado';
                }
            }
        }
    }

    actions
    {
    }
}

