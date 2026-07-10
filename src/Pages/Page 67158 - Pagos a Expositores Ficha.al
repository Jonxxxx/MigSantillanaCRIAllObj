page 67158 "Pagos a Expositores Ficha"
{
    PageType = Card;
    SourceTable = Table67098;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = wEdit;
                field("Cod. Expositor";"Cod. Expositor")
                {
                }
                field("Nombre Expositor";"Nombre Expositor")
                {
                    Editable = false;
                }
                field(Fecha;Fecha)
                {
                }
                field("Tipo Documento";"Tipo Documento")
                {
                }
                field("No. Documento";"No. Documento")
                {
                }
                field("Estado Pago";"Estado Pago")
                {
                }
            }
            part(Subform;67159)
            {
                Caption = 'Detalle';
                Editable = wEdit;
                Enabled = wEdit;
                SubPageLink = ID Pago=FIELD(ID Pago);
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
                        CALCFIELDS(Importe,"Numero Eventos");
                        TESTFIELD("Cod. Expositor");
                        TESTFIELD(Fecha);
                        TESTFIELD("Tipo Documento");
                        TESTFIELD("No. Documento");
                        IF ("Numero Eventos" = 0) THEN
                          ERROR(Error001);
                        IF CONFIRM(STRSUBSTNO(Text001,Importe,"Numero Eventos")) THEN BEGIN
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
                        CALCFIELDS(Importe,"Numero Eventos");
                        IF CONFIRM(STRSUBSTNO(Text001,Importe,"Numero Eventos")) THEN BEGIN
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
                        CALCFIELDS(Importe,"Numero Eventos");
                        MESSAGE(STRSUBSTNO(Text001,Importe,"Numero Eventos"));
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
        IF  "Estado Pago" = "Estado Pago"::Pendiente THEN BEGIN
          wEdit := TRUE;
          wPendiente := TRUE;
        END
        ELSE BEGIN
          wEdit := FALSE;
          wPendiente  := FALSE;
        END;
    end;
}

