page 55561 "Lista Cab. Planif. Evento"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = 55518;
    UsageCategory = Lists;

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
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                }
                field("Cod. Taller - Evento"; Rec."Cod. Taller - Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Taller - Evento';
                }
                field("Description Taller"; Rec."Description Taller")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Taller';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
                }
                field("Description Tipo evento"; Rec."Description Tipo evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description Tipo evento';
                }
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                }
                field("Fecha Programada"; Rec."Fecha Programada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Programada';
                    Editable = false;
                }
                field("Fecha Realizada"; Rec."Fecha Realizada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Realizada';
                    Editable = false;
                }
                field("Fecha Inicio"; Rec."Fecha Inicio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Inicio';
                }
                field("Numero de sesiones"; Rec."Numero de sesiones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Numero de sesiones';
                }
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field(Lunes; Rec.Lunes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lunes';
                }
                field(Martes; Rec.Martes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Martes';
                }
                field(Miercoles; Rec.Miercoles)
                {
                    ApplicationArea = All;
                    ToolTip = 'Miercoles';
                }
                field(Jueves; Rec.Jueves)
                {
                    ApplicationArea = All;
                    ToolTip = 'Jueves';
                }
                field(Viernes; Rec.Viernes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Viernes';
                }
                field(Sabados; Rec.Sabados)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sabados';
                }
                field(Domingos; Rec.Domingos)
                {
                    ApplicationArea = All;
                    ToolTip = 'Domingos';
                }
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
                action("<Action1000000039>")
                {
                    ApplicationArea = All;
                    Caption = 'New';
                    ToolTip = 'New';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Evento: Record 55478;
                        CabPlanEvent: Record 55518;
                        fCabPlanEvent: Page 55560;
                        Seq: Integer;
                        IndSkip: Boolean;
                    begin
                        CLEAR(CabPlanEvent);

                        Evento.RESET;
                        Evento.SETRANGE("No.", gCodEvento);
                        Evento.FINDFIRST;

                        CabPlanEvent.VALIDATE("Tipo Evento", Evento."Tipo de Evento");
                        CabPlanEvent.VALIDATE("Cod. Taller - Evento", gCodEvento);
                        CabPlanEvent."Tipo de Expositor" := gTipoExpositor;
                        CabPlanEvent.VALIDATE(Expositor, Expositor);

                        CabPlanEvent.INSERT(TRUE);
                        COMMIT;

                        fCabPlanEvent.SETRECORD(CabPlanEvent);
                        fCabPlanEvent.RUNMODAL;
                        CLEAR(fCabPlanEvent);
                    end;
                }

                action(Edit)
                {
                    ApplicationArea = All;
                    Caption = 'Edit';
                    ToolTip = 'Edit';
                    Image = Edit;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 55560;
                    RunPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                                  "Tipo Evento" = FIELD("Tipo Evento"),
                                  "Expositor" = FIELD("Expositor"),
                                  "Secuencia" = FIELD("Secuencia");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        SETRANGE("No. Solicitud", '');

        IF gCodExpositor <> '' THEN
            SETRANGE(Expositor, gCodExpositor);

        IF gCodEvento <> '' THEN
            SETRANGE("Cod. Taller - Evento", gCodEvento);
    end;

    var
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

