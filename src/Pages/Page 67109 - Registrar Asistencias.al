page 67109 "Registrar Asistencias"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55518;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Expositor; Rec.Expositor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Expositor';
                    Editable = false;
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                    Editable = false;
                }
                field("Cod. Taller-Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                    Editable = false;
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                    Editable = false;
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                    Editable = false;
                }
                field("Description Tipo evento"; Rec."Description Tipo evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Tipo evento';
                    Editable = false;
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                    Editable = false;
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                    Editable = false;
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                    Editable = false;
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                    Editable = false;
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                    Editable = false;
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                    Editable = false;
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                    Editable = false;
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                    Editable = false;
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(ConsultaPLanTyE; 67110)
            {
                Editable = false;
                ShowFilter = false;
                SubPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                              "Tipo Evento" = FIELD("Tipo Evento"),
                              "Expositor" = FIELD("Expositor"),
                              "Secuencia" = FIELD("Secuencia");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action1000000038>")
            {
                Caption = '&Event';
                action("<Action1000000022>")
                {
                    ApplicationArea = All;
                    Caption = 'Edit';
                    ToolTip = 'Edit';
                    Image = Edit;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 67101;
                    RunPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                  "Tipo Evento" = FIELD("Tipo Evento"),
                                  "Expositor" = FIELD("Expositor"),
                                  "Secuencia" = FIELD("Secuencia");
                }
                action("Register Assistants")
                {
                    ApplicationArea = All;
                    Caption = 'Register Assistants';
                    ToolTip = 'Register Assistants';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        "ProgT&E": Record 55482;
                    begin
                        CurrPage.ConsultaPLanTyE.PAGE.AbrirPagAsistentes;

                        //CurrPage.ConsultaPLanTyE.FORM.GETRECORD("ProgT&E");
                        //MESSAGE('%1',aa);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETRANGE("No. Solicitud", '');

        IF gCodExpositor <> '' THEN
            SETRANGE(Expositor, gCodExpositor);
    end;

    var
        PagAsistentes: Page 67110;
        Fecha: Record 2000000007;
        CabPlanEvent: Record 55518;
        gCodExpositor: Code[20];
        gTipoExpositor: Integer;
        gCodEvento: Code[20];
        gTipoEvento: Code[20];

    procedure RecibeParametros(CodExpositor: Code[20]; TipoExpositor: Integer; CodEvento: Code[20]; TipoEvento: Code[20])
    begin
        gCodExpositor := CodExpositor;
        gTipoExpositor := TipoExpositor;
        gCodEvento := CodEvento;
        gTipoEvento := TipoEvento;
    end;
}

