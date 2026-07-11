page 67102 "Lista Cab. Planif. Evento"
{
    ApplicationArea = Basic, Suite, Service;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Table67051;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Expositor; Expositor)
                {
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                }
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                }
                field("Description Taller"; "Description Taller")
                {
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                }
                field(Secuencia; Secuencia)
                {
                }
                field("Fecha Programada"; "Fecha Programada")
                {
                    Editable = false;
                }
                field("Fecha Realizada"; "Fecha Realizada")
                {
                    Editable = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field(Lunes; Lunes)
                {
                }
                field(Martes; Martes)
                {
                }
                field(Miercoles; Miercoles)
                {
                }
                field(Jueves; Jueves)
                {
                }
                field(Viernes; Viernes)
                {
                }
                field(Sabados; Sabados)
                {
                }
                field(Domingos; Domingos)
                {
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
                    Caption = 'New';
                    Image = NewDocument;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Evento: Record 67011;
                        CabPlanEvent: Record 67051;
                        fCabPlanEvent: Page67101;
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
                separator()
                {
                }
                action(Edit)
                {
                    Caption = 'Edit';
                    Image = Edit;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 67101;
                    RunPageLink = Cod. Taller - Evento=FIELD("Cod. Taller - Evento"),
                                  Tipo Evento=FIELD("Tipo Evento"),
                                  Expositor=FIELD("Expositor"),
                                  Secuencia=FIELD("Secuencia");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        SETRANGE("No. Solicitud", '');

        IF gCodExpositor <> '' THEN
           SETRANGE(Expositor,gCodExpositor);

        IF gCodEvento  <> '' THEN
          SETRANGE("Cod. Taller - Evento",gCodEvento);
    end;

    var
        Fecha: Record 2000000007;
        CabPlanEvent: Record 67051;
        gCodExpositor: Code[20];
        gTipoExpositor: Integer;
        gCodEvento: Code[20];
        gTipoEvento: Code[20];

    procedure RecibeParametros(CodExpositor: Code[20];TipoExpositor: Integer;CodEvento: Code[20];TipoEvento: Code[20])
    begin
        gCodExpositor := CodExpositor;
        gTipoExpositor := TipoExpositor;
        gCodEvento := CodEvento;
        gTipoEvento := TipoEvento;
    end;
}

