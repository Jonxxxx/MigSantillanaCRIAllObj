page 67141 "Colegio - Textos que utilizan"
{
    Editable = false;
    PageType = List;
    SourceTable = 67035;
    SourceTableView = SORTING("Cod. Colegio", Campana, Adopcion, Cod. Editorial);

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Campana; Campana)
                {
                }
                field("Cod. Editorial"; "Cod. Editorial")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Grado"; "Cod. Grado")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field("Cod. Promotor"; "Cod. Promotor")
                {
                }
                field(Seccion; Seccion)
                {
                }
                field("Cod. Equiv. Santillana"; "Cod. Equiv. Santillana")
                {
                }
                field("Descripcion Equiv. Santillana"; "Descripcion Equiv. Santillana")
                {
                }
                field("Nombre Editorial"; "Nombre Editorial")
                {
                }
                field("Cod. producto"; "Cod. producto")
                {
                }
                field("Cod. Producto Editora"; "Cod. Producto Editora")
                {
                }
                field("Nombre Producto Editora"; "Nombre Producto Editora")
                {
                }
                field("Nombre Libro"; "Nombre Libro")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Descripcion Nivel"; "Descripcion Nivel")
                {
                }
                field("Descripcion Grado"; "Descripcion Grado")
                {
                }
                field("Fecha Adopcion"; "Fecha Adopcion")
                {
                }
                field("Cantidad Alumnos"; "Cantidad Alumnos")
                {
                }
                field("Linea de negocio"; "Linea de negocio")
                {
                }
                field(Familia; Familia)
                {
                }
                field("Sub Familia"; "Sub Familia")
                {
                }
                field(Adopcion; Adopcion)
                {
                }
                field("% Dto. Padres de familia"; "% Dto. Padres de familia")
                {
                }
                field("% Dto. Colegio"; "% Dto. Colegio")
                {
                }
                field("% Dto. Docente"; "% Dto. Docente")
                {
                }
                field("% Dto. Feria Padres de familia"; "% Dto. Feria Padres de familia")
                {
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

