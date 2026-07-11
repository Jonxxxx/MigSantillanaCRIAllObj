table 75004 "Imp.MdM Tabla"
{

    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Id Cab."; Integer)
        {
            Description = 'Id de la cabecera';
        }
        field(3; Operacion; Option)
        {
            OptionMembers = Insert,Update,Delete;
        }
        field(5; "Id Tabla"; Integer)
        {
        }
        field(10; "Code"; Code[30])
        {
        }
        field(11; "Code MdM"; Code[30])
        {
            Caption = 'Code MdM';
        }
        field(12; Rename; Boolean)
        {
            CalcFormula = Exist("Imp.MdM Campos" WHERE("Id Rel" = FIELD("Id"),
                                                        "Renamed Val" = FILTER(<> '')));
            Description = 'FlowField';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Descripcion; Text[100])
        {
        }
        field(30; Tipo; Integer)
        {
        }
        field(40; Procesado; Boolean)
        {
        }
        field(41; Visible; Option)
        {
            OptionMembers = Ind,"S ",No;
        }
        field(50; "Nombre Elemento"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Id)
        {
        }
        key(Key2; "Id Cab.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lrFields: Record 75005;
    begin

        // Borramos todos los campos relacionados

        CLEAR(lrFields);
        lrFields.SETRANGE("Id Rel", Id);
        lrFields.DELETEALL;
    end;

    var
        cFuncMdM: Codeunit 75000;
        cGenProd: Codeunit 75007;
        ConfMdM: Record 75000;
        Text0001: Label 'Dim. ';
        Text0002: Label 'Alto';
        Text0003: Label 'Ancho';
        Text0004: Label 'Peso';
        wRecRef: RecordRef;
        ft: Integer;

    procedure GetTableName() TableName: Text[50]
    var
        lrTables: Record 2000000001;
    begin
        // GetTableName

        CLEAR(lrTables);
        lrTables.SETRANGE(Type, lrTables.Type::Table);
        lrTables.SETRANGE(ID, "Id Tabla");
        IF lrTables.FIND('-') THEN
            TableName := lrTables.Name;
    end;

    procedure GetFieldName(pwFieldNo: Integer) FieldName: Text[50]
    var
        rlFields: Record 2000000041;
    begin
        // GetFieldName

        FieldName := '';
        IF pwFieldNo > 0 THEN BEGIN
            CLEAR(rlFields);
            rlFields.SETRANGE(TableNo, "Id Tabla");
            rlFields.SETRANGE("No.", pwFieldNo);
            IF rlFields.FIND('-') THEN
                FieldName := rlFields.FieldName;
        END
        ELSE BEGIN  // Estos son valores "Virtuales"
            CASE "Id Tabla" OF
                27:
                    BEGIN // Productos
                        CASE pwFieldNo OF
                            -101:
                                FieldName := Text0002;  // Alto
                            -102:
                                FieldName := Text0003;  // Ancho
                            -103:
                                FieldName := Text0004;  // Peso
                                                        // Dimensiones
                            -299 .. -200:
                                FieldName := Text0001 + cFuncMdM.GetDimCode(ABS("Id Tabla" + 200), FALSE);
                        END;
                    END;
            END;
        END;
    end;

    procedure ValidaCampos()
    var
        lrField: Record 75005;
        lrField2Record: Record 2000000041;
        lrRF: FieldRef;
        lwType: Option;
        lwIntT: Integer;
    begin
        // ValidaCampos

        wRecRef.OPEN("Id Tabla");

        CLEAR(lrField);
        lrField.SETRANGE("Id Rel", Id);
        IF lrField.FINDSET THEN BEGIN
            REPEAT
                IF lrField."Id Field" > 0 THEN BEGIN
                    IF wRecRef.FIELDEXIST(lrField."Id Field") THEN BEGIN
                        // Buscamos el tipo de dato (lrRF.TYPE no nos sirve)
                        //lrField2.Type := lrRF.TYPE;

                        lrRF := wRecRef.FIELD(lrField."Id Field");
                        CASE lrField2.Type OF
                            lrField2.Type::Integer:
                                BEGIN
                                    EVALUATE(lwIntT, lrField.Value);
                                    lrRF.VALIDATE(lwIntT);
                                END;
                        END;
                    END;
                END;
            UNTIL lrField.NEXT = 0;
        END;
    end;

    procedure GetIdTipoField() wId: Integer
    begin
        // GetIdTipoField
        // Devuelve el Id de Campo del valor tipo seg n la tabla

        wId := 0;
        CASE "Id Tabla" OF
            75001, 349:
                wId := 1;
            90:
                wId := 2;
        //75002     : wId := 10; // El nivel de estructura analitica se determina por la longitud del campo Code
        END;
    end;

    procedure GetIdCodeField() wId: Integer
    begin
        // GetIdTipoField
        // Devuelve el Id de Campo del valor Codigo seg n la tabla

        wId := 0;
        CASE "Id Tabla" OF
            27, 5722, 90, 56003, 8, 75010, 9, 56007, 75002, 56008, 75009
                  :
                wId := 1;
            75001, 349
                  :
                wId := 2;
        END;
    end;

    procedure GetIdDescField() wId: Integer
    begin
        // GetIdDescField
        // Devuelve el Id de Campo del valor Descripcion seg n la tabla

        wId := 0;
        CASE "Id Tabla" OF
            56003, 8, 9, 56007, 56008, 75009
                     :
                wId := 2;
            27, 349, 5722, 75001
                     :
                wId := 3;
            75010:
                wId := 5;
            75002:
                wId := 11;
        END;
    end;

    procedure GetTipoText() wText: Text
    var
        lwId: Integer;
    begin
        // GetTipoText

        wText := '';
        CASE "Id Tabla" OF
            349:
                BEGIN
                    lwId := ABS(Tipo + 200);
                    wText := cFuncMdM.GetDimCode(lwId, FALSE); // Dimensiones MdM
                END;
            ELSE
                wText := FORMAT(Tipo);
        END;
    end;

    procedure SetVisibleTx(pwVisibleTx: Text[10])
    var
        lwBool: Boolean;
    begin
        // SetVisibleTx

        IF EVALUATE(lwBool, pwVisibleTx) THEN BEGIN
            IF lwBool THEN
                Visible := Visible::S
            ELSE
                Visible := Visible::No
        END
        ELSE
            Visible := Visible::Ind;
    end;

    procedure GetVisibleTx() Value: Text
    begin
        // GetVisibleTx
        Value := '';

        CASE Visible OF
            Visible::S:
                Value := FORMAT(TRUE);
            Visible::No:
                Value := FORMAT(FALSE);
        END;
    end;

    procedure GetVisibleDef(pwDef: Boolean) Value: Boolean
    begin
        // GetVisibleDef

        IF Visible = Visible::Ind THEN
            Value := pwDef
        ELSE
            Value := (Visible = Visible::S);
    end;

    procedure GetBloqueadoTx() Value: Text
    begin
        // GetBloqueadoTx
        // Es lo contrario GetVisibleTx
        // Devuelve trues si est  bloqueado, eso es si no est  visible
        Value := '';

        CASE Visible OF
            Visible::S:
                Value := FORMAT(FALSE);
            Visible::No:
                Value := FORMAT(TRUE);
        END;
    end;

    procedure VerFicha()
    var
        lrPK: KeyRef;
        lwN: Integer;
        lrField: Record 75005;
        lwRecRef: RecordRef;
        lwField2: FieldRef;
        lwCod: Code[20];
        lwNo: Code[20];
        lwOK: Boolean;
        lwVarRecRef: Variant;
        lwidPg: Integer;
    begin
        // VerFicha

        IF "Id Tabla" = 0 THEN
            EXIT;

        lwRecRef.OPEN("Id Tabla");

        // Buscamos el registro
        lrPK := lwRecRef.KEYINDEX(1);

        CLEAR(lrField);

        FOR lwN := 1 TO lrPK.FIELDCOUNT DO BEGIN
            lwField2 := lrPK.FIELDINDEX(lwN);
            IF lrField.GET(Id, lwField2.NUMBER) THEN BEGIN // Los campos de la clave primaria deben de existir
                cGenProd.SetFieldValue(lwField2, lrField.Value, FALSE); // Por defecto No validamos la clave primaria
            END
            ELSE BEGIN
                CASE lwField2.NUMBER OF
                    GetIdTipoField:
                        cGenProd.SetFieldValue(lwField2, GetTipoText, FALSE); // Por defecto No validamos la clave primaria
                    GetIdCodeField:
                        cGenProd.SetFieldValue(lwField2, Code, FALSE);
                    GetIdDescField:
                        cGenProd.SetFieldValue(lwField2, Descripcion, FALSE);
                END;
            END;
        END;

        CASE "Id Tabla" OF
            27:
                lwidPg := 30
            ELSE
                lwidPg := 0;
        END;

        IF "Id Tabla" = 75001 THEN BEGIN // Datos MdM
                                         // Filtramos por el tipo de dato
            lwField2 := lwRecRef.FIELD(1); // Tipo
            lwField2.SETRANGE(Tipo);
        END;


        IF lwRecRef.FIND THEN BEGIN
            lwVarRecRef := lwRecRef;
            PAGE.RUN(lwidPg, lwVarRecRef);
        END;
    end;
}

