table 67098 "Pago a Expositores"
{

    fields
    {
        field(1; "ID Pago"; Integer)
        {
        }
        field(2; "Cod. Expositor"; Code[20])
        {
            TableRelation = "Expositores - aps";

            trigger OnLookup()
            var
                recExp: Record 67021;
                Err001: Label 'No puede modificar el Expositor ya que el pago contiene lineas que no pertenecen a este Expositor. ';
                rDetalle: Record 67099;
            begin

                IF PAGE.RUNMODAL(0, recExp) = ACTION::LookupOK THEN BEGIN
                    "Cod. Expositor" := recExp."No.";
                    "Nombre Expositor" := recExp.Name;
                    IF "Cod. Expositor" <> '' THEN BEGIN
                        rDetalle.SETRANGE("ID Pago", "ID Pago");
                        rDetalle.SETFILTER("Cod. Expositor", '<>%1', "Cod. Expositor");
                        IF rDetalle.FINDFIRST THEN
                            ERROR(Err001);
                    END;
                END;
            end;

            trigger OnValidate()
            var
                Err001: Label 'No puede modificar el Expositor ya que el pago contiene lineas que no pertenecen a este Expositor. ';
                rDetalle: Record 67099;
                rExp: Record 67021;
            begin

                "Nombre Expositor" := '';
                IF "Cod. Expositor" <> '' THEN BEGIN
                    rDetalle.SETRANGE("ID Pago", "ID Pago");
                    rDetalle.SETFILTER("Cod. Expositor", '<>%1', "Cod. Expositor");
                    IF rDetalle.FINDFIRST THEN
                        ERROR(Err001);
                    IF rExp.GET("Cod. Expositor") THEN
                        "Nombre Expositor" := rExp.Name;

                END;
            end;
        }
        field(3; Fecha; Date)
        {
        }
        field(4; "No. Documento"; Code[20])
        {
        }
        field(5; Importe; Decimal)
        {
            CalcFormula = Sum("Detalle Pago Expositores"."Monto a Pagar" WHERE("ID Pago" = FIELD("ID Pago")));
            FieldClass = FlowField;
        }
        field(6; "Nombre Expositor"; Text[80])
        {
        }
        field(7; "Estado Pago"; Option)
        {
            OptionCaption = 'Pendiente,Pagado';
            OptionMembers = Pendiente,Pagado;
        }
        field(8; "Numero Eventos"; Integer)
        {
            CalcFormula = Count("Detalle Pago Expositores" WHERE("ID Pago" = FIELD("ID Pago")));
            FieldClass = FlowField;
        }
        field(9; "Tipo Documento"; Code[20])
        {
            TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST(28));
        }
    }

    keys
    {
        key(Key1; "ID Pago")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        rDetalle: Record 67099;
        Err001: Label 'No se permite eliminar pagos realizados.';
    begin

        IF "Estado Pago" = "Estado Pago"::Pagado THEN
            ERROR(Err001);

        rDetalle.SETRANGE(rDetalle."ID Pago", "ID Pago");
        rDetalle.DELETEALL;
    end;

    trigger OnInsert()
    var
        recPagos: Record 67098;
    begin

        Fecha := WORKDATE;

        IF recPagos.FINDLAST THEN
            "ID Pago" := recPagos."ID Pago" + 1
        ELSE
            "ID Pago" := 1;
    end;

    procedure PagoEventos()
    var
        rDet: Record 67099;
        rPlanEv: Record 67051;
        Error001: Label 'El evento %1 con secuencia %2 ya fue pagado anteriormente.';
    begin

        rDet.SETRANGE("ID Pago", "ID Pago");
        IF rDet.FINDSET THEN
            REPEAT
                rPlanEv.GET(rDet."Cod. Evento", rDet."Cod. Expositor", rDet.Secuencia);
                IF rPlanEv.Pagado THEN
                    ERROR(STRSUBSTNO(Error001, rDet."Cod. Evento", rDet.Secuencia));
                rPlanEv.Pagado := TRUE;
                rPlanEv."Importe pago" := rDet."Monto a Pagar";
                rPlanEv."No. Documento Pago" := "No. Documento";
                rPlanEv.MODIFY;
            UNTIL rDet.NEXT = 0;
    end;

    procedure RetrocederPagoEventos()
    var
        rDet: Record 67099;
        rPlanEv: Record 67051;
    begin

        rDet.SETRANGE("ID Pago", "ID Pago");
        IF rDet.FINDSET THEN
            REPEAT
                rPlanEv.GET(rDet."Cod. Evento", rDet."Cod. Expositor", rDet.Secuencia);
                rPlanEv.Pagado := FALSE;
                rPlanEv."Importe pago" := 0;
                rPlanEv."No. Documento Pago" := '';
                rPlanEv.MODIFY;
            UNTIL rDet.NEXT = 0;
    end;
}

