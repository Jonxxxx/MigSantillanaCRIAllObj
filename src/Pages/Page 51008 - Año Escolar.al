page 55169 "Año Escolar"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'School Year';
    PageType = List;
    SourceTable = 55174;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Ano"; Rec."Cod. Ano")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Ano';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field("Fecha Desde"; Rec."Fecha Desde")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Desde';
                }
                field("Fecha Hasta"; Rec."Fecha Hasta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Hasta';
                }
            }
        }
    }

    actions
    {
    }
}

