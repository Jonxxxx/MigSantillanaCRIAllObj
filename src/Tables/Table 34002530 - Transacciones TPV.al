table 34002530 "Transacciones TPV"
{
    // #348662 25.11.2020  RRT: Actualizar DS-POS para ajustar a version 43c. Redenominar tambien campos con caracteres conflictivos.

    Caption = 'Pos Transactions';
    DrillDownPageID = 34002544;
    LookupPageID = 34002544;

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
        field(50; "No. Transaccion"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Transaccion';
        }
        field(60; "Tipo Transaccion"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Tipo Transaccion';
            OptionCaption = 'Venta,Anulacion,Nota de Credito';
            OptionMembers = Venta,Anulacion,Abono;
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
        field(90; Importe; Decimal)
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
        field(95; "Importe IVA inc."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Importe IVA inc.';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                recCurrExchRate: Record 330;
            begin
            end;
        }
        field(100; "No. Borrador"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Borrador';
        }
        field(110; "No. Registrado"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Registrado';
            TableRelation = IF ("Tipo Transaccion" = CONST(Venta)) "Sales Invoice Header"
            ELSE IF ("Tipo Transaccion" = CONST(Anulacion)) "Sales Cr.Memo Header";
        }
        field(120; "Cod. cliente"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cod. cliente';
        }
        field(130; "Nombre cliente"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre cliente';
        }
        field(34002518; "Id Replicacion"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Id Replicacion';
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
        recVentaTPV: Record 34002530;
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
        cduControl: Codeunit 34002521;
    begin
        "No. turno" := cduControl.TraerTurnoActual("Cod. tienda", "Cod. TPV", Fecha);
    end;
}

