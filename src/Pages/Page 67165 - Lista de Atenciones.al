page 67165 "Lista de Atenciones"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha de Atenciones";
    Editable = false;
    PageType = List;
    SourceTable = 67061;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Codigo)
                {
                }
                field(Estado; Estado)
                {
                }
                field("Id. Usuario"; "Id. Usuario")
                {
                }
                field("Fecha registro"; "Fecha registro")
                {
                }
                field("Tipo documento"; "Tipo documento")
                {
                }
                field(Documento; Documento)
                {
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
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
                field(Turno; Turno)
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field(Distritos; Distritos)
                {
                }
                field(Objetivo; Objetivo)
                {
                }
                field("Area Responsable"; "Area Responsable")
                {
                }
                field("Cod. Responsable"; "Cod. Responsable")
                {
                }
                field("Nombre responsable"; "Nombre responsable")
                {
                }
                field("Fecha Recepción Documento"; "Fecha Recepcion Documento")
                {
                }
            }
        }
    }

    actions
    {
    }
}

