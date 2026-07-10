xmlport 50003 "Importar Adopciones"
{
    Direction = Import;
    Format = Xml;

    schema
    {
        textelement(ImportarAdopciones1)
        {
            textelement(ImportarAdopciones)
            {
                textelement(FechaAdopcion)
                {
                }
                textelement(CodColegio)
                {
                }
                textelement(CodProducto)
                {
                }
                textelement(CantidadAlumno)
                {
                }
                textelement(CodNivel)
                {
                }
                textelement(CodGrado)
                {
                }
                textelement(Adopcion1)
                {
                }
                textelement(AdopcionReal)
                {
                }
                textelement(CodEditorial)
                {
                }
                textelement(CodProductoEditorial)
                {
                }
                textelement(MotivoPerdida)
                {
                }
                textelement(CodPromotor)
                {
                }

                trigger OnAfterAssignVariable()
                begin
                    IF FechaAdopcion <> '' THEN BEGIN
                        CLEAR(ConvertFecha);
                        EVALUATE(ConvertFecha, FechaAdopcion);
                    END;

                    IF CantidadAlumno <> '' THEN BEGIN
                        CLEAR(ConvertDecimal);
                        EVALUATE(ConvertDecimal, CantidadAlumno);
                    END;

                    CASE Adopcion1 OF
                        '':
                            TipoAdopcion := 0;
                        'Conquista':
                            TipoAdopcion := 1;
                        'Mantener':
                            TipoAdopcion := 2;
                        'Perdida':
                            TipoAdopcion := 3;
                        'No utiliza':
                            TipoAdopcion := 4;
                        'Conpetencia':
                            TipoAdopcion := 5;
                    END;

                    IF AdopcionReal <> '' THEN BEGIN
                        CLEAR(ConvertDecimal);
                        EVALUATE(ConvertDecimal, AdopcionReal);
                    END;

                    Adop.INIT;
                    WITH Adop DO BEGIN
                        "Fecha Adopcion" := ConvertFecha;
                        "Cod. Colegio" := CodColegio;
                        "Cod. Producto" := CodProducto;
                        "Cantidad Alumnos" := ConvertDecimal;
                        "Cod. Nivel" := CodNivel;
                        "Cod. Grado" := CodGrado;
                        Adopcion := TipoAdopcion;
                        "Adopcion Real" := ConvertDecimal;
                        "Cod. Editorial" := CodEditorial;
                        "Cod. Producto Editora" := CodProductoEditorial;
                        "Motivo perdida adopcion" := MotivoPerdida;
                        "Cod. Promotor" := CodPromotor;
                        INSERT;
                    END;

                    CLEAR(ConvertFecha);
                    CodColegio := '';
                    CodProducto := '';
                    CantidadAlumno := '';
                    CodNivel := '';
                    CodGrado := '';
                    Adopcion1 := '';
                    AdopcionReal := '';
                    CodEditorial := '';
                    CodProductoEditorial := '';
                    MotivoPerdida := '';
                    CodPromotor := '';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        ConvertFecha: Date;
        Adop Record: 50008;
        ConvertDecimal: Decimal;
        TipoAdopcion: Integer;
}

