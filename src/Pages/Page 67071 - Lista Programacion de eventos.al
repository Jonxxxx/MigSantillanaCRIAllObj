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
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Cod. promotor"; Rec."Cod. promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. promotor';
                    Editable = "Cod. promotorEditable";
                }
                field("Nombre promotor"; Rec."Nombre promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre promotor';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                }
                field("Tipo de Evento"; Rec."Tipo de Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de Evento';
                }
                field("Cod. evento"; Rec."Cod. evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. evento';
                }
                field("Descripcion evento"; Rec."Descripcion evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion evento';
                }
                field(Delegacion; Rec.Delegacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Delegacion';
                }
                field(Observaciones; Rec.Observaciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Observaciones';
                    MultiLine = true;
                }
                field("Fecha Solicitud"; Rec."Fecha Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Solicitud';
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
                field("Cod. Turno"; Rec."Cod. Turno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Turno';
                }
                field("Evento programado"; Rec."Evento programado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Evento programado';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status';
                    Editable = false;
                }
                field("Asistentes Esperados"; Rec."Asistentes Esperados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes Esperados';
                }
            }
            group("Event")
            {
                Caption = 'Event';
                field(Sala; Rec.Sala)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sala';
                }
                field("Horas programadas"; Rec."Horas programadas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Horas programadas';
                }
                field("Asistentes Reales"; Rec."Asistentes Reales")
                {
                    ApplicationArea = All;
                    ToolTip = 'Asistentes Reales';
                }
                field("Eventos programados"; Rec."Eventos programados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Eventos programados';
                }
                field("Importe Gasto Expositor"; Rec."Importe Gasto Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gasto Expositor';
                }
                field("Importe Gasto mensajeria"; Rec."Importe Gasto mensajeria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Gasto mensajeria';
                }
                field("ImporteGastos Impresion"; Rec."ImporteGastos Impresion")
                {
                    ApplicationArea = All;
                    ToolTip = 'ImporteGastos Impresion';
                }
                field("Importe Utiles"; Rec."Importe Utiles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Utiles';
                }
                field("Importe Atenciones"; Rec."Importe Atenciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Atenciones';
                }
                field("Otros Importes"; Rec."Otros Importes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Otros Importes';
                }
                field("Nombre responsable"; Rec."Nombre responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre responsable';
                }
                field("No. celular responsable"; Rec."No. celular responsable")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. celular responsable';
                }
                field("Objetivo promotor"; Rec."Objetivo promotor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Objetivo promotor';
                }
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
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

