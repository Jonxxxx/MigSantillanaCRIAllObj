page 67090 "Lista Solicitudes T&E"
{
    ApplicationArea = Basic, Suite, Service;
    CardPageID = "Solicitud asistencia Tec - Ped";
    Editable = false;
    PageType = List;
    SourceTable = 67055;
    SourceTableView = SORTING("Fecha Propuesta");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field("Cod. promotor"; "Cod. promotor")
                {
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                }
                field("Grupo de Negocio"; "Grupo de Negocio")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Tipo de Evento"; "Tipo de Evento")
                {
                }
                field("Existe evento"; "Existe evento")
                {
                }
                field("Cod. evento"; "Cod. evento")
                {
                    Editable = false;
                }
                field("Descripcion evento"; "Descripcion evento")
                {
                }
                field("Evento dictado por (tipo)"; "Evento dictado por (tipo)")
                {
                }
                field("Evento dictado por (codigo)"; "Evento dictado por (codigo)")
                {
                }
                field("Evento dictado por (nombre)"; "Evento dictado por (nombre)")
                {
                }
                field("Grupo de Colegios"; "Grupo de Colegios")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Direccion Colegio"; "Direccion Colegio")
                {
                }
                field(Referencia; Referencia)
                {
                }
                field("Codigo Distrito Colegio"; "Codigo Distrito Colegio")
                {
                }
                field("Nombre Distrito Colegio"; "Nombre Distrito Colegio")
                {
                }
                field("KPI Status"; "KPI Status")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Status; Status)
                {
                }
                field("Fecha Solicitud"; "Fecha Solicitud")
                {
                }
                field("Fecha Propuesta"; "Fecha Propuesta")
                {
                    Caption = 'Fecha Propuesta';
                }
                field("Fecha programada"; "Fecha programada")
                {
                    Caption = 'Fecha Programada';
                }
                field(Delegacion; Delegacion)
                {
                }
                field("Cod. evento programado"; "Cod. evento programado")
                {
                }
                field("Descripcion evento programado"; "Descripcion evento programado")
                {
                }
                field("Tipo de Expositor"; "Tipo de Expositor")
                {
                }
                field("Cod. Expositor"; "Cod. Expositor")
                {
                }
                field("Nombre expositor"; "Nombre expositor")
                {
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
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 67064;
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

