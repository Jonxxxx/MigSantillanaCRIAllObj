page 55474 Asignaturas
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = 55474;
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

