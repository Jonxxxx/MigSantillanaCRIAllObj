table 55915 "Pagos TPV"
{
    // #70132  19.06.2018 RRT  Creacion de los campos "NCR regis. de compensacion"
    // #184407 10.04.2018, RRT: Al igual que en Bolivia, se crea el campo "Registrado TPV".
    // 
    // RRT, 05.07.17: Por indicacion de PLB, no se debe testear el num de factura introducido. Esto ya se realizaba en las notad de credito.
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Tender POS';

    fields
    {
        field(55894; Tienda; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tienda';
            Description = 'DsPOS Standar';
            TableRelation = Tiendas."Cod. Tienda";
        }
        field(55895; TPV; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'TPV';
            Description = 'DsPOS Standar';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE(Tienda = FIELD("Tienda"));
        }
        field(55897; "Forma pago TPV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Forma pago TPV';
            Description = 'DsPOS Standar';
            TableRelation = IF ("Tipo Tarjeta" = CONST()) "Formas de Pago"
            ELSE IF ("Tipo Tarjeta" = FILTER(<> '')) "Tipos de Tarjeta";

            trigger OnValidate()
            var
                recFormaPago: Record 55907;
            begin
                IF recFormaPago.GET("Forma pago TPV") THEN
                    VALIDATE("Cod. divisa", recFormaPago."Cod. divisa");
            end;
        }
        field(55898; "No. Borrador"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Borrador';
            Description = 'DsPOS Standar';
        }
        field(55899; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                recDivisa: Record 4;
            begin
                IF "Cod. divisa" <> '' THEN BEGIN
                    recDivisa.GET("Cod. divisa");
                    "Factor divisa" := recCurrExchRate.ExchangeRate(Fecha, "Cod. divisa");
                END;
            end;
        }
        field(55900; "Importe (DL)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe (DL)';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            var
                recDivisa: Record 4;
            begin
                IF "Cod. divisa" = '' THEN BEGIN
                    Importe := "Importe (DL)";
                END ELSE BEGIN
                    recDivisa.GET("Cod. divisa");
                    recDivisa.TESTFIELD("Amount Rounding Precision");
                    Importe := ROUND(recCurrExchRate.ExchangeAmtLCYToFCY(Fecha, "Cod. divisa", "Importe (DL)", "Factor divisa"), recDivisa."Amount Rounding Precision")
                END;
            end;
        }
        field(55901; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            Description = 'DsPOS Standar';

            trigger OnValidate()
            begin
                IF "Cod. divisa" = '' THEN
                    "Importe (DL)" := Importe
                ELSE
                    "Importe (DL)" := ROUND(recCurrExchRate.ExchangeAmtFCYToLCY(Fecha, "Cod. divisa", Importe, "Factor divisa"));
            end;
        }
        field(55902; Cajero; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cajero';
            Description = 'DsPOS Standar';
            TableRelation = Cajeros.ID WHERE(Tienda = FIELD("Tienda"));
        }
        field(55903; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
            Description = 'DsPOS Standar';
        }
        field(55904; Hora; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora';
            Description = 'DsPOS Standar';
        }
        field(55905; "No. Factura"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Factura';
            Description = 'DsPOS Standar';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(55907; "Tipo Tarjeta"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Tarjeta';
            Description = 'DsPOS Standar';
            TableRelation = "Tipos de Tarjeta".Codigo;
        }
        field(55908; "No. Tarjeta"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Tarjeta';
            Description = 'DsPOS Standar';
        }
        field(55909; "No. Cheque"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Cheque';
            Description = 'DsPOS Standar';
        }
        field(55910; "Banco Cheque"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Banco Cheque';
            Description = 'DsPOS Standar';
            TableRelation = "Bank Account";
        }
        field(55911; "No. Nota Credito"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Nota Credito';
            Description = 'DsPOS Standar';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(55914; "Importe Total divisa"; Decimal)
        {
            CalcFormula = Sum("Pagos TPV".Importe WHERE("No. Borrador" = FIELD("No. Borrador"),
                                                         "Cod. divisa" = FIELD("Cod. divisa")));
            Caption = 'Importe Total divisa';
            Description = 'DsPOS Standar';
            FieldClass = FlowField;
        }
        field(55924; Cambio; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cambio';
            Description = 'DsPOS Standar';
        }
        field(34002540; "Factor divisa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Factor divisa';
            DecimalPlaces = 0 : 5;
            Description = 'DsPOS Standar';
        }
        field(34002541; "No. Documento Exencion"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Documento Exencion';
            Description = 'DsPOS Standar';
        }
        field(34002545; "Registrado TPV"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Registrado TPV';
            Description = 'DsPOS Standard - #211509';
            Editable = false;
            FieldClass = Normal;
        }
        field(34002551; "NCR regis. de compensacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCR regis. de compensacion';
            Description = '#70132';
            TableRelation = "Sales Cr.Memo Header";
        }
    }

    keys
    {
        key(Key1; "No. Borrador", "Forma pago TPV", Cambio)
        {
        }
        key(Key2; "No. Factura", "Cod. divisa")
        {
            SumIndexFields = Importe;
        }
        key(Key3; "Forma pago TPV", "No. Borrador")
        {
        }
        key(Key4; "No. Nota Credito")
        {
        }
        key(Key5; "No. Nota Credito", "Cod. divisa")
        {
        }
        key(Key6; "No. Borrador", "Cod. divisa")
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
        Error001: Label 'Imposible Borrar, renombrar o modificar';
        recCurrExchRate: Record 330;
}

