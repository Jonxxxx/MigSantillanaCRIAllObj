query 34002101 "NOMDS Query Nominas"
{
    Caption = 'Payroll query';

    elements
    {
        dataitem(Historico_Lin_nomina; 34002118)
        {
            column(No_empleado; "No. empleado")
            {
            }
            column(Nombre; Nombre)
            {
            }
            column("Periodo"; "Periodo")
            {
            }
            column(Tipo_de_nomina; "Tipo de nomina")
            {
            }
            column(Tipo_concepto; "Tipo concepto")
            {
            }
            column("Descripcion"; "Descripcion")
            {
            }
            column(Total; Total)
            {
            }
            column(Departamento; Departamento)
            {
            }
            column(No_Documento; "No. Documento")
            {
            }
            dataitem(Employee; 5200)
            {
                DataItemLink = "No." = Historico_Lin_nomina."No. empleado";
                column(Company; Company)
                {
                }
                dataitem(Departamentos; 34002135)
                {
                    DataItemLink = Codigo = Historico_Lin_nomina.Departamento;
                    column(Depto_Descripcion; Descripcion)
                    {
                    }
                    dataitem(Puestos_laborales; 34002110)
                    {
                        DataItemLink = Codigo = Employee."Job Type Code";
                        column(Cargo_Descripcion; "Descripcion")
                        {
                        }
                    }
                }
            }
        }
    }
}

