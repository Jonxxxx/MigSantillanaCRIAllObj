page 67165 "Lista de Atenciones"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Ficha de Atenciones";
    Editable = false;
    PageType = List;
    SourceTable = 55528;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado';
                }
                field("Id. Usuario"; Rec."Id. Usuario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id. Usuario';
                }
                field("Fecha registro"; Rec."Fecha registro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha registro';
                }
                field("Tipo documento"; Rec."Tipo documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo documento';
                }
                field(Documento; Rec.Documento)
                {
                    ApplicationArea = All;
                    ToolTip = 'Documento';
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
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
                field(Turno; Rec.Turno)
                {
                    ApplicationArea = All;
                    ToolTip = 'Turno';
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Address';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address 2';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field(Distritos; Rec.Distritos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Distritos';
                }
                field(Objetivo; Rec.Objetivo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo';
                }
                field("Area Responsable"; Rec."Area Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Area Responsable';
                }
                field("Cod. Responsable"; Rec."Cod. Responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Responsable';
                }
                field("Nombre responsable"; Rec."Nombre responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre responsable';
                }
                field("Fecha Recepcion Documento"; Rec."Fecha Recepcion Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Recepcion Documento';
                }
            }
        }
    }

    actions
    {
    }
}

