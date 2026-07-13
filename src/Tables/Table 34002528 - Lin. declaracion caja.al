table 34002528 "Lin. declaracion caja"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Lín. declaración de caja TPV';

    fields
    {
        field(10;"No. tienda";Code[20])
        {
            Caption = 'Store No.';
            TableRelation = Tiendas;
        }
        field(20;"No. TPV";Code[20])
        {
            Caption = 'POS Terminal No.';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE (Tienda=FIELD(No. tienda));
        }
        field(25;Fecha;Date)
        {
            Caption = 'Fecha';
        }
        field(30;"No. turno";Integer)
        {
            Caption = 'Receipt No.';
        }
        field(40;"Forma de pago";Code[10])
        {
            Caption = 'Tender Type';
            TableRelation = "Formas de Pago";

            trigger OnValidate()
            var
                recTienda: Record "34002503";
                recFormaPago: Record "34002513";
            begin
                //Si se requiere arqueo se marca el campo "arqueo requerido" para copiar la configuración de arqueo.

                "Requiere recueto" := FALSE;
                recTienda.GET("No. tienda");
                recFormaPago.GET("Forma de pago");
                VALIDATE("Cod. divisa", recFormaPago."Cod. divisa");
                IF recTienda."Arqueo de caja obligatorio" THEN
                  "Requiere recueto" := recFormaPago."Realizar recuento";
            end;
        }
        field(50;Descripcion;Text[250])
        {
            Caption = 'Description';
            TableRelation = "Formas de Pago".Descripcion WHERE (ID Pago=FIELD(Forma de pago));
        }
        field(60;"Cod. divisa";Code[10])
        {
            Caption = 'Currency Code';

            trigger OnValidate()
            var
                recDivisa: Record "4";
                recCurrExchRate: Record "330";
            begin
                IF "Cod. divisa" <> '' THEN BEGIN
                  recDivisa.GET("Cod. divisa");
                  "Factor divisa" := recCurrExchRate.ExchangeRate(Fecha,"Cod. divisa");
                END;
            end;
        }
        field(70;"Factor divisa";Decimal)
        {
            Caption = 'Real Exchange Rate';
            DecimalPlaces = 0:5;
        }
        field(80;"Importe calculado";Decimal)
        {
            CalcFormula = Sum("Transacciones Caja TPV".Importe WHERE (Cod. tienda=FIELD(No. tienda),
                                                                      Cod. TPV=FIELD(No. TPV),
                                                                      Fecha=FIELD(Fecha),
                                                                      No. turno=FIELD(No. turno),
                                                                      Forma de pago=FIELD(Forma de pago)));
            Caption = 'Trans. Amount in LCY';
            FieldClass = FlowField;
        }
        field(90;"Importe calculado (DL)";Decimal)
        {
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE (Cod. tienda=FIELD(No. tienda),
                                                                             Cod. TPV=FIELD(No. TPV),
                                                                             Fecha=FIELD(Fecha),
                                                                             No. turno=FIELD(No. turno),
                                                                             Forma de pago=FIELD(Forma de pago)));
            Caption = 'Trans. Amount in LCY';
            FieldClass = FlowField;
        }
        field(100;"Importe contado";Decimal)
        {
            Caption = 'Amount';
            MinValue = 0;

            trigger OnLookup()
            var
                recCurrExchRate: Record "330";
            begin
                LookupArqueo;
            end;

            trigger OnValidate()
            var
                Error001: Label 'Se debe realizar el recuento para la forma de pago %1.';
                recCurrExchRate: Record "330";
            begin
                IF "Requiere recueto" THEN
                  ERROR(Error001,"Forma de pago");

                IF "Cod. divisa" = '' THEN
                  "Importe contado (DL)" := "Importe contado"
                ELSE
                  "Importe contado (DL)" := ROUND(recCurrExchRate.ExchangeAmtFCYToLCY(Fecha,"Cod. divisa","Importe contado","Factor divisa"));
            end;
        }
        field(110;"Importe contado (DL)";Decimal)
        {
            Caption = 'Amount in LCY';
            DecimalPlaces = 2:2;
            Editable = false;
        }
        field(140;"Requiere recueto";Boolean)
        {
            Caption = 'Requiere recuento';
        }
        field(34002518;"Id Replicacion";Code[20])
        {
            Description = 'DsPOS Standard';
        }
    }

    keys
    {
        key(Key1;"No. tienda","No. TPV",Fecha,"No. turno","Forma de pago")
        {
        }
        key(Key2;"Id Replicacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        recArqueo: Record "34002526";
    begin
    end;

    trigger OnInsert()
    begin
        IF "Requiere recueto" THEN
          InsertarCfgArqueo;

        "Id Replicacion" := STRSUBSTNO('%1',DATE2DMY(Fecha,1)) + STRSUBSTNO('%1',DATE2DMY(Fecha,2)) + STRSUBSTNO('%1',DATE2DMY(Fecha,3));
    end;

    trigger OnModify()
    begin
        ControlEstadoTPV;
    end;

    procedure ControlArqueoRequerido()
    var
        recTienda: Record "34002503";
        Error001: Label 'Se debe realizar el arqueo de caja para la forma de pago %1.';
    begin
        recTienda.GET("No. tienda");
        IF recTienda."Arqueo de caja obligatorio" THEN
          ERROR(Error001, "Forma de pago");
    end;

    procedure InsertarCfgArqueo()
    var
        recCfgArqueo: Record "34002527";
        recArqueo: Record "34002526";
        Error001: Label 'Debe configurar el arqueo de caja para divisa %1';
    begin
        recCfgArqueo.RESET;
        recCfgArqueo.SETRANGE("Cod. divisa", "Cod. divisa");
        IF recCfgArqueo.FINDSET THEN BEGIN
          REPEAT
            recArqueo.INIT;
            recArqueo."Cod. tienda" := "No. tienda";
            recArqueo."Cod. TPV" := "No. TPV";
            recArqueo.Fecha := Fecha;
            recArqueo."No. turno" := "No. turno";
            recArqueo."Forma de pago" := "Forma de pago";
            recArqueo."Cod. divisa" := recCfgArqueo."Cod. divisa";
            recArqueo.Tipo := recCfgArqueo.Tipo;
            recArqueo.Importe := recCfgArqueo.Importe;
            recArqueo.INSERT(TRUE);
          UNTIL recCfgArqueo.NEXT = 0;
        END
        ELSE
          ERROR(Error001,"Cod. divisa");
    end;

    procedure LookupArqueo()
    var
        recCurrExchRate: Record "330";
        recArqueo: Record "34002526";
        frmArqueo: Page "34002538";
        Error001: Label 'La forma de pago %1 no requiere recuento.';
    begin
        IF NOT "Requiere recueto" THEN
          ERROR(Error001,"Forma de pago");

        recArqueo.RESET;
        recArqueo.SETRANGE("Cod. tienda", "No. tienda");
        recArqueo.SETRANGE("Cod. TPV", "No. TPV");
        recArqueo.SETRANGE(Fecha, Fecha);
        recArqueo.SETRANGE("No. turno", "No. turno");
        recArqueo.SETRANGE("Forma de pago", "Forma de pago");
        CLEAR(frmArqueo);
        frmArqueo.LOOKUPMODE := TRUE;
        frmArqueo.SETTABLEVIEW(recArqueo);
        IF frmArqueo.RUNMODAL = ACTION::LookupOK THEN BEGIN
          "Importe contado" := frmArqueo.TraerTotalContado;
          IF "Cod. divisa" = '' THEN
            "Importe contado (DL)" := "Importe contado"
          ELSE
            "Importe contado (DL)" := ROUND(recCurrExchRate.ExchangeAmtFCYToLCY(Fecha,"Cod. divisa","Importe contado","Factor divisa"));
          MODIFY;
        END;
    end;

    procedure TraerDiferencia(): Decimal
    begin
        IF NOT "Requiere recueto" THEN
          EXIT(0);

        CALCFIELDS("Importe calculado");
        EXIT("Importe contado" - "Importe calculado");
    end;

    procedure TraerDiferenciaDL(): Decimal
    begin
        IF NOT "Requiere recueto" THEN
          EXIT(0);

        CALCFIELDS("Importe calculado (DL)");
        EXIT("Importe contado (DL)" - "Importe calculado (DL)");
    end;

    procedure ControlEstadoTPV()
    var
        recControlTurno: Record "34002529";
        Error001: Label 'El turno está cerrado.';
    begin
        recControlTurno.GET("No. tienda","No. TPV",Fecha,"No. turno");
        IF recControlTurno.Estado = recControlTurno.Estado::Cerrado THEN
          ERROR(Error001);
    end;
}

