page 75014 "Filtro Valor Campo"
{
    // YA SE que codigo en la page no es lo suyo
    // El problema es que NO puede estar en la tabla ya que se trata como una tabla "Temporal" todo el tiempo y no cosume licencia
    // Si introducimos código dentro de la tabla, El sistema Si solicitará licencia para este objeto.

    Editable = false;
    PageType = List;
    SourceTable = Table75014;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Value; Value)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RellenaTemp;
    end;

    var
        Text001: Label 'El tipo de dato %1 no está permitido. Campo %2';
        Text002: Label '%1 No es un valor permitido para %2.\ Los valores permitidos son %3';
        cFunMdM: Codeunit 75000;

    procedure RellenaTemp()
    var
        lwTableId: Integer;
        lwFieldNo: Integer;
        lwRecRf: RecordRef;
        lwFieldRf: FieldRef;
        lwRecRf2: RecordRef;
        lwFieldRf2: FieldRef;
        lwKeyRef: KeyRef;
        lwIdRel: Integer;
        lwTotal: Integer;
        lwId: Integer;
        lwIdDim: Integer;
        lwOptionValue: Text;
        lwIdfVal: Integer;
        lwIdfDesc: Integer;
        lwText: Text;
        lwDescrpt: Text;
        lwCodDim: Code[20];
        lrValDim: Record 349;
    begin
        // RellenaTemp

        // Recuerde que la tabla en cuestión debe de ser temporal

        lwTableId := GETRANGEMIN("Table Id");
        lwFieldNo := GETRANGEMIN("Field No");

        IF (lwTableId = 0) OR (lwFieldNo = 0) THEN
            EXIT;

        CLEAR(Rec);
        DELETEALL;
        CLEAR(lwId);

        // Campos virtuales de la tabla producto
        IF (lwTableId = 27) AND (lwFieldNo < 0) THEN BEGIN
            CASE lwFieldNo OF
                -299 .. -200:
                    BEGIN // Dimensiones
                        lwIdDim := -(lwFieldNo + 200);
                        lwCodDim := cFunMdM.GetDimCode(lwIdDim, TRUE);
                        CLEAR(lrValDim);
                        lrValDim.SETRANGE("Dimension Code", lwCodDim);
                        lrValDim.SETRANGE(Blocked, FALSE);
                        IF lrValDim.FINDSET THEN BEGIN
                            REPEAT
                                lwId += 1;
                                InsertReg(lwId, lwTableId, lwFieldNo, lrValDim.Code, lrValDim.Name);
                            UNTIL lrValDim.NEXT = 0;
                        END;
                    END;
            END;
        END
        ELSE BEGIN
            lwRecRf.OPEN(lwTableId);
            lwFieldRf := lwRecRf.FIELD(lwFieldNo);
            IF UPPERCASE(FORMAT(lwFieldRf.TYPE)) = 'BOOLEAN' THEN BEGIN
                InsertReg(1, lwTableId, lwFieldNo, 'Sí', '');
                InsertReg(2, lwTableId, lwFieldNo, 'No', '');
            END ELSE
                IF UPPERCASE(FORMAT(lwFieldRf.TYPE)) = 'OPTION' THEN BEGIN
                    CurrPage.CAPTION := lwFieldRf.CAPTION;
                    //lwOptionValue := lwFieldRf.OPTIONCAPTION;
                    lwOptionValue := lwFieldRf.OPTIONSTRING;
                    lwTotal := GeOptionNums(lwOptionValue);
                    FOR lwId := 1 TO lwTotal DO BEGIN
                        InsertReg(lwId, lwTableId, lwFieldNo, SELECTSTR(lwId, lwOptionValue), '');
                    END;
                END
                ELSE BEGIN
                    lwIdRel := lwFieldRf.RELATION;

                    IF lwIdRel <> 0 THEN BEGIN
                        lwRecRf2.OPEN(lwIdRel);
                        CurrPage.CAPTION := lwRecRf2.CAPTION;
                        lwIdfVal := 0; // Id del campo Valor
                        lwIdfDesc := 0; // Id del campo Descripción, por defecto en blanco
                        RelFilter(lwTableId, lwFieldNo, lwRecRf2, lwIdfVal, lwIdfDesc); // Añade filtros adicionales
                        IF lwIdfVal = 0 THEN BEGIN
                            // Buscamos el primer campo de la clave primaria
                            lwKeyRef := lwRecRf2.KEYINDEX(1);
                            lwFieldRf2 := lwKeyRef.FIELDINDEX(1);
                            lwIdfVal := lwFieldRf2.NUMBER;
                        END;
                        IF lwRecRf2.FINDSET THEN BEGIN
                            REPEAT
                                lwId += 1;
                                lwFieldRf2 := lwRecRf2.FIELD(lwIdfVal);
                                lwText := FORMAT(lwFieldRf2.VALUE);
                                //lwText := COPYSTR(lwText, 1, MAXSTRLEN(Value));
                                CLEAR(lwDescrpt);
                                IF lwIdfDesc <> 0 THEN BEGIN
                                    lwFieldRf2 := lwRecRf2.FIELD(lwIdfDesc);
                                    lwDescrpt := FORMAT(lwFieldRf2.VALUE);
                                    lwDescrpt := COPYSTR(lwDescrpt, 1, MAXSTRLEN(Description));
                                END;
                                InsertReg(lwId, lwTableId, lwFieldNo, lwText, lwDescrpt);
                            UNTIL lwRecRf2.NEXT = 0;
                        END;
                    END;
                END;
        END;
    end;

    procedure RelFilter(pwTableId: Integer; pwFieldNo: Integer; var pwRelRf: RecordRef; var pwIdfVal: Integer; var pwIdfDesc: Integer)
    var
        lwFieldRf: FieldRef;
        lwOptionValue: Text;
        lwId: Integer;
    begin
        // RelFilter
        // Añade filtros adicionales que no he sabido manejar de otro modo
        // pwIdfVal, pwIdfDesc Devuelve el numero de código y descripción para cada caso


        CASE pwRelRf.NUMBER OF // Tabla relacionada
            67002:
                BEGIN // Datos auxiliares
                    pwIdfVal := 2;  // Código
                    pwIdfDesc := 3;  // Descripción
                    lwFieldRf := pwRelRf.FIELD(1);
                    //lwOptionValue := lwFieldRf.OPTIONCAPTION;
                    lwOptionValue := lwFieldRf.OPTIONSTRING;
                    lwId := 0;
                    CASE pwTableId OF
                        27:
                            BEGIN // Producto
                                CASE pwFieldNo OF
                                    56022:
                                        lwId := GeOptionValueId(lwOptionValue, 'Grupo de Negocio');// Grupo Negocio
                                    55000:
                                        lwId := GeOptionValueId(lwOptionValue, 'Materia'); // Materia
                                END;
                            END;
                    END;
                    IF lwId > 0 THEN
                        lwFieldRf.SETRANGE(lwId);
                END;
            75001:
                BEGIN  // Datos MdM
                    pwIdfVal := 2;  // Código
                    pwIdfDesc := 3;  // Descripción
                    lwFieldRf := pwRelRf.FIELD(1);
                    //lwOptionValue := lwFieldRf.OPTIONCAPTION;
                    lwOptionValue := lwFieldRf.OPTIONSTRING;
                    lwId := 0;
                    CASE pwTableId OF
                        27:
                            BEGIN // Producto
                                CASE pwFieldNo OF
                                    50005:
                                        lwId := GeOptionValueId(lwOptionValue, 'Grado');// Nivel Escolar (Grado)
                                    56007:
                                        lwId := GeOptionValueId(lwOptionValue, 'Edicion');// Edicion
                                    56008:
                                        lwId := GeOptionValueId(lwOptionValue, 'Estado');// Estado
                                    56010:
                                        lwId := GeOptionValueId(lwOptionValue, 'Sello');// Sello
                                    75001:
                                        lwId := GeOptionValueId(lwOptionValue, 'Tipo Producto');// Tipo Producto
                                    75002:
                                        lwId := GeOptionValueId(lwOptionValue, 'Soporte');// Soporte
                                    75003:
                                        lwId := GeOptionValueId(lwOptionValue, 'Editora');// Empresa Editora
                                    75005:
                                        lwId := GeOptionValueId(lwOptionValue, 'Editora');// Sociedad
                                    75004:
                                        lwId := GeOptionValueId(lwOptionValue, 'Linea');// Linea de Negocio
                                    75006:
                                        lwId := GeOptionValueId(lwOptionValue, 'Plan Editorial');// Plan Editorial
                                    75010:
                                        lwId := GeOptionValueId(lwOptionValue, 'Asignatura');// Asignatura
                                    75011:
                                        lwId := GeOptionValueId(lwOptionValue, 'Campaña');// Campaña
                                    56015:
                                        lwId := GeOptionValueId(lwOptionValue, 'Autor');// Autor
                                END;
                            END;
                    END;


                    IF lwId > 0 THEN
                        lwFieldRf.SETRANGE(lwId);
                END;
        END;
    end;

    procedure TestCampo(pwIdTable: Integer; pwIdField: Integer)
    var
        lrFields: Record 2000000041;
        lwIdDim: Integer;
    begin
        // TestCampo
        IF (pwIdTable = 0) OR (pwIdField = 0) THEN
            EXIT;

        IF (pwIdTable = 27) AND (pwIdField < 0) THEN BEGIN // Campos Virtuales
            CASE pwIdField OF
                -299 .. -200:
                    BEGIN // Dimensiones
                        lwIdDim := -(pwIdField + 200);
                        cFunMdM.GetDimCode(lwIdDim, TRUE);
                    END;
            END;
        END
        ELSE
            lrFields.GET(pwIdTable, pwIdField);
    end;

    procedure GetFieldValue(var pwFieRef: FieldRef; pwValue: Text; var pwVariant: Variant)
    var
        ValDecimal: Decimal;
        ValInteger: Integer;
        ValDate: Date;
        ValDateTime: DateTime;
        ValBoolean: Boolean;
        lwIsNULL: Boolean;
        lwOK: Boolean;
        lwValue2: Text;
    begin
        // GetFieldValue
        // Devuelve un valor a un campo
        // pwVariant Es el valor de retorno

        pwValue := DELCHR(pwValue, '<>');
        lwIsNULL := EsNulo(pwValue);

        CLEAR(pwVariant);
        CASE UPPERCASE(FORMAT(pwFieRef.TYPE)) OF
            'OPTION':
                BEGIN
                    IF lwIsNULL THEN
                        ValInteger := 0
                    ELSE BEGIN
                        IF NOT EVALUATE(ValInteger, pwValue) THEN BEGIN
                            ValInteger := GeOptionValueId(pwFieRef.OPTIONCAPTION, pwValue);
                            IF ValInteger = -1 THEN
                                ValInteger := GeOptionValueId(pwFieRef.OPTIONSTRING, pwValue);
                            IF ValInteger = -1 THEN
                                ERROR(Text002, pwValue, pwFieRef.CAPTION, pwFieRef.OPTIONCAPTION);
                        END;
                    END;
                    pwVariant := ValInteger;
                END;
            'INTEGER', 'BIGINTEGER':
                BEGIN
                    IF lwIsNULL THEN
                        ValInteger := 0
                    ELSE
                        EVALUATE(ValInteger, pwValue);
                    pwVariant := ValInteger;
                END;
            'DECIMAL':
                BEGIN
                    IF lwIsNULL THEN
                        ValDecimal := 0
                    ELSE
                        EVALUATE(ValDecimal, pwValue);
                    pwVariant := ValDecimal;
                END;
            'DATE':
                BEGIN
                    IF lwIsNULL THEN
                        ValDate := 0D
                    ELSE BEGIN
                        lwOK := EVALUATE(ValDate, pwValue);
                        IF NOT lwOK THEN BEGIN
                            lwValue2 := STRSUBSTNO('%1/%2/%3', COPYSTR(pwValue, 9, 2), COPYSTR(pwValue, 6, 2), COPYSTR(pwValue, 1, 4));
                            lwOK := EVALUATE(ValDate, lwValue2);
                        END;
                        IF NOT lwOK THEN BEGIN
                            lwValue2 := STRSUBSTNO('%1/%2/%3', COPYSTR(pwValue, 6, 2), COPYSTR(pwValue, 9, 2), COPYSTR(pwValue, 1, 4));
                            lwOK := EVALUATE(ValDate, lwValue2);
                        END;
                        IF NOT lwOK THEN
                            EVALUATE(ValDate, pwValue); // Genera Error
                    END;
                    pwVariant := ValDate;
                END;
            'DATETIME':
                BEGIN
                    IF lwIsNULL THEN
                        ValDateTime := 0DT
                    ELSE
                        EVALUATE(ValDateTime, pwValue);
                    pwVariant := ValDateTime;
                END;
            'BOOLEAN':
                BEGIN
                    IF lwIsNULL THEN
                        ValBoolean := FALSE
                    ELSE
                        EVALUATE(ValBoolean, pwValue);
                    pwVariant := ValBoolean;
                END;
            'TEXT', 'BIGTEXT', 'CODE':
                BEGIN
                    IF lwIsNULL THEN
                        pwValue := '';
                    pwVariant := pwValue;
                END
            ELSE
                ERROR(Text001, FORMAT(pwFieRef.TYPE), pwFieRef.CAPTION);
        END;
    end;

    procedure EsNulo(pwValue: Text) wIsNull: Boolean
    begin
        // EsNulo
        // Determina si es un valor Nulo

        pwValue := DELCHR(pwValue, '<>');
        wIsNull := (UPPERCASE(pwValue) = 'NULL') OR (pwValue = '');
    end;

    procedure GeOptionValueId(pwOptionValue: Text; pwValue: Text) wId: Integer
    var
        lwId: Integer;
        lwTotal: Integer;
    begin
        // GeOptionValueId
        // Devolvemos el valor del Id del option (valores separados por comas)
        // Si no lo encuetra devuelve -1;

        wId := -1;

        pwOptionValue := UPPERCASE(DELCHR(pwOptionValue, '<>'));
        pwValue := UPPERCASE(DELCHR(pwValue, '<>')); // Le quitamos los valors vacios al principio y fin

        lwTotal := GeOptionNums(pwOptionValue);

        FOR lwId := 1 TO lwTotal DO BEGIN
            IF pwValue = SELECTSTR(lwId, pwOptionValue) THEN
                EXIT(lwId - 1); // Los option empiezan por 0
        END;
    end;

    procedure GeOptionNums(pwOptionValue: Text) Result: Integer
    var
        lwOptValues: Text;
        lwPs: Integer;
        lwId: Integer;
    begin
        // GeOptionNums
        // Devolvemos la cantidad de posiciones que tiene un option

        pwOptionValue := UPPERCASE(DELCHR(pwOptionValue, '<>'));
        lwOptValues := pwOptionValue;

        // Contamos cuantas posiciones tiene (comas +1)
        Result := 0;
        IF lwOptValues <> '' THEN BEGIN
            REPEAT
                lwPs := STRPOS(lwOptValues, ',');
                IF lwPs > 0 THEN
                    lwOptValues := COPYSTR(lwOptValues, lwPs + 1);
                Result += 1;
            UNTIL (lwPs = 0);
        END;
    end;

    procedure InsertReg(pwId: Integer; pwTableId: Integer; pwFieldId: Integer; pwValue: Text; pwDescripcion: Text)
    begin
        // InsertReg

        pwValue := DELCHR(pwValue, '<>');

        IF pwValue = '' THEN
            EXIT;

        INIT;
        Id := pwId;
        "Table Id" := pwTableId;
        "Field No" := pwFieldId;
        Value := pwValue;
        Description := pwDescripcion;
        INSERT;
    end;
}

