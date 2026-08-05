page 55520 "Tipos de documentos personales"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55512;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field("Tipo Factura"; Rec."Tipo Factura")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Factura';
                }
                field("Tax Identification Type"; Rec."Tax Identification Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tax Identification Type';
                }
            }
        }
    }

    actions
    {
    }
}

