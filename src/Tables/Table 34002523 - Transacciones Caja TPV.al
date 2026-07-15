table 34002523 "Transacciones Caja TPV"
{
    // #70132 RRT, 09.07.2018: Añadir el campo  "NCR regis. de compensacion"
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Transaccion caja TPV';
    //TODO: Ver DrillDownPageID = 34002535;
    //TODO: Ver LookupPageID = 34002535;

    fields
    {
        field(10; "Cod. tienda"; Code[20])
        {
            Caption = 'Store No.';
            TableRelation = Tiendas;
        }
        field(20; "Cod. TPV"; Code[20])
        {
            Caption = 'POS Terminal No.';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE(Tienda = FIELD("Cod. tienda"));
        }
        field(30; Fecha; Date)
        {
            Caption = 'Date';
        }
        field(40; "No. turno"; Integer)
        {
            Caption = 'Nº turno';
        }
        field(50; "No. transaccion"; Integer)
        {
            Caption = 'Transaction No.';
        }
        field(60; "Tipo transaccion"; Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Cobro TPV,Anulacion,Entrada de caja,Salida de caja,Fondo de caja';
            OptionMembers = "Cobro TPV",Anulacion,Entrada,Salida,Fondo;
        }
        field(70; "Id. cajero"; Code[50])
        {
            Caption = 'Staff ID';
            TableRelation = Cajeros.ID WHERE(Tienda = FIELD("Cod. tienda"));
        }
        field(80; Hora; Time)
        {
            Caption = 'Time';
        }
        field(100; "Forma de pago"; Code[10])
        {
            Caption = 'Tender Type';
            TableRelation = "Formas de Pago";

            trigger OnValidate()
            var
                recTienda: Record 34002503;
                recFormaPago: Record 34002513;
            begin
            end;
        }
        field(110; Importe; Decimal)
        {
            Caption = 'Net Amount';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                recCurrExchRate: Record 330;
            begin
            end;
        }
        field(120; "Importe (DL)"; Decimal)
        {
            Caption = 'Net Amount';
            DecimalPlaces = 2 : 2;
        }
        field(130; "Cod. divisa"; Code[10])
        {
            Caption = 'Cod. divisa';
        }
        field(140; "Factor divisa"; Decimal)
        {
            Caption = 'Factor divisa';
            DecimalPlaces = 0 : 5;
        }
        field(145; "No. Registrado"; Code[20])
        {
            Caption = 'No. Registrado';
        }
        field(150; "Importe venta (DL)"; Decimal)
        {
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
            CalcFormula = Sum("Transacciones Caja TPV"."Importe (DL)" WHERE("Cod. tienda" = FIELD("Cod. tienda"),
                                                                             "Cod. TPV" = FIELD("Cod. TPV"),
                                                                             Fecha = FIELD("Fecha")));
            Caption = 'Total caja dia (DL)';
            FieldClass = FlowField;
        }
        field(170; Cambio; Boolean)
        {
            Caption = 'Cambio';
        }
        field(34002518; "Id Replicacion"; Code[20])
        {
            Description = 'DsPOS Standard';
        }
        field(34002551; "NCR regis. de compensacion"; Code[20])
        {
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
        recTrans: Record 34002523;
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
    //TODO: Ver cduControl: Codeunit 34002521;
    begin
        //TODO: Ver "No. turno" := cduControl.TraerTurnoActual("Cod. tienda", "Cod. TPV", Fecha);
    end;
}

