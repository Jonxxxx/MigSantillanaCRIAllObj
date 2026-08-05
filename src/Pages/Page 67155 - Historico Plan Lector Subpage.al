page 67155 "Historico Plan Lector Subpage"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55555;
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
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
                field("Edit. 1"; Rec."Edit. 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Edit. 1';
                }
                field("Cant. x Alum 1"; Rec."Cant. x Alum 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cant. x Alum 1';
                }
                field("Edit. 2"; Rec."Edit. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Edit. 2';
                }
                field("Cant. x Alum 2"; Rec."Cant. x Alum 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cant. x Alum 2';
                }
                field("Edit. 3"; Rec."Edit. 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Edit. 3';
                }
                field("Cant. x Alum 3"; Rec."Cant. x Alum 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cant. x Alum 3';
                }
                field("Edit. 4"; Rec."Edit. 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Edit. 4';
                }
                field("Cant. x Alum 4"; Rec."Cant. x Alum 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cant. x Alum 4';
                }
                field("Tipo Lectura 1"; Rec."Tipo Lectura 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Lectura 1';
                }
                field("Modalidad Lectura 1"; Rec."Modalidad Lectura 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Modalidad Lectura 1';
                }
                field("Total Obras Compradas x Alumno"; Rec."Total Obras Compradas x Alumno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Obras Compradas x Alumno';
                }
                field("Universo de Titulos u Obras"; Rec."Universo de Titulos u Obras")
                {
                    ApplicationArea = All;
                    ToolTip = 'Universo de Titulos u Obras';
                }
                field("Adopcion real"; Rec."Adopcion real")
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion real';
                }
                field("Porc. Afinidad"; Rec."Porc. Afinidad")
                {
                    ApplicationArea = All;
                    ToolTip = 'Porc. Afinidad';
                    Caption = '% Afinidad';
                }
            }
        }
    }

    actions
    {
    }
}

