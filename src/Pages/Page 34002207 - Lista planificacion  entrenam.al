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
                field("No. entrenamiento"; "No. entrenamiento")
                {
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                }
                field("Titulo entrenamiento"; "Titulo entrenamiento")
                {
                }
                field("Tipo de Instructor"; "Tipo de Instructor")
                {
                }
                field("Cod. Instructor"; "Cod. Instructor")
                {
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field(Lunes; Lunes)
                {
                }
                field(Martes; Martes)
                {
                }
                field(Miercoles; Miercoles)
                {
                }
                field(Jueves; Jueves)
                {
                }
                field(Viernes; Viernes)
                {
                }
                field(Sabados; Sabados)
                {
                }
                field(Domingos; Domingos)
                {
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                }
                field("Total registrados"; "Total registrados")
                {
                }
                field(Estado; Estado)
                {
                }
                field("No. serie"; "No. serie")
                {
                }
                field("Asistentes reales"; "Asistentes reales")
                {
                }
                field("Area Curricular"; "Area Curricular")
                {
                }
                field(Sala; Sala)
                {
                }
                field(Tipo; Tipo)
                {
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

