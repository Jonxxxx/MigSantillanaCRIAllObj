page 67046 "Lista Colegio - Asignatura"
{
    ApplicationArea = Basic, Suite, Service;
    DataCaptionFields = "Codigo Colegio", "Descripcion Colegio";
    PageType = Card;
    SourceTable = 67042;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Codigo Colegio"; Rec."Codigo Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Colegio';
                    Visible = false;
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. local"; Rec."Cod. local")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. local';
                }
                field("Cod. Docente"; Rec."Cod. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Docente';
                }
                field("Descripcion Colegio"; Rec."Descripcion Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Colegio';
                    Visible = false;
                }
                field("Nombre docente"; Rec."Nombre docente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre docente';
                }
                field("Cod. especialidad"; Rec."Cod. especialidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. especialidad';
                }
                field("Pertenece al CDS"; Rec."Pertenece al CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pertenece al CDS';
                }
                field("Fecha inscripcion CDS"; Rec."Fecha inscripcion CDS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha inscripcion CDS';
                }
                field("Cod. nivel de decision"; Rec."Cod. nivel de decision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. nivel de decision';
                }
                field("Cod. Cargo"; Rec."Cod. Cargo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Cargo';
                }
                field("Descripcion puesto"; Rec."Descripcion puesto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion puesto';
                }
                field(Observacion; Rec.Observacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observacion';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
            }
        }
    }

    actions
    {
    }
}

