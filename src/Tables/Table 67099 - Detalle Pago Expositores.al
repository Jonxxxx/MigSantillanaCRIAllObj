table 55558 "Detalle Pago Expositores"
{

    fields
    {
        field(1; "ID Pago"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Pago';
        }
        field(2; Linea; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Linea';
        }
        field(3; "Cod. Expositor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Expositor';
        }
        field(5; "Num. Solicitud"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Num. Solicitud';
            Editable = false;
        }
        field(6; "Cod. Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Evento';

            trigger OnLookup()
            var
                recCabPlanif: Record 55518;
                pgCabPlanif: Page 55620;
                recCabPago: Record 55557;
            begin
                recCabPago.RESET;
                recCabPago.SETRANGE("ID Pago", "ID Pago");
                recCabPago.FINDFIRST;
                recCabPlanif.RESET;
                recCabPlanif.SETRANGE(recCabPlanif.Expositor, recCabPago."Cod. Expositor");
                pgCabPlanif.SETTABLEVIEW(recCabPlanif);
                pgCabPlanif.LOOKUPMODE(TRUE);
                IF pgCabPlanif.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    pgCabPlanif.GETRECORD(recCabPlanif);
                    "Cod. Expositor" := recCabPago."Cod. Expositor";
                    "Num. Solicitud" := recCabPlanif."No. Solicitud";
                    "Cod. Evento" := recCabPlanif."Cod. Taller - Evento";
                    "Descripcion Evento" := recCabPlanif."Description Taller";
                    Secuencia := recCabPlanif.Secuencia;
                    "Tipo Evento" := recCabPlanif."Tipo Evento";
                    "Monto a Pagar" := recCabPlanif.CalculaMonto();
                END;
            end;
        }
        field(7; Secuencia; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Secuencia';
            Editable = false;
        }
        field(8; "Monto a Pagar"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Monto a Pagar';
        }
        field(9; "Descripcion Evento"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Descripcion Evento';
            Editable = false;
        }
        field(10; "Tipo Evento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Evento';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "ID Pago", Linea)
        {
            SumIndexFields = "Monto a Pagar";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        recCabPago: Record 55557;
        rDet: Record 55558;
    begin
        IF recCabPago.GET("ID Pago") THEN
            "Cod. Expositor" := recCabPago."Cod. Expositor";

        rDet.SETRANGE(rDet."ID Pago", "ID Pago");
        IF rDet.FINDLAST THEN
            Linea := rDet.Linea + 1
        ELSE
            Linea := 1;
    end;
}

