page 34002207 "Lista planificacion  entrenam"
{
    Caption = 'Training schedule list';
    CardPageID = "Cab. Planif. Entrenamiento";
    Editable = false;
    PageType = List;
    SourceTable = 34002204;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                }
                field("Titulo entrenamiento"; Rec."Titulo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Titulo entrenamiento';
                }
                field("Tipo de Instructor"; Rec."Tipo de Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Instructor';
                }
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                }
                field("Nombre Instructor"; Rec."Nombre Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Instructor';
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                }
                field("Total registrados"; Rec."Total registrados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total registrados';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("No. serie"; Rec."No. serie")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. serie';
                }
                field("Asistentes reales"; Rec."Asistentes reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes reales';
                }
                field("Area Curricular"; Rec."Area Curricular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Curricular';
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 34002246)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No. entrenamiento" = FIELD("No. entrenamiento"),
                              Inscrito = CONST(True);
            }
        }
    }

    actions
    {
    }
}

