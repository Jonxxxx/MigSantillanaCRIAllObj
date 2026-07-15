page 67071 "Lista Programacion de eventos"
{
    ApplicationArea = Basic, Suite, Service;
    Caption = 'Solicitud de Asistencia Técnico - Pedagogica';
    PageType = Card;
    SourceTable = 67055;
    SourceTableView = WHERE("Status" = CONST(" "));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Solicitud"; "No. Solicitud")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cod. promotor"; "Cod. promotor")
                {
                    Editable = "Cod. promotorEditable";
                }
                field("Nombre promotor"; "Nombre promotor")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Tipo de Evento"; "Tipo de Evento")
                {
                }
                field("Cod. evento"; "Cod. evento")
                {
                }
                field("Descripcion evento"; "Descripcion evento")
                {
                }
                field(Delegacion; Delegacion)
                {
                }
                field(Observaciones; Observaciones)
                {
                    MultiLine = true;
                }
                field("Fecha Solicitud"; "Fecha Solicitud")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Colegio"; "Nombre Colegio")
                {
                }
                field("Cod. Local"; "Cod. Local")
                {
                }
                field("Cod. Nivel"; "Cod. Nivel")
                {
                }
                field("Cod. Turno"; "Cod. Turno")
                {
                }
                field("Evento programado"; "Evento programado")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Asistentes Esperados"; "Asistentes Esperados")
                {
                }
            }
            group("Event")
            {
                Caption = 'Event';
                field(Sala; Sala)
                {
                }
                field("Horas programadas"; "Horas programadas")
                {
                }
                field("Asistentes Reales"; "Asistentes Reales")
                {
                }
                field("Eventos programados"; "Eventos programados")
                {
                }
                field("Importe Gasto Expositor"; "Importe Gasto Expositor")
                {
                }
                field("Importe Gasto mensajeria"; "Importe Gasto mensajeria")
                {
                }
                field("ImporteGastos Impresion"; "ImporteGastos Impresion")
                {
                }
                field("Importe Utiles"; "Importe Utiles")
                {
                }
                field("Importe Atenciones"; "Importe Atenciones")
                {
                }
                field("Otros Importes"; "Otros Importes")
                {
                }
                field("Nombre responsable"; "Nombre responsable")
                {
                }
                field("No. celular responsable"; "No. celular responsable")
                {
                }
                field("Objetivo promotor"; "Objetivo promotor")
                {
                }
                field("Cod. Expositor"; "Cod. Expositor")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Event")
            {
                Caption = '&Event';
                action("&Send request")
                {
                    Caption = '&Send request';

                    trigger OnAction()
                    begin
                        Status := 1;
                        MODIFY;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Cod. promotorEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF CodPromotor <> '' THEN BEGIN
            UserSetup.GET(USERID);
            SalesPerson.GET(UserSetup."Salespers./Purch. Code");
            IF SalesPerson.Tipo = 0 THEN //Salesperson
               BEGIN
                UserSetup.TESTFIELD("Salespers./Purch. Code");
                VALIDATE("Cod. promotor", UserSetup."Salespers./Purch. Code");
                "Cod. promotorEditable" := FALSE;
            END;
        END;
    end;

    var
        UserSetup: Record 91;
        SalesPerson: Record 13;
        CodPromotor: Code[20];
        [InDataSet]
        "Cod. promotorEditable": Boolean;

    procedure RecibeParam(CodProm: Code[20])
    begin
        CodPromotor := CodProm;
    end;
}

