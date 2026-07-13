table 34002521 "Pagos TPV"
{
    // #70132  19.06.2018 RRT  Creación de los campos "NCR regis. de compensación"
    // #184407 10.04.2018, RRT: Al igual que en Bolivia, se crea el campo "Registrado TPV".
    // 
    // RRT, 05.07.17: Por indicacion de PLB, no se debe testear el num de factura introducido. Esto ya se realizaba en las notad de credito.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Tender POS';

    fields
    {
        field(34002500;Tienda;Code[20])
        {
            Caption = 'Store';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(34002501;TPV;Code[20])
        {
            Caption = 'POS';
            Description = 'DsPOS Standar';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE (Tienda=FIELD(Tienda));
        }
        field(34002503;"Forma pago TPV";Code[20])
        {
            Caption = 'Tender Type POS';
            Description = 'DsPOS Standar';
            TableRelation = IF (Tipo Tarjeta=CONST()) "Formas de Pago"
                            ELSE IF (Tipo Tarjeta=FILTER(<>'')) "Tipos de Tarjeta";

            trigger OnValidate()
            var
                recFormaPago: Record "34002513";
            begin
                IF recFormaPago.GET("Forma pago TPV") THEN
                  VALIDATE("Cod. divisa", recFormaPago."Cod. divisa");
            end;
        }
        field(34002504;"No. Borrador";Code[20])
        {
            Caption = 'Sales No.';
            Description = 'DsPOS Standar';
        }
        field(34002505;"Cod. divisa";Code[10])
        {
            Caption = 'Currency code';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                recDivisa: Record "4";
            begin
                IF "Cod. divisa" <> '' THEN BEGIN
                  recDivisa.GET("Cod. divisa");
                  "Factor divisa" := recCurrExchRate.ExchangeRate(Fecha,"Cod. divisa");
                END;
            end;
        }
        field(34002506;"Importe (DL)";Decimal)
        {
            Caption = 'Amount';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                recDivisa: Record "4";
            begin
                IF "Cod. divisa" = '' THEN BEGIN
                  Importe := "Importe (DL)";
                END ELSE BEGIN
                  recDivisa.GET("Cod. divisa");
                  recDivisa.TESTFIELD("Amount Rounding Precision");
                  Importe := ROUND(recCurrExchRate.ExchangeAmtLCYToFCY(Fecha,"Cod. divisa","Importe (DL)","Factor divisa"),recDivisa."Amount Rounding Precision")
                END;
            end;
        }
        field(34002507;Importe;Decimal)
        {
            Caption = 'Importe';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            begin
                IF "Cod. divisa" = '' THEN
                  "Importe (DL)" := Importe
                ELSE
                  "Importe (DL)" := ROUND(recCurrExchRate.ExchangeAmtFCYToLCY(Fecha,"Cod. divisa",Importe,"Factor divisa"));
            end;
        }
        field(34002508;Cajero;Code[20])
        {
            Caption = 'Cashier';
            Description = 'DsPOS Standar';
            TableRelation = Cajeros.ID WHERE (Tienda=FIELD(Tienda));
        }
        field(34002509;Fecha;Date)
        {
            Caption = 'Date';
            Description = 'DsPOS Standar';
        }
        field(34002510;Hora;Time)
        {
            Caption = 'Time';
            Description = 'DsPOS Standar';
        }
        field(34002511;"No. Factura";Code[20])
        {
            Caption = 'Nº Factura';
            Description = 'DsPOS Standar';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(34002513;"Tipo Tarjeta";Code[10])
        {
            Caption = 'Tipo Tarjeta';
            Description = 'DsPOS Standar';
            TableRelation = "Tipos de Tarjeta".Codigo;
        }
        field(34002514;"No. Tarjeta";Text[50])
        {
            Caption = 'Nº Tarjeta';
            Description = 'DsPOS Standar';
        }
        field(34002515;"No. Cheque";Text[30])
        {
            Caption = 'Nº Cheque';
            Description = 'DsPOS Standar';
        }
        field(34002516;"Banco Cheque";Code[20])
        {
            Caption = 'Banco Cheque';
            Description = 'DsPOS Standar';
            TableRelation = "Bank Account";
        }
        field(34002517;"No. Nota Credito";Code[20])
        {
            Caption = 'Return Invoice No.';
            Description = 'DsPOS Standar';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(34002520;"Importe Total divisa";Decimal)
        {
            CalcFormula = Sum("Pagos TPV".Importe WHERE (No. Borrador=FIELD(No. Borrador),
                                                         Cod. divisa=FIELD(Cod. divisa)));
            Caption = 'Importe Total divisa';
            Description = 'DsPOS Standar';
            FieldClass = FlowField;
        }
        field(34002530;Cambio;Boolean)
        {
            Caption = 'Cambio';
            Description = 'DsPOS Standar';
        }
        field(34002540;"Factor divisa";Decimal)
        {
            Caption = 'Factor divisa';
            DecimalPlaces = 0:5;
            Description = 'DsPOS Standar';
        }
        field(34002541;"No. Documento Exencion";Text[50])
        {
            Caption = 'No. Documento Exención';
            Description = 'DsPOS Standar';
        }
        field(34002545;"Registrado TPV";Boolean)
        {
            Description = 'DsPOS Standard - #211509';
            Editable = false;
            FieldClass = Normal;
        }
        field(34002551;"NCR regis. de compensacion";Code[20])
        {
            Description = '#70132';
            TableRelation = "Sales Cr.Memo Header";
        }
    }

    keys
    {
        key(Key1;"No. Borrador","Forma pago TPV",Cambio)
        {
        }
        key(Key2;"No. Factura","Cod. divisa")
        {
            SumIndexFields = Importe;
        }
        key(Key3;"Forma pago TPV","No. Borrador")
        {
        }
        key(Key4;"No. Nota Credito")
        {
        }
        key(Key5;"No. Nota Credito","Cod. divisa")
        {
        }
        key(Key6;"No. Borrador","Cod. divisa")
        {
            SumIndexFields = Importe;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(Error001);
    end;

    trigger OnModify()
    begin
        ERROR(Error001);
    end;

    trigger OnRename()
    begin
        ERROR(Error001);
    end;

    var
        Error001: Label 'Imposible Borrar, renombrar ó modificar';
        recCurrExchRate: Record "330";
}

