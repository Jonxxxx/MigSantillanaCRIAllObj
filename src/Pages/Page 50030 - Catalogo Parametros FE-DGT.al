page 55030 "Catalogo Parametros FE-DGT"
{
    Caption = 'Catalogo Parametros FE-DGT';
    PageType = List;
    QueryCategory = '#Basic,#Suite';
    SourceTable = 55030;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Tipo Parametro"; Rec."Tipo Parametro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Parametro';
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
                field(Inactivo; Rec.Inactivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactivo';
                }
                field("Descuento Asumido Fabrica"; Rec."Descuento Asumido Fabrica")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descuento Asumido Fabrica';
                }
            }
        }
    }

    actions
    {
    }
}

