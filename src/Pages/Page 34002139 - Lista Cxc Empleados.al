page 34002139 "Lista Cxc Empleados"
{
    Caption = 'Create employee loan';
    CardPageID = "CxC Empleados";
    PageType = List;
    SourceTable = 34002145;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Préstamo"; "No. Préstamo")
                {
                }
                field("Codigo Empleado"; "Codigo Empleado")
                {
                }
                field("Fecha Registro CxC"; "Fecha Registro CxC")
                {
                }
                field("Tipo CxC"; "Tipo CxC")
                {
                }
                field(Importe; Importe)
                {
                }
                field(Cuotas; Cuotas)
                {
                }
                field("No. Documento"; "No. Documento")
                {
                }
                field(Pendiente; Pendiente)
                {
                }
                field("Tipo Contrapartida"; "Tipo Contrapartida")
                {
                }
                field("Cta. Contrapartida"; "Cta. Contrapartida")
                {
                }
            }
        }
    }

    actions
    {
    }
}

