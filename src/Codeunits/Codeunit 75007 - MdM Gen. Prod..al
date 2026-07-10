codeunit 75007 "MdM Gen. Prod."
{
    //  Tengase en cuenta que, en esta ocasión,  tanto rImp como rCab y rField son registros REALES no temporales

    TableNo = 75003;

    trigger OnRun()
    begin

        //Introduce los valores de las tablas temporales


        rCab := Rec;
        rCab.SETRECFILTER;

        Code(rCab);

        Rec.Traspasado := TRUE;
        Rec.Estado := Rec.Estado::Finalizado;
        Rec.MODIFY;
    end;

    var
        cFuncMdm: Codeunit 75000;
        cFileMng: Codeunit 419;
        cAsynMng: Codeunit 75005;
        cGestMdM: Codeunit 75001;
        rConfMdM Record: 75000;
        NoSeriesMgt: Codeunit 396;
        rImp Record: 75004;
        rCab Record: 75003;
        rField Record: 75005;
        Text001: Label 'El tipo de dato %1 no está permitido en la importación de datos. Campo %2';
        rTmpField Record: 75005" temporary;
        rConvNM Record: 75007;
        wIds: array[3] of Integer;
        Text002: Label '%1 No es un valor permitido para %2.\ Los valores permitidos son %3';
        wDia: Dialog;
        wTotal: Integer;
        wCont: Integer;
        Text003: Label 'Traspasando';
        wStep: Integer;

    procedure "Code"(var prCab Record: 75003")
    var
        Item: Record 27;
        lrCabR Record: 75003;
        lrLinBom Record: 90;
        RecRef: RecordRef;
        FieRef: FieldRef;
        lwKeyRef: KeyRef;
        ValDecimal: Decimal;
        ValInteger: Integer;
        ValDate: Date;
        ValDateTime: DateTime;
        ValBoolean: Boolean;
        Dim1: Code[20];
        Dim2: Code[20];
        BlockedFieldNo: Integer;
        lwId2: Integer;
        lwMod: Boolean;
        lwVerDia: Boolean;
        lwPack: Code[20];
        lwDec: Decimal;
        lwCodDim: Code[20];
        lwFieldValue: Text;
        lwMngd: Boolean;
        lwN: Integer;
        lwOK: Boolean;
    begin
        COMMIT;

        IF NOT rConfMdM.Activo THEN
            rConfMdM.GET;

        lwVerDia := GUIALLOWED; // Ver el cuadro de dialogo

        IF prCab.Id = 0 THEN
            EXIT;

        rImp.RESET;
        IF Item.COUNT > 10000 THEN
            rImp.SETCURRENTKEY("Id Cab.");
        rImp.SETRANGE("Id Cab.", prCab.Id);
        rImp.SETFILTER("Id Tabla", '>0');
        rImp.SETRANGE(Procesado, FALSE);
        IF rImp.FINDSET THEN BEGIN
            // Muestra dialogo
            IF lwVerDia THEN BEGIN
                wDia.OPEN(Text003 + '\#1##############\@2@@@@@@@@@@@@@@@');
                wTotal := rImp.COUNT;
                wCont := 0;
                wStep := wTotal DIV 100;
                IF wStep = 0 THEN
                    wStep := 1;
            END;

            REPEAT
                IF lwVerDia THEN BEGIN
                    wCont += 1;
                    IF wCont MOD wStep = 0 THEN BEGIN
                        wDia.UPDATE(1, rImp."Nombre Elemento");
                        wDia.UPDATE(2, ROUND(wCont / wTotal * 10000, 1));
                    END;
                END;

                CLEAR(RecRef);
                RecRef.OPEN(rImp."Id Tabla");
                RecRef.INIT;

                // Comprobamos si s precisan conversion
                ConvierteTabl(rImp, TRUE);
                FillTempFields(rImp); // Crea un temporal de campos
                CLEAR(rField);
                rField.SETCURRENTKEY("Id Rel", Orden, Id); // Por orden
                rField.SETRANGE("Id Rel", rImp.Id);
                rField.SETRANGE("Id Cab.", rImp."Id Cab.");
                IF rField.FINDSET THEN BEGIN
                    REPEAT
                        ConvierteField(rImp, rField, TRUE); // Algunos campos precisan conversion
                    UNTIL rField.NEXT = 0;
                END;

                FillPrimKey(RecRef);

                CASE rImp.Operacion OF
                    rImp.Operacion::Insert:
                        InsertReg(rImp, RecRef);
                    rImp.Operacion::Update:
                        RecRef.FIND;
                    rImp.Operacion::Delete:
                        DeleteReg(rImp, RecRef);
                END;

                IF rImp.Operacion IN [rImp.Operacion::Insert, rImp.Operacion::Update] THEN BEGIN
                    // campos reales
                    CLEAR(rField);
                    rField.SETCURRENTKEY("Id Rel", Orden, Id); // Por orden
                    rField.SETRANGE("Id Rel", rImp.Id);
                    rField.SETRANGE("Id Cab.", rImp."Id Cab.");
                    rField.SETRANGE(PK, FALSE); // Los campos de la clave primaria ya se han introducido
                    rField.SETFILTER("Id Field", '>0');
                    IF rField.FINDSET THEN BEGIN
                        REPEAT
                            FieRef := RecRef.FIELD(rField."Id Field");
                            SetFieldValue(FieRef, rField.Value, TRUE);
                        UNTIL rField.NEXT = 0;

                        IF rImp."Id Tabla" = 27 THEN BEGIN
                            RecRef.SETTABLE(Item);
                            //IF rCab.Entrada <> rCab.Entrada::INT_EXCEl THEN  //JPT 29/10/2019
                            Item.SetModificadoMdM(TRUE);
                        END;
                        RecRef.MODIFY(TRUE);

                    END;

                    // campos virtuales
                    IF rImp."Id Tabla" = 27 THEN BEGIN

                        RecRef.SETTABLE(Item);

                        Item.SetModificadoMdM(TRUE);
                        lwMod := FALSE;

                        rField.SETFILTER("Id Field", '<0');
                        IF rField.FINDSET THEN BEGIN
                            IF rImp.Operacion <> rImp.Operacion::Insert THEN BEGIN
                                Dim1 := Item."Global Dimension 1 Code";
                                Dim2 := Item."Global Dimension 2 Code";
                            END;

                            REPEAT
                                lwFieldValue := rField.GetValue;
                                lwCodDim := '';
                                lwPack := ''; // Inicializamos este valor

                                CASE rField."Id Field" OF
                                    // Unidad de medida
                                    -101:
                                        SetUnid(Item."No.", Item."Base Unit of Measure", 0, StrtoDec(lwFieldValue)); // Ancho
                                    -102:
                                        SetUnid(Item."No.", Item."Base Unit of Measure", 1, StrtoDec(lwFieldValue)); // Alto
                                    -103:
                                        SetUnid(Item."No.", Item."Base Unit of Measure", 2, StrtoDec(lwFieldValue)); // Peso

                                    // Packs
                                    -110:
                                        BEGIN
                                            lwPack := lwFieldValue;
                                            SetProdBOMValue(Item."No.", lwPack, FALSE, 0);
                                        END;
                                    // Unidades Packs
                                    -111:
                                        SetProdBOMValue(Item."No.", lwPack, TRUE, StrtoDec(lwFieldValue));

                                    // Dimensiones Generales
                                    // Codigo de Dimension
                                    -120:
                                        lwCodDim := lwFieldValue;
                                    // Valor de Dimension
                                    -121:
                                        IF lwCodDim <> '' THEN BEGIN
                                            cFuncMdm.ValidaDimValC(Item, lwCodDim, lwFieldValue);
                                            lwMod := TRUE;
                                        END;

                                    // Dimensiones MdM
                                    -299 .. -200:
                                        BEGIN
                                            lwId2 := ABS(rField."Id Field" + 200);
                                            cFuncMdm.ValidaDimValT(Item, lwId2, lwFieldValue);
                                            lwMod := TRUE;
                                        END;

                                    // Precio venta (Sin impuesto)
                                    -324 .. -300:
                                        IF prCab.Entrada = prCab.Entrada::INT_Excel THEN BEGIN
                                            SetPrecioVta(Item."No.", Item."Base Unit of Measure", TODAY, StrtoDec(lwFieldValue), FALSE);
                                        END;
                                    // LOS PRECIOS NO DEBEN DE INFORMARSE NUNCA DESDE EL MDM (Si por Excel)
                                    // -349..-325 Precio venta (Con impuesto)
                                    // -399..-350 Lo reservasmos para precios de compra si algún día hace falta
                                    // -501 Lo reservamos para código de divisa
                                    // -901 Lo reservamos para guardar la Codigo de Articulo Pack Anterior en modificaciones
                                    // cód. barras
                                    // 25/10/2018 Se solicita que la descripción del código de barras sea la del producto
                                    -499 .. -400:
                                        SetRefCruz(Item."No.", Item."Base Unit of Measure", lwFieldValue, Item.Description);

                                    // observaciones
                                    -500:
                                        SetCommentLine(Item."No.", lwFieldValue);

                                    // Autores
                                    -601:
                                        IF GestAutor(Item, lwFieldValue) THEN
                                            lwMod := TRUE;

                                END;
                            UNTIL rField.NEXT = 0;

                            // en el update, si alguna dimensión actualizada es global, hay que actualizar el producto
                            IF (rImp.Operacion = rImp.Operacion::Update) AND
                               (Dim1 <> Item."Global Dimension 1 Code") OR (Dim2 <> Item."Global Dimension 2 Code") THEN
                                lwMod := TRUE;
                        END;
                        Item."Gestionado MdM" := TRUE;
                        CLEAR(rField);
                        IF rImp.Operacion IN [rImp.Operacion::Insert, rImp.Operacion::Update] THEN BEGIN
                            //IF cFuncMdm.ConfiguraTipologiaMdM(Item) THEN
                            IF ConfiguraTipologiaMdM(Item, rImp) THEN
                                lwMod := TRUE;
                        END;
                        // Solo en el insert de la importación por Web Service
                        IF (prCab.Operacion IN [prCab.Operacion::Insert]) AND (prCab.Entrada = prCab.Entrada::INT_WS) THEN BEGIN
                            // MdM Hay una configuración a partir de estructura analítica
                            IF cGestMdM.SetEstrAnalitica(Item) THEN
                                lwMod := TRUE;

                            // Hay una modificación por campos relacionados
                            IF cGestMdM.SetCamposRelacionados(Item) THEN
                                lwMod := TRUE;
                        END;

                        // Hay una modificación por campos relacionados
                        /*
                        CLEAR(rTmpField);
                        IF cGestMdM.SetCamposRelacionados2(Item,rTmpField) THEN
                          lwMod := TRUE;
                        */

                        IF lwMod THEN BEGIN
                            Item.MODIFY;
                            RecRef.GETTABLE(Item);
                        END;
                    END;

                    IF rImp."Id Tabla" = 90 THEN BEGIN // BOM Component
                        RecRef.SETTABLE(lrLinBom); // Añadimos la descripcion
                        IF (lrLinBom.Description = '') OR (lrLinBom."Unit of Measure Code" = '') THEN BEGIN
                            IF Item.GET(lrLinBom."Parent Item No.") THEN BEGIN
                                IF lrLinBom.Description = '' THEN
                                    lrLinBom.Description := Item.Description;
                                IF lrLinBom."Unit of Measure Code" = '' THEN
                                    lrLinBom."Unit of Measure Code" := Item."Base Unit of Measure";
                                lrLinBom.MODIFY(TRUE);
                            END;
                        END;
                    END;

                    // Ahora igual falta por rellenar algún campo por defecto
                    lwMod := FALSE;
                    CLEAR(rField);
                    FOR lwN := 1 TO 4 DO BEGIN
                        CASE lwN OF
                            1:
                                BEGIN
                                    lwId2 := rImp.GetIdTipoField;
                                    lwFieldValue := rImp.GetTipoText;
                                END;
                            2:
                                BEGIN
                                    lwId2 := rImp.GetIdCodeField;
                                    lwFieldValue := rImp.Code;
                                END;
                            3:
                                BEGIN
                                    lwId2 := rImp.GetIdDescField;
                                    lwFieldValue := rImp.Descripcion;
                                END;
                            4:
                                BEGIN
                                    lwId2 := GetBlockedFieldNo(rImp."Id Tabla");
                                    lwFieldValue := rImp.GetBloqueadoTx;
                                END; // No Visible
                        END;
                        IF (lwId2 <> 0) AND (lwFieldValue <> '') THEN BEGIN
                            IF NOT IsFieldPrimKey(RecRef, lwId2) THEN BEGIN // Si no es clave primaria (se supone que ya se ha rellenado)
                                FieRef := RecRef.FIELD(lwId2);
                                IF (NOT rField.GET(rImp.Id, lwId2)) OR (FORMAT(FieRef.VALUE) <> lwFieldValue) THEN BEGIN
                                    SetFieldValue(FieRef, lwFieldValue, (lwN <> 4)); // No validamos el campo bloqueado
                                    lwMod := TRUE;
                                END;
                            END;
                        END;
                    END;


                    IF lwMod THEN
                        RecRef.MODIFY;
                END;

                RecRef.CLOSE;
                rImp.Procesado := TRUE;
                rImp.MODIFY;
                IF prCab.Entrada = prCab.Entrada::INT_Excel THEN
                    COMMIT;
            UNTIL rImp.NEXT = 0;

            IF lwVerDia THEN
                wDia.CLOSE;
        END;

    end;

    procedure ConvierteTabl(var prImp Record: 75004; pwError: Boolean)
    var
        lwForce: Boolean;
        lwOK: Boolean;
        lwTipo: Integer;
        lwId: Integer;
        lwExists: Boolean;
    begin
        // ConvierteTabl

        IF (prImp.Code <> '') OR (prImp."Code MdM" = '') THEN
            EXIT;

        lwExists := FALSE;
        CASE prImp."Id Tabla" OF
            // Producto
            27:
                BEGIN
                    pwError := pwError AND (rCab.Operacion <> rCab.Operacion::Insert);
                    prImp.Code := GetProdNav(prImp."Code MdM", pwError);
                    IF prImp.Code <> '' THEN
                        prImp.MODIFY;
                END;

            90:
                BEGIN // Production BOM Line : BEGIN // Production BOM Header
                    prImp.Code := GetProdNav(prImp."Code MdM", pwError);
                    IF prImp.Code <> '' THEN
                        prImp.MODIFY;
                END;

            349:
                BEGIN
                    lwId := ABS(prImp.Tipo + 200);
                    lwTipo := rConvNM.GetTipoDim(lwId);
                    CASE lwId OF
                        // Dim Series
                        0:
                            BEGIN
                                lwForce := prImp.Operacion = prImp.Operacion::Insert;
                                IF lwForce THEN
                                    prImp.Code := 'Z' + prImp."Code MdM";
                                IF rConvNM.GetMdm2NAV(lwTipo, prImp."Code MdM", prImp.Code, lwForce, (NOT lwForce) AND pwError) THEN
                                    prImp.MODIFY;
                            END;
                        // Dim Cuenta
                        2:
                            BEGIN // Si no existe le incorporamos una Z
                                lwForce := prImp.Operacion = prImp.Operacion::Insert;
                                IF lwForce THEN BEGIN
                                    lwExists := cFuncMdm.ExistDimValT(lwId, prImp."Code MdM");
                                    IF lwExists THEN
                                        prImp.Code := 'Z' + prImp."Code MdM"
                                    ELSE BEGIN
                                        prImp.Code := prImp."Code MdM";
                                        prImp.MODIFY;
                                    END;
                                END;
                                IF NOT lwExists THEN
                                    IF rConvNM.GetMdm2NAV(lwTipo, prImp."Code MdM", prImp.Code, lwForce, (NOT lwForce) AND pwError) THEN
                                        prImp.MODIFY;
                            END;
                        // Otros
                        ELSE BEGIN
                            IF rConvNM.GetMdm2NAV(lwTipo, prImp."Code MdM", prImp.Code, FALSE, pwError) THEN
                                prImp.MODIFY;
                        END;
                    END;
                END;

            75008:
                BEGIN // Autores Producto
                    prImp.Code := GetProdNav(prImp."Code MdM", TRUE);
                    IF prImp.Code <> '' THEN
                        prImp.MODIFY;
                END;


            ELSE BEGIN
                lwTipo := rConvNM.GetTipoTable(prImp);
                IF lwTipo > -1 THEN
                    IF rConvNM.GetMdm2NAV(lwTipo, prImp."Code MdM", prImp.Code, FALSE, pwError) THEN
                        prImp.MODIFY;
            END;
        END;
    end;

    procedure ConvierteField(var prImp Record: 75004; var prField Record: 75005; pwError: Boolean)
    var
        lrProd: Record 27;
        lwOK: Boolean;
        lwTipo: Integer;
        lwId: Integer;
        lwCode: Code[20];
        lwErr2: Boolean;
    begin
        // ConvierteField

        IF (prField.Value <> '') OR (prField."MdM Value" = '') THEN
            EXIT;

        lwErr2 := pwError;
        CASE prImp."Id Tabla" OF
            //27 : lwErr2 := lwErr2 AND (prImp.Operacion <> prImp.Operacion::Insert);
            27:
                CASE prField."Id Field" OF // Producto
                    1:
                        BEGIN // Clave primaria
                            prField.Value := prImp.Code;
                            prField.MODIFY;
                        END;
                END;
            90:
                BEGIN // Production BOM Line
                    CASE prField."Id Field" OF
                        1, 4:
                            BEGIN
                                prField.Value := GetProdNav(prField."MdM Value", TRUE);
                                prField.MODIFY;
                            END;

                    END;
                END;
        END;

        IF (prField.Value <> '') OR (prField."MdM Value" = '') THEN
            EXIT;

        CASE prImp."Id Tabla" OF
            // Espacio destinado a casos especiales
            // ************
            ELSE BEGIN
                lwTipo := rConvNM.GetTipoField(prImp, prField);
                IF lwTipo > -1 THEN BEGIN
                    IF rConvNM.GetMdm2NAV(lwTipo, prField."MdM Value", lwCode, FALSE, lwErr2) THEN BEGIN
                        prField.Value := lwCode;
                        prField.MODIFY;
                    END;
                END;
            END;
        END;
    end;

    local procedure SetRefCruz(pwItemNo: Code[20]; pwCodUnidadBase: Code[10]; pwEan: Code[20]; pwDescrip: Text)
    var
        lrRef Record: 5717;
    begin
        // SetRefCruz
        // Crea y actualiza una referencia cruzada si no existe
        // Para codigos de barra

        CLEAR(lrRef);
        lrRef.SETRANGE("Item No.", pwItemNo);
        lrRef.SETRANGE("Cross-Reference Type", lrRef."Cross-Reference Type"::"Bar Code");
        // lrRef.SETRANGE("Unit of Measure", pwCodUnidadBase);
        lrRef.SETFILTER("Unit of Measure", '%1|%2', pwCodUnidadBase, '');
        lrRef.SETRANGE("Cross-Reference No.", pwEan);
        IF lrRef.FINDFIRST THEN
            EXIT;

        lrRef.SETRANGE("Cross-Reference No.");
        lrRef.DELETEALL;

        IF pwEan <> '' THEN BEGIN
            lrRef.SETRANGE("Cross-Reference Type");
            lrRef.SETRANGE("Cross-Reference No.", pwEan);
            lrRef.DELETEALL;

            CLEAR(lrRef);
            lrRef."Item No." := pwItemNo;
            lrRef."Unit of Measure" := pwCodUnidadBase;
            lrRef."Cross-Reference Type" := lrRef."Cross-Reference Type"::"Bar Code";
            lrRef."Cross-Reference No." := pwEan;
            lrRef.Description := COPYSTR(pwDescrip, 1, MAXSTRLEN(lrRef.Description));
            lrRef.INSERT(TRUE);
        END;
    end;

    local procedure SetUnid(pwItemNo: Code[20]; pwCodUnidadBase: Code[10]; pwTipo: Option Ancho,Alto,Peso; pwValor: Decimal)
    var
        lrUnid Record: 5404;
    begin
        // SetUnid
        // Determina elementos de la unidad de medida

        IF pwItemNo = '' THEN
            EXIT;

        CLEAR(lrUnid);
        IF NOT lrUnid.GET(pwItemNo, pwCodUnidadBase) THEN BEGIN
            lrUnid."Item No." := pwItemNo;
            lrUnid.Code := pwCodUnidadBase;
            lrUnid."Qty. per Unit of Measure" := 1;
            lrUnid.INSERT(TRUE);
        END;

        CASE pwTipo OF
            pwTipo::Ancho:
                lrUnid.Width := pwValor;
            pwTipo::Alto:
                lrUnid.Height := pwValor;
            pwTipo::Peso:
                lrUnid.Weight := pwValor;
            ELSE
                EXIT;
        END;

        lrUnid.SetModificadoMdM(TRUE);
        lrUnid.MODIFY(TRUE);
    end;

    local procedure GetUnid(pwItemNo: Code[20]; pwCodUnidadBase: Code[10]; pwTipo: Option Ancho,Alto,Peso) wValor: Decimal
    var
        lrUnid Record: 5404;
    begin
        // GetUnid
        // Devuelve elementos de la unidad de medida

        IF pwItemNo = '' THEN
            EXIT;

        CLEAR(lrUnid);
        IF lrUnid.GET(pwItemNo, pwCodUnidadBase) THEN BEGIN
            CASE pwTipo OF
                pwTipo::Ancho:
                    wValor := lrUnid.Width;
                pwTipo::Alto:
                    wValor := lrUnid.Height;
                pwTipo::Peso:
                    wValor := lrUnid.Weight;
            END;
        END;
    end;

    local procedure SetPrecioVta(pwItemNo: Code[20]; pwCodUnidadBase: Code[10]; pwFecha: Date; pwPrecio: Decimal; pwImpInc: Boolean)
    var
        lrPrec Record: 7002;
        lwExits: Boolean;
        lwIgual: Boolean;
        lwFecha2: Date;
    begin
        // SetPrecioVta

        IF pwFecha = 0D THEN
            pwFecha := TODAY;

        lwIgual := FALSE;

        CLEAR(lrPrec);
        lrPrec.SETRANGE("Item No.", pwItemNo);
        lrPrec.SETRANGE("Sales Type", lrPrec."Sales Type"::"All Customers");
        lrPrec.SETFILTER("Sales Code", '');
        lrPrec.SETFILTER("Currency Code", '%1', '');
        lrPrec.SETRANGE("Unit of Measure Code", pwCodUnidadBase);
        lrPrec.SETFILTER("Starting Date", '<=%1', pwFecha);
        lrPrec.SETFILTER("Ending Date", '>%1|%2', pwFecha, 0D);
        lrPrec.SETRANGE("Price Includes VAT", pwImpInc);
        lwExits := lrPrec.FINDLAST;
        IF lwExits THEN BEGIN
            lwIgual := lrPrec."Unit Price" = pwPrecio;
        END;

        IF NOT lwIgual THEN BEGIN
            IF lwExits THEN BEGIN // Cerramos el precio anterior
                lwFecha2 := CALCDATE('<-1D>', pwFecha);
                IF (lwFecha2 <> lrPrec."Ending Date") AND (lrPrec."Sales Type" <> lrPrec."Sales Type"::Campaign) THEN BEGIN
                    lrPrec.VALIDATE("Ending Date", lwFecha2);
                    lrPrec.SetModificadoMdM(TRUE);
                    lrPrec.MODIFY(TRUE);
                END;
            END;

            CLEAR(lrPrec);
            lrPrec.VALIDATE("Item No.", pwItemNo);
            lrPrec."Sales Type" := lrPrec."Sales Type"::"All Customers"; // ***
            lrPrec.VALIDATE("Sales Code", '');
            lrPrec.VALIDATE("Unit of Measure Code", pwCodUnidadBase);
            lrPrec.VALIDATE("Starting Date", pwFecha);
            lrPrec.VALIDATE("Unit Price", pwPrecio);
            lrPrec."Currency Code" := '';
            lrPrec."Price Includes VAT" := pwImpInc;
            lrPrec.INSERT(TRUE)
        END;
    end;

    local procedure StrtoDec(pwTexto: Text[1024]) Dec: Decimal
    begin
        // StrtoDec

        IF pwTexto = '' THEN
            pwTexto := '0';
        Dec := 0;
        EVALUATE(Dec, pwTexto);
    end;

    procedure SetProdBOMValue(pwCodItem: Code[20]; pwCod: Code[20]; pwSetVal: Boolean; pwUnidades: Decimal)
    var
        lrLinBOM Record: 90;
        lwLinNo: Integer;
    begin
        // SetProdBOMValue
        IF pwCod = '' THEN
            EXIT;


        CLEAR(lrLinBOM);
        lrLinBOM.SETRANGE("Parent Item No.", pwCod);
        lrLinBOM.SETRANGE(Type, lrLinBOM.Type::Item);
        lrLinBOM.SETRANGE("No.", pwCodItem);
        IF lrLinBOM.FINDFIRST THEN BEGIN
            IF pwSetVal THEN BEGIN
                IF lrLinBOM."Quantity per" <> pwUnidades THEN BEGIN
                    lrLinBOM.VALIDATE("Quantity per", pwUnidades);
                    lrLinBOM.MODIFY;
                END;
            END;
        END
        ELSE BEGIN
            // Buscamos el útlimo Nº de línea
            CLEAR(lwLinNo);
            CLEAR(lrLinBOM);
            lrLinBOM.SETRANGE("Parent Item No.", pwCod);
            IF lrLinBOM.FINDLAST THEN
                lwLinNo := lrLinBOM."Line No.";
            lwLinNo := lwLinNo + 10000;

            CLEAR(lrLinBOM);
            lrLinBOM.VALIDATE("Parent Item No.", pwCod);
            lrLinBOM.VALIDATE("Line No.", lwLinNo);
            lrLinBOM.VALIDATE(Type, lrLinBOM.Type::Item);
            lrLinBOM.VALIDATE("No.", pwCodItem);
            IF pwSetVal THEN
                lrLinBOM.VALIDATE("Quantity per", pwUnidades);
            lrLinBOM.INSERT(TRUE);
        END;
    end;

    procedure DeleteReg(prImp Record: 75004; var pwRecRef: RecordRef)
    var
        lwFieldN: Integer;
        lwFieRef: FieldRef;
        lwVal: Boolean;
    begin
        // DeleteReg
        // Borra el registro o lo marca como bloqueado, según la tabla

        IF (prImp."Id Tabla" = 0) OR (prImp.Operacion <> prImp.Operacion::Delete) THEN
            EXIT;
        // lwField es el id del campo bloqueado de la tabla
        // Si no se le asigna (no tiene) el registro se borrará, sino se marcará bloqueado
        lwFieldN := 0;
        //IF pwRecRef.FIND THEN BEGIN
        // Provocamos un error si no se encuentra
        pwRecRef.FIND;
        BEGIN
            lwFieldN := GetBlockedFieldNo(prImp."Id Tabla");

            IF lwFieldN = 0 THEN
                pwRecRef.DELETE(TRUE)
            ELSE BEGIN
                lwFieRef := pwRecRef.FIELD(lwFieldN);
                lwVal := lwFieRef.VALUE;
                IF NOT lwVal THEN BEGIN // Marca como bloqueado
                    lwFieRef.VALIDATE(TRUE);
                    pwRecRef.MODIFY(TRUE);
                END;
            END;
        END;
    end;

    procedure InsertReg(prImp Record: 75004; var pwRecRef: RecordRef)
    var
        lwFieldN: Integer;
        lwFieRef: FieldRef;
        lwField2: FieldRef;
        lwVal: Boolean;
        lwUpdated: Boolean;
        lwMngd: Boolean;
        lrPK: KeyRef;
        lwN: Integer;
        lwNo: Code[20];
        lwSerie: Code[10];
    begin
        // InsertReg
        // Inserta el registro o lo marca como NO bloqueado, según la tabla

        IF (prImp."Id Tabla" = 0) OR (prImp.Operacion = prImp.Operacion::Delete) THEN
            EXIT;

        // lwField es el id del campo bloqueado de la tabla
        lwFieldN := 0;
        lwMngd := TRUE;
        IF pwRecRef.FIND THEN BEGIN
            lwUpdated := MdmManaged(prImp, pwRecRef, lwMngd);
            IF rCab.Entrada <> rCab.Entrada::INT_Excel THEN
                lwFieldN := GetBlockedFieldNo(prImp."Id Tabla");

            IF lwFieldN <> 0 THEN BEGIN
                lwFieRef := pwRecRef.FIELD(lwFieldN);
                lwVal := lwFieRef.VALUE;
                IF lwVal THEN BEGIN // desbloquea
                    lwFieRef.VALIDATE(FALSE);
                    IF NOT lwUpdated THEN
                        lwUpdated := TRUE;
                END;
            END;

            IF lwUpdated THEN
                pwRecRef.MODIFY(TRUE);

        END
        ELSE BEGIN
            IF rCab.Entrada = rCab.Entrada::INT_WS THEN BEGIN
                IF prImp."Id Tabla" = 27 THEN BEGIN
                    lwFieRef := pwRecRef.FIELD(1); // No. de lo dejamos en blanco
                    lwFieRef.VALUE := '';

                    // Buscamos en la configuración de tipologia
                    lwSerie := GestSerieTip(prImp);
                    // Si no está configurada, buscamos la serie por defecto
                    IF lwSerie = '' THEN
                        lwSerie := rConfMdM."Serie Producto";

                    IF lwSerie <> '' THEN BEGIN
                        lwNo := '';
                        NoSeriesMgt.InitSeries(lwSerie, lwSerie, 0D, lwNo, lwSerie);
                        lwFieRef.VALUE := lwNo;
                        // le ponemos la serie
                        lwFieRef := pwRecRef.FIELD(97); // Serie

                        lwFieRef.VALUE := lwSerie;
                    END;
                    // En algunos paises la serie viene dada por la Conf. Tipologias

                END;
            END;
            MdmManaged(prImp, pwRecRef, lwMngd);
            pwRecRef.INSERT(TRUE);

            // Esto es despues de la insercción
            IF EsProducto THEN BEGIN
                // Le ponemos la unidad de medida base
                rConfMdM.TESTFIELD("Base Unit of Measure");
                lwFieRef := pwRecRef.FIELD(8); // Unidad de Medida Base
                lwFieRef.VALIDATE(rConfMdM."Base Unit of Measure");
                IF rCab.Entrada <> rCab.Entrada::INT_Excel THEN BEGIN
                    lwFieRef := pwRecRef.FIELD(54); // Bloqueado
                    lwFieRef.VALUE := FALSE; // Por defecto se bloquea, lo desbloqueamos
                END;
                pwRecRef.MODIFY;
            END;

            // Si se crea la clave primaria, la rellenamos en la tabla de campos
            lrPK := pwRecRef.KEYINDEX(1);
            CLEAR(rField);
            FOR lwN := 1 TO lrPK.FIELDCOUNT DO BEGIN
                lwField2 := lrPK.FIELDINDEX(lwN);
                IF rField.GET(rImp.Id, lwField2.NUMBER) THEN BEGIN
                    IF (rField.Value = '') THEN BEGIN
                        rField.Value := FORMAT(lwField2.VALUE);
                        rField.MODIFY;
                    END;
                END;
                IF rImp.Code = '' THEN BEGIN
                    IF rImp.GetIdCodeField = lwField2.NUMBER THEN BEGIN
                        rImp.Code := FORMAT(lwField2.VALUE);
                        rImp.MODIFY;
                    END;
                END;
            END;
        END;
    end;

    procedure MdmManaged(prImp Record: 75004; var pwRecRef: RecordRef; pwMngd: Boolean) Updated: Boolean
    var
        lwFieldN: Integer;
        lwFieRef: FieldRef;
        lwVal: Boolean;
    begin
        // MdmManaged
        // marcamos el registro para que se gestione desde el MdM

        Updated := FALSE; // si se actualiza el valor, devolveremos TRUE

        IF rCab.Entrada <> rCab.Entrada::INT_WS THEN
            EXIT;
        lwFieldN := GetFieldMdMMngd(prImp."Id Tabla");
        IF lwFieldN <> 0 THEN BEGIN
            lwFieRef := pwRecRef.FIELD(lwFieldN);
            lwVal := lwFieRef.VALUE;
            IF lwVal <> pwMngd THEN BEGIN
                lwFieRef.VALUE := pwMngd;
                Updated := TRUE;
            END;
        END;
    end;

    procedure GetBlockedFieldNo(pwTableId: Integer) wField: Integer
    begin
        // GetBlockedFieldNo

        wField := 0;
        CASE pwTableId OF
            75001:
                wField := 5;      // Datos MdM
            56003:
                wField := 50;     // Sello/Marca
            349:
                wField := 6;      // Dimension Value
            56007:
                wField := 50;     // Edicion
            75002:
                wField := 50;     // Estructura Analitica
            56008:
                wField := 50;     // Estado productos
            27:
                wField := 54;     // Item
            9:
                wField := 75000;  // Country/Region
            8:
                wField := 75000;  // Language
            75010:
                wField := 50;     // Sociedad Comercializadora
            75009:
                wField := 50;     // Tipo Autoria
            5722:
                wField := 75000;  // Item Category
        END;
    end;

    procedure GetFieldMdMMngd(pwTableId: Integer) wField: Integer
    begin

        wField := 0;
        CASE pwTableId OF
            27:
                wField := 75000; // producto y LM
            5722:
                wField := 75001; // Categoria de producto
        END;
    end;

    procedure SetCommentLine(pwCodPro: Code[20]; pwComment: Text)
    var
        lrComntLine Record: 97;
        lwNxtLine: Integer;
        lwComment2: Text;
        lwMax: Integer;
        lwEnc: Boolean;
    begin
        // SetCommentLine

        CLEAR(lrComntLine);

        lwComment2 := DELCHR(pwComment, '<>');
        IF lwComment2 = '' THEN
            EXIT;

        lwMax := MAXSTRLEN(lrComntLine.Comment);
        IF STRLEN(lwComment2) > lwMax THEN BEGIN
            lwComment2 := COPYSTR(lwComment2, 1, lwMax);
            lwComment2 := DELCHR(lwComment2, '<>'); // Borramos espacios en blanco
        END;

        lrComntLine.SETRANGE("Table Name", lrComntLine."Table Name"::Item);
        lrComntLine.SETRANGE("No.", pwCodPro);
        lrComntLine.SETRANGE(Comment, lwComment2);
        lwEnc := lrComntLine.FINDFIRST; // Comprobamos que no exista yá el comentario

        IF NOT lwEnc THEN BEGIN
            // Buscamos el último no de línea
            CLEAR(lrComntLine);
            lrComntLine.SETRANGE("Table Name", lrComntLine."Table Name"::Item);
            lrComntLine.SETRANGE("No.", pwCodPro);
            IF lrComntLine.FINDLAST THEN
                lwNxtLine := lrComntLine."Line No." + 10000
            ELSE
                lwNxtLine := 10000;

            lrComntLine.RESET;
            lrComntLine.INIT;
            lrComntLine."Table Name" := lrComntLine."Table Name"::Item;
            lrComntLine."No." := pwCodPro;
            lrComntLine."Line No." := lwNxtLine;
            lrComntLine.Date := TODAY;
            lrComntLine.Comment := lwComment2;
            lrComntLine.INSERT;
        END;
    end;

    procedure FillPrimKey(pwRecRef: RecordRef)
    var
        lrPK: KeyRef;
        lwN: Integer;
        lwField2: FieldRef;
        lwCod: Code[20];
        lwNo: Code[20];
        lwOK: Boolean;
        lwFind: Boolean;
        lwRename: Boolean;
    begin
        // FillPrimKey
        // Rellena los valores de la clave primaria

        CLEAR(lwRename);
        IF rImp.Operacion = rImp.Operacion::Update THEN BEGIN
            rImp.CALCFIELDS(rImp.Rename);
            lwRename := rImp.Rename;
        END;

        lrPK := pwRecRef.KEYINDEX(1);

        CLEAR(rField);

        FOR lwN := 1 TO lrPK.FIELDCOUNT DO BEGIN
            lwField2 := lrPK.FIELDINDEX(lwN);
            IF rField.GET(rImp.Id, lwField2.NUMBER) THEN BEGIN // Los campos de la clave primaria deben de existir
                SetFieldValue(lwField2, rField.Value, FALSE); // Por defecto No validamos la clave primaria
                rField.PK := TRUE; // Indicamos que forma parte de la clave primaria
                rField.MODIFY;
            END
            ELSE BEGIN
                CASE lwField2.NUMBER OF
                    rImp.GetIdTipoField:
                        SetFieldValue(lwField2, rImp.GetTipoText, FALSE); // Por defecto No validamos la clave primaria
                    rImp.GetIdCodeField:
                        SetFieldValue(lwField2, rImp.Code, FALSE);
                    rImp.GetIdDescField:
                        SetFieldValue(lwField2, rImp.Descripcion, FALSE);
                END;
            END;
        END;

        // Aqui tenemos un problema por tener distinta clave primaria
        IF rImp."Id Tabla" = 90 THEN BEGIN // BOM Component
            lwField2 := pwRecRef.FIELD(1); // Parent Item No.
            lwCod := rImp.Code;
            lwField2.SETRANGE(lwCod);
            lwField2 := pwRecRef.FIELD(4); //No.
            lwOK := FALSE;
            lwFind := FALSE;
            IF rImp.Operacion = rImp.Operacion::Update THEN
                lwFind := rField.GET(rImp.Id, -901);  // Valor Anterior
            IF NOT lwFind THEN
                lwFind := rField.GET(rImp.Id, 4);  //No.

            IF lwFind THEN BEGIN
                lwNo := rField.Value;
                lwField2.SETRANGE(lwNo);
                lwOK := pwRecRef.FINDFIRST;
            END;

            IF NOT lwOK THEN BEGIN
                lwField2 := pwRecRef.FIELD(2); //Line No.
                IF rImp.Operacion = rImp.Operacion::Insert THEN
                    lwField2.VALUE := BuscaSigumOrden(lwCod)
                ELSE
                    lwField2.VALUE := 0;
            END;
        END;

        IF lwRename THEN
            RenameRec(pwRecRef);
    end;

    procedure FindPrimKey(pwRecRef: RecordRef; var pwPKVal: array[10] of Variant) wNoFlds: Integer
    var
        lrPK: KeyRef;
        lwN: Integer;
        lwField2: FieldRef;
    begin
        // FindPrimKey
        // Devuelve la clave primaria del registro en un array(10) pwPKVal Por Dios que debería de bastar.
        // Devuelve el número de campos encontrados

        wNoFlds := 0;
        CLEAR(pwPKVal);

        lrPK := pwRecRef.KEYINDEX(1);

        CLEAR(rField);
        FOR lwN := 1 TO lrPK.FIELDCOUNT DO BEGIN
            lwField2 := lrPK.FIELDINDEX(lwN);
            IF rField.GET(rImp.Id, lwField2.NUMBER) THEN BEGIN // Los campos de la clave primaria deben de existir
                pwPKVal[lwN] := lwField2.VALUE;
                wNoFlds += 1;
            END;
        END;
    end;

    procedure FindPrimKeyIdField(pwRecRef: RecordRef; var pwPKIdFields: array[10] of Integer) wNoFlds: Integer
    var
        lrPK: KeyRef;
        lwN: Integer;
        lwField2: FieldRef;
    begin
        // FindPrimKeyIdField
        // Devuelve la clave primaria del registro en un array(10) pwPKIdFields (Por Dios que debería de bastar). El array es de integer, id de campos
        // Devuelve el número de campos encontrados


        CLEAR(pwPKIdFields);
        lrPK := pwRecRef.KEYINDEX(1);
        wNoFlds := lrPK.FIELDCOUNT;
        FOR lwN := 1 TO wNoFlds DO BEGIN
            lwField2 := lrPK.FIELDINDEX(lwN);
            pwPKIdFields[lwN] := lwField2.NUMBER;
        END;
    end;

    procedure IsFieldPrimKey(pwRecRef: RecordRef; pwFieldNo: Integer) wIsPK: Boolean
    var
        lrPK: KeyRef;
        lwN: Integer;
        lwField2: FieldRef;
    begin
        // IsFieldPrimKey
        // Devuelve True si el campo indicado está en la clave primaria
        // Devuelve el número de campos encontrados


        wIsPK := FALSE;
        lrPK := pwRecRef.KEYINDEX(1);
        FOR lwN := 1 TO lrPK.FIELDCOUNT DO BEGIN
            lwField2 := lrPK.FIELDINDEX(lwN);
            IF pwFieldNo = lwField2.NUMBER THEN
                EXIT(TRUE);
        END;
    end;

    procedure RenameRec(pwRecRef: RecordRef)
    var
        lwPKIdFields: array[10] of Integer;
        lwNoFields: Integer;
        lwFieldVals: array[10] of Variant;
        lwField2: FieldRef;
        lwN: Integer;
    begin
        // RenameRec
        // Renombra la tabla

        CLEAR(lwFieldVals);
        lwNoFields := FindPrimKeyIdField(pwRecRef, lwPKIdFields);

        FOR lwN := 1 TO lwNoFields DO BEGIN
            lwField2 := pwRecRef.FIELD(lwPKIdFields[lwNoFields]);
            IF rField.GET(rImp.Id, lwPKIdFields[lwNoFields]) AND (rField."Renamed Val" <> '') THEN
                GetFieldValue(lwField2, rField."Renamed Val", lwFieldVals[lwN])
            ELSE
                lwFieldVals[lwN] := lwField2.VALUE;
        END;

        // Creo que con 5 debe de bastar
        CASE lwNoFields OF
            1:
                pwRecRef.RENAME(lwFieldVals[1]);
            2:
                pwRecRef.RENAME(lwFieldVals[1], lwFieldVals[2]);
            3:
                pwRecRef.RENAME(lwFieldVals[1], lwFieldVals[2], lwFieldVals[3]);
            4:
                pwRecRef.RENAME(lwFieldVals[1], lwFieldVals[2], lwFieldVals[3], lwFieldVals[4]);
            5:
                pwRecRef.RENAME(lwFieldVals[1], lwFieldVals[2], lwFieldVals[3], lwFieldVals[4], lwFieldVals[5]);
        END;
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
                        lwOK := EVALUATE(ValDate, pwValue, 9); // 9 Es el formato XML
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
                    // Si la cadena es demasiado larga, la trunca
                    IF pwFieRef.LENGTH < STRLEN(pwValue) THEN
                        pwValue := COPYSTR(pwValue, 1, pwFieRef.LENGTH);
                    pwVariant := pwValue;
                END
            ELSE
                ERROR(Text001, FORMAT(pwFieRef.TYPE), pwFieRef.CAPTION);
        END;
    end;

    procedure SetFieldValue(var pwFieRef: FieldRef; pwValue: Text; pwValida: Boolean)
    var
        lwValue: Variant;
    begin
        // SetFieldValue
        // Asigna o Valida un valor a un campo

        GetFieldValue(pwFieRef, pwValue, lwValue);

        IF pwValida THEN
            pwFieRef.VALIDATE(lwValue)
        ELSE
            pwFieRef.VALUE := lwValue;
    end;

    procedure GeOptionValueId(pwOptionValue: Text; pwValue: Text) wId: Integer
    var
        lwOptValues: Text;
        lwPs: Integer;
        lwActVal: Text;
        lwId: Integer;
        lwTotal: Integer;
    begin
        // GeOptionValueId
        // Devolvemos el valor del Id del option (valores separados por comas)
        // Si no lo encuetra devuelve -1;

        wId := -1;

        pwOptionValue := UPPERCASE(DELCHR(pwOptionValue, '<>'));
        lwOptValues := pwOptionValue;
        pwValue := UPPERCASE(DELCHR(pwValue, '<>')); // Le quitamos los valors vacios al principio y fin

        /* Decidimos hacerlo de otro modo
        lwId := 0;
        REPEAT
          lwPs := STRPOS(lwOptValues,',');
          IF lwPs > 0 THEN BEGIN
            lwActVal    := COPYSTR(lwOptValues,1, lwPs-1);
            lwOptValues := COPYSTR(lwOptValues, lwPs+1);
          END
          ELSE
            lwActVal := lwOptValues;
          lwActVal := DELCHR(lwActVal, '<>'); // Le quitamos los valors vacios al principio y fin
          IF lwActVal = pwValue THEN
            wId := lwId;
          lwId +=1;
        UNTIL (lwPs=0) OR (wId > -1);
        */

        // Contamos cuantas posiciones tiene (comas +1)
        lwTotal := 0;
        REPEAT
            lwPs := STRPOS(lwOptValues, ',');
            IF lwPs > 0 THEN
                lwOptValues := COPYSTR(lwOptValues, lwPs + 1);
            lwTotal += 1;
        UNTIL (lwPs = 0);

        FOR lwId := 1 TO lwTotal DO BEGIN
            IF pwValue = SELECTSTR(lwId, pwOptionValue) THEN
                EXIT(lwId - 1); // Los option empiezan por 0
        END;

    end;

    procedure GetTableCaption(pwId: Integer) wText: Text
    var
        lrObjects Record: 2000000001;
        lrObjects2Record 2000000058;
    begin
        // GetTableCaption
        // Devuelve el caption de la tabla

        wText := '';
        /*
        CLEAR(lrObjects);
        lrObjects.SETRANGE(Type, lrObjects.Type::Table);
        lrObjects.SETRANGE(ID, pwId);
        IF lrObjects.FINDFIRST THEN BEGIN
          lrObjects.CALCFIELDS(Caption);
          wText := lrObjects.Caption;
        END;
        */

        CLEAR(lrObjects2);
        lrObjects2.SETRANGE("Object Type", lrObjects2."Object Type"::Table);
        lrObjects2.SETRANGE("Object ID", pwId);
        IF lrObjects2.FINDFIRST THEN BEGIN
            //lrObjects2.CALCFIELDS("Object Caption");
            wText := lrObjects2."Object Caption";
        END;

    end;

    procedure GetFieldCaption(pwTableId: Integer; pwFieldId: Integer) wText: Text
    var
        lrFields Record: 2000000041;
        LTEXT0001: Label 'Ancho';
        LTEXT0002: Label 'Alto';
        LTEXT0003: Label 'Peso';
        LTEXT0004: Label 'Dimensiones';
        LTEXT0005: Label 'Precio Venta';
        LTEXT0006: Label 'Cód. Barras';
        LTEXT0007: Label 'Observaciones';
        lwIdDim: Integer;
        LTEXT0008: Label 'Código Pack';
        LTEXT0009: Label 'Unidades Pack';
        LTEXT0010: Label 'Codigo Dimensión';
        LTEXT0011: Label 'Valor Dimensión';
        LTEXT0012: Label 'Moneda';
    begin
        // GetFieldCaption

        wText := '';

        IF pwFieldId > 0 THEN BEGIN // Campos Reales
            CLEAR(lrFields);
            lrFields.SETRANGE(TableNo, pwTableId);
            lrFields.SETRANGE("No.", pwFieldId);
            IF lrFields.FINDFIRST THEN BEGIN
                //lrFields.CALCFIELDS("Field Caption");
                wText := lrFields."Field Caption";
            END;
        END
        ELSE BEGIN // Campos virtuales
            CASE pwTableId OF
                27:
                    BEGIN
                        CASE pwFieldId OF
                            -101:
                                wText := LTEXT0001;
                            -102:
                                wText := LTEXT0002;
                            -103:
                                wText := LTEXT0003;
                            -110:
                                wText := LTEXT0008;
                            -111:
                                wText := LTEXT0009;
                            -120:
                                wText := LTEXT0010;
                            -121:
                                wText := LTEXT0011;

                            -299 .. -200:
                                BEGIN // Dimensiones
                                    lwIdDim := pwFieldId + 200;
                                    wText := cFuncMdm.GetDimCode(lwIdDim, FALSE);
                                END;
                            -349 .. -300:
                                wText := LTEXT0005;
                            -499 .. -400:
                                wText := LTEXT0006;
                            -500:
                                wText := LTEXT0007;
                            -501:
                                wText := LTEXT0012;
                        END;
                    END;
            END;
        END;
    end;

    procedure EsNulo(pwValue: Text) wIsNull: Boolean
    begin
        // EsNulo
        // Determina si es un valor Nulo

        pwValue := DELCHR(pwValue, '<>');
        wIsNull := UPPERCASE(pwValue) = 'NULL';
    end;

    procedure ExpMigracion(prProd: Record 27)
    var
        lwFileName: Text;
        lwFileName2: Text;
        lwFile: File;
        lwOutStr: OutStream;
        lText001: Label 'Guardar Archivo';
        lwXML: XMLport "75004;
    begin
        // ExpMigracion2

        lwFileName := cFileMng.ServerTempFileName('xml');

        lwFile.CREATE(lwFileName);
        lwFile.CREATEOUTSTREAM(lwOutStr);
        XMLPORT.EXPORT(XMLPORT::"MDM-Migracion Inicial Art.", lwOutStr, prProd);
        lwFile.CLOSE;


        //lwFileName2 := cFileMng.SaveFileDialog(lText001,'','XML|*.XML');
        cFileMng.DownloadHandler(lwFileName, lText001, '', 'XML|*.XML', lwFileName2);
    end;

    procedure GetProdNav(pwCodMdm: Code[20]; pwError: Boolean) wCodNav: Code[20]
    var
        lwOK: Boolean;
        lrProd: Record 27;
    begin
        // GetProdNav

        wCodNav := '';

        CLEAR(lrProd);
        lrProd.SETRANGE("No. 2", pwCodMdm);
        IF pwError THEN BEGIN
            lrProd.FINDFIRST;
            lwOK := TRUE;
        END
        ELSE
            lwOK := lrProd.FINDFIRST;
        IF lwOK THEN
            wCodNav := lrProd."No.";
    end;

    procedure GestAutor(var prProd: Record 27; pwValue: Code[20]) Result: Boolean
    var
        lwAutorCatalogo: Boolean;
        lrField2Record 75005;
    begin
        // GestAutor

        lwAutorCatalogo := FALSE;

        CLEAR(lrField2);
        // Mira si es un autor de catálogo
        IF lrField2.GET(rImp.Id, -600) THEN
            EVALUATE(lwAutorCatalogo, lrField2.GetValue);

        // Si no miramos si es un cambio del valor actual
        IF NOT lwAutorCatalogo THEN BEGIN
            IF lrField2.GET(rImp.Id, -602) THEN // Valor Anterior
                lwAutorCatalogo := (prProd.Autor = lrField2.GetValue);
        END;

        lwAutorCatalogo := lwAutorCatalogo AND (prProd.Autor <> pwValue);

        Result := lwAutorCatalogo;
        IF lwAutorCatalogo THEN BEGIN
            prProd.VALIDATE(Autor, pwValue);
        END;
    end;

    procedure BuscaSigumOrden(pwCodBom: Code[20]) wNum: Integer
    var
        lrBomItem Record: 90;
    begin
        // BuscaSigumOrden

        wNum := 0;
        CLEAR(wNum);
        CLEAR(lrBomItem);
        lrBomItem.SETRANGE(lrBomItem."Parent Item No.", pwCodBom);
        IF lrBomItem.FINDLAST THEN
            wNum := lrBomItem."Line No.";

        wNum += 1
    end;

    procedure EsProducto() Res: Boolean
    begin
        // EsProducto
        // Devuelve true si estamos tratando la tabla producto

        Res := rImp."Id Tabla" = 27;
    end;

    procedure GestSerieTip(var prImp Record: 75004") wSerie: Code[10]
    var
        lrConfTip Record: 75006;
    begin
        // GestSerieTip
        // Buscamos la serie en la configuración tipologia

        wSerie := '';

        IF FindTipoConf(prImp, lrConfTip) THEN
            wSerie := lrConfTip."No. Series";
    end;

    procedure FindFieldValue(pwId1: Integer; pwId2: Integer; pwIdField: Integer) wValue: Text
    var
        lrField2Record 75005;
    begin
        // FindFieldValue

        wValue := '';
        CLEAR(lrField2);
        IF pwId2 = 0 THEN
            lrField2.SETRANGE("Id Rel", pwId1)
        ELSE
            lrField2.SETRANGE("Id Rel", pwId1, pwId2);
        lrField2.SETRANGE("Id Field", pwIdField);
        IF lrField2.FINDFIRST THEN
            EXIT(lrField2.Value)
    end;

    procedure FindTipoConf(var prImp Record: 75004; var prConfTip Record: 75006") Result: Boolean
    var
        lrprImp2Record 75004;
        lwId1: Integer;
        lwId2: Integer;
        lrFiltroTipo Record: 75008;
        lwFieldNo: Integer;
        lwTip: Code[20];
        lwNo: Integer;
        lwValor: Code[20];
    begin
        // FindTipoConf
        // Buscamos la serie Configuración Tipologia

        Result := FALSE;

        IF prImp.Tipo <> 1 THEN // Si no es general
            EXIT;

        // Buscamos el Id del especifico
        lwId1 := prImp.Id;

        lwId2 := 0;
        CLEAR(lrprImp2);
        lrprImp2.SETRANGE("Id Cab.", prImp."Id Cab.");
        lrprImp2.SETRANGE("Id Tabla", prImp."Id Tabla");
        lrprImp2.SETRANGE("Code MdM", prImp."Code MdM");
        lrprImp2.SETRANGE(Tipo, 2);
        IF lrprImp2.FINDFIRST THEN
            lwId2 := lrprImp2.Id;

        CLEAR(prConfTip);

        lwTip := FindFieldValue(lwId1, lwId2, 5702); // Busca la tipologia en la importación
        IF lwTip = '' THEN
            EXIT;

        prConfTip.SETRANGE(Tipologia, lwTip);
        FOR lwNo := 1 TO lrFiltroTipo.MaxId DO BEGIN
            IF lrFiltroTipo.GET(lwNo) THEN BEGIN
                CASE lrFiltroTipo.Tipo OF
                    lrFiltroTipo.Tipo::Dimension:
                        lwFieldNo := -(200 + lrFiltroTipo."Valor Id");
                    lrFiltroTipo.Tipo::"Dato MdM":
                        lwFieldNo := cFuncMdm.GetDatoMdMFieldNo(lrFiltroTipo."Valor Id");
                    lrFiltroTipo.Tipo::Otros:
                        lwFieldNo := cFuncMdm.GetOtrosFieldNo(lrFiltroTipo."Valor Id");
                END;

                lwValor := FindFieldValue(lwId1, lwId2, lwFieldNo);
                prConfTip.SetFilterRef(lwNo, lwValor);
            END;
        END;

        Result := prConfTip.FINDFIRST;
    end;

    procedure ConfiguraTipologiaMdM(var prProd: Record 27; var prImp Record: 75004") Result: Boolean
    var
        lrConfTip Record: 75006;
        lrConv Record: 75007;
        lrFiltroTipo Record: 75008;
        lwNo: Integer;
        lwValores: array[20] of Code[20];
    begin
        // ConfiguraTipologiaMdM

        Result := FindTipoConf(prImp, lrConfTip);

        IF Result THEN
            cFuncMdm.SetConfTipologiaData(prProd, lrConfTip);
    end;

    procedure FillTempFields(PrImp Record: 75004")
    begin
        // FillTempFields;

        CLEAR(rTmpField);
        rTmpField.DELETEALL;

        CLEAR(rField);
        rField.SETRANGE("Id Rel", PrImp.Id);
        rField.SETRANGE("Id Cab.", PrImp."Id Cab.");
        IF rField.FINDSET THEN BEGIN
            REPEAT
                rTmpField := rField;
                rTmpField.INSERT;
            UNTIL rField.NEXT = 0;
        END;
    end;
}

