page 67140 "Asistencia Docentes x Colegio"
{
    CardPageID = "Solicitud asistencia Tec - Ped";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table67055;
    SourceTableView = SORTING(No. Solicitud)
                      WHERE(Status=CONST(Realizada));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No. Solicitud";"No. Solicitud")
                {
                }
                field("Cod. Colegio";"Cod. Colegio")
                {
                }
                field("Nombre Colegio";"Nombre Colegio")
                {
                }
                field("Cod. Local";"Cod. Local")
                {
                }
                field("Cod. Nivel";"Cod. Nivel")
                {
                }
                field("Codigo Distrito Colegio";"Codigo Distrito Colegio")
                {
                }
                field("Nombre Distrito Colegio";"Nombre Distrito Colegio")
                {
                }
                field("KPI Status";"KPI Status")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Status;Status)
                {
                }
                field("Cod. evento programado";"Cod. evento programado")
                {
                }
                field("Descripción evento programado";"Descripción evento programado")
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
                action("<Action1000000025>")
                {
                    Caption = '&Asistencia';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 67101;
                    RunPageLink = No. Solicitud=FIELD(No. Solicitud);
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF CodPromotor <> '' THEN
           BEGIN
            SETRANGE("Cod. promotor",CodPromotor);
           END;
    end;

    var
        CodPromotor: Code[20];

    procedure RecibeParam(CodProm: Code[20])
    begin
        CodPromotor := CodProm;
    end;
}

