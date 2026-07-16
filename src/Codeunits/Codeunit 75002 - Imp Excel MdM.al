codeunit 75002 "Imp Excel MdM"
{

    trigger OnRun()
    begin
    end;

    var
        Text0001: Label 'No se ha encontrado relacion de tabla de la pestaña %1';
        wFieldsNo: array[100] of Integer;
        wFieldsName: array[100] of Text[100];
        wExcelBuf: Record 370 temporary;
        cFileMng: Codeunit 419;
        Text0002: Label 'Abrir Excel';
        Text0003: Label 'No existe %1';
        Text0004: Label 'Importando Valores MdM';
        wDia: Dialog;
        Text0005: Label 'Operacion Terminada';
        Text0006: Label 'No ha quedado definido el destino del valor %1';
        wTotalFlds: Integer;
        cGesImptMdm: Codeunit 75001;
        cFubMdM: Codeunit 75000;
        cTrasp: Codeunit 75007;

    procedure ImportaFile(pwTodas: Boolean; pwOperacion: Option Insert,Update,Delete)
    var
        lwFileName: Text;
    begin
        // ImportaFile

        lwFileName := GetFilenameDialog;
        Importa(lwFileName, pwTodas, pwOperacion);
    end;

    procedure Importa(pwFileName: Text; pwTodas: Boolean; pwOperacion: Option Insert,Update,Delete)
    var
        lwSheetNames: array[50] of Text;
        lwSheetName: Text;
        lwFila: Integer;
        lwTipo: Integer;
        lwTableId: Integer;
        lwPTotal: Integer;
        lwInt: Integer;
        lwCodProds: Text;
        lwPgn: Integer;
        lwDef: Boolean;
        lwCol: Integer;
        lwTotalRows: Integer;
        lwMdMTabla: Record 75004 temporary;
        lRecRef: RecordRef;
        lwFieRef: FieldRef;
        lwOk: Boolean;
        lwValue: Text[250];
        lwFilename2: Text;
        lwDefFields: array[3] of Integer;
    begin
        // Importa
        // pwTodas Indica que se quieren importar a la vez todas las pestañas de la hoja


        //pwFileName := wFileMng.OpenFileDialog(Text0002, '(Excel|*.xlsx|All Files (*.*)|*.*,', '');

        cGesImptMdm.ResetAll;

        IF pwFileName = '' THEN
            EXIT;

        //TODO: Ver IF NOT cFileMng.ClientFileExists(pwFileName) THEN
        //TODO: Ver     ERROR(Text0003, pwFileName);


        //TODO: Ver lwFilename2 := cFileMng.UploadFileSilent(pwFileName);
        /*//fes mig
        CLEAR(lwSheetNames);
        lwPTotal :=0;
        IF pwTodas THEN
          lwPTotal := wExcelBuf.FindAllSheetsNames(lwFilename2, lwSheetNames)
        ELSE BEGIN
          lwSheetNames[1] := wExcelBuf.SelectSheetsName(lwFilename2);
          IF lwSheetNames[1] <> '' THEN
            lwPTotal := 1;
        END;
        
        IF lwPTotal = 0 THEN
          EXIT;
        
        cGesImptMdm.AddMstRegHeader(pwOperacion,1); // Cabecera de importacion
        
        // LO que hacemos ahor es dejar la pagina de productos para el final ya que es necesario pasar antes todas las demás auxiliares
        IF lwPTotal > 1 THEN BEGIN
          lwCodProds := 'PRODUCTOS';
          FOR lwPgn := 1 TO lwPTotal-1 DO BEGIN
            IF lwSheetNames[lwPgn] = lwCodProds THEN BEGIN
              lwSheetNames[lwPgn]    := lwSheetNames[lwPTotal];
              lwSheetNames[lwPTotal] := lwCodProds;
              lwPgn := lwPTotal-1; // Terminamos el bucle
            END;
          END;
        END;
        
        wDia.OPEN( Text0004 + '\#1###############################\@2@@@@@@@@@@@@@@@@@@@@@@@@@');
        
        FOR lwPgn := 1 TO lwPTotal DO BEGIN
          lwSheetName := lwSheetNames[lwPgn];
          lwTipo    := GetIdTipo(lwSheetName);
          lwTableId := GetIdTabla(lwSheetName);
          IF lwTableId > 0 THEN BEGIN
            IF lwPgn = 1 THEN
              wExcelBuf.OpenBook(lwFilename2, lwSheetName);
            wExcelBuf.ReadSheet2(lwSheetName, FALSE);
        
            lwFila       := 0;
        
            wDia.UPDATE(1, lwSheetName);
            FillArrays(lwTableId);
            CLEAR(lwTotalRows);
            //wExcelBuf.RESET;
            IF wExcelBuf.FINDLAST THEN
              lwTotalRows := wExcelBuf."Row No.";
        
            IF lwTotalRows > 2 THEN BEGIN
              FOR lwFila := 3 TO lwTotalRows DO BEGIN  // Las dos primeras filas no se tienen en cuenta
        
                wDia.UPDATE(2,ROUND(lwFila / lwTotalRows * 10000,1));
        
                CLEAR(lwMdMTabla);
                lwMdMTabla."Id Tabla" := lwTableId;
                IF lwTipo >= 0 THEN // Tipo Predeterminado
                  lwMdMTabla.Tipo := lwTipo
                ELSE
                  lwMdMTabla.Tipo := -1;
        
                // Los tres campos por defecto
                lwDefFields[1] := lwMdMTabla.GetIdCodeField;
                lwDefFields[2] := lwMdMTabla.GetIdDescField;
                lwDefFields[3] := lwMdMTabla.GetIdTipoField;
        
                cGesImptMdm.AddMstReg(pwOperacion, lwTableId, lwTipo, '' , '', lwSheetName,''); // Inserta la cabecera de tabla
                FOR lwCol :=1 TO wTotalFlds DO BEGIN
                  IF wExcelBuf.GET(lwFila, lwCol) THEN BEGIN
                    //lwValue := DELCHR(wExcelBuf."Cell Value as Text",'<>'); // Le quitamos los espacios en blanco
                    lwValue := GestVal(wExcelBuf."Cell Value as Text");
        
                    IF UPPERCASE(lwValue) <> '' THEN BEGIN // El valor no se importará ni modificará
                      IF wFieldsNo[lwCol] = lwDefFields[1] THEN
                        lwMdMTabla.Code := lwValue;
        
                      IF wFieldsNo[lwCol] = lwDefFields[2] THEN
                        lwMdMTabla.Descripcion := lwValue;
        
                      IF (lwTipo = -1) AND (wFieldsNo[lwCol] = lwDefFields[3]) THEN BEGIN
                        lwOk := EVALUATE(lwInt, lwValue);
                        IF NOT lwOk THEN BEGIN // Miramos si es un valor Option
                          lRecRef.OPEN(lwTableId);
                          lwFieRef := lRecRef.FIELD(wFieldsNo[3]);
                          IF UPPERCASE(FORMAT(lwFieRef.TYPE)) =  'OPTION' THEN BEGIN
                            lwInt := cTrasp.GeOptionValueId(lwFieRef.OPTIONCAPTION, lwValue);
                            IF lwInt = -1 THEN
                              lwInt := cTrasp.GeOptionValueId(lwFieRef.OPTIONSTRING, lwValue);
                            lwOk := lwInt > -1;
                          END;
                          lRecRef.CLOSE;
                          CLEAR(lwFieRef);
                        END;
                        IF lwOk THEN
                          lwMdMTabla.Tipo := lwInt;
                      END;
        
                      lwDef := FALSE;
                      IF lwCol IN [1..3] THEN
                        lwDef := (wFieldsNo[lwCol] = lwDefFields[lwCol]);
                      IF NOT lwDef THEN
                        cGesImptMdm.AddMstRegField(wFieldsNo[lwCol], lwValue, wFieldsName[lwCol]); // Si no es un valor por defecto
                    END;
                  END;
                END;
        
                // Dimension Value .
                IF (lwTableId = 349) AND (lwTipo > -1) THEN //  Introducimos "Dimension Code"
                  cGesImptMdm.AddMstRegField(1 , cFubMdM.GetDimCode(lwTipo, TRUE), 'CODE');
                // Rellenamos los campos principales de la tabla
                cGesImptMdm.UpdtMstReg(lwMdMTabla.Tipo,lwMdMTabla.Code,lwMdMTabla.Descripcion,'');
              END;
            END;
          END;
        END;
        *///fes mig
        wExcelBuf.QuitExcel;
        wDia.CLOSE;
        cGesImptMdm.ImpCabExcel;

        MESSAGE(Text0005);

    end;

    procedure GetIdTabla(pwCode: Code[30]) wId: Integer
    begin
        // GetIdTabla
        // Devuelve el Id de Tabla según la pestaña

        wId := 0;

        CASE pwCode OF
            'PRODUCTOS':
                wId := 27;     // Item
            'SOCIEDAD':
                wId := 75001;  // Datos MDM;
            'TIPOLOGiA':
                wId := 5722;   // Item Category
            'TIPO PRODUCTO':
                wId := 75001;  // Datos MDM;
            'SOPORTE':
                wId := 75001;  // Datos MDM;
            'EMPRESA EDITORA':
                wId := 75001;  // Datos MDM;
            'LiNEA':
                wId := 75001;  // Datos MDM;
            'SELLO':
                wId := 75001;  // Datos MDM;
            'IDIOMA':
                wId := 8;      // Language
            'SERIE MÉTODO':
                wId := 349;    // Dimension Value
            'AUTOR':
                wId := 75001;  // Datos MDM;
            'PAiS':
                wId := 9;      // Country/Region
            'PLAN EDITORIAL':
                wId := 75001;  // Datos MDM;
            'EDICIoN':
                wId := 75001;  // Datos MDM;
            'DESTINO':
                wId := 349;    // Dimension Value
            'CUENTA':
                wId := 349;    // Dimension Value;
            'ESTRUCTURA ANALiTICA':
                wId := 75002;  // Estructura Analitica
            'ESTADO':
                wId := 75001;  // Datos MDM;
            'TIPO TEXTO':
                wId := 349;    // Dimension Value
            'ASIGNATURA':
                wId := 75001;  // Datos MDM;
            'MATERIA':
                wId := 349;    // Dimension Value
            'CURSO':
                wId := 75001;  // Datos MDM;      // Grado
            'CARGA HORARIA':
                wId := 349;    // Dimension Value
            'ORIGEN':
                wId := 349;    // Dimension Value
            'CICLO':
                wId := 75001;  // Datos MDM;
            'NIVEL':
                wId := 75001;  // Datos MDM;
            'Campana':
                wId := 75001;  // Datos MDM;
        END;

        IF wId = 0 THEN
            wId := ExtractTableId(pwCode);

        IF wId = 0 THEN
            ERROR(Text0001, pwCode);
    end;

    procedure GetIdTipo(pwCode: Code[30]) wTipo: Integer
    begin
        // GetIdTabla
        // Devuelve el Id del Tipo Fijo según la pestaña

        wTipo := -1; // Si no encuntra nada, delvuelve -1

        CASE pwCode OF
            'SERIE MÉTODO':
                wTipo := 0;    // Dimension Value
            'DESTINO':
                wTipo := 1;    // Dimension Value
            'CUENTA':
                wTipo := 2;    // Dimension Value
            'TIPO TEXTO':
                wTipo := 3;    // Dimension Value
            'MATERIA':
                wTipo := 4;    // Dimension Value
            'CARGA HORARIA':
                wTipo := 5;    // Dimension Value
            'ORIGEN':
                wTipo := 6;    // Dimension Value

            'TIPO PRODUCTO':
                wTipo := 0;  // Datos MDM;
            'SOPORTE':
                wTipo := 1;  // Datos MDM;
            'EMPRESA EDITORA':
                wTipo := 2;  // Datos MDM;
            'SOCIEDAD':
                wTipo := 2;  // Datos MDM; // Tiene el mismo valor que "EMPRESA EDITORA"
            'NIVEL':
                wTipo := 3;  // Datos MDM;
            'PLAN EDITORIAL':
                wTipo := 4;  // Datos MDM;
            'AUTOR':
                wTipo := 5;  // Datos MDM;
            'CICLO':
                wTipo := 6;  // Datos MDM;
            'LiNEA':
                wTipo := 7;  // Datos MDM;
            'ASIGNATURA':
                wTipo := 8;  // Datos MDM;
            'CURSO':
                wTipo := 9;  // Datos MDM; // Grado
            'SELLO':
                wTipo := 10; // Datos MDM;
            'EDICIoN':
                wTipo := 11; // Datos MDM;
            'ESTADO':
                wTipo := 12; // Datos MDM;
            'Campana':
                wTipo := 13; // Datos MDM;
        END;
    end;

    procedure FillArrays(pwTableId: Integer) wDef: Boolean
    var
        lwN: Integer;
        lwTotal: Integer;
        lwMdMTabla: Record 75004 temporary;
        lwIdsDefs: array[10] of Integer;
        lwMax: Integer;
    begin
        // FillArrays
        // Devuelve true si se han definido los valores de campos por defecto según la id de tabla,
        // Eso es, que no hace falta registros de campos

        CLEAR(wFieldsNo);
        IF pwTableId = 0 THEN
            EXIT;

        // Buscamos si se han establecido los numeros de campos en la primera fila (Productos)
        //wExcelBuf.RESET;
        wExcelBuf.SETRANGE("Row No.", 2); // Segunda Fila, Las cabeceras. Definimos el total de campos a importar
        wTotalFlds := wExcelBuf.COUNT;
        IF wExcelBuf.FINDSET THEN BEGIN
            REPEAT
                wFieldsName[wExcelBuf."Column No."] := wExcelBuf."Cell Value as Text";
            UNTIL wExcelBuf.NEXT = 0;
        END;

        wExcelBuf.SETRANGE("Row No.", 1); // Primera Fila, Total de cabeceras que esta definido expresamente el numero de campo
        lwTotal := wExcelBuf.COUNT;
        IF lwTotal > wTotalFlds THEN
            wTotalFlds := lwTotal;
        IF wExcelBuf.FINDSET THEN BEGIN
            REPEAT
                IF EVALUATE(lwN, wExcelBuf."Cell Value as Text") THEN
                    wFieldsNo[wExcelBuf."Column No."] := lwN;
            UNTIL wExcelBuf.NEXT = 0;
        END;


        // Si no está definido expresamente determinamos los tres primeros valores como Codigo, Descripcion, Tipo
        // El valor predefinido tiene prioridad
        lwMdMTabla."Id Tabla" := pwTableId;
        lwIdsDefs[1] := lwMdMTabla.GetIdCodeField;
        lwIdsDefs[2] := lwMdMTabla.GetIdDescField;
        lwIdsDefs[3] := lwMdMTabla.GetIdTipoField;

        // wDef Determina que los tres primeros valores son por defecto
        lwMax := 0;
        lwN := 1;
        WHILE (lwN <= 3) AND (lwN <= wTotalFlds) AND (lwIdsDefs[lwN] <> 0) AND ((wFieldsNo[lwN] = 0) OR (wFieldsNo[lwN] = lwIdsDefs[lwN])) DO BEGIN
            lwMax += 1;
            lwN += 1;
        END;

        wDef := lwMax > 0;

        FOR lwN := 1 TO 3 DO BEGIN
            IF wFieldsNo[lwN] = 0 THEN
                wFieldsNo[lwN] := lwIdsDefs[lwN];
        END;

        wExcelBuf.SETRANGE("Row No.");
        //wExcelBuf.RESET;

        //Comprobamos que se han rellanado todos los ids de campo
        FOR lwN := 1 TO wTotalFlds DO BEGIN
            IF wFieldsNo[lwN] = 0 THEN BEGIN
                wExcelBuf.GET(2, lwN);
                ERROR(Text0006, wExcelBuf."Cell Value as Text");
            END;
        END;
    end;

    procedure GetFilenameDialog() wFilename: Text
    begin
        // GetFilenameDialog

        //TODO: Ver wFilename := cFileMng.OpenFileDialog(Text0002, '', '(Excel|*.xlsx|All Files (*.*)|*.*,');
    end;

    procedure ExtractTableId(pwCode: Code[30]) wId: Integer
    var
        lwCode2: Code[30];
        lwN: Integer;
        lwCh: Char;
        lwOK: Integer;
        lwId: Integer;
    begin
        // ExtractTableId
        // Devuelve el numero de tabla si esta en algún punto del nombre de hoja entre #. Por ejempo "Articulo #27#" devolveria 27

        wId := 0;

        IF pwCode = '' THEN
            EXIT;

        CLEAR(lwCode2);
        lwOK := 0;
        FOR lwN := 1 TO STRLEN(pwCode) DO BEGIN
            lwCh := pwCode[lwN];
            IF lwOK = 1 THEN BEGIN
                IF lwCh IN ['0' .. '9'] THEN
                    lwCode2 := lwCode2 + FORMAT(lwCh)
                ELSE
                    lwOK += 1;
            END;
            IF lwCh IN ['#'] THEN
                lwOK += 1;
        END;

        IF EVALUATE(lwId, lwCode2) THEN
            wId := lwId;
    end;

    procedure GestVal(pwText: Text) Result: Text
    var
        lwCR: Char;
        lwText2: Text;
        lwPos: Integer;
    begin
        // GestVal

        lwCR := 13; // Salto de Linea
        Result := pwText;
        Result := DELCHR(Result, '=', FORMAT(lwCR));
        lwCR := 10; //
        Result := DELCHR(Result, '=', FORMAT(lwCR));

        lwText2 := '_x000D_';
        lwPos := STRPOS(Result, lwText2);
        WHILE lwPos <> 0 DO BEGIN
            Result := DELSTR(Result, lwPos, STRLEN(lwText2));
            lwPos := STRPOS(Result, lwText2);
        END;

        Result := DELCHR(Result, '<>');
    end;
}

