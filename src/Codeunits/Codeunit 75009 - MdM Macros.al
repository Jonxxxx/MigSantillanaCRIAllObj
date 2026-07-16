codeunit 75009 "MdM Macros"
{
    // #278368 30/10/19 KOS Proceso para importacion de codigos de un excel + cambio de fecha fin


    trigger OnRun()
    begin
        //RellenaFechasMdM;
        ImportarProductos;//+#278368
        MESSAGE('Proceso Finalizado');
    end;

    var
        GLSetup: Record 98;
        rConfMdM: Record 75000;
        wCont: Integer;
        wTotal: Integer;
        wStep: Integer;
        wCasos: Integer;
        wDia: Dialog;
        cFuncMdM: Codeunit 75000;
        i: Integer;
        excelbuff2: Record 370 temporary;

    procedure GestDimGral()
    var
        lrProd: Record 27;
        lwValue: Code[20];
        lwOK: Boolean;
        lwCod: Code[20];
        LTEXT001: Label 'Se han procesado %1 casos';
    begin
        // GestDimGral
        // Regenera las dimensiones globales en producto

        IF NOT CONFIRM('¿Desea regenear las dimensiones globales en producto?') THEN
            EXIT;

        GLSetup.GET;

        // Restaura las dimensiones generales en los productos
        IF lrProd.FINDSET THEN BEGIN
            InitDia(lrProd.COUNT);
            wDia.OPEN('Generando Dim Globales @1@@@@@@@@@@@@@@@@@@@@@@@');
            REPEAT
                lwOK := FALSE;
                lwValue := GetDefDimesions(27, lrProd."No.", GLSetup."Global Dimension 1 Code");
                IF lwValue <> lrProd."Global Dimension 1 Code" THEN BEGIN
                    lrProd."Global Dimension 1 Code" := lwValue;
                    lwOK := TRUE;
                END;

                lwValue := GetDefDimesions(27, lrProd."No.", GLSetup."Global Dimension 2 Code");
                IF lwValue <> lrProd."Global Dimension 2 Code" THEN BEGIN
                    lrProd."Global Dimension 2 Code" := lwValue;
                    lwOK := TRUE;
                END;
                IF lwOK THEN BEGIN
                    lrProd.MODIFY(TRUE);
                    wCasos += 1;
                END;
                UpdateDia(1);
            UNTIL lrProd.NEXT = 0;
            wDia.CLOSE;
        END;

        MESSAGE(LTEXT001, wCasos);
    end;

    procedure GetDefDimesions(pwIdTabla: Integer; pwNo: Code[20]; pwDimcode: Code[20]) Result: Code[20]
    var
        lrDefDim: Record 352;
    begin
        // GetDefDimesions
        // Añadimos dimensiones por defecto

        IF (pwIdTabla = 0) OR (pwNo = '') OR (pwDimcode = '') THEN
            EXIT;

        CLEAR(lrDefDim);
        IF lrDefDim.GET(pwIdTabla, pwNo, pwDimcode) THEN
            Result := lrDefDim."Dimension Value Code"
    end;

    procedure InitDia(pwTotal: Integer)
    begin
        // InitDia

        wCasos := 0;
        wCont := 0;
        wTotal := pwTotal;
        SetStep;
    end;

    procedure UpdateDia(pwId: Integer)
    begin
        // UpdateDia

        wCont += 1;
        IF wCont MOD wStep = 0 THEN
            wDia.UPDATE(pwId, ROUND(wCont / wTotal * 1000, 1));
    end;

    procedure SetStep()
    begin
        // SetStep

        wStep := wTotal DIV 100;
        IF wStep = 0 THEN
            wStep := 1;
    end;

    procedure SetTipoDimensiones()
    var
        lwId: Integer;
        lwCode: Code[20];
    begin
        // SetTipoDimensiones

        FOR lwId := 0 TO 6 DO BEGIN
            lwCode := cFuncMdM.GetDimCode(lwId, FALSE);
            cFuncMdM.SetTipoDim(lwCode, lwId);
        END;
    end;

    procedure BorraDescrpEAN()
    var
    //TODO: Ver lrRefC: Record 5717;
    begin
        // BorraDescrpEAN
        // Borra la descripcion de todas las referencias cruzadas

        IF NOT CONFIRM('¿Desea borrar la descripcion de todos los codigos de barra?') THEN
            EXIT;

        //TODO: Ver CLEAR(lrRefC);
        //TODO: Ver lrRefC.SETRANGE("Cross-Reference Type", lrRefC."Cross-Reference Type"::"Bar Code");
        //TODO: Ver lrRefC.MODIFYALL(Description, '');
    end;

    procedure RellenaUnidadEnPrecios()
    var
        lrPreV: Record 7002;
        lrPreV2: Record 7002;
        lrPreV3: Record 7002;
        lrProd: Record 27;
    begin
        // RellenaUnidadEnPrecios
        // Rellena los precios que tienen la unidad en blanco con la de los productos
        // Se diseño inicialmente para puerto rico

        // Customer,Customer Price Group,All Customers,Campaign
        // Todos clientes,Grupo precio cliente,Sin Filtrar


        IF NOT CONFIRM('¿Desea realmente iniciar el proceso de llenado de unidad de medida en las lineas de precio de venta producto?') THEN
            EXIT;

        rConfMdM.GET;

        CLEAR(lrPreV);
        CASE rConfMdM."Tipo Precio Venta" OF
            rConfMdM."Tipo Precio Venta"::"Todos clientes":
                BEGIN
                    lrPreV.SETRANGE("Sales Type", lrPreV."Sales Type"::"All Customers");
                END;
            rConfMdM."Tipo Precio Venta"::"Grupo precio cliente":
                BEGIN
                    lrPreV.SETRANGE("Sales Type", lrPreV."Sales Type"::"Customer Price Group");
                    IF rConfMdM."Grupo Precio Cliente" <> '' THEN
                        lrPreV.SETRANGE("Sales Code", rConfMdM."Grupo Precio Cliente");
                END;
        END;
        lrPreV.SETFILTER("Unit of Measure Code", '%1', '');

        wCasos := 0;
        IF lrPreV.FINDSET(TRUE, TRUE) THEN BEGIN
            InitDia(lrPreV.COUNT);
            wDia.OPEN('Rellenando Unidad en Precios Venta @1@@@@@@@@@@@@@@@@@@@@@@@');
            REPEAT
                IF lrProd.GET(lrPreV."Item No.") AND (lrProd."Base Unit of Measure" <> '') THEN BEGIN
                    lrPreV2 := lrPreV;
                    lrPreV2."Unit of Measure Code" := lrProd."Base Unit of Measure";
                    IF NOT lrPreV2.FIND THEN BEGIN
                        lrPreV3 := lrPreV;
                        lrPreV3.DELETE;
                        lrPreV2.INSERT;
                        wCasos += 1;
                    END;
                END;
                UpdateDia(1);
            UNTIL lrPreV.NEXT = 0;
            wDia.CLOSE;
        END;

        MESSAGE('Se han modificado %1 casos', wCasos);
    end;

    procedure RellenaFechasMdM()
    var
        lrProd: Record 27;
    begin
        // RellenaFechasMdM
        // #209115

        IF NOT CONFIRM('Iniciar procesod de rellando de fechas MdM en Producto') THEN
            EXIT;

        CLEAR(lrProd);
        lrProd.SETRANGE("Gestionado MdM", TRUE);
        InitDia(lrProd.COUNT);
        wDia.OPEN('Rellenando Fechas MdM @1@@@@@@@@@@@@@@@@@');
        //lrProd.SETRANGE("Assembly BOM",TRUE);
        IF lrProd.FINDSET THEN BEGIN
            REPEAT
                UpdateDia(1);
                IF cFuncMdM.GestContrlFechasProd(lrProd, 0, 2) THEN
                    wCasos += 1
            UNTIL (lrProd.NEXT = 0) OR (wCont > 20);
        END;

        wDia.CLOSE;
        MESSAGE('Se han modificado %1 casos', wCasos);
    end;

    procedure ImportarProductos()
    var
        excelBuff: Record 370 temporary;
        fileMgt: Codeunit 419;
        ruta: Text;
        totalRows: Integer;
        rutaServidor: Text;
    begin
        //+#278368
        //TODO: Ver ruta := fileMgt.OpenFileDialog('Archivo a importar', '', fileMgt.GetToFilterText('', '*.xlsx'));
        IF ruta = '' THEN
            EXIT;
        //TODO: Ver rutaServidor := fileMgt.UploadFileSilent(ruta);

        //TODO: Ver excelBuff.OpenBook(rutaServidor, 'PRECIOS');
        excelBuff.ReadSheet();

        //excelbuff2.COPY(excelBuff,TRUE);
        excelBuff.SETRANGE(excelBuff."Column No.", 3);
        IF excelBuff.FINDSET THEN BEGIN
            i := 0;
            REPEAT
                CambioFechaFin(excelBuff."Cell Value as Text");
                i += 1;
            UNTIL excelBuff.NEXT = 0;
        END;
        //-#278368
    end;

    procedure CambioFechaFin(itemNo: Text)
    var
        preciosVenta: Record 7002;
        endDate: Text;
    begin
        //+#278368
        IF i <> 0 THEN BEGIN
            /*
            excelbuff2.SETRANGE(excelbuff2."Column No.",8);
            excelbuff2.SETRANGE(excelbuff2."Row No.",i+1);
            IF excelbuff2.FINDFIRST THEN
              endDate:=excelbuff2."Cell Value as Text"
            ELSE
              ERROR('No se encuentra fecha fin');
            */
            preciosVenta.SETRANGE("Item No.", itemNo);
            preciosVenta.SETRANGE("Starting Date", 20190909D);
            IF preciosVenta.FINDFIRST THEN
                IF (preciosVenta."Ending Date" = 0D) OR (preciosVenta."Ending Date" > 20191031D) THEN BEGIN
                    preciosVenta."Ending Date" := 20191031D;
                    preciosVenta.MODIFY;
                END;
        END;
        //-#278368

    end;
}

