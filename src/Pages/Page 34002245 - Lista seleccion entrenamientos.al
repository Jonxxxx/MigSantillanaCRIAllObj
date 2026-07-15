page 34002245 "Lista seleccion entrenamientos"
{
    Caption = 'Training selection list';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 34002204;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Seleccionado; Seleccionado)
                {
                    Caption = 'Selected';

                    trigger OnValidate()
                    begin
                        IF Seleccionado THEN BEGIN
                            CLEAR(Asistentesentrenam);
                            Asistentesentrenam.VALIDATE("No. entrenamiento", "No. entrenamiento");
                            Asistentesentrenam.VALIDATE("Fecha programacion", "Fecha Inicio");
                            Asistentesentrenam.VALIDATE("No. empleado", gCodEmpl);
                            //Asistentesentrenam.VALIDATE("Cod. Instructor");
                            IF Asistentesentrenam.INSERT(TRUE) THEN;
                        END
                        ELSE BEGIN
                            Asistentesentrenam.RESET;
                            Asistentesentrenam.VALIDATE("No. entrenamiento", "No. entrenamiento");
                            Asistentesentrenam.SETRANGE("Tipo entrenamiento", "Tipo entrenamiento");
                            Asistentesentrenam.SETRANGE("Cod. Instructor", "Cod. Instructor");
                            IF Asistentesentrenam.FINDSET(TRUE, FALSE) THEN
                                REPEAT
                                    Asistentesentrenam.DELETE(TRUE);
                                UNTIL Asistentesentrenam.NEXT = 0;
                        END;
                    end;
                }
                field("No. entrenamiento"; "No. entrenamiento")
                {
                    Editable = false;
                }
                field("Tipo entrenamiento"; "Tipo entrenamiento")
                {
                    Editable = false;
                }
                field(Disponible; Disponible)
                {
                    Editable = false;
                }
                field("Titulo entrenamiento"; "Titulo entrenamiento")
                {
                }
                field("Tipo de Instructor"; "Tipo de Instructor")
                {
                    Editable = false;
                }
                field("Cod. Instructor"; "Cod. Instructor")
                {
                    Editable = false;
                }
                field("Nombre Instructor"; "Nombre Instructor")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                    Editable = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                    Editable = false;
                }
                field(Lunes; Lunes)
                {
                    Editable = false;
                }
                field(Martes; Martes)
                {
                    Editable = false;
                }
                field(Miercoles; Miercoles)
                {
                    Editable = false;
                }
                field(Jueves; Jueves)
                {
                    Editable = false;
                }
                field(Viernes; Viernes)
                {
                    Editable = false;
                }
                field(Sabados; Sabados)
                {
                    Editable = false;
                }
                field(Domingos; Domingos)
                {
                    Editable = false;
                }
                field("Asistentes esperados"; "Asistentes esperados")
                {
                    Editable = false;
                }
                field("Total registrados"; "Total registrados")
                {
                    Editable = false;
                }
                field(Estado; Estado)
                {
                    Editable = false;
                }
                field("Asistentes reales"; "Asistentes reales")
                {
                    Editable = false;
                }
                field("Area Curricular"; "Area Curricular")
                {
                    Editable = false;
                }
                field(Sala; Sala)
                {
                    Editable = false;
                }
                field(Tipo; Tipo)
                {
                }
                field("Hora de Inicio"; "Hora de Inicio")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(PartPage; 34002246)
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No. entrenamiento" = FIELD("No. entrenamiento");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Seleccionado := FALSE;
        Asistentesentrenam.RESET;
        Asistentesentrenam.SETRANGE("No. entrenamiento", "No. entrenamiento");
        Asistentesentrenam.SETRANGE("Cod. Instructor", "Cod. Instructor");
        Asistentesentrenam.SETRANGE("No. empleado", gCodEmpl);
        Asistentesentrenam.SETRANGE("Tipo entrenamiento", "Tipo entrenamiento");
        IF Asistentesentrenam.FINDFIRST THEN
            Seleccionado := TRUE;
    end;

    var
        Asistentesentrenam: Record 34002206;
        Seleccionado: Boolean;
        gCodEmpl: Code[20];

    procedure RecibeParametro(CodEmpleado: Code[20])
    begin
        gCodEmpl := CodEmpleado;
    end;
}

