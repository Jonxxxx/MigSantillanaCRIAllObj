page 67178 "Estado Pago Expo. Eve. Planif."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 67051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Expositor; Expositor)
                {
                    Editable = false;
                }
                field("Nombre Expositor"; "Nombre Expositor")
                {
                    Editable = false;
                }
                field("No. Solicitud"; "No. Solicitud")
                {
                }
                field("Tipo Evento"; "Tipo Evento")
                {
                    Editable = false;
                }
                field("Cod. Taller-Evento"; "Cod. Taller - Evento")
                {
                    Editable = false;
                }
                field("Description Taller"; "Description Taller")
                {
                    Editable = false;
                }
                field(Secuencia; Secuencia)
                {
                    Editable = false;
                }
                field(wTextCostos; wTextCostos)
                {
                    Caption = 'Centro Costos';
                    Editable = false;
                }
                field(wImporte; wImporte)
                {
                    Caption = 'Importe estimado s/ tarifa';
                    Editable = false;
                }
                field(Pagado; Pagado)
                {
                    Editable = false;
                }
                field("Tipo Documento Pago"; "Tipo Documento Pago")
                {
                    Editable = false;
                }
                field("No. Documento Pago"; "No. Documento Pago")
                {
                    Editable = false;
                }
                field("Importe pago"; "Importe pago")
                {
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Programación"; 67164)
            {
                Caption = 'Programación';
                Editable = false;
                SubPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                              "Tipo Evento" = FIELD("Tipo Evento"),
                              "Tipo de Expositor" = FIELD("Tipo de Expositor"),
                              "Expositor" = FIELD("Expositor"),
                              "Secuencia" = FIELD("Secuencia");
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        recCostos: Record 67086;
    begin
        wTextCostos := '';
        IF "No. Solicitud" <> '' THEN BEGIN
            recCostos.SETRANGE("No. Solicitud", "No. Solicitud");
        END
        ELSE BEGIN
            recCostos.SETRANGE("Cod. Taller - Evento", "Cod. Taller - Evento");
            recCostos.SETRANGE("Tipo Evento", "Tipo Evento");
            recCostos.SETRANGE(Expositor, Expositor);
            recCostos.SETRANGE(Secuencia, Secuencia);
        END;
        IF recCostos.FINDSET THEN
            REPEAT
                IF recCostos.Porcentaje <> 0 THEN
                    wTextCostos := wTextCostos + recCostos.Codigo + ' (' + FORMAT(recCostos.Porcentaje) + '%) ';
            UNTIL recCostos.NEXT = 0;

        wImporte := 0;
        wImporte := CalculaMonto();
    end;

    var
        wTextCostos: Text[150];
        wImporte: Decimal;
}

