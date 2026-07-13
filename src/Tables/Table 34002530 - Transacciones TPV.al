table 34002530 "Transacciones TPV"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Pos Transactions';
    //TODO: Ver DrillDownPageID = 34002544;
    //TODO: Ver LookupPageID = 34002544;

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
            TableRelation = "Configuracion TPV"."Id TPV" WHERE(Tienda = FIELD(Cod. tienda));
        }
        field(30; Fecha; Date)
        {
            Caption = 'Date';
        }
        field(40; "No. turno"; Integer)
        {
            Caption = 'Nº turno';
        }
        field(50; "No. Transaccion"; Integer)
        {
            Caption = 'Transaction No';
        }
        field(60; "Tipo Transaccion"; Option)
        {
            Caption = 'Transaction Type';
            OptionCaption = 'Venta,Anulación,Nota de crédito';
            OptionMembers = Venta,Anulacion,Abono;
        }
        field(70; "Id. cajero"; Code[50])
        {
            Caption = 'Staff ID';
            TableRelation = Cajeros.ID WHERE(Tienda = FIELD(Cod. tienda));
        }
        field(80; Hora; Time)
        {
            Caption = 'Time';
        }
        field(90; Importe; Decimal)
        {
            Caption = 'Net Amount';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                recCurrExchRate: Record "330";
            begin
            end;
        }
        field(95; "Importe IVA inc."; Decimal)
        {
            Caption = 'Net Amount';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                recCurrExchRate: Record "330";
            begin
            end;
        }
        field(100; "No. Borrador"; Code[20])
        {
            Caption = 'No. Borrador';
        }
        field(110; "No. Registrado"; Code[20])
        {
            Caption = 'No. Registrado';
            TableRelation = IF (Tipo Transaccion=CONST(Venta)) "Sales Invoice Header"
                            ELSE IF (Tipo Transaccion=CONST(Anulacion)) "Sales Cr.Memo Header";
        }
        field(120; "Cod. cliente"; Code[20])
        {
            Caption = 'Cód. cliente';
        }
        field(130; "Nombre cliente"; Text[50])
        {
            Caption = 'Nombre cliente';
        }
        field(34002518; "Id Replicacion"; Code[20])
        {
            Description = 'DsPOS Standard';
        }
    }

    keys
    {
        key(Key1; "Cod. tienda", "Cod. TPV", Fecha, "No. turno", "No. Transaccion")
        {
            SumIndexFields = Importe, "Importe IVA inc.";
        }
        key(Key2; "No. Registrado")
        {
        }
        key(Key3; "Id Replicacion")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        AsignarTurno;
        "No. Transaccion" := TraerUltimaVenta + 1;

        "Id Replicacion" := STRSUBSTNO('%1', DATE2DMY(Fecha, 1)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 2)) + STRSUBSTNO('%1', DATE2DMY(Fecha, 3));
    end;

    procedure TraerUltimaVenta(): Integer
    var
        recVentaTPV: Record "34002530";
    begin
        recVentaTPV.RESET;
        recVentaTPV.SETRANGE("Cod. tienda", "Cod. tienda");
        recVentaTPV.SETRANGE("Cod. TPV", "Cod. TPV");
        recVentaTPV.SETRANGE(Fecha, Fecha);
        recVentaTPV.SETRANGE("No. turno", "No. turno");
        IF recVentaTPV.FINDLAST THEN
            EXIT(recVentaTPV."No. Transaccion");
    end;

    procedure AsignarTurno(): Integer
    var
        cduControl: Codeunit "34002521";
    begin
        "No. turno" := cduControl.TraerTurnoActual("Cod. tienda", "Cod. TPV", Fecha);
    end;
}

