table 55684 "Imp.MdM Cabecera"
{
    Permissions = TableData 55684 = rimd;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
            AutoIncrement = true;
        }
        field(10; Operacion; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Operacion';
            OptionMembers = Insert,Update,Delete;
        }
        field(11; "Fecha Creacion"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Fecha Creacion';
            Editable = false;
        }
        field(20; Traspasado; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Traspasado';
        }
        field(100; id_mensaje; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'id_mensaje';
        }
        field(101; sistema_origen; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'sistema_origen';
        }
        field(102; pais_origen; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'pais_origen';
        }
        field(103; fecha_origen; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'fecha_origen';
        }
        field(104; fecha; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'fecha';
        }
        field(105; tipo; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'tipo';
        }
        field(250; Entrada; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entrada';
            OptionMembers = INT_WS,INT_Excel,NOTIFICA;
        }
        field(300; DOC; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'DOC';
        }
        field(301; "Send XML"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Send XML';
        }
        field(302; "Send XML Reply"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'Send XML Reply';
        }
        field(350; Estado; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado';
            OptionCaption = 'Pendiente,Error,Finalizado,Desestimada';
            OptionMembers = Pendiente,Error,Finalizado,Desestimada;
        }
        field(351; "Last Attempt"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Attempt';
        }
        field(352; "Attempt No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attempt No';
        }
        field(353; Attempt; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attempt';
        }
        field(355; "Estado Envio"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Estado Envio';
            OptionCaption = 'Pendiente,Error,Finalizado,Desestimada';
            OptionMembers = Pendiente,Error,Finalizado,Desestimada;
        }
        field(400; "Texto Error"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Texto Error';
        }
        field(500; "No Tablas"; Integer)
        {
            Caption = 'No Tablas';
            CalcFormula = Count("Imp.MdM Tabla" WHERE("Id Cab." = FIELD("Id")));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
        field(501; "No Tablas Procesadas"; Integer)
        {
            Caption = 'No Tablas Procesadas';
            CalcFormula = Count("Imp.MdM Tabla" WHERE("Id Cab." = FIELD("Id"),
                                                       "Procesado" = CONST(true)));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lrImp: Record 55685;
        lrFields: Record 55686;
    begin

        // Borramos los registros derivados

        CLEAR(lrImp);
        lrImp.SETCURRENTKEY("Id Cab.");
        lrImp.SETRANGE("Id Cab.", Id);
        lrImp.DELETEALL;

        CLEAR(lrFields);
        lrFields.SETCURRENTKEY("Id Cab.");
        lrFields.SETRANGE("Id Cab.", Id);
        lrFields.DELETEALL;
    end;

    trigger OnInsert()
    begin
        "Fecha Creacion" := CURRENTDATETIME;
    end;

    var
        cFileMng: Codeunit 419;

    procedure GetIntDates(var pwNivel: Integer; var pwEstado: Integer; var pwNIntentos: Integer)
    begin
        // GetIntDates

        /*
        pwNivel   := "Attempt No" DIV 10;
        pwEstado  := "Attempt No" MOD 10;
        pwNIntentos := (pwNivel * GetIntesntosXNivel) + pwEstado;
        */

        pwNIntentos := Attempt;
        GetIntDates2(pwNivel, pwEstado, pwNIntentos);

    end;

    procedure GetIntDates2(var pwNivel: Integer; var pwEstado: Integer; pwNIntentos: Integer)
    begin
        // GetIntDates2
        // Le decimos nosotros el intento

        pwNivel := ((pwNIntentos - 1) DIV GetIntesntosXNivel) + 1;
        pwEstado := ((pwNIntentos - 1) MOD GetIntesntosXNivel) + 1;
    end;

    procedure GetIntesntosXNivel(): Integer
    begin
        // GetIntesntosXNivel

        EXIT(5);
    end;

    procedure NewIntentInc(var pwNivel: Integer; var pwEstado: Integer; var pwNIntentos: Integer)
    begin
        // NewIntentInc

        Attempt += 1;
        GetIntDates(pwNivel, pwEstado, pwNIntentos);
        "Attempt No" := (pwNivel * 10) + pwEstado;
        "Last Attempt" := CURRENTDATETIME;

        /*
        pwEstado += 1;
        IF pwEstado > GetIntesntosXNivel THEN BEGIN
          pwEstado := 1;
          pwNivel +=1;
        END;
        pwNIntentos := (pwNivel * GetIntesntosXNivel) + pwEstado;
        
        "Attempt No"   := (pwNivel * 10) + pwEstado;
        */

    end;

    procedure NewIntent()
    var
        lwNivel: Integer;
        lwEstado: Integer;
        lwNIntentos: Integer;
    begin
        // NewIntent

        NewIntentInc(lwNivel, lwEstado, lwNIntentos);
    end;
}

