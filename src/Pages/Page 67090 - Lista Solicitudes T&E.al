page 55549 "Lista Solicitudes T&E"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Solicitud asistencia Tec - Ped";
    Editable = false;
    PageType = List;
    SourceTable = 55522;
    SourceTableView = SORTING("Fecha Propuesta");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
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
                field("Grupo de Negocio"; Rec."Grupo de Negocio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Negocio';
                }
                field("Cod. Nivel"; Rec."Cod. Nivel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Nivel';
                }
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                }
                field("Existe evento"; Rec."Existe evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Existe evento';
                }
                field("Cod. evento"; Rec."Cod. evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. evento';
                    Editable = false;
                }
                field("Descripcion evento"; Rec."Descripcion evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion evento';
                }
                field("Evento dictado por (tipo)"; Rec."Evento dictado por (tipo)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (tipo)';
                }
                field("Evento dictado por (codigo)"; Rec."Evento dictado por (codigo)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (codigo)';
                }
                field("Evento dictado por (nombre)"; Rec."Evento dictado por (nombre)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento dictado por (nombre)';
                }
                field("Grupo de Colegios"; Rec."Grupo de Colegios")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grupo de Colegios';
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
                field(Referencia; Rec.Referencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Referencia';
                }
                field("Codigo Distrito Colegio"; Rec."Codigo Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo Distrito Colegio';
                }
                field("Nombre Distrito Colegio"; Rec."Nombre Distrito Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Distrito Colegio';
                }
                field("KPI Status"; Rec."KPI Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'KPI Status';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                }
                field("Fecha Solicitud"; Rec."Fecha Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Solicitud';
                }
                field("Fecha Propuesta"; Rec."Fecha Propuesta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Propuesta';
                    Caption = 'Fecha Propuesta';
                }
                field("Fecha programada"; Rec."Fecha programada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha programada';
                    Caption = 'Fecha Programada';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field("Cod. evento programado"; Rec."Cod. evento programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. evento programado';
                }
                field("Descripcion evento programado"; Rec."Descripcion evento programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion evento programado';
                }
                field("Tipo de Expositor"; Rec."Tipo de Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Expositor';
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                }
                field("Nombre expositor"; Rec."Nombre expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre expositor';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Request")
            {
                Caption = '&Request';
                action("&Card")
                {
                    ApplicationArea = All;
                    Caption = '&Card';
                    ToolTip = '&Card';
                    Image = EditLines;
                    RunObject = Page 55531;
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        wFechaProp := GetFechaPropuesta();
        wFechaProg := GetFechaProgramada();
    end;

    trigger OnOpenPage()
    begin
        IF CodPromotor <> '' THEN BEGIN
            SETRANGE("Cod. promotor", CodPromotor);
        END;

        IF (CodPromotor = '') AND (recUsuario.GET(USERID)) THEN
            IF recUsuario."Salespers./Purch. Code" <> '' THEN
                SETRANGE("Cod. promotor", recUsuario."Salespers./Purch. Code");
    end;

    var
        CodPromotor: Code[20];
        wFechaProp: Date;
        wFechaProg: Date;
        recUsuario: Record 91;

    procedure RecibeParam(CodProm: Code[20])
    begin
        CodPromotor := CodProm;
    end;
}

