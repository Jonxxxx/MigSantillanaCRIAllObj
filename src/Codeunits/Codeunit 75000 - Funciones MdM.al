codeunit 75000 "Funciones MdM"
{
    // Dimensiones:
    //   0 SerieMetodo
    //   1 Destino
    //   2 Cuenta
    //   3 TipoTexto
    //   4 Materia
    //   5 CargaHoraria
    //   6 Origen
    // 
    // #209115 JPT 03/04/2019  Gestionamos el control de rellenado automatico de las fechas MdM de producto


    trigger OnRun()
    begin
    end;

    var
        wConfMdM: Record 75000;
        GLSetup: Record 98;
        GLSetupRead: Boolean;
        ErrEditDim: Label 'No puede editar esta dimensión predeterminada para este producto, se gestiona por el MdM.';
        ErrEditDim2: Label 'No puede editar esta dimensión, se gestiona por MdM.';
        ErrEditTable: Label 'No puede editar %1. Se gestiona por MdM';
        ErrISBN: Label 'El código ISBN %1 No es correcto';
        ErrFieldM: Label 'Debe de rellenar el valor %1';
        lrDim: Record 348;
        rTmpBuff Record: 75016" temporary;

    procedure GetTotalGestDim(): Integer
    begin
        // GetTotalGestDim
        // Devuelve el total de dimensiones gestionadas por MdM
        // Se define aqui por si hay que ampliar alguna

        EXIT(7);
    end;

    procedure GetDimValueT(pwCodProd: Code[20]; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen): Code[20]
    var
        lwDimCode: Code[20];
    begin
        // GetDimValueT
        // Devuelve el valor de una dimension determinada (por Tipo)

        lwDimCode := GetDimCode(pwTipoDim, FALSE);
        EXIT(GetDimValueC(pwCodProd, lwDimCode));
    end;

    procedure GetDimValueC(pwCodProd: Code[20]; pwCode: Code[20]): Code[20]
    var
        lrDefDim: Record 352;
    begin
        // GetDimValueC
        // Devuelve el valor de una dimension determinada (por Codigo)

        CLEAR(lrDefDim);
        IF lrDefDim.GET(27, pwCodProd, pwCode) THEN
            EXIT(lrDefDim."Dimension Value Code");
    end;

    procedure GetDimCode(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen; pwTest: Boolean) wCode: Code[20]
    begin
        // GetDimCode
        // Devuelve el Código de una dimension determinada

        GetConfM;

        wCode := '';

        IF pwTest THEN BEGIN
            CASE pwTipoDim OF
                pwTipoDim::SerieMetodo:
                    wConfMdM.TESTFIELD("Dim Serie/Metodo");
                pwTipoDim::Destino:
                    wConfMdM.TESTFIELD("Dim Destino");
                pwTipoDim::Cuenta:
                    wConfMdM.TESTFIELD("Dim Cuenta");
                pwTipoDim::TipoTexto:
                    wConfMdM.TESTFIELD("Dim Tipo Texto");
                pwTipoDim::Materia:
                    wConfMdM.TESTFIELD("Dim Materia");
                pwTipoDim::CargaHoraria:
                    wConfMdM.TESTFIELD("Dim Carga Horaria");
                pwTipoDim::Origen:
                    wConfMdM.TESTFIELD("Dim Origen");
            END;
        END;

        CASE pwTipoDim OF
            pwTipoDim::SerieMetodo:
                wCode := wConfMdM."Dim Serie/Metodo";
            pwTipoDim::Destino:
                wCode := wConfMdM."Dim Destino";
            pwTipoDim::Cuenta:
                wCode := wConfMdM."Dim Cuenta";
            pwTipoDim::TipoTexto:
                wCode := wConfMdM."Dim Tipo Texto";
            pwTipoDim::Materia:
                wCode := wConfMdM."Dim Materia";
            pwTipoDim::CargaHoraria:
                wCode := wConfMdM."Dim Carga Horaria";
            pwTipoDim::Origen:
                wCode := wConfMdM."Dim Origen";
        END;
    end;

    procedure GetDimCodeName(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen): Text[30]
    var
        lrDim: Record 348;
        lwDimCode: Code[20];
    begin
        // GetDimCodeName
        // Devuelve el nombre de un codigo de dimensión

        lwDimCode := GetDimCode(pwTipoDim, FALSE);
        CLEAR(lrDim);
        IF lrDim.GET(lwDimCode) THEN
            EXIT(lrDim.Name);
    end;

    procedure GetDimValueName(pwCodProd: Code[20]; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen): Text[50]
    var
        lrDimVal: Record 349;
        lwDimValue: Code[20];
        lwDimCode: Code[20];
    begin
        // GetDimValueName
        // Devuelve el nombre de un valor de dimensión

        lwDimCode := GetDimCode(pwTipoDim, FALSE);
        lwDimValue := GetDimValueC(pwCodProd, lwDimCode);

        CLEAR(lrDimVal);
        IF lrDimVal.GET(lwDimCode, lwDimValue) THEN
            EXIT(lrDimVal.Name);
    end;

    procedure GetDimNameField(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen) wName: Text
    var
        lText001: Label 'Serie';
        lText002: Label 'Destino';
        lText003: Label 'Cuenta';
        lText004: Label 'Tipo Texto';
        lText005: Label 'Materia';
        lText006: Label 'Carga Horaria';
        lText007: Label 'Origen';
    begin
        // GetDimNameField

        wName := '';
        CASE pwTipoDim OF
            pwTipoDim::SerieMetodo:
                wName := lText001;
            pwTipoDim::Destino:
                wName := lText002;
            pwTipoDim::Cuenta:
                wName := lText003;
            pwTipoDim::TipoTexto:
                wName := lText004;
            pwTipoDim::Materia:
                wName := lText005;
            pwTipoDim::CargaHoraria:
                wName := lText006;
            pwTipoDim::Origen:
                wName := lText007;
        END;
    end;

    procedure TestDimValT(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen; pwValue: Code[20])
    var
        lwDimCode: Code[20];
    begin
        // TestDimValT

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        TestDimValC(lwDimCode, pwValue);
    end;

    procedure TestDimValC(pwDimCode: Code[20]; pwValue: Code[20])
    var
        lrDimVal: Record 349;
    begin
        // TestDimValC
        // Comprueba que exista el valor de dimensión

        CLEAR(lrDimVal);
        IF pwValue <> '' THEN
            lrDimVal.GET(pwDimCode, pwValue);
    end;

    procedure ExistDimValT(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen; pwValue: Code[20]) Result: Boolean
    var
        lwDimCode: Code[20];
    begin
        // ExistDimValT

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        Result := ExistDimValC(lwDimCode, pwValue);
    end;

    procedure ExistDimValC(pwDimCode: Code[20]; pwValue: Code[20]) Result: Boolean
    var
        lrDimVal: Record 349;
    begin
        // ExistDimValC
        // Devuelve true si existe el valor de dimensión

        CLEAR(lrDimVal);
        Result := lrDimVal.GET(pwDimCode, pwValue);
    end;

    procedure ValidaDimValT(var prProd: Record 27; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen; pwValue: Code[20])
    var
        lwDimCode: Code[20];
    begin
        // ValidaDimValT
        // Valida una dimensión

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        ValidaDimValC(prProd, lwDimCode, pwValue);
    end;

    procedure ValidaDimValC(var prProd: Record 27; pwDimCode: Code[20]; pwValue: Code[20])
    var
        lrDefDim: Record 352;
        lwExists: Boolean;
    begin
        // ValidaDimValC
        // Valida una dimensión

        // Comprueba que exista
        TestDimValC(pwDimCode, pwValue);

        CLEAR(lrDefDim);
        lwExists := lrDefDim.GET(27, prProd."No.", pwDimCode);

        IF pwValue = '' THEN BEGIN
            IF lwExists THEN
                lrDefDim.DELETE;
        END
        ELSE BEGIN
            GetConfM;
            IF NOT lwExists THEN BEGIN
                CLEAR(lrDefDim);
                lrDefDim.VALIDATE("Table ID", 27);
                lrDefDim.VALIDATE("No.", prProd."No.");
                lrDefDim.VALIDATE("Dimension Code", pwDimCode);
                lrDefDim.VALIDATE("Dimension Value Code", pwValue);
                /*
                IF pwDimCode IN [wConfMdM."Dim Carga Horaria",wConfMdM."Dim Destino",wConfMdM."Dim Origen",wConfMdM."Dim Tipo Texto"] THEN
                  lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Same Code"
                ELSE
                  lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Code Mandatory";
                */
                lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Same Code";
                lrDefDim.INSERT;
                //lrDefDim.INSERT(TRUE);
            END
            ELSE BEGIN
                IF lrDefDim."Dimension Value Code" <> pwValue THEN
                    lrDefDim.VALIDATE("Dimension Value Code", pwValue);
                /*
                IF pwDimCode IN [wConfMdM."Dim Carga Horaria",wConfMdM."Dim Destino",wConfMdM."Dim Origen",wConfMdM."Dim Tipo Texto"] THEN
                  lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Same Code"
                ELSE
                  lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Code Mandatory";
                */
                lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Same Code";
                lrDefDim.MODIFY
                //lrDefDim.MODIFY(TRUE);
            END;
        END;

        SetGlobalDim(prProd, pwDimCode, pwValue);

    end;

    procedure GetDimValueLookupT(pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen; pwDefault: Code[20]): Code[20]
    var
        lwDimCode: Code[20];
    begin
        // GetDimValueLookupT
        // Devuelve un codigo de valor de la lista solicitado (Por Tipo)

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        EXIT(GetDimValueLookupC(lwDimCode, pwDefault));
    end;

    procedure GetDimValueLookupC(pwDimCode: Code[20]; pwDefault: Code[20]) wCode: Code[20]
    var
        lrDimVal: Record 349;
        lwOK: Boolean;
    begin
        // GetDimValueLookupC
        // Devuelve un codigo de valor de la lista solicitado (Por Codigo)

        wCode := '';
        IF pwDimCode = '' THEN
            EXIT;

        CLEAR(lrDimVal);
        lrDimVal.FILTERGROUP(2);
        lrDimVal.SETRANGE("Dimension Code", pwDimCode);
        lrDimVal.SETRANGE(Blocked, FALSE);
        lrDimVal.FILTERGROUP(0);
        IF pwDefault <> '' THEN
            lwOK := lrDimVal.GET(pwDimCode, pwDefault); // Posicionamos el valor por defecto
        IF PAGE.RUNMODAL(0, lrDimVal) = ACTION::LookupOK THEN
            wCode := lrDimVal.Code;
    end;

    procedure ExecDimValLookupT(prProd: Record 27; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen)
    var
        lwDimCode: Code[20];
    begin
        // ExecDimValLookupT
        // Solicita un codigo de valor de dimensión y lo valida. (Por Tipo)

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        ExecDimValLookupC(prProd, lwDimCode);
    end;

    procedure ExecDimValLookupC(prProd: Record 27; pwDimCode: Code[20])
    var
        lwValue: Code[20];
        lwDefault: Code[20];
    begin
        // ExecDimValLookupC
        // Solicita un codigo de valor de dimensión y lo valida (Por Codigo)

        lwDefault := GetDimValueC(prProd."No.", pwDimCode);
        lwValue := GetDimValueLookupC(pwDimCode, lwDefault);
        IF lwValue <> '' THEN
            ValidaDimValC(prProd, pwDimCode, lwValue);
    end;

    procedure ShowDimT(prProd: Record 27; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen)
    var
        lwDimCode: Code[20];
    begin
        // ShowDimT
        // Muestra la dimensión establecida

        lwDimCode := GetDimCode(pwTipoDim, TRUE);
        ShowDimC(prProd, lwDimCode);
    end;

    procedure ShowDimC(prProd: Record 27; pwDimCode: Code[20])
    var
        lrDefDim: Record 352;
        lrDimVal: Record 349;
        lwPag: Page540;
        lwEnc: Boolean;
    begin
        // ShowDimC
        // Muestra la dimensión establecida

        CLEAR(lrDimVal);
        lrDimVal.SETRANGE("Dimension Code", pwDimCode);
        lrDimVal.SETRANGE(Blocked, FALSE);
        IF PAGE.RUNMODAL(0, lrDimVal) = ACTION::LookupOK THEN BEGIN
            CLEAR(lrDefDim);
            lrDefDim.SETRANGE("Table ID", 27);
            lrDefDim.SETRANGE("No.", prProd."No.");
            lrDefDim.SETRANGE("Dimension Code", pwDimCode);
            lwEnc := lrDefDim.FINDFIRST;
            IF NOT lwEnc THEN BEGIN
                lrDefDim.VALIDATE("Table ID", 27);
                lrDefDim.VALIDATE("No.", prProd."No.");
                lrDefDim.VALIDATE("Dimension Code", pwDimCode);
            END;
            lrDefDim.VALIDATE("Dimension Value Code", lrDimVal.Code);
            lrDefDim."Value Posting" := lrDefDim."Value Posting"::"Same Code";
            IF lwEnc THEN
                lrDefDim.MODIFY(TRUE)
            ELSE
                lrDefDim.INSERT(TRUE);
        END;

        /*
        
        CLEAR(lrDefDim);
        lrDefDim.SETRANGE("Table ID"      , 27);
        lrDefDim.SETRANGE("No."           , prProd."No.");
        lrDefDim.SETRANGE("Dimension Code", pwDimCode);
        
        
        CLEAR(lwPag);
        // lwPag.SetEditable(wEditaMDM);
        lwPag.SETTABLEVIEW(lrDefDim);
        lwPag.SETRECORD(lrDefDim);
        lwPag.RUN;
        */

    end;

    procedure SetTipoDim(pwCode: Code[20]; pwTipoDim: Option SerieMetodo,Destino,Cuenta,TipoTexto,Materia,CargaHoraria,Origen)
    var
        lrDim: Record 348;
    begin
        // SetTipoDim
        // Define el valor "Tipo MdM" de la tabla de Dimensiones en virtud del valor de configuración

        CLEAR(lrDim);
        IF pwCode = '' THEN BEGIN
            lrDim.SETRANGE("Tipo MdM", pwTipoDim + 1);
            lrDim.MODIFYALL("Tipo MdM", 0);
        END
        ELSE
            IF lrDim.GET(pwCode) THEN BEGIN
                lrDim.VALIDATE("Tipo MdM", pwTipoDim + 1);
                lrDim.MODIFY;
            END;
    end;

    procedure GetDatoMdM(prProd: Record 27; pwId: Integer) wValue: Code[20]
    var
        lwRecRef: RecordRef;
        lwFieldRef: FieldRef;
        lwIdField: Integer;
    begin
        // GetDatoMdM

        wValue := '';
        lwIdField := 0;
        lwRecRef.GETTABLE(prProd);

        lwIdField := GetDatoMdMFieldNo(pwId);

        IF lwIdField > 0 THEN BEGIN
            lwFieldRef := lwRecRef.FIELD(lwIdField);
            wValue := lwFieldRef.VALUE;
        END;
    end;

    procedure GetDatosOtros(prProd: Record 27; pwId: Integer) wValue: Code[20]
    var
        lwRecRef: RecordRef;
        lwFieldRef: FieldRef;
        lwIdField: Integer;
    begin
        // GetDatosOtros

        wValue := '';
        lwIdField := 0;
        lwRecRef.GETTABLE(prProd);

        lwIdField := GetOtrosFieldNo(pwId);

        IF lwIdField > 0 THEN BEGIN
            lwFieldRef := lwRecRef.FIELD(lwIdField);
            wValue := lwFieldRef.VALUE;
        END;
    end;

    procedure GetDatoMdMCod(pwCodProd: Code[20]; pwId: Integer) wValue: Code[20]
    var
        lrItem: Record 27;
    begin
        // GetDatoMdMCod

        IF lrItem.GET(pwCodProd) THEN
            EXIT(GetDatoMdM(lrItem, pwId));
    end;

    procedure GetDatoMdMFieldNo(pwId: Integer) wIdField: Integer
    begin
        // GetDatoMdMFieldNo
        // Devuelve el numero de campo en Producto referente al Dato MdM

        CASE pwId OF
            0:
                wIdField := 75001; // Tipo Producto
            1:
                wIdField := 75002; // Soporte
            2:
                wIdField := 75003; // Editora
            3:
                wIdField := 0; // Nivel (No se encuntra)
            5:
                wIdField := 56015; // Autor
            6:
                wIdField := 0; // Ciclo (No se encuntra)
            7:
                wIdField := 75004; // Linea de Negocio
            8:
                wIdField := 75010; // Asignatura
            9:
                wIdField := 50005; // Nivel Escolar (Grado);
            10:
                wIdField := 56010; // Sello
            11:
                wIdField := 56007; // Edicion
            12:
                wIdField := 56008; // Estado
            13:
                wIdField := 75011; // Campaña
        END;
    end;

    procedure GetOtrosFieldNo(pwId: Integer) wIdField: Integer
    begin
        // GetOtrosFieldNo
        // Devuelve el numero de campo en Producto referente al Otros datos

        CASE pwId OF
            1:
                wIdField := 5704; // Cód. Grupo Producto
        END;
    end;

    procedure GetGLSetup()
    begin
        // GetGLSetup

        //IF NOT GLSetupRead THEN
        GLSetup.GET;
        GLSetupRead := TRUE;
    end;

    procedure GetConfM()
    begin
        // GetConfM
        IF NOT wConfMdM.Activo THEN
            wConfMdM.GET;
    end;

    procedure GetBarCode(prProd: Record 27): Code[20]
    var
        lwRecRef: Record 5717;
    begin
        // GetBarCode

        CLEAR(lwRecRef);
        lwRecRef.SETRANGE("Item No.", prProd."No.");
        lwRecRef.SETRANGE("Variant Code", '');
        lwRecRef.SETRANGE("Unit of Measure", prProd."Base Unit of Measure");
        lwRecRef.SETRANGE("Cross-Reference Type", lwRecRef."Cross-Reference Type"::"Bar Code");
        lwRecRef.SETRANGE("Cross-Reference Type No.", '');
        IF lwRecRef.FINDFIRST THEN
            EXIT(lwRecRef."Cross-Reference No.");
    end;

    procedure GetDatDescrp(pwTipo: Integer; pwCode: Code[20]) wDesc: Text[100]
    var
        lrDat: Record 75001;
    begin
        // GetDatDescrp
        // Devuelve la descripción de un dato de la tabla Datos MdM

        wDesc := '';
        IF STRLEN(pwCode) > MAXSTRLEN(lrDat.Codigo) THEN
            EXIT;
        CLEAR(lrDat);
        IF lrDat.GET(pwTipo, pwCode) THEN
            wDesc := lrDat.Descripcion;
    end;

    procedure GetEstrcturaAnaliticaDescr(prProd: Record 27) wDesc: Text[100]
    var
        lrEsct: Record 75002;
    begin
        // GetEstrcturaAnaliticaDescr
        // Devuelve la descripción de la estructura analitica

        wDesc := '';
        CLEAR(lrEsct);
        IF lrEsct.GET(prProd."Estructura Analitica") THEN
            wDesc := lrEsct.Descripcion;
    end;

    procedure GetIdiomaDesc(prProd: Record 27) wDesc: Text[50]
    var
        lrLang: Record 8;
    begin
        // GetIdiomaDesc
        // Devuelve la descripción del idioma

        wDesc := '';
        CLEAR(lrLang);
        IF lrLang.GET(prProd.Idioma) THEN
            wDesc := lrLang.Name;
    end;

    procedure GetTipologiaDesc(prProd: Record 27) wDesc: Text
    var
        lrItemCat: Record 5722;
    begin
        // GetTipologiaDesc     ***Revisar aqui***

        wDesc := '';
        IF lrItemCat.GET(prProd."Item Category Code") THEN
            wDesc := lrItemCat.Description;
    end;

    procedure GetPaisDesc(prProd: Record 27) wDesc: Text
    var
        lrCountry: Record 9;
    begin
        // GetPaisDesc

        IF lrCountry.GET(prProd."Country/Region of Origin Code") THEN
            wDesc := lrCountry.Name;
    end;

    procedure GetDatosAuxDesc(pwTipo: Option Aficiones,"Areas de interés",Atenciones,"Canal de venta",Especialidades,Grados,Materiales,"Nivel de decisión","Puestos de trabajo",Rutas,"Tipo de educacion","Tipos de colegios","Tipos de contactos",Turnos,Zonas,"Linea Negocio","Sub familia",Objetivos,Tareas,"Motivos Perdida","Orden religiosa","Asociacion educativa",Materia,"Grupo de Negocio","Equipos T&E","Iniciales Almacen"; pwCode: Code[20]) Result: Text
    var
        lrDatosAux: Record 67002;
    begin
        // GetDatosAuxDesc
        // Devuelve descripcion de Datos Auxiliares (APS)

        CLEAR(lrDatosAux);
        IF lrDatosAux.GET(pwTipo, pwCode) THEN
            Result := lrDatosAux.Descripcion;
    end;

    procedure GetEAN(prProd: Record 27) wEan: Text
    var
        lrCrossRef: Record 5717;
    begin
        // GetEAN

        wEan := '';
        IF prProd."No." = '' THEN
            EXIT;

        CLEAR(lrCrossRef);
        lrCrossRef.SETRANGE("Item No.", prProd."No.");
        lrCrossRef.SETRANGE("Cross-Reference Type", lrCrossRef."Cross-Reference Type"::"Bar Code");
        IF lrCrossRef.FINDFIRST THEN
            wEan := lrCrossRef."Cross-Reference No.";
    end;

    procedure GetEditable() wEditable: Boolean
    var
        lrUserStp: Record 91;
        Usuario: Text[30];
    begin

        // GetEditable

        GetConfM;
        wEditable := NOT (wConfMdM."Bloquea Datos MDM");

        Usuario := USERID;

        IF (NOT wEditable) THEN BEGIN
            //IF lrUserStp.GET(USERID) THEN BEGIN
            IF lrUserStp.GET(Usuario) THEN BEGIN
                wEditable := lrUserStp."Editar Prod. MdM Total";
            END;
        END;
    end;

    procedure GetEditableErr(pwIssueName: Text) wEditable: Boolean
    begin
        // GetEditableErr

        wEditable := GetEditable;
        IF NOT wEditable THEN
            SetEditableError(pwIssueName);
    end;

    procedure SetEditableError(pwIssueName: Text)
    begin
        // SetEditableError

        ERROR(ErrEditTable, pwIssueName);
    end;

    procedure GetEditableP(prProd: Record 27; pwAut: Boolean) wEditable: Boolean
    var
        lrUserStp: Record 91;
    begin
        // GetEditableP
        // Determina si los campos MdM son editables en un producto
        // pwAut solicita el usuario tiene la marca para modificar parcialmente productos MdM

        GetConfM;

        wEditable := NOT (wConfMdM."Bloquea Datos MDM" AND prProd."Gestionado MdM");
        //wEditable := NOT (wConfMdM."Bloquea Datos MDM");

        IF NOT wEditable THEN BEGIN
            IF lrUserStp.GET(USERID) THEN BEGIN
                IF pwAut THEN
                    wEditable := lrUserStp."Editar Prod. MdM Parcial" OR lrUserStp."Editar Prod. MdM Total"
                ELSE
                    wEditable := lrUserStp."Editar Prod. MdM Total";
            END;
        END;
    end;

    procedure GetDimEditable(prDefDim Record: 352; pwError: Boolean) wEditable: Boolean
    var
        lwN: Integer;
        lrUserStp: Record 91;
        lrItem: Record 27;
    begin
        // GetDimEditable
        // Determina si la dimensión es editable

        wEditable := TRUE;

        IF prDefDim."Table ID" = 27 THEN BEGIN // Producto
            IF prDefDim."Dimension Code" <> '' THEN BEGIN
                GetConfM;
                IF wConfMdM."Bloquea Datos MDM" THEN BEGIN
                    IF lrDim.GET(prDefDim."Dimension Code") THEN BEGIN
                        wEditable := lrDim."Tipo MdM" = lrDim."Tipo MdM"::Ninguno;
                    END;
                    IF NOT wEditable THEN BEGIN
                        IF lrItem.GET(prDefDim."No.") THEN
                            wEditable := NOT lrItem."Gestionado MdM";
                    END;
                END;
            END;
        END;

        IF (NOT wEditable) THEN BEGIN
            IF lrUserStp.GET(USERID) THEN
                wEditable := lrUserStp."Editar Prod. MdM Total";
        END;

        IF (NOT wEditable) AND pwError THEN
            ERROR(ErrEditDim);
    end;

    procedure GetDimValueEditable(prDimVal Record: 349; pwError: Boolean) wEditable: Boolean
    var
        lwN: Integer;
        lrUserStp: Record 91;
    begin
        // GetDimValueEditable
        // Determina un valor de dimensión es editable

        wEditable := TRUE;

        IF prDimVal."Dimension Code" <> '' THEN BEGIN
            GetConfM;
            IF wConfMdM."Bloquea Datos MDM" THEN BEGIN
                IF lrDim.GET(prDimVal."Dimension Code") THEN BEGIN
                    wEditable := lrDim."Tipo MdM" = lrDim."Tipo MdM"::Ninguno;
                END;
            END;
        END;

        IF (NOT wEditable) THEN BEGIN
            IF lrUserStp.GET(USERID) THEN
                wEditable := lrUserStp."Editar Prod. MdM Total";
        END;

        IF (NOT wEditable) AND pwError THEN
            ERROR(ErrEditDim2);
    end;

    procedure SetConfTipologiaMdM(var prProd: Record 27; pwTipologia: Code[10]; pwValores: array[10] of Code[20]) Result: Boolean
    var
        lrConfTip: Record 75006;
        lrItemCat: Record 5722;
        lwNo: Integer;
        lrFiltroTipo: Record 75008;
    begin
        // SetConfTipologiaMdM
        // Tener en cuenta que no se hace Modify en la tabla

        CLEAR(lrConfTip);
        CLEAR(lrFiltroTipo);

        lrConfTip.SETRANGE(Tipologia, pwTipologia);
        FOR lwNo := 1 TO lrFiltroTipo.MaxId DO
            IF lrFiltroTipo.GET(lwNo) THEN
                lrConfTip.SetFilterRef(lwNo, pwValores[lwNo]);

        Result := lrConfTip.FIND('-');

        IF Result THEN
            SetConfTipologiaData(prProd, lrConfTip);

        // Se supone que por defecto ya se han validado estos valores
        //ELSE BEGIN
        //  IF lrItemCat.GET(pwTipologia) THEN BEGIN
        //    prProd.VALIDATE("Gen. Prod. Posting Group", lrItemCat."Def. Gen. Prod. Posting Group");
        //    prProd.VALIDATE("Inventory Posting Group" , lrItemCat."Def. Inventory Posting Group");
        //    prProd.VALIDATE("VAT Prod. Posting Group" , lrItemCat."Def. VAT Prod. Posting Group");
        //    prProd.VALIDATE("Costing Method"          , lrItemCat."Def. Costing Method");
        //  END;
        //END;
    end;

    procedure SetConfTipologiaData(var prProd: Record 27; var prConfTip Record: 75006")
    begin
        // SetConfTipologiaData
        // Tener en cuenta que no se hace Modify en la tabla

        prProd.VALIDATE("Gen. Prod. Posting Group", prConfTip."Gen. Prod. Posting Group");
        prProd.VALIDATE("Inventory Posting Group", prConfTip."Inventory Posting Group");
        prProd.VALIDATE("VAT Prod. Posting Group", prConfTip."VAT Prod. Posting Group");
        prProd.VALIDATE("Costing Method", prConfTip."Costing Method");
        prProd.VALIDATE("Item Disc. Group", prConfTip."Item Disc. Group");
        //prProd.VALIDATE("Product Group Code"      , prConfTip."Product Group Code");   //CAMPO OBSOLETO EN BC
    end;

    procedure ConfiguraTipologiaMdM(var prProd: Record 27) Result: Boolean
    var
        lrConv: Record 75007;
        lrFiltroTipo: Record 75008;
        lwNo: Integer;
        lwValores: array[20] of Code[20];
    begin
        // ConfiguraTipologiaMdM

        CLEAR(lwValores);
        FOR lwNo := 1 TO lrFiltroTipo.MaxId DO BEGIN
            IF lrFiltroTipo.GET(lwNo) THEN BEGIN
                //lwValores[lwNo] :=
                CASE lrFiltroTipo.Tipo OF
                    lrFiltroTipo.Tipo::Dimension:
                        lwValores[lwNo] := GetDimValueT(prProd."No.", lrFiltroTipo."Valor Id");
                    lrFiltroTipo.Tipo::"Dato MdM":
                        lwValores[lwNo] := GetDatoMdM(prProd, lrFiltroTipo."Valor Id");
                    lrFiltroTipo.Tipo::Otros:
                        lwValores[lwNo] := GetDatosOtros(prProd, lrFiltroTipo."Valor Id");
                END;
            END;
        END;

        Result := SetConfTipologiaMdM(prProd, prProd."Item Category Code", lwValores);
    end;

    procedure ShowSalesPrice(var prProd: Record 27)
    var
        lrSPrice: Record 7002;
    begin
        // ShowSalesPrice

        CLEAR(lrSPrice);
        lrSPrice.SETRANGE("Item No.", prProd."No.");
        PAGE.RUN(PAGE::"Sales Prices", lrSPrice);
    end;

    procedure ControlIBN(pwCode: Code[13]; pwError: Boolean) wOK: Boolean
    var
        lwChar: Char;
        lwN: Integer;
        lwInt: Integer;
        lwTotal: Integer;
        lwCont: Integer;
        lwCont2: Integer;
    begin
        // ControlIBN
        // Devuelve true si el dígito de control es correcto

        wOK := FALSE;
        IF pwCode = '' THEN
            EXIT;

        lwTotal := 0;
        wOK := EVALUATE(lwCont, FORMAT(pwCode[13])); // Dígito de control
        IF wOK THEN BEGIN
            FOR lwN := 1 TO 12 DO BEGIN
                lwChar := pwCode[lwN];
                IF wOK THEN BEGIN
                    wOK := EVALUATE(lwInt, FORMAT(lwChar));
                    IF wOK THEN BEGIN
                        IF lwN MOD 2 = 0 THEN
                            lwInt := lwInt * 3;
                        lwTotal += lwInt
                    END;
                END;
            END;
        END;

        IF wOK THEN BEGIN
            lwCont2 := 0;
            WHILE ((lwTotal + lwCont2) MOD 10 <> 0) DO
                lwCont2 += 1;
            wOK := lwCont = lwCont2;
        END;

        IF (NOT wOK) AND pwError THEN
            ERROR(ErrISBN, pwCode);
    end;

    procedure ObligaCampos(prProd: Record 27)
    var
        ltEan: Label 'EAN';
        lwN: Integer;
        lPrecioVta: Label 'Precio de Venta';
    begin
        // ObligaCampos
        // Genera un error si no se han rellenado debidamente los campos MdM

        GetConfM;
        IF NOT wConfMdM."Obliga Campos MdM" THEN
            EXIT;

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        prProd.TESTFIELD("Item Category Code");
        prProd.TESTFIELD(Description);
        prProd.TESTFIELD("Search Description");
        prProd.TESTFIELD("Tipo Producto");
        prProd.TESTFIELD(Soporte);
        prProd.TESTFIELD(Linea);
        prProd.TESTFIELD(Sello);
        prProd.TESTFIELD(Idioma);
        ObligaDim(prProd, 0, 2); // Serie
        //prProd.TESTFIELD(Autor);
        prProd.TESTFIELD("Empresa Editora");
        prProd.TESTFIELD("Plan Editorial");
        prProd.TESTFIELD(Edicion);
        ObligaDim(prProd, 1, 2); // Destino
        ObligaDim(prProd, 2, 2); // Cuenta
        prProd.TESTFIELD("Estructura Analitica");
        ObligaDim(prProd, 3, 2); // Tipo Texto
        prProd.TESTFIELD(Asignatura);
        prProd.TESTFIELD("Nivel Escolar (Grado)");
        ObligaDim(prProd, 5, 2); // Carga Horaria
        ObligaDim(prProd, 6, 2); // Origen
        prProd.TESTFIELD(Estado);

        /*  // De momento no obligatorios
        prProd.TESTFIELD(ISBN);
        IF GetEAN(prProd) = '' THEN
          ERROR(ErrFieldM, ltEan);
        prProd.TESTFIELD("No. Paginas");
        
        prProd.TESTFIELD("Country/Region of Origin Code");
        
        */

    end;

    procedure ObligaCampos2(prProd: Record 27) Result: Boolean
    var
        ltEan: Label 'EAN';
        lwN: Integer;
        lPrecioVta: Label 'Precio de Venta';
        lwOK: Boolean;
        lwRecRef: RecordRef;
    begin
        // ObligaCampos2
        // Genera un Aviso si no se han rellenado debidamente los campos MdM

        GetConfM;
        IF NOT wConfMdM."Obliga Campos MdM" THEN
            EXIT;

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        lwOK := TRUE;
        lwRecRef.GETTABLE(prProd);


        // Campos
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 5702, 1); // "Item Category Code"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 2, 1); // Description
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 4, 1); // Search Description"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75001, 1); // "Tipo Producto"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75002, 1); // Soporte
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75004, 1); // Linea
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 56010, 1); // Sello
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 56013, 1); // Idioma
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75003, 1); // "Empresa Editora"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75006, 1); // "Plan Editorial"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 56007, 1); // Edicion
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75007, 1); // "Estructura Analitica"
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 56008, 1); // Estado
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 75010, 1); // Asignatura
        IF lwOK THEN
            lwOK := ObligaField(lwRecRef, 50005, 1);  // "Nivel Escolar (Grado)"


        // Dimensiones
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 0, 1); // Serie
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 1, 1); // Destino
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 2, 1); // Cuenta
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 3, 1); // Tipo Texto
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 5, 1); // Carga Horaria
        IF lwOK THEN
            lwOK := ObligaDim(prProd, 6, 1); // Origen

        Result := lwOK;
    end;

    procedure ObligaDim(prProd: Record 27; pwDim: Integer; pwTipo: Option Nada,Aviso,Error) Result: Boolean
    var
        lwDimCode: Code[20];
    begin
        // ObligaDim

        Result := TRUE;
        lwDimCode := GetDimCode(pwDim, TRUE);
        IF GetDimValueC(prProd."No.", lwDimCode) = '' THEN BEGIN
            Result := FALSE;
            CASE pwTipo OF
                pwTipo::Aviso:
                    MESSAGE(ErrFieldM, GetDimNameField(pwDim));
                pwTipo::Error:
                    ERROR(ErrFieldM, GetDimNameField(pwDim));
            END;
        END;
    end;

    procedure ObligaField(var pRecRef: RecordRef; pwIdField: Integer; pwTipo: Option Nada,Aviso,Error) Result: Boolean
    var
        lwFieldRef: FieldRef;
    begin
        // ObligaField

        Result := TRUE;
        lwFieldRef := pRecRef.FIELD(pwIdField);
        IF FORMAT(lwFieldRef.VALUE) = '' THEN BEGIN
            Result := FALSE;
            CASE pwTipo OF
                pwTipo::Aviso:
                    MESSAGE(ErrFieldM, lwFieldRef.CAPTION);
                pwTipo::Error:
                    ERROR(ErrFieldM, lwFieldRef.CAPTION);
            END;
        END;
    end;

    procedure GetOtrosName(pwId: Integer) Result: Text
    var
        lwIdTable: Integer;
        lrRecRef: RecordRef;
    begin
        // GetOtrosName

        Result := '';
        lwIdTable := GetOtrosTableId(pwId);

        IF lwIdTable > 0 THEN BEGIN
            lrRecRef.OPEN(lwIdTable, TRUE);
            Result := lrRecRef.CAPTION;
            lrRecRef.CLOSE;
        END;
    end;

    procedure GetOtrosTableId(pwId: Integer) Result: Integer
    begin
        // GetOtrosTableId

        Result := 0;
        CASE pwId OF
            1:
                Result := 5723; // Product Group
        END;
    end;

    procedure GetTotalOtrosOptions(): Integer
    begin
        // GetTotalOtrosOptions
        // Devuelve el total de opciones Otros Existentes

        EXIT(1);
    end;

    procedure GetDefDimesions(var prProd: Record 27)
    var
        lrDefDim: Record 352;
        lrDefDim2Record: Record 352;
        lrDefDim3Record: Record 352;
    begin
        // GetDefDimesions
        // Añadimos dimensiones por defecto

        IF prProd."No." = '' THEN
            EXIT;

        CLEAR(lrDefDim);
        lrDefDim.SETRANGE("Table ID", 27);
        lrDefDim.SETFILTER("No.", '=%1', '');
        lrDefDim.SETFILTER("Dimension Value Code", '<>%1', ''); // JPT 06/02/2019 No consideramos valores en blanco
        IF lrDefDim.FINDSET THEN BEGIN
            REPEAT
                IF lrDefDim."Value Posting" IN [lrDefDim."Value Posting"::"Code Mandatory", lrDefDim."Value Posting"::"Same Code"] THEN BEGIN
                    lrDefDim2.COPY(lrDefDim);
                    lrDefDim2."No." := prProd."No.";
                    lrDefDim3 := lrDefDim2;
                    IF lrDefDim3.FIND THEN // Si existe la modifica
                        lrDefDim2.MODIFY
                    ELSE
                        lrDefDim2.INSERT;

                    SetGlobalDim(prProd, lrDefDim2."Dimension Code", lrDefDim2."Dimension Value Code");
                END;
            UNTIL lrDefDim.NEXT = 0;
        END;
    end;

    procedure SetGlobalDim(var prProd: Record 27; pwDimCode: Code[20]; pwValue: Code[20])
    begin
        // SetGlobalDim

        GetGLSetup;
        IF pwDimCode = GLSetup."Global Dimension 1 Code" THEN
            prProd."Global Dimension 1 Code" := pwValue;
        IF pwDimCode = GLSetup."Global Dimension 2 Code" THEN
            prProd."Global Dimension 2 Code" := pwValue;
    end;

    procedure SetEstadoProd(var prItem: Record 27)
    begin
        // SetEstadoProd
        // Gestionamos el campo Inactivo a través del estado
        // El campo Inactivo de Navision se marque cuando un artículo adquiera en el MdM el estado Y8 FONDO DE BAJA
        // JPT 08/01/2019

        GetConfM;
        IF wConfMdM."Estado Inactivo" <> '' THEN BEGIN
            IF prItem.Estado = wConfMdM."Estado Inactivo" THEN
                prItem.VALIDATE(Inactivo, TRUE);
        END;
    end;

    procedure ContrlFechasDocV(prSalesHd Record: 36")
    var
        lrLin: Record 37;
    begin
        // ContrlFechasDocV
        // #209115 JPT 03/04/2019

        IF NOT (prSalesHd."Document Type" IN [prSalesHd."Document Type"::Order, prSalesHd."Document Type"::Invoice]) THEN
            EXIT;

        IF prSalesHd."No." = '' THEN
            EXIT;

        ClearFechasBuff;
        CLEAR(lrLin);
        lrLin.SETRANGE("Document Type", prSalesHd."Document Type");
        lrLin.SETRANGE("Document No.", prSalesHd."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        lrLin.SETFILTER("No.", '<>%1', '');
        lrLin.SETFILTER(Quantity, '<>%1', 0);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF NOT rTmpBuff.GET(lrLin."No.") THEN BEGIN
                    rTmpBuff."Cod Producto" := lrLin."No.";
                    rTmpBuff.INSERT;
                END;
            UNTIL lrLin.NEXT = 0;
        END;
    end;

    procedure ContrlFechasDocC(prPurchHd Record: 38")
    var
        lrLin: Record 39;
    begin
        // ContrlFechasDocC
        // #209115 JPT 03/04/2019

        IF NOT (prPurchHd."Document Type" IN [prPurchHd."Document Type"::Order, prPurchHd."Document Type"::Invoice]) THEN
            EXIT;

        IF prPurchHd."No." = '' THEN
            EXIT;

        ClearFechasBuff;
        CLEAR(lrLin);
        lrLin.SETRANGE("Document Type", prPurchHd."Document Type");
        lrLin.SETRANGE("Document No.", prPurchHd."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        lrLin.SETFILTER("No.", '<>%1', '');
        lrLin.SETFILTER(Quantity, '<>%1', 0);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF NOT rTmpBuff.GET(lrLin."No.") THEN BEGIN
                    rTmpBuff."Cod Producto" := lrLin."No.";
                    rTmpBuff.INSERT;
                END;
            UNTIL lrLin.NEXT = 0;
        END;
    end;

    procedure ContrlFechasAlbC(prCabAlbC Record: 120")
    var
        lrLin: Record 121;
        lrTmpBuff Record: 75016" temporary;
    begin
        // ContrlFechaAlbC
        // #209115 JPT 03/04/2019
        // Gestion de fechas MdM por Albarán Compra

        IF prCabAlbC."No." = '' THEN
            EXIT;

        CLEAR(lrLin);
        lrLin.SETRANGE("Document No.", prCabAlbC."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        lrLin.SETRANGE(Correction, FALSE);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF NOT lrTmpBuff.GET(lrLin."No.") THEN BEGIN
                    lrTmpBuff."Cod Producto" := lrLin."No.";
                    lrTmpBuff.INSERT;
                END;
            UNTIL lrLin.NEXT = 0;

            ContrlFechasMdM(lrTmpBuff, 1);
        END;
    end;

    procedure ContrlFechasAlbV(prCabAlbV Record: 110")
    var
        lrLin: Record 111;
        lrTmpBuff Record: 75016" temporary;
    begin
        // ContrlFechaAlbV
        // #209115 JPT 03/04/2019
        // Gestion de fechas MdM por Albarán Venta

        IF prCabAlbV."No." = '' THEN
            EXIT;

        CLEAR(lrLin);
        lrLin.SETRANGE("Document No.", prCabAlbV."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        lrLin.SETRANGE(Correction, FALSE);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF NOT lrTmpBuff.GET(lrLin."No.") THEN BEGIN
                    lrTmpBuff."Cod Producto" := lrLin."No.";
                    lrTmpBuff.INSERT;
                END;
            UNTIL lrLin.NEXT = 0;

            ContrlFechasMdM(lrTmpBuff, 2);
        END;
    end;

    procedure ContrlFechasFactV(prCabFactV Record: 112")
    var
        lrLin: Record 113;
        lrTmpBuff Record: 75016" temporary;
    begin
        // ContrlFechasFactV
        // #209115 JPT 03/04/2019
        // Gestion de fechas MdM por Factura Venta

        IF prCabFactV."No." = '' THEN
            EXIT;

        CLEAR(lrLin);
        lrLin.SETRANGE("Document No.", prCabFactV."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF NOT lrTmpBuff.GET(lrLin."No.") THEN BEGIN
                    lrTmpBuff."Cod Producto" := lrLin."No.";
                    lrTmpBuff.INSERT;
                END;
            UNTIL lrLin.NEXT = 0;

            ContrlFechasMdM(lrTmpBuff, 2);
        END;
    end;

    procedure ContrlFechasEns(prAssemHd Record: 910") Result: Boolean
    var
        lrLin: Record 911;
        lrProd: Record 27;
        lrTmpFechasBuff Record: 75016" temporary;
        lrTmpf2Record 75016" temporary;
        lrProd2: Record 27;
        lwBEntrada: Boolean;
        lwBComerc: Boolean;
        lrTmpBuff Record: 75016" temporary;
    begin
        // ContrlFechasEns - Ensamblado
        // #209115 JPT 01/07/2019

        IF (prAssemHd."No." = '') OR (prAssemHd."Item No." = '') THEN
            EXIT;

        IF NOT lrProd.GET(prAssemHd."Item No.") THEN
            EXIT;

        IF NOT lrProd."Gestionado MdM" THEN
            EXIT;

        Result := GestValoresFechasBuff(lrProd, lrTmpFechasBuff, 1, TRUE, TRUE, 2);

        IF lrTmpFechasBuff."Fecha Almacen" = 0D THEN
            lrTmpFechasBuff."Fecha Almacen" := lrProd."Fecha Almacen";

        CLEAR(lrLin);
        lrLin.SETRANGE("Document No.", prAssemHd."No.");
        lrLin.SETRANGE(Type, lrLin.Type::Item);
        lrLin.SETFILTER("No.", '<>%1', '');
        lrLin.SETFILTER(Quantity, '<>%1', 0);
        IF lrLin.FINDSET THEN BEGIN
            REPEAT
                IF lrProd2.GET(lrLin."No.") THEN BEGIN
                    IF DesfFechasBuff(lrProd2, 1, lwBEntrada, lwBComerc) THEN BEGIN
                        GestValoresFechasBuff(lrProd2, lrTmpf2, 1, TRUE, FALSE, 0);
                        IF lwBEntrada THEN BEGIN
                            IF lrTmpFechasBuff."Fecha Almacen" <> 0D THEN
                                IF (lrTmpFechasBuff."Fecha Almacen" < lrTmpf2."Fecha Almacen") OR (lrTmpf2."Fecha Almacen" = 0D) THEN
                                    lrTmpf2."Fecha Almacen" := lrTmpFechasBuff."Fecha Almacen";
                        END;
                        Result := Result OR GestValoresFechasBuff(lrProd2, lrTmpf2, 1, FALSE, TRUE, 2);
                    END;
                END;
            UNTIL lrLin.NEXT = 0;
        END;


        /*
        IF NOT lrTmpBuff.GET(prAssemHd."Item No.") THEN BEGIN
          lrTmpBuff."Cod Producto" := prAssemHd."Item No.";
          lrTmpBuff.INSERT;
        END;
        
        CLEAR(lrLin);
        lrLin.SETRANGE("Document No." , prAssemHd."No.");
        lrLin.SETRANGE(Type           , lrLin.Type::Item);
        lrLin.SETFILTER("No."         , '<>%1','');
        lrLin.SETFILTER(Quantity      , '<>%1',0);
        IF lrLin.FINDSET THEN BEGIN
          REPEAT
            IF NOT lrTmpBuff.GET(lrLin."No.") THEN BEGIN
              lrTmpBuff."Cod Producto" := lrLin."No.";
              lrTmpBuff.INSERT;
            END;
          UNTIL lrLin.NEXT=0;
        
          ContrlFechasMdM(lrTmpBuff,1);
        END;
        */

    end;

    procedure ContrlFechasMdM(var prTmpBuff Record: 75016" temporary; pwTipoFecha: Option Todas,Entrada,Comercializacion)
    begin
        // ContrlFechasMdM
        // #209115 JPT 03/04/2019
        // Gestion de fechas MdM

        IF prTmpBuff.FINDSET THEN BEGIN
            REPEAT
                GestContrlFechasProd2(prTmpBuff."Cod Producto", pwTipoFecha);
            UNTIL prTmpBuff.NEXT = 0;
        END;
    end;

    procedure ContrlFechasMdMTmp(pwTipoFecha: Option Todas,Entrada,Comercializacion)
    begin
        // ContrlFechasMdMTmp
        // #209115 JPT 03/04/2019
        // Gestion de fechas MdM

        ContrlFechasMdM(rTmpBuff, pwTipoFecha);
        ClearFechasBuff;
    end;

    procedure GestContrlFechasProd(var prProd: Record 27; pwTipoFecha: Option Todas,Entrada,Comercializacion; pwGuardar: Option No,Single,RunTrigger) Result: Boolean
    var
        lrTmpFechasBuff Record: 75016" temporary;
        lrTmpf2Record 75016" temporary;
        lrBoomC: Record 90;
        lrProd2: Record 27;
        lwBEntrada: Boolean;
        lwBComerc: Boolean;
    begin
        // GestContrlFechasProd
        // #209115 JPT 03/04/2019  Gestionamos el control de rellenado automatico de las fechas MdM de producto
        // OJO : pwGuardar = Single Provocará que NO se lancen las notificaciones a MdM

        Result := FALSE;

        IF prProd."No." = '' THEN
            EXIT;

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        Result := GestValoresFechasBuff(prProd, lrTmpFechasBuff, pwTipoFecha, TRUE, TRUE, pwGuardar);


        IF NOT prProd."Assembly BOM" THEN
            prProd.CALCFIELDS("Assembly BOM");
        IF prProd."Assembly BOM" THEN BEGIN

            IF lrTmpFechasBuff."Fecha Almacen" = 0D THEN
                lrTmpFechasBuff."Fecha Almacen" := prProd."Fecha Almacen";
            IF lrTmpFechasBuff."Fecha Comercializacion" = 0D THEN
                lrTmpFechasBuff."Fecha Comercializacion" := prProd."Fecha Comercializacion";

            CLEAR(lrBoomC);
            lrBoomC.SETRANGE("Parent Item No.", prProd."No.");
            lrBoomC.SETRANGE(Type, lrBoomC.Type::Item);
            IF lrBoomC.FINDSET THEN BEGIN
                REPEAT
                    IF lrProd2.GET(lrBoomC."No.") THEN BEGIN
                        IF DesfFechasBuff(lrProd2, pwTipoFecha, lwBEntrada, lwBComerc) THEN BEGIN
                            GestValoresFechasBuff(lrProd2, lrTmpf2, pwTipoFecha, TRUE, FALSE, 0);
                            IF lwBEntrada THEN BEGIN
                                IF lrTmpFechasBuff."Fecha Almacen" <> 0D THEN
                                    IF (lrTmpFechasBuff."Fecha Almacen" < lrTmpf2."Fecha Almacen") OR (lrTmpf2."Fecha Almacen" = 0D) THEN
                                        lrTmpf2."Fecha Almacen" := lrTmpFechasBuff."Fecha Almacen";
                            END;
                            IF lwBComerc THEN BEGIN
                                IF lrTmpFechasBuff."Fecha Comercializacion" <> 0D THEN
                                    IF (lrTmpFechasBuff."Fecha Comercializacion" < lrTmpf2."Fecha Comercializacion") OR (lrTmpf2."Fecha Comercializacion" = 0D) THEN
                                        lrTmpf2."Fecha Comercializacion" := lrTmpFechasBuff."Fecha Comercializacion";
                            END;
                            Result := Result OR GestValoresFechasBuff(lrProd2, lrTmpf2, pwTipoFecha, FALSE, TRUE, pwGuardar);
                        END;
                    END;
                UNTIL lrBoomC.NEXT = 0;
            END;
        END;
    end;

    procedure GestContrlFechasProd2(pwCodPro: Code[20]; pwTipoFecha: Option Todas,Entrada,Comercializacion) Result: Boolean
    var
        lrProd: Record 27;
    begin
        // GestContrlFechasProd2
        // #209115

        Result := FALSE;
        IF pwCodPro = '' THEN
            EXIT;

        IF lrProd.GET(pwCodPro) THEN
            Result := GestContrlFechasProd(lrProd, pwTipoFecha, 2); // Guardamos validando
    end;

    local procedure GestValoresFechasBuff(var prProd: Record 27; var prTmpFechasBuff Record: 75016" temporary; pwTipoFecha: Option Todas,Entrada,Comercializacion; pwCalcula: Boolean; pwAsigna: Boolean; pwGuardar: Option No,Single,RunTrigger) Result: Boolean
    var
        lwBEntrada: Boolean;
        lwBComerc: Boolean;
        lwOk: Boolean;
        lwDate: Date;
        lrProd2: Record 27;
    begin
        // GestValoresFechasBuff
        // OJO : pwGuardar = Single Provocará que NO se lancen las notificaciones a MdM
        // #209115

        Result := FALSE;

        IF pwCalcula THEN
            CLEAR(prTmpFechasBuff);

        IF prProd."No." = '' THEN
            EXIT;

        IF NOT prProd."Gestionado MdM" THEN
            EXIT;

        IF NOT DesfFechasBuff(prProd, pwTipoFecha, lwBEntrada, lwBComerc) THEN // Si está todo rellenado
            EXIT;

        WITH prTmpFechasBuff DO BEGIN

            "Cod Producto" := prProd."No.";

            IF pwCalcula THEN BEGIN
                CASE TRUE OF
                    lwBEntrada AND lwBComerc:
                        CALCFIELDS("Fecha Alb Compra", "Fecha Ensamblado", "Fecha Alb Venta", "Fecha Fact Venta");
                    lwBEntrada:
                        CALCFIELDS("Fecha Alb Compra", "Fecha Ensamblado");
                    lwBComerc:
                        CALCFIELDS("Fecha Alb Venta", "Fecha Fact Venta");
                END;

                IF lwBEntrada THEN BEGIN
                    lwDate := "Fecha Alb Compra";
                    //"Fecha Almacen" := "Fecha Alb Compra";
                    IF "Fecha Ensamblado" <> 0D THEN BEGIN
                        IF ("Fecha Ensamblado" < lwDate) OR (lwDate = 0D) THEN
                            lwDate := "Fecha Ensamblado";
                    END;
                    IF lwDate = 0D THEN BEGIN // Miramos si es un componente de ensamblado
                        CALCFIELDS(CodProdEsamblado);
                        IF CodProdEsamblado <> '' THEN BEGIN
                            IF lrProd2.GET(CodProdEsamblado) THEN
                                lwDate := lrProd2."Fecha Almacen";
                        END;
                    END;
                    "Fecha Almacen" := lwDate;
                END;

                IF lwBComerc THEN BEGIN
                    lwDate := "Fecha Alb Venta";
                    IF "Fecha Fact Venta" <> 0D THEN BEGIN
                        IF ("Fecha Fact Venta" < lwDate) OR (lwDate = 0D) THEN
                            lwDate := "Fecha Fact Venta"
                    END;
                    "Fecha Comercializacion" := lwDate;
                END;
            END;

            IF pwAsigna THEN BEGIN
                IF lwBEntrada THEN BEGIN
                    IF "Fecha Almacen" <> 0D THEN BEGIN
                        prProd.VALIDATE("Fecha Almacen", "Fecha Almacen");
                        Result := TRUE;
                    END;
                END;

                IF lwBComerc THEN BEGIN
                    IF "Fecha Comercializacion" <> 0D THEN BEGIN
                        prProd.VALIDATE("Fecha Comercializacion", "Fecha Comercializacion");
                        Result := TRUE;
                    END;
                END;
            END;
        END;

        IF Result THEN BEGIN
            CASE pwGuardar OF
                pwGuardar::Single:
                    prProd.MODIFY(FALSE);
                pwGuardar::RunTrigger:
                    prProd.MODIFY(TRUE);
            END;
        END;
    end;

    procedure DesfFechasBuff(prProd: Record 27; pwTipoFecha: Option Todas,Entrada,Comercializacion; var pwBEntrada: Boolean; var pwBComerc: Boolean) Result: Boolean
    begin
        // DesfFechasBuff
        // #209115

        CLEAR(pwBEntrada);
        CLEAR(pwBComerc);
        IF pwTipoFecha IN [pwTipoFecha::Todas, pwTipoFecha::Entrada] THEN
            pwBEntrada := prProd."Fecha Almacen" = 0D;
        IF pwTipoFecha IN [pwTipoFecha::Todas, pwTipoFecha::Comercializacion] THEN
            pwBComerc := prProd."Fecha Comercializacion" = 0D;

        Result := pwBEntrada OR pwBComerc;
    end;

    procedure ClearFechasBuff()
    begin
        // ClearFechasBuff
        // #209115

        CLEAR(rTmpBuff);
        rTmpBuff.DELETEALL;
    end;
}

