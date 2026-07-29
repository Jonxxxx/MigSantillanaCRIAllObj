page 67141 "Colegio - Textos que utilizan"
{
    Editable = false;
    PageType = List;
    SourceTable = 67035;
    SourceTableView = SORTING("Cod. Colegio", Campana, Adopcion, "Cod. Editorial");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Campana; Rec.Campana)
                {
                    ApplicationArea = All;
                    ToolTip = 'Campana';
                }
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
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
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                }
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Cod. Promotor"; Rec."Cod. Promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Promotor';
                }
                field(Seccion; Rec.Seccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seccion';
                }
                field("Cod. Equiv. Santillana"; Rec."Cod. Equiv. Santillana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Equiv. Santillana';
                }
                field("Descripcion Equiv. Santillana"; Rec."Descripcion Equiv. Santillana")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Equiv. Santillana';
                }
                field("Nombre Editorial"; Rec."Nombre Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Editorial';
                }
                field("Cod. producto"; Rec."Cod. producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. producto';
                }
                field("Cod. Producto Editora"; Rec."Cod. Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto Editora';
                }
                field("Nombre Producto Editora"; Rec."Nombre Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Producto Editora';
                }
                field("Nombre Libro"; Rec."Nombre Libro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Libro';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Descripcion Nivel"; Rec."Descripcion Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Nivel';
                }
                field("Descripcion Grado"; Rec."Descripcion Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion Grado';
                }
                field("Fecha Adopcion"; Rec."Fecha Adopcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Adopcion';
                }
                field("Cantidad Alumnos"; Rec."Cantidad Alumnos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Alumnos';
                }
                field("Linea de negocio"; Rec."Linea de negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Linea de negocio';
                }
                field(Familia; Rec.Familia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Familia';
                }
                field("Sub Familia"; Rec."Sub Familia")
                {
                    ApplicationArea = All;
                    ToolTip = 'Sub Familia';
                }
                field(Adopcion; Rec.Adopcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Adopcion';
                }
                field("% Dto. Padres de familia"; Rec."% Dto. Padres de familia")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Padres de familia';
                }
                field("% Dto. Colegio"; Rec."% Dto. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Colegio';
                }
                field("% Dto. Docente"; Rec."% Dto. Docente")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Docente';
                }
                field("% Dto. Feria Padres de familia"; Rec."% Dto. Feria Padres de familia")
                {
                    ApplicationArea = All;
                    ToolTip = '% Dto. Feria Padres de familia';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Textos)
            {
                Caption = 'Textos';
                action("<Action1000000020>")
                {
                    Caption = 'Ver Solo Adopciones';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        verAdopciones;
                    end;
                }
                action("<Action1000000022>")
                {
                    Caption = 'Ver Solo Competencias';
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        verCompetencias;
                    end;
                }
            }
        }
    }

    procedure verAdopciones()
    begin
        SETFILTER(Adopcion, '<>%1', 0);
        SETRANGE("Cod. Editorial");
    end;

    procedure verCompetencias()
    begin
        SETRANGE(Adopcion);
        SETFILTER("Cod. Editorial", '<>%1', '');
    end;
}

