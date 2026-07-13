table 34002529 "Turnos TPV"
{
    Caption = 'Control de TPV';
    //TODO: Ver DrillDownPageID = 34002536;
    //TODO: Ver LookupPageID = 34002536;

    fields
    {
        field(10; "No. tienda"; Code[20])
        {
            Caption = 'Nº tienda';
            TableRelation = Tiendas;
        }
        field(20; "No. TPV"; Code[20])
        {
            Caption = 'Nº TPV';
            TableRelation = "Configuracion TPV"."Id TPV" WHERE(Tienda = FIELD(No. tienda));
        }
        field(30; Fecha; Date)
        {
            Caption = 'Fecha';
        }
        field(40; "No. turno"; Integer)
        {
            Caption = 'Nº turno';
        }
        field(60; "Hora apertura"; Time)
        {
            Caption = 'Hora apertura';
        }
        field(70; "Usuario apertura"; Code[20])
        {
            Caption = 'Usuario apertura';
        }
        field(90; "Hora cierre"; Time)
        {
            Caption = 'Hora cierre';
        }
        field(100; "Usuario cierre"; Code[20])
        {
            Caption = 'Usuario cierre';
        }
        field(110; "Nombre tienda"; Text[200])
        {
            CalcFormula = Lookup(Tiendas.Descripcion WHERE(Cod. Tienda=FIELD(No. tienda)));
            Caption = 'Nombre tienda';
            FieldClass = FlowField;
        }
        field(120;"Nombre TPV";Text[200])
        {
            CalcFormula = Lookup("Configuracion TPV"."Id TPV" WHERE (Tienda=FIELD(No. tienda),
                                                                     Id TPV=FIELD(No. TPV)));
            Caption = 'Nombre TPV';
            FieldClass = FlowField;
        }
        field(130;Estado;Option)
        {
            Caption = 'Estado';
            OptionCaption = 'Cerrado,Abierto';
            OptionMembers = Cerrado,Abierto;
        }
        field(140;"Fondo de caja";Decimal)
        {
            CalcFormula = Lookup("Transacciones Caja TPV"."Importe (DL)" WHERE (Cod. tienda=FIELD(No. tienda),
                                                                                Cod. TPV=FIELD(No. TPV),
                                                                                Fecha=FIELD(Fecha),
                                                                                No. turno=FIELD(No. turno),
                                                                                Tipo transaccion=CONST(Fondo)));
            FieldClass = FlowField;
        }
        field(34002518;"Id Replicacion";Code[20])
        {
            Description = 'DsPOS Standard';
        }
    }

    keys
    {
        key(Key1;"No. tienda","No. TPV",Fecha,"No. turno")
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
        "No. turno" := TraerUltimoTurno + 1;
        CopiarFormasPagoDeclaracion;

        "Id Replicacion" := STRSUBSTNO('%1',DATE2DMY(Fecha,1)) + STRSUBSTNO('%1',DATE2DMY(Fecha,2)) + STRSUBSTNO('%1',DATE2DMY(Fecha,3));
    end;

    var
        Error001: Label 'El TPV %1 de la tienda %2 esta cerrado.';

    procedure TraerUltimoTurno(): Integer
    var
        recControl: Record "34002529";
    begin
        recControl.RESET;
        recControl.SETRANGE("No. tienda", "No. tienda");
        recControl.SETRANGE("No. TPV", "No. TPV");
        recControl.SETRANGE(Fecha, Fecha);
        IF recControl.FINDLAST THEN
          EXIT(recControl."No. turno");
    end;

    procedure ActualizarFondoCaja(codPrmUsuario: Code[20];decPrmFondo: Decimal)
    var
        recTrans: Record "34002523";
        cduComun: Codeunit "34002503";
    begin
        recTrans.RESET;
        recTrans.SETRANGE("Cod. tienda", "No. tienda");
        recTrans.SETRANGE("Cod. TPV", "No. TPV");
        recTrans.SETRANGE(Fecha, Fecha);
        recTrans.SETRANGE("No. turno", "No. turno");
        recTrans.SETRANGE("Tipo transaccion", recTrans."Tipo transaccion"::Fondo);
        IF recTrans.FINDFIRST THEN BEGIN
          recTrans.Fecha := WORKDATE;
          recTrans.Hora := FormatTime(TIME);
          recTrans."Id. cajero" := codPrmUsuario;
          recTrans.Importe := decPrmFondo;
          recTrans."Importe (DL)" := decPrmFondo;
          recTrans.MODIFY;
        END
        ELSE BEGIN
          recTrans.INIT;
          recTrans."Cod. tienda" := "No. tienda";
          recTrans."Cod. TPV" := "No. TPV";
          recTrans.Fecha := Fecha;
          recTrans."No. turno" := "No. turno";
          recTrans."Tipo transaccion" := recTrans."Tipo transaccion"::Fondo;
          recTrans."Id. cajero" := codPrmUsuario;
          recTrans.Fecha := WORKDATE;
          recTrans.Hora := FormatTime(TIME);
          recTrans."Forma de pago" := cduComun.Efectivo_Local;
          recTrans.Importe := decPrmFondo;
          recTrans."Importe (DL)" := decPrmFondo;
          recTrans.INSERT(TRUE);
        END;
    end;

    procedure TraerFondoCaja(): Decimal
    var
        recTrans: Record "34002523";
    begin
        recTrans.RESET;
        recTrans.SETRANGE("Cod. tienda", "No. tienda");
        recTrans.SETRANGE("Cod. TPV", "No. TPV");
        recTrans.SETRANGE(Fecha, Fecha);
        recTrans.SETRANGE("No. turno", "No. turno");
        recTrans.SETRANGE("Tipo transaccion", recTrans."Tipo transaccion"::Fondo);
        IF recTrans.FINDFIRST THEN
          EXIT(recTrans.Importe);
    end;

    procedure CopiarFormasPagoDeclaracion()
    var
        recFormaPago: Record "34002513";
        recTPV: Record "34002501";
        recBotones: Record "34002511";
    begin
        recFormaPago.RESET;
        recFormaPago.SETRANGE("Efectivo Local", TRUE);
        IF recFormaPago.FINDFIRST THEN
          InsertarLinDeclaracion(recFormaPago."ID Pago");

        recFormaPago.RESET;
        recFormaPago.SETFILTER("Tipo Tarjeta", '<>%1', recFormaPago."Tipo Tarjeta");
        IF recFormaPago.FINDSET THEN
          REPEAT
            InsertarLinDeclaracion(recFormaPago."ID Pago");
          UNTIL recFormaPago.NEXT = 0;

        //Formas de pago configuradas en el TPV
        recTPV.GET("No. tienda","No. TPV");
        recTPV.TESTFIELD("Menu de Formas de Pago");

        recBotones.RESET;
        recBotones.SETRANGE("ID Menu", recTPV."Menu de Formas de Pago");
        recBotones.SETFILTER(Pago, '<>%1', '');
        IF recBotones.FINDSET THEN
          REPEAT
            InsertarLinDeclaracion(recBotones.Pago);
          UNTIL recBotones.NEXT = 0;
    end;

    procedure InsertarLinDeclaracion(codPrmFormaPago: Code[20])
    var
        recLinDeclara: Record "34002528";
    begin
        IF NOT recLinDeclara.GET("No. tienda","No. TPV",Fecha,"No. turno",codPrmFormaPago) THEN BEGIN
          recLinDeclara.INIT;
          recLinDeclara."No. tienda" := "No. tienda";
          recLinDeclara."No. TPV" := "No. TPV";
          recLinDeclara.Fecha := Fecha;
          recLinDeclara."No. turno" := "No. turno";
          recLinDeclara.VALIDATE("Forma de pago", codPrmFormaPago);
          recLinDeclara.INSERT(TRUE);
        END;
    end;

    procedure FormatTime(timEntrada: Time): Time
    var
        texHora: Text;
        timSalida: Time;
    begin
        texHora := FORMAT(timEntrada);
        EVALUATE(timSalida, texHora);
        EXIT(timSalida);
    end;

    procedure TraerDescuadreTurno(): Decimal
    var
        recDecCaja: Record "34002528";
        decDescuadre: Decimal;
        rformasPago: Record "34002513";
    begin
        recDecCaja.RESET;
        recDecCaja.SETRANGE("No. tienda", "No. tienda");
        recDecCaja.SETRANGE("No. TPV", "No. TPV");
        recDecCaja.SETRANGE(Fecha, Fecha);
        recDecCaja.SETRANGE("No. turno", "No. turno");
        IF recDecCaja.FINDSET THEN
          REPEAT
            rformasPago.GET(recDecCaja."Forma de pago");
            IF rformasPago."Realizar recuento" THEN
              decDescuadre += recDecCaja.TraerDiferencia;
          UNTIL recDecCaja.NEXT = 0;
        EXIT(decDescuadre);
    end;
}

