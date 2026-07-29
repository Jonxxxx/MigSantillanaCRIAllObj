page 67140 "Asistencia Docentes x Colegio"
{
    CardPageID = "Solicitud asistencia Tec - Ped";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67055;
    SourceTableView = SORTING("No. Solicitud")
                      WHERE("Status" = CONST(Realizada));

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
                    RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
                    ShortCutKey = 'Shift+F5';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF CodPromotor <> '' THEN BEGIN
            SETRANGE("Cod. promotor", CodPromotor);
        END;
    end;

    var
        CodPromotor: Code[20];

    procedure RecibeParam(CodProm: Code[20])
    begin
        CodPromotor := CodProm;
    end;
}

