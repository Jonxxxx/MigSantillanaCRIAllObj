page 55606 "Log Coleg. - Work Flow visitas"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55645;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                }
                field(Resultado; Rec.Resultado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Resultado';
                }
                field(Programado; Rec.Programado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Programado';
                }
                field(Paso; Rec.Paso)
                {
                    ApplicationArea = All;
                    ToolTip = 'Paso';
                }
                field(Detalle; Rec.Detalle)
                {
                    ApplicationArea = All;
                    ToolTip = 'Detalle';
                }
                field(Mantenimiento; Rec.Mantenimiento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mantenimiento';
                }
                field(Conquista; Rec.Conquista)
                {
                    ApplicationArea = All;
                    ToolTip = 'Conquista';
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area';
                }
            }
        }
    }

    actions
    {
    }
}

