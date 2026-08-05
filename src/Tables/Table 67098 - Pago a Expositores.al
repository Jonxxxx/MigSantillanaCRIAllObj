table 55557 "Pago a Expositores"
{

    fields
    {
        field(1; "ID Pago"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Pago';
        }
        field(2; "Cod. Expositor"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. Expositor';
            TableRelation = "Expositores - aps";

            trigger OnLookup()
            var
                recExp: Record 55488;
                Err001: Label 'No puede modificar el Expositor ya que el pago contiene lineas que no pertenecen a este Expositor. ';
                rDetalle: Record 55558;
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
                rDetalle: Record 55558;
                rExp: Record 55488;
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
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(4; "No. Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento';
        }
        field(5; Importe; Decimal)
        {
            Caption = 'Importe';
            CalcFormula = Sum("Detalle Pago Expositores"."Monto a Pagar" WHERE("ID Pago" = FIELD("ID Pago")));
            FieldClass = FlowField;
        }
        field(6; "Nombre Expositor"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre Expositor';
        }
        field(7; "Estado Pago"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Pago';
            OptionCaption = 'Pendiente,Pagado';
            OptionMembers = Pendiente,Pagado;
        }
        field(8; "Numero Eventos"; Integer)
        {
            Caption = 'Numero Eventos';
            CalcFormula = Count("Detalle Pago Expositores" WHERE("ID Pago" = FIELD("ID Pago")));
            FieldClass = FlowField;
        }
        field(9; "Tipo Documento"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Documento';
            //TODO Ver: TableRelation = "Datos auxiliares".Codigo WHERE("Tipo registro" = CONST('28'));
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
        rDetalle: Record 55558;
        Err001: Label 'No se permite eliminar pagos realizados.';
    begin

        IF "Estado Pago" = "Estado Pago"::Pagado THEN
            ERROR(Err001);

        rDetalle.SETRANGE(rDetalle."ID Pago", "ID Pago");
        rDetalle.DELETEALL;
    end;

    trigger OnInsert()
    var
        recPagos: Record 55557;
    begin

        Fecha := WORKDATE;

        IF recPagos.FINDLAST THEN
            "ID Pago" := recPagos."ID Pago" + 1
        ELSE
            "ID Pago" := 1;
    end;

    procedure PagoEventos()
    var
        rDet: Record 55558;
        rPlanEv: Record 55518;
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
        rDet: Record 55558;
        rPlanEv: Record 55518;
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

