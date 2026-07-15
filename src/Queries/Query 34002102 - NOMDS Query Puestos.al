query 34002102 "NOMDS Query Puestos"
{
    Caption = 'Job position query';

    elements
    {
        dataitem(Puestos_laborales; 34002110)
        {
            column(Cod_departamento; "Cod. departamento")
            {
            }
            column("Codigo"; "Codigo")
            {
            }
            column("Descripcion"; "Descripcion")
            {
            }
            column(Cod_nivel; "Cod. nivel")
            {
            }
            column(Cod_Supervisor; "Cod. Supervisor")
            {
            }
            column(Nombre_Completo; "Nombre Completo")
            {
            }
            column(Maximo_de_posiciones; "Maximo de posiciones")
            {
            }
            column(Total_Empleados; "Total Empleados")
            {
            }
            dataitem(Employee; 5200)
            {
                DataItemLink = "Job Type Code" = Puestos_laborales.Codigo;
                column(Company; Company)
                {
                }
            }
        }
    }
}

