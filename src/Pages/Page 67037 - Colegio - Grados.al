page 67037 "Colegio - Grados"
{
    DataCaptionFields = "Cod. Colegio";
    DelayedInsert = true;
    PageType = List;
    SourceTable = 67037;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                    Visible = false;
                }
                field("Cod. Local"; Rec."Cod. Local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Local';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field(Seccion; Rec.Seccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seccion';
                }
                field("Cantidad Secciones"; Rec."Cantidad Secciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Secciones';
                }
                field("Cantidad Alumnos"; Rec."Cantidad Alumnos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Alumnos';
                }
                field("Cantidad Docentes"; Rec."Cantidad Docentes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Docentes';
                }
                field("Lista Utiles"; Rec."Lista Utiles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lista Utiles';
                }
                field("Lista Competencia"; Rec."Lista Competencia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lista Competencia';
                }
                field("Horas Ingles"; Rec."Horas Ingles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas Ingles';
                }
            }
        }
    }

    actions
    {
    }
}

