page 67109 "Registrar Asistencias"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Table67051;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Expositor; Expositor)
                {
                    Editable = false;
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                    Editable = false;
                }
                field("Cod. Taller - Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                }
                field("Description Tipo evento"; "Description Tipo evento")
                {
                    Editable = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                }
                field("Fecha Inicio"; "Fecha Inicio")
                {
                    Editable = false;
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field("Numero de sesiones"; "Numero de sesiones")
                {
                    Editable = false;
                }
                field(Lunes; Lunes)
                {
                    Editable = false;
                }
                field(Martes; Martes)
                {
                    Editable = false;
                }
                field(Miercoles; Miercoles)
                {
                    Editable = false;
                }
                field(Jueves; Jueves)
                {
                    Editable = false;
                }
                field(Viernes; Viernes)
                {
                    Editable = false;
                }
                field(Sabados; Sabados)
                {
                    Editable = false;
                }
                field(Domingos; Domingos)
                {
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
                SubPageLink = Cod. Taller - Evento=FIELD("Cod. Taller - Evento"),
                              "Tipo Evento"=FIELD("Tipo Evento"),
                              "Expositor"=FIELD("Expositor"),
                              "Secuencia"=FIELD("Secuencia");
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
                    Caption = 'Edit';
                    Image = Edit;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 67101;
                                    RunPageLink = Cod. Taller - Evento=FIELD("Cod. Taller - Evento"),
                                  "Tipo Evento"=FIELD("Tipo Evento"),
                                  "Expositor"=FIELD("Expositor"),
                                  "Secuencia"=FIELD("Secuencia");
                }
                action("Register Assistants")
                {
                    Caption = 'Register Assistants';
                    Image = OpenWorksheet;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        "ProgT&E"Record 67015;
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
           SETRANGE(Expositor,gCodExpositor);
    end;

    var
        PagAsistentes: Page67110;
                           Fecha: Record 2000000007;
                           CabPlanEvent: Record 67051;
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

