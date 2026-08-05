page 55477 "Tipos de Eventos"
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 55477;
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
                field("Ingresar grados"; Rec."Ingresar grados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ingresar grados';
                }
                field("Ingresar libros a presentar"; Rec."Ingresar libros a presentar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ingresar libros a presentar';
                }
            }
        }
    }

    actions
    {
    }
}

