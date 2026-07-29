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
                    ApplicationArea = All;
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
                field("No. entrenamiento"; Rec."No. entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. entrenamiento';
                    Editable = false;
                }
                field("Tipo entrenamiento"; Rec."Tipo entrenamiento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo entrenamiento';
                    Editable = false;
                }
                field(Disponible; Rec.Disponible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Disponible';
                    Editable = false;
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
                    Editable = false;
                }
                field("Cod. Instructor"; Rec."Cod. Instructor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Instructor';
                    Editable = false;
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
                    Editable = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                    Editable = false;
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                    Editable = false;
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                    Editable = false;
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                    Editable = false;
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                    Editable = false;
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                    Editable = false;
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                    Editable = false;
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                    Editable = false;
                }
                field("Asistentes esperados"; Rec."Asistentes esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes esperados';
                    Editable = false;
                }
                field("Total registrados"; Rec."Total registrados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total registrados';
                    Editable = false;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                    Editable = false;
                }
                field("Asistentes reales"; Rec."Asistentes reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes reales';
                    Editable = false;
                }
                field("Area Curricular"; Rec."Area Curricular")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Curricular';
                    Editable = false;
                }
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                    Editable = false;
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field("Hora de Inicio"; Rec."Hora de Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora de Inicio';
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

