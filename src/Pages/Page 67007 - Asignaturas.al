page 67007 Asignaturas
{
    ApplicationArea = Basic, Suite, Service;
    PageType = List;
    SourceTable = 67007;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field(Nivel; Rec.Nivel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nivel';
                }
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field(Grado; Rec.Grado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado';
                }
                field("Carga horaria"; Rec."Carga horaria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Carga horaria';
                }
            }
        }
    }

    actions
    {
    }
}

