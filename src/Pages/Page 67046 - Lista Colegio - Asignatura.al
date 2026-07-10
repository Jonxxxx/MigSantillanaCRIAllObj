page 67046 "Lista Colegio - Asignatura"
{
    ApplicationArea = Basic,Suite,Service;
    DataCaptionFields = "Codigo Colegio","Descripcion Colegio";
    PageType = Card;
    SourceTable = Table67042;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Codigo Colegio";"Codigo Colegio")
                {
                    Visible = false;
                }
                field("Cod. Nivel";"Cod. Nivel")
                {
                }
                field("Cod. local";"Cod. local")
                {
                }
                field("Cod. Docente";"Cod. Docente")
                {
                }
                field("Descripcion Colegio";"Descripcion Colegio")
                {
                    Visible = false;
                }
                field("Nombre docente";"Nombre docente")
                {
                }
                field("Cod. especialidad";"Cod. especialidad")
                {
                }
                field("Pertenece al CDS";"Pertenece al CDS")
                {
                }
                field("Fecha inscripcion CDS";"Fecha inscripcion CDS")
                {
                }
                field("Cod. nivel de decision";"Cod. nivel de decision")
                {
                }
                field("Cod. Cargo";"Cod. Cargo")
                {
                }
                field("Descripcion puesto";"Descripcion puesto")
                {
                }
                field(Observacion;Observacion)
                {
                }
                field(Status;Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

