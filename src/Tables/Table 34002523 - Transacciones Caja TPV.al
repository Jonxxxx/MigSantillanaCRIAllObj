table 55917 "Transacciones Caja TPV"
{
    // #70132 RRT, 09.07.2018: Añadir el campo  "NCR regis. de compensacion"
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Transaccion caja TPV';
    DrillDownPageID = 55929;
    LookupPageID = 55929;

    fields
    {
        field(10; "Cod. tienda"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. tienda';
            TableRelation = Tiendas;
        }
        field(20; "Cod. TPV"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. TPV';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE(Tienda = FIELD("Cod. tienda"));
        }
        field(30; Fecha; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha';
        }
        field(40; "No. turno"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. turno';
        }
        field(50; "No. transaccion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. transaccion';
        }
        field(60; "Tipo transaccion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo transaccion';
            OptionCaption = 'Cobro TPV,Anulacion,Entrada de caja,Salida de caja,Fondo de caja';
            OptionMembers = "Cobro TPV",Anulacion,Entrada,Salida,Fondo;
        }
        field(70; "Id. cajero"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Id. cajero';
            TableRelation = Cajeros.ID WHERE(Tienda = FIELD("Cod. tienda"));
        }
        field(80; Hora; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Hora';
        }
        field(100; "Forma de pago"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Forma de pago';
            TableRelation = "Formas de Pago";

            trigger OnValidate()
            var
                recTienda: Record 55897;
                recFormaPago: Record 55907;
            begin
            end;
        }
        field(110; Importe; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                recCurrExchRate: Record 330;
            begin
            end;
        }
        field(120; "Importe (DL)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe (DL)';
            DecimalPlaces = 2 : 2;
        }
        field(130; "Cod. divisa"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. divisa';
        }
        field(140; "Factor divisa"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Factor divisa';
            DecimalPlaces = 0 : 5;
        }
        field(145; "No. Registrado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Registrado';
        }
        field(150; "Importe venta (DL)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe venta (DL)';
        }
        field(160; "Total caja turno (DL)"; Decimal)
        {
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE("Cod. tienda" = FIELD("Cod. tienda"),
                                                                             "Cod. TPV" = FIELD("Cod. TPV"),
                                                                             Fecha = FIELD("Fecha"),
                                                                             "No. turno" = FIELD("No. turno")));
            Caption = 'Total caja turno (DL)';
            FieldClass = FlowField;
        }
        field(161; "Total cajadia (DL)"; Decimal)
        {
            Caption = 'Total cajadia (DL)';
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE("Cod. tienda" = FIELD("Cod. tienda"),
                                                                             "Cod. TPV" = FIELD("Cod. TPV"),
                                                                             Fecha = FIELD("Fecha")));
            FieldClass = FlowField;
        }
        field(170; Cambio; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cambio';
        }
        field(55912; "Id Replicacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id Replicacion';
            Description = 'DsPOS Standard';
        }
        field(34002551; "NCR regis. de compensacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'NCR regis. de compensacion';
            Description = 'DsPos Dominicana - #70132';
            TableRelation = "Sales Cr.Memo Header";
        }
    }

    keys
    {
        key(Key1; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. transaccion")
        {
            SumIndexFields = Importe, "Importe (DL)", "Importe venta (DL)";
        }
        key(Key2; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Forma de pago")
        {
            SumIndexFields = Importe, "Importe (DL)";
        }
        key(Key3; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Tipo transaccion")
        {
        }
        key(Key4; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "Cod. divisa")
        {
        }
        key(Key5; "Id Replicacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No. turno" = 0 THEN
            AsignarTurno;

        "No. transaccion" := TraerUltimaTrans + 1;
        "Id Replicacion" := STRSUBSTNO('%1', DATE2DMY(Fecha, 1)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 2)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 3));
    end;

    procedure TraerUltimaTrans(): Decimal
    var
        recTrans: Record 55917;
    begin
        recTrans.RESET;
        recTrans.SETRANGE("Cod. tienda", "Cod. tienda");
        recTrans.SETRANGE("Cod. TPV", "Cod. TPV");
        recTrans.SETRANGE(Fecha, Fecha);
        recTrans.SETRANGE("No. turno", "No. turno");
        IF recTrans.FINDLAST THEN
            EXIT(recTrans."No. transaccion");
    end;

    procedure AsignarTurno(): Integer
    var
        cduControl: Codeunit 55915;
    begin
        "No. turno" := cduControl.TraerTurnoActual("Cod. tienda", "Cod. TPV", Fecha);
    end;
}

