table 67099 "Detalle Pago Expositores"
{

    fields
    {
        field(1; "ID Pago"; Integer)
        {
        }
        field(2; Linea; Integer)
        {
        }
        field(3; "Cod. Expositor"; Code[20])
        {
        }
        field(5; "Num. Solicitud"; Code[20])
        {
            Editable = false;
        }
        field(6; "Cod. Evento"; Code[20])
        {

            trigger OnLookup()
            var
                recCabPlanif Record: 67051;
                pgCabPlanif: Page67161;
                recCabPago Record: 67098;
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
                    "Descripci n Evento" := recCabPlanif."Description Taller";
                    Secuencia := recCabPlanif.Secuencia;
                    "Tipo Evento" := recCabPlanif."Tipo Evento";
                    "Monto a Pagar" := recCabPlanif.CalculaMonto();
                END;
            end;
        }
        field(7; Secuencia; Integer)
        {
            Editable = false;
        }
        field(8; "Monto a Pagar"; Decimal)
        {
        }
        field(9; "Descripci n Evento"; Text[60])
        {
            Editable = false;
        }
        field(10; "Tipo Evento"; Code[20])
        {
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
        recCabPago Record: 67098;
        rDet Record: 67099;
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

