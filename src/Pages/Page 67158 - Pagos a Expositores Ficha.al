page 67158 "Pagos a Expositores Ficha"
{
    PageType = Card;
    SourceTable = 67098;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wEdit;
                field("Cod. Expositor"; Rec."Cod. Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Expositor';
                }
                field("Nombre Expositor"; Rec."Nombre Expositor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Expositor';
                    Editable = false;
                }
                field(Fecha; Rec.Fecha)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha';
                }
                field("Tipo Documento"; Rec."Tipo Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento';
                }
                field("No. Documento"; Rec."No. Documento")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento';
                }
                field("Estado Pago"; Rec."Estado Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Estado Pago';
                }
            }
            part(Subform; 67159)
            {
                Caption = 'Detalle';
                Editable = wEdit;
                Enabled = wEdit;
                SubPageLink = "ID Pago" = FIELD("ID Pago");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1000000011>")
            {
                Caption = 'Pagos';
                action("<Action1000000010>")
                {
                    Caption = '&Pagar';
                    Enabled = wPendiente;
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text001: Label 'Importe del pago: %1. \Eventos incluidos: %2. \¿Desea continuar con el pago?';
                        Error001: Label 'No se ha ingresado ningun evento en este pago.';
                    begin
                        CurrPage.SAVERECORD;
                        CALCFIELDS(Importe, "Numero Eventos");
                        TESTFIELD("Cod. Expositor");
                        TESTFIELD(Fecha);
                        TESTFIELD("Tipo Documento");
                        TESTFIELD("No. Documento");
                        IF ("Numero Eventos" = 0) THEN
                            ERROR(Error001);
                        IF CONFIRM(STRSUBSTNO(Text001, Importe, "Numero Eventos")) THEN BEGIN
                            "Estado Pago" := "Estado Pago"::Pagado;
                            PagoEventos();
                            Estado;
                        END;
                    end;
                }
                action("<Action1000000012>")
                {
                    Caption = '&Retroceder Pagado';
                    Enabled = NOT wPendiente;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text001: Label 'Importe del pago: %1. \Eventos incluidos: %2. \¿Desea retroceder el pago?';
                    begin
                        CALCFIELDS(Importe, "Numero Eventos");
                        IF CONFIRM(STRSUBSTNO(Text001, Importe, "Numero Eventos")) THEN BEGIN
                            "Estado Pago" := "Estado Pago"::Pendiente;
                            RetrocederPagoEventos();
                            Estado;
                        END;
                    end;
                }
                action(Estadisticas)
                {
                    Caption = 'Estadisticas';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text001: Label 'Importe del pago: %1. \Eventos incluidos: %2.';
                    begin
                        CALCFIELDS(Importe, "Numero Eventos");
                        MESSAGE(STRSUBSTNO(Text001, Importe, "Numero Eventos"));
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Estado;
    end;

    var
        [InDataSet]
        wEdit: Boolean;
        [InDataSet]
        wPendiente: Boolean;

    procedure Estado()
    begin
        IF "Estado Pago" = "Estado Pago"::Pendiente THEN BEGIN
            wEdit := TRUE;
            wPendiente := TRUE;
        END
        ELSE BEGIN
            wEdit := FALSE;
            wPendiente := FALSE;
        END;
    end;
}

