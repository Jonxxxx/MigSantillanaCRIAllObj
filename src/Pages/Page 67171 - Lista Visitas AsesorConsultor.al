page 55630 "Lista Visitas Asesor/Consultor"
{
    ApplicationArea = All;
    CardPageID = "Ficha Visitas Asesor/Consultor";
    PageType = List;
    SourceTable = 55561;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No. Visita Asesor/Consultor"; Rec."No. Visita Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Visita Asesor/Consultor';
                }
                field("Fecha Registro"; Rec."Fecha Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Registro';
                }
                field("Hora Registro"; Rec."Hora Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Hora Registro';
                }
                field("Usuario Registro"; Rec."Usuario Registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Usuario Registro';
                }
                field("Cod. Asesor/Consultor"; Rec."Cod. Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Asesor/Consultor';
                }
                field("Nombre Asesor/Consultor"; Rec."Nombre Asesor/Consultor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Asesor/Consultor';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Grupo Negocio"; Rec."Grupo Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo Negocio';
                }
                field("Tipo Visita"; Rec."Tipo Visita")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Visita';
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field("Direccion Colegio"; Rec."Direccion Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Direccion Colegio';
                }
                field("Distrito Colegio"; Rec."Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Distrito Colegio';
                }
                field("Telefono 1 Colegio"; Rec."Telefono 1 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 1 Colegio';
                }
                field("Telefono 2 Colegio"; Rec."Telefono 2 Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Telefono 2 Colegio';
                }
                field("Cod. promotor"; Rec."Cod. promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. promotor';
                }
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Tipo Persona Contacto"; Rec."Tipo Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Persona Contacto';
                }
                field("Cod. Persona Contacto"; Rec."Cod. Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Persona Contacto';
                }
                field("Nombre Persona Contacto"; Rec."Nombre Persona Contacto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Persona Contacto';
                }
                field("No. Asistentes Esperados"; Rec."No. Asistentes Esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes Esperados';
                }
                field("No. Asistentes Reales"; Rec."No. Asistentes Reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Asistentes Reales';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
            }
        }
    }

    actions
    {
    }
}

