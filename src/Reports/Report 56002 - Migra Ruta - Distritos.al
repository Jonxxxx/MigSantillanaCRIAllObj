report 56002 "Migra Ruta - Distritos"
{
    // Proyecto: Microsoft Dynamics Nav
    // ------------------------------------------------------------------------------
    // FES   : Fausto Serrata
    // ------------------------------------------------------------------------------
    // No.             Firma         Fecha           Descripcion
    // ------------------------------------------------------------------------------
    // CPMCR-CEC       FES           08-06-2021      Comentario por migracion Costa Rica. Corregir error compilacion.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Solicitud - Competencia"; 67087)
        {

            trigger OnAfterGetRecord()
            var
                recRut: Record 67009;
            begin

                recRut.INIT;
                recRut."Cod. Ruta" := "Solicitud - Competencia"."No. Solicitud";
                recRut.Description := "Solicitud - Competencia"."Cod. Libro";
                //recRut."Codigo Postal" := "Solicitud - Competencia"."Cod. Editorial";      //CPMCR-CEC+-
                recRut."Name of route" := "Solicitud - Competencia".Description;
                recRut.City := "Solicitud - Competencia"."Cod. Grado";
                recRut.County := "Solicitud - Competencia"."Grupo de Negocio";
                //recRut.Departamento    := "Solicitud - Competencia"."Cod. Libro Santillana";   //CPMCR-CEC+-
                recRut.INSERT;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('fin');
            end;
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

    labels
    {
    }
}

