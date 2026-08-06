page 55637 "Estado Pago Expo. Eve. Planif."
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 55518;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("No. Solicitud"; Rec."No. Solicitud")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Solicitud';
                }
                field("Tipo Evento"; Rec."Tipo Evento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Evento';
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
                field(Secuencia; Rec.Secuencia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Secuencia';
                    Editable = false;
                }
                field(wTextCostos; wTextCostos)
                {
                    ApplicationArea = All;
                    Caption = 'Centro Costos';
                    Editable = false;
                }
                field(wImporte; wImporte)
                {
                    ApplicationArea = All;
                    Caption = 'Importe estimado s/ tarifa';
                    Editable = false;
                }
                field(Pagado; Rec.Pagado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pagado';
                    Editable = false;
                }
                field("Tipo Documento Pago"; Rec."Tipo Documento Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Documento Pago';
                    Editable = false;
                }
                field("No. Documento Pago"; Rec."No. Documento Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. Documento Pago';
                    Editable = false;
                }
                field("Importe pago"; Rec."Importe pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe pago';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Programacion"; 55623)
            {
                Caption = 'Programacion';
                Editable = false;
                SubPageLink = "Cod. Taller - Evento" = FIELD("Cod. Taller - Evento"),
                              "Tipo Evento" = FIELD("Tipo Evento"),
                              "Tipo de Expositor" = FIELD("Tipo de Expositor"),
                              "Expositor" = FIELD("Expositor"),
                              "Secuencia" = FIELD("Secuencia");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        recCostos: Record 55648;
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

