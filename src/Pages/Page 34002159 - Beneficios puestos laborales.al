page 34002159 "Beneficios puestos laborales"
{
    Caption = 'Benefits list';
    PageType = List;
    SourceTable = 34002152;

    layout
    {
        area(content)
        {
            repeater(GeneralRep)
            {
                field("Tipo Beneficio"; Rec."Tipo Beneficio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Beneficio';
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
            }
        }
    }

    actions
    {
    }
}

